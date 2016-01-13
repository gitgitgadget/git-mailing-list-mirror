From: Erik Johnson <palehose@gmail.com>
Subject: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Wed, 13 Jan 2016 17:47:53 -0600
Message-ID: <20160113234753.GA26473@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 00:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJV90-0000fv-05
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbcAMXr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:47:57 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:36155 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbcAMXr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:47:56 -0500
Received: by mail-io0-f177.google.com with SMTP id g73so241143264ioe.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=A3ts5bmH9W0JemtDGijvM/sDFLAZi5wCiQ5Kndt4+zU=;
        b=T0Md/29P1Ixbs51VE8cCh58xngTInOTAo8mlepwoiU6dFBA/4+2Vm2mxRoU3O7wsLc
         5N3fi/qvtG8FxGlP+N7VXFX06XpKBwxQ8y3Cha5cZFalUNxILbMmkg/ysjCMjkNXkV5K
         M+jKicvWFXMDJwzeC9huKnJt9lG/EbTaN1cMtcZsQ9LDWM7Nm8GGQ0Xt1cppbM9PDcHG
         gBHCTEee8Q2bScOmrJ17RZu7YE11cBKunMd82bHnpLKcQto/sSa65uwJtkFs6dFjCoR5
         tf5mY0RHbl65ReihQTJdZzUAfAY+Uv+iwXpcAuQcWB7KqmHgDASWfcAXWCcBOsmrKTgP
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=A3ts5bmH9W0JemtDGijvM/sDFLAZi5wCiQ5Kndt4+zU=;
        b=PPFDt0gz/pA2rlwXOfTcgmnLs68GOkdpwnBBMZjYP9gV48RSwUleKXoFEYBd9Htxk7
         sdUSiIQIrlmDF46ioms9dXPY0EnCK6uMamnXsekPl8I05FQC6e41mmiQXIT7x3yNxwbN
         dGvvvtgq2tyi68eyPwNxajKGwuVwQVvxQJHpEw0HtcwY8Ams1utPZ9fvAqweUu8vMhF2
         nCQ1O2nhR7fm3TLKv/syFOoWBEmN0gu9I3vf3CQKqTIY/19Q3UAJMp7crrpYYSM7ChtN
         53iAiD4fn81KF+qNWZzGGkQRXJH0Ey9E9LAnb/FZk8RJndcEWOz0s9EEwJ5xPcndydOf
         uejA==
X-Gm-Message-State: ALoCoQnSFCx+G68kA/AayyRGLzB/gc0Gz+j85TS0wlUTva+llvVj7ur9wLymhsjZ6JRxGiTClTCOhvBxO9C0GU5FgPZ6bFqEFw==
X-Received: by 10.107.136.226 with SMTP id s95mr1591469ioi.38.1452728876180;
        Wed, 13 Jan 2016 15:47:56 -0800 (PST)
Received: from gmail.com (c-73-51-186-156.hsd1.il.comcast.net. [73.51.186.156])
        by smtp.gmail.com with ESMTPSA id or1sm1763419igb.4.2016.01.13.15.47.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 15:47:55 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283998>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Since upgrading to 2.7.0 last week, eventually I'll get to a point when
I run 'git worktree list' where several worktrees are incorrectly
reported as pointing to my main git checkout. Further analysis of the
files in $GIT_DIR/worktrees/worktree_name/ shows that the gitdir file
for the worktrees which display incorrectly contains ".git" instead of
what it should contain (i.e. "/path/to/worktree/.git".

This was reported a couple days ago on Github:

https://github.com/git/git-scm.com/issues/650

Since the audiences for the mailing list and Github don't overlap
completely, I figured I'd report it here to get this issue in front of
as many eyes as possible.

--

-Erik

"For me, it is far better to grasp the universe as it really is than to
persist in delusion, however satisfying and reassuring."  --Carl Sagan


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAlaW4ikACgkQXlWDxDeAjz90lgCYgNn/A4jy4ZsIbmi3YmOb8GUd
dACeMbWHbQIEA8ikTGOF8FMLCoeEbFw=
=sONT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
