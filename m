From: Alexander Toresson <alexander.toresson@gmail.com>
Subject: Re: git diff infinite loop at attempt to diff two specific commits
Date: Sun, 5 Jul 2009 22:09:45 +0200
Message-ID: <b33ba6660907051309y55bd5472oc665118a1851ddce@mail.gmail.com>
References: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
	 <20090705181208.GA8629@atjola.homenet>
	 <706b4240907051122s784e97abkde5628189956ceb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 22:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNY5J-0000mw-Ux
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 22:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZGEUJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZGEUJo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 16:09:44 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:33932 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbZGEUJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 16:09:43 -0400
Received: by bwz25 with SMTP id 25so617380bwz.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CQQN2j4DyFS9k8M+i8/8Er33Bta0IRdDY0YjBeObtmk=;
        b=vtHbNHOK6LYgJXdVQPqG4t7Fxn5a4zcXVFpsVNSXCpykIFJZ4oAZ3JwOUX9/DoroRO
         suNIFmEfZvOv6X3lSRfwkWjhCvgg0mGWeQ0OdcMfrchNWzlDPtrZItzrVG5cQLr6i8b8
         WawJtIBa6+gE68jBbitrWVJyIVDf6p5ri6a1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=tMUsIPXQmsFL6sC9qqH8RwgDNss8mP4QPl2jTunCXT/ektycnZHpjAl8/TIcYteJcM
         +cNkQcplygIPWq6YSjY14Vbyc0f43lHh7mVPMBf070u1Q8KMFcP+6S2TfgGhqEwdRafc
         Ykjzay5SmznFdkfrYsvCSfL0pwl2AqGBI+nXI=
Received: by 10.204.72.15 with SMTP id k15mr3841523bkj.14.1246824586008; Sun, 
	05 Jul 2009 13:09:46 -0700 (PDT)
In-Reply-To: <706b4240907051122s784e97abkde5628189956ceb0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122756>

2009/7/5 Matt Pearson <404emailnotfound@gmail.com>:
> 2009/7/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> On 2009.07.05 19:37:44 +0200, Alexander Toresson wrote:
>>> Hello,
>>>
>>> I've got problems with git diff, it hangs in an infinite loop when
>>> attempting to generate a diff between two specific commits. Command=
s
>>> to reproduce:
>>>
>>> git clone git://eulex.zapto.org/nightfall.git
>>> cd nightfall
>>> git diff --stat 597711..61a139
>>>
>>> (Note that the clone needs to fetch 16mb)
>>>
>>> I'm running git 1.6.3.3.
>>
>> FWIW, it "hangs" on the save.xml file. The old version is 1.2M, the =
new
>> one is 9M. Using the patience diff algorithm to compare them takes a=
bout
>> 5 seconds here, while the default algorithm took 6m15s.
>
> I can confirm this for the 1.6.0.4 shipped with Ubuntu Jaunty (so thi=
s
> would seem to not be a recent change). Actually, it may be worse: min=
e
> is still running after 8 minutes, and this machine is almost
> brand-new. Normal diff -u on the two versions of the file finishes in
> under a second.
>
> On an unrelated note, it's usually a bad idea to have files like
> configure and *.suo in the repo (and possibly this save.xml as well).
>

Ah! I shouldn't really have had that file in version control, I can
understand that it would be slow to diff a 9mb xml file. On the other
hand, is there a way to mark the file so git won't attempt to diff it,
but will just dispose of the old contents and use the new contents?

As for the configure file, it's convenient for users to not have to
have autoconf installed to build it. I don't really know what *.suo
does nor do I think I added it, so I'll check up on that.

Thank you.

// Alexander
