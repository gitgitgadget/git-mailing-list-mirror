From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 14:46:43 -0400
Message-ID: <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll6Ey-0000FZ-AN
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 19:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZCUSqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZCUSqq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 14:46:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:43387 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZCUSqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 14:46:45 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1505242ywb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=J0B944gJBS8TKQDg3SMfFYfNp2QONcojlHzFmN/z0z8=;
        b=Vrq3Grpe5YLVQ7WUePEBDuEkWp/VVe/iYmqTjHdyTfek1EzhJrUQq7qEtNr+m6/Tsu
         gJ17e3GknfqL6dd/+q0mcKVoFRY/X9Gjj9gYwqrs+6EDnKc9guaD3+N64Gk1cbB301SJ
         ub4MaTFkt5EOuJRCaQB0xOj/whAVEvSCpfBZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ud2H4iPWWMmffT7EVqBkCY0Uwt/AtVPCeXTLGI+0WtUfqalvhpiYuHM6tkFf0Njm13
         HxEuR4r5Wa3a2dbWnxwrBYlx9zx2KpAbExck5DlWrbmtmman17pVTWabekU9r4t8o7ov
         6Ik5bP/e15A6y6et4zDdacGZPGmrJD/ydWshA=
Received: by 10.90.86.9 with SMTP id j9mr2965762agb.114.1237661203449; Sat, 21 
	Mar 2009 11:46:43 -0700 (PDT)
In-Reply-To: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
X-Google-Sender-Auth: 6723c30f77e2acbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114049>

On Sat, Mar 21, 2009 at 1:56 PM, James Pickens wrote:
> I wanted to have a pre-commit hook that would prevent users from
> amending a commit that had already been published, but I couldn't
> find any way in the pre-commit hook to figure out if --amend was
> used. =A0Is there a way to do that? =A0Or any better way to disallow
> amending published commits?

An amended commit will have a new SHA1, and therefore git will treat
it as an entirely different commit. Trying to push an amended history
is 'non fast forward' in git terminology, since it involves a rewind
of existing history.

Set receive.denyNonFastForwards if you don't want people to be able to
amend (or otherwise rewind) published history.

Peter Harris
