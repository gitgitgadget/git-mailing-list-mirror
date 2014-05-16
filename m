From: Michal Stasa <michal.stasa@gmail.com>
Subject: Fwd: [Bug] - Processing commit message after amend
Date: Fri, 16 May 2014 12:18:07 +0200
Message-ID: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 12:18:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFDS-0004wt-0I
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbaEPKSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 06:18:09 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:44636 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbaEPKSI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 06:18:08 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so2791462veb.23
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=IBQCnqC4uKi+36mV6jw3kzw+nfd/i9gLyjs9CG0vf6A=;
        b=hcfdmZHvOywv+r0OgS4iWjyPBpHwulY/+yixRXvRitAO+SISSOGyxW+OIJ8t0dfiCZ
         96fsxZLvqQFVvsVd9bHyh6wm8Ix+undjfPF7acwWGdc9uRTDDVmKLB2mv2xDuBYBOmvz
         YUmGTv6CZ72Kk+SCk+j+3HUsVgU4bEbj5ItHZP8giC7UVczZtWO0Axzt89sU7/lBluK5
         bIvODR93SkmLg0ZlnepcKq3fhERdwkSVPIQIsys7MnMyISno5lJwsBBbAHJvbK8Zc0Ma
         +tdBy3ozbWyX1L6rLkkK1ORaAoR8ZjexYVvHYAoMXCBsCy6n5jrwCcW21wSiCoQuoKt8
         joFw==
X-Received: by 10.221.20.199 with SMTP id qp7mr13402479vcb.24.1400235487807;
 Fri, 16 May 2014 03:18:07 -0700 (PDT)
Received: by 10.58.37.97 with HTTP; Fri, 16 May 2014 03:18:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249291>

Hi,

I have stumbled on a weird bug. At work, we use redmine as an issue
tracker and its task are marked by a number starting with #. When I
commit some work and write #1234 in the message, it works. However,
later on when I remember that I forgot to add some files and amend the
commit, vim appears and I cannot perform the commit because the
message starts with # which is a comment in vim and thus I get an
error that my commit message is empty.

Steps to reproduce:
1) commit a file
git commit File1.txt -m "#1234 documentation added"

2) amend previous commit
git commit File2.txt -- amend

3) go for :wq right away

4) an error that the message is empty appears
"Aborting commit due to empty commit message"

However, if you use amend and no edit option, it works
git commit --amend --no-edit

We use git for Windows downloaded here:
http://git-scm.com/downloads

The problem appears in Windows command line. I have not tested it
anywhere else. The OS is Windows Server 2008 R2 Datacenter.

Cheers from cloudy Prague
Michal Sta=C5=A1a

Santhos.net
www.santhos.net

+420 773 454 793
michal.stasa@santhos.net
