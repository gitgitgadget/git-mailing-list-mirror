From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: how to reorder commits
Date: Mon, 20 Jul 2009 21:31:34 +0530
Message-ID: <f46c52560907200901w67edbbdcpe405f28d98953354@mail.gmail.com>
References: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
	 <adf1fd3d0907200837k63f21504v3d660f9503962fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 18:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSvJ8-0000aV-UL
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 18:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZGTQBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbZGTQBf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 12:01:35 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:60415 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZGTQBe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 12:01:34 -0400
Received: by pxi31 with SMTP id 31so452999pxi.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=k/CT8vNtA4ypyQkjjQ3Uj7o8ay7JUInu5uFtySMWOMc=;
        b=vRVu92HaehGGBnTCNs4dhVbwZIg5DKteTXJ9GcDhPECLHXOb529MrX8CRD/sCLqXbw
         kkijOGbEZ2Y2MPF8kQljOLBr+pKfGS7lglNTzalxDrr8BajWNkBgrijoYuMdW7NHUaco
         oqfhIB3FmSkS1p19u/ztIVrOUk19KOR7uva9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=DZ02L8XXZxCXUfM0CVpUP/wCe5PHygNGIVR0A/yE10b1XC2e8feACb05I8BHd/WkhU
         oifrJmShcPfXte/FBLE4jyVeEFmXqjcMmO+I32/NtaXsEkventJlllj1C2/AugJ7gtcq
         3lQtsopovvoBUSaQvlW+HruoaGQm/Jv3PifLQ=
Received: by 10.114.15.9 with SMTP id 9mr7419838wao.82.1248105694606; Mon, 20 
	Jul 2009 09:01:34 -0700 (PDT)
In-Reply-To: <adf1fd3d0907200837k63f21504v3d660f9503962fcf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123618>

On Mon, Jul 20, 2009 at 9:07 PM, Santi B=E9jar<santi@agolina.net> wrote=
:
> 2009/7/20 Rustom Mody <rustompmody@gmail.com>:
>> I have a sequence of commits. I tried to reorder the top two in this=
 way.
>> $ git rebase -i HEAD^^
>>
>> flip the two pick lines and exit vi
>>
>> I find my file full of conflict markers.
>
> "git rebase" applies the changes between the commit and the parent,
> and if the changes have conflicts this is what you get.
>
>> So what is the way of doing:
>> HEAD becomes current HEAD^
>> HEAD^ becomes current HEAD
>
> $ git branch old
> $ git reset --hard HEAD~2
> $ git read-tree old
> $ git commit -C old
> $ git read-tree old^
> $ git commit -C old^

Beautiful -- plumbing is nifty!

>
> But normally you reorder "changes", not trees.

Which may not always be conflict-free?
