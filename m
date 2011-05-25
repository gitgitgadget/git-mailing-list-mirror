From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: gitk normal use on linux repo and severe memory pressure
Date: Wed, 25 May 2011 11:20:24 -0400
Message-ID: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 17:20:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFtC-0002p5-Qv
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016Ab1EYPUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 11:20:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51085 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794Ab1EYPUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 11:20:46 -0400
Received: by gyd10 with SMTP id 10so3066044gyd.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=AmarGFzPHJzjHDAGUqP3Fh6lFwrajDGCoh2Lgt7GA/g=;
        b=hLzkDf/kRgnAfWL7KpjG4BsD3N8aNUmlU9ydW/EG84P7lFDiIAaHv3w44mwHRr03Xa
         OrsKpNjFOBKWiBjhDgtl6MEphTnBzIdFd8WyE0Om8QXeyMU5BfYI9Kl5pBc6/PCJjQDi
         WgI3LC0h+5RtP52DX/rgWsSACCTNPz5e1I/Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=DCiFKj12xy5Ju8fogKtythn5fRyI4wm8hm10jjPENBMyWeZPm8IpBwo7luEe0nUl3V
         bmKeHDhnFA/0U0ldCDedUhYmJjabT5oYJIN+DLcZ3Y34a7RMyBfSz2BfeE12dTAO5SRj
         f6zNjO8yhBCDum1XFTrqaiC82rdmZvcKWZxLI=
Received: by 10.90.61.8 with SMTP id j8mr5617457aga.76.1306336844130; Wed, 25
 May 2011 08:20:44 -0700 (PDT)
Received: by 10.90.65.10 with HTTP; Wed, 25 May 2011 08:20:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174414>

An anecdotical report: Right today, I fired up gitk on a linux-2.6.39
checkout to review some new patches. While discussing the patches with
other developers on irc, my machine (arguably, RAM-constrained at 1GB)
started to hit swap heavily.

Took a couple of minutes to kill it and get the machine back to a
usable state. This is on F-14, git v1.7.4.4 .

Linus' early instinct that people care about the recent patches (so
gitk and git log better show them immediately) was spot on. Now the
problem is that gitk continues to walk history regardless of user
interest. It gobbled up a ton of memory while I never went deeper than
20 commits.

I am tempted to set a global config option limiting gitk to a couple
thousand commits, but it's not really the right solution. If I am
trawling older history, I'll hit the limit and have to close gitk and
reopen overriding the parameter.

Are there efforts afoot to teach gitk to read in _some_ history and
pause, continuing if the user scrolls down? Not sure if searches are
done in-memory in gitk -- which probably complicates things.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
