From: Lasse Kliemann <lasse@lassekliemann.de>
Subject: Re: Easy Non-Fast-Forward Pushes
Date: Sun, 01 Mar 2015 12:08:46 +0100
Message-ID: <ygeioel2cw1.fsf@lassekliemann.de>
References: <loom.20150227T170215-199@post.gmane.org> <CAGZ79kZ3_ohE6ebY5MvOk6+QfChppR_OtcmVaw5LBoutTWm3ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 19:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS8VF-0003zY-El
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 19:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbbCASWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 13:22:05 -0500
Received: from smtp-01.snyder.systems ([85.214.28.39]:53213 "EHLO
	smtp-01.snyder.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbbCASWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 13:22:03 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2015 13:22:03 EST
Received: from sunrise.localdomain (unknown [84.141.132.91])
	(using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-01.snyder.systems (Postfix) with ESMTPSA id 224A723F61E10
	for <git@vger.kernel.org>; Sun,  1 Mar 2015 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lassekliemann.de;
	s=2015.01; t=1425233815;
	bh=alh3PausIlu9QWOc637/oWTSu7GT1hEvaS4cwTGKzVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jyL/bw+rjyTKwiS6aR6fis8Zd6AH+bSngnl5Ozc4CncUCKJ6KDNfgBVhHrgt72BLk
	 bACmewoCGtf10sZeiyOaooMRSuaCiAWFx06c35j15tUs9xtmT221DzcErKVyNI3e/0
	 nEA6cNxTatNIKSN/IPLslFxbkLBDsMqHCHAkX1do=
Received: by sunrise.localdomain (Postfix, from userid 2001)
	id 0FC152581EED; Sun,  1 Mar 2015 12:08:47 +0100 (CET)
In-reply-to: <CAGZ79kZ3_ohE6ebY5MvOk6+QfChppR_OtcmVaw5LBoutTWm3ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264563>

--=-=-=
Content-Type: text/plain

Stefan Beller <sbeller@google.com> writes:

> So maybe you create a bash alias for
> alias gitup='git push origin HEAD:${USER}/$(date -Iseconds)'
> which would push your current tip of the repository to the remote with
> quite a unique name.
>
> Then you could also do a "git commit -a && gitup" to push your changes
> to the server
> As the integrator you could then integrate branches with
>     "git fetch origin && git merge origin/sbeller/2015-02-27T09:34:47-0800"
>
> So it is doable. Though I am not convinced of the workflow.

This solution is not too bad, I thought, but there should be a way to
remove those branches once I have integrated them. Otherwise the
repository might get cluttered, and I found that those branches are
particularly annoying when viewing a graphical representation of the
commit graph.

Deleting is possible, using 'git push origin :BRANCH'. But then, anyone
with pushing capabilities could do this! I don't like the possibility of
one team member messing up another's commit, be it on purpose or
accidentally.

In Gitlab, branches can be protected. For this to work, however, I would
need fixed names. So I would assign one branch to each team member, make
those branches (let's call them "personal branches" for now) protected,
and then configure their systems (by shell aliases, scripts, ...) to the
following:

1. Try pushing to origin/master. If it works, fine. If not, goto 2.

2. Push to the appropriate personal branch.

This system does not prevent someone pushing to another's personal
branch, thereby possibly making a fast-forward push impossible. So step
number 2 may fail due to this, but this might be an acceptable risk.

Thanks a lot for your thoughts.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJU8vM+AAoJEEKWo+CJA9AY0gEQAI0DVW02+SmPQ820PGpZ1uIV
6fLzmui/P487ulE7hCcl6wWIephs8yxuK5/oyYN/0WcRm4i3Lap54KYIo1lto9mb
v75Mwf60TLtMlxsIEOlP3buWgfuVoU93uCK7CRJVgB/vlY+rpVlJpEcpV6/H9J6m
Xeq/cVmOvE6FBDuz1X6BerC0zsTVOIXBmyps8z3HYE+9K/qnP8Th0nOr/Cu2Q73s
FAnP7phpx44WWM5lscvfsqJEKTWlUba1Eq5qEFhS0kC6gIszhKIkFsMVvNKyrJCj
Ec0DQEhWNj82GK5SJXmbEAFMBckli3bULz2T2C1HqVptcLi/tz+4zcjpnfJ3PTdb
HkUnbpL6WVHggFOuMfqtmbGGtkFyb7Q7dOUkF95ZGqRxsQv6z75XG9P1zk6vDQeT
elIuyGhXzNehC54em4eGVes3JP/pSCwZiKoa6/Zw1Ug758Jt3TokhyKHJ5p+8lQ0
ynb91xttAvZtULNZQlHNCw+yYZ55bfHDJSOsMLVY8e2GiChOWFM20yj234kqqzO4
dbQpcHPQKuyl2lL89kpvIgD5R/5rhryqwlr+at3Lf6KNBuEI6zV9LVm3GjY3RF7b
1ib+1gzLQbivomCG/hVOTf5Xdodj9ViR9j4uNU1H6a6kO+PNBvcDKxLFjm3SzLkM
HlynQ+ThKbgZNKPDrAsD
=x423
-----END PGP SIGNATURE-----
--=-=-=--
