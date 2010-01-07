From: David Kirk <davemkirk@gmail.com>
Subject: Strange happening with 'git fetch'
Date: Thu, 7 Jan 2010 11:59:39 -0600
Message-ID: <de73f1891001070959h30e4ecebw7c852f0417647419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:59:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSweA-0003G7-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0AGR7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285Ab0AGR7m
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:59:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:30877 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0AGR7m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 12:59:42 -0500
Received: by fg-out-1718.google.com with SMTP id 19so7605079fgg.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=7IXBbuIHpMTjYsT2+2MZUJMnXoY26wz3vZBAfGQNAH8=;
        b=Zqff0pW3AkFt4yy1gOnYqT8hxoUQMnkHzUx/Iy0LjnDe85hr09U9EVGQ8K/iFJHJLN
         YccwJscD5kV9r1WZLLkI2e1VffJXNloR8HZi1UoGBp84rY/BRGIDCUoeamGINIefFjex
         4jWTI2+OZ4VEzt3EHWchyxMpCbi68LfYQaeZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xxMxUgMEsnOLcGYSmZhoUVrCXauImyB5N9ihDuQhxcHuzIISGKWU+qqhHnTnMFuRvX
         IURXsfz2tAiTgVYHitq2VZ4jU+FiTLCXUlfBf5Tyq5W3ux8nV1VYBSuXZggjVuMZ0hVj
         mbyem3ChoDGhGaVaa0BRKXnaD1kHoYJmtpMo8=
Received: by 10.216.167.196 with SMTP id i46mr1310400wel.130.1262887179945; 
	Thu, 07 Jan 2010 09:59:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is very strange, and defies the understanding of everyone in the
office familiar with git.=A0 Is it a bug, or some feature we don't
understand?

Basically, when I do a 'git fetch', it updates my local repository.
Now nobody else is doing anything, so the remote repository does not
change.=A0 Doing another 'git fetch' should report that nothing needs t=
o
be done and nothing should change.=A0 But instead, it reports something
about the remote HEAD, and changes my local branch 'master' to some
strange location!=A0 Running 'git fetch' again restores it to the
correct state, reporting that it is updating 'master'.=A0 Repeated
invocations will toggle between these two results.=A0 Below is a
transcript from the bash shell.

Can someone please explain this?

---- bash console ----
dkirk@RI-ENG-21 /c/Dev/TSWeb2 (master)
$ git fetch
=46rom //10.18.0.53/git/repos/WebTrading
=A0+ 03c60a4...209b0bc HEAD=A0=A0=A0=A0=A0=A0 -> origin/HEAD=A0 (forced=
 update)

dkirk@RI-ENG-21 /c/Dev/TSWeb2 (master)
$ git fetch
=46rom //10.18.0.53/git/repos/WebTrading
=A0+ 209b0bc...03c60a4 master=A0=A0=A0=A0 -> origin/master=A0 (forced u=
pdate)

dkirk@RI-ENG-21 /c/Dev/TSWeb2 (master)
$ git fetch
=46rom //10.18.0.53/git/repos/WebTrading
=A0+ 03c60a4...209b0bc HEAD=A0=A0=A0=A0=A0=A0 -> origin/HEAD=A0 (forced=
 update)

dkirk@RI-ENG-21 /c/Dev/TSWeb2 (master)
$ git fetch
=46rom //10.18.0.53/git/repos/WebTrading
=A0+ 209b0bc...03c60a4 master=A0=A0=A0=A0 -> origin/master=A0 (forced u=
pdate)

Thanks,
-David
