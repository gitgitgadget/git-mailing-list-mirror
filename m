From: Matt Di Pasquale <liveloveprosper@gmail.com>
Subject: Fwd: how to apply patch?
Date: Sat, 6 Feb 2010 21:05:39 -0500
Message-ID: <13f0168a1002061805o5d64c05cy9d8f0190a8f37feb@mail.gmail.com>
References: <13f0168a1002061720t93ff6aew3420a41a547549d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 03:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdwXK-0001qc-3c
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 03:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab0BGCGE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 21:06:04 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37307 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0BGCGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 21:06:01 -0500
Received: by wwi18 with SMTP id 18so1133348wwi.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 18:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=xPCEa2cRr1Ks+elO0/ki3tuGtWJiRnJEUnbLLtIzyD4=;
        b=sqY4HmoZ1YEcuDvMjnJ471uqoulGX/7jFlh+4WrrhtDA02pG9s5JQT7F/qQ/PVSADZ
         9JjCi5kj28149gJ4dubsASJcrWRgB99vjVh7E8jawPAvyLaKy0o2M6R+pd0GJPfDHUok
         kkaYM3Fk78AuugyYCSct2ujhozs4UdGadBAqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=PV0Bit+KALPoXQ1TkKV63hjZNHRE4wcSTcEC5NQPpatTUcRnji/0HrZwiII5THmSfl
         ERrk1iflJq+gRBLL/XQnZneMUHI88YgHASeQvfGZw03J2DJ1ILvSlEM26oihc3wstKZv
         JJepZiAq7f1fy1saFTFUwfuHGEHT0+FukyiDs=
Received: by 10.216.88.15 with SMTP id z15mr2714482wee.113.1265508359123; Sat, 
	06 Feb 2010 18:05:59 -0800 (PST)
In-Reply-To: <13f0168a1002061720t93ff6aew3420a41a547549d8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139210>

I have a development version & a production version of my website.
There are a few essential differences between them that I want to
always stay different (like path constants, etc). When I make changes
on the dev version and test it out and they work and am ready to copy
them to the production (www) version, how do i do that without
annihilating the essential differences that i want to keep? I was
thinking of creating a patch or branch or something with the
differences. Then, copy dev to pro, then reapply/rebase the essential
differences to pro that got wiped out. if i rebase though, i want to
be able to rebase again on the next edit.
what's a good way to do this?

My dir structure:

example.com
=C2=A0=C2=A0www =C2=A0# production site
=C2=A0=C2=A0dev =C2=A0 # development site

Via DreamHost control panel:
www.example.com points to example.com/www/
dev.example.com points to example.com/dev/

Why don't I just have a branch called dev? Maybe I should... Advice?
(Anyway, it's nice to be able quickly, simultaneously open
corresponding files from both www & dev in textmate.
I guess I could do that with like git show master:www/index.html |
mate or something, but then it opens in a new textmate window. it's
just not the same. I guess there's always the possibility of editing
www/index.html when I actually want to be editing dev/index.html, but
then again, it's also possible to be editing the wrong branch.)

My .git/config file has the following aliases for deployment:

# deploy dev
ddev =3D !rsync -avi --copy-unsafe-links --exclude=3D'*.DS_Store'
--delay-updates --delete-after --delete-excluded -e ssh
~/Sites/example.com/dev/ acani@acani.com:Sites/example.com/dev/

# deploy www
dpro =3D !rsync -avi --copy-unsafe-links --exclude=3D'*.DS_Store'
--delay-updates --delete-after --delete-excluded -e ssh
~/Sites/example.com/www/ username@example.com:Sites/example.com/www/

Thanks!

Matt
