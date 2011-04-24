From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Announcing Gitspread - Spread Git commits to several servers with a
 single push
Date: Mon, 25 Apr 2011 00:15:20 +0200
Message-ID: <BANLkTikuCfnSuY2r+YzWu1PegP3baniOjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 00:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE7ad-000218-Jp
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916Ab1DXWPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2011 18:15:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56730 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757908Ab1DXWPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 18:15:21 -0400
Received: by vws1 with SMTP id 1so1437592vws.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=uvbm5nUpgqILs0oyc+XO4JnVcGaJUcFw9Q0sobZcN3s=;
        b=w4DRMv5wq677PAkuCXKAC7Gr3lModzFB6tn5VRllVpmhqcuRASiAg4/V2XZI+L0OQw
         IcmM6HXm4GAa+cNMNzM+2F3YpllV47h87yljuMIT+ucCHlp+Z6YHpWodQ9lIYkmxqNmQ
         A9FdKucDSZCgCwyWqP1fgKisYt7NwhtOmZIGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=ENb2E30zD9rbXkLCds7oNhZzO1yfCiLb6fyOQ2rMPR057f76UKthItl7n3jDwCcykY
         ot/vkkCVS+QQYj3OY6C1bKfWSNP3TNIU/E5mzgl0LXCweDJU+/S8y5hVEYGVrq49IXCm
         ixvOdJqFE+EujQQ2l4R3Z7qX7ZbhC8LBfBa54=
Received: by 10.52.97.229 with SMTP id ed5mr5019928vdb.237.1303683320083; Sun,
 24 Apr 2011 15:15:20 -0700 (PDT)
Received: by 10.52.181.99 with HTTP; Sun, 24 Apr 2011 15:15:20 -0700 (PDT)
X-Google-Sender-Auth: AZ70wzGr8Xubu49NVR9rfYNJ3Xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172005>

A project is often stored on several hosting services like Gitorious,
GitHub, repo.or.cz or similar for backup purposes. Ideally, all these
repositories should be updated at the same time when pushing. If you=E2=
=80=99re
using a slow Internet connection, like a mobile connection from a
laptop, this process tends to be rather slow because the commits have t=
o
be pushed several times over a slow connection. Gitspread aims to solve
this by pushing the commits once to a server with a fast connection, an=
d
pushing the commits from there to all the defined remotes.

Setup
-----

- Create a directory on a server with a fast connection where multiple
  repositories can be stored
- Create a bare repository for each project under that directory
- Copy the post-receive hook script to the hooks/ directory in the
  repositories
- Define all necessary remotes using SSH push URLs
- Start the gitspreadd daemon in a shell where ssh-agent is activated
- Set up a git remote on the local computer with the slow connection
  pointing to the repository on the server

That=E2=80=99s all there is. From now on, you can push to the defined r=
emote and
let the remote server with a faster connection take care of spreading
the commits around.

Source code
-----------

Gitspread can be cloned from the following repositories:

- git://gitorious.org/sunny256/gitspread.git
- git://github.com/sunny256/gitspread.git
- git://repo.or.cz/gitspread.git

Bugs and suggestions
--------------------

Bugs and suggestions can be filed in the issue tracker at
<https://github.com/sunny256/gitspread/issues> .

License: GNU General Public License version 3 or later

Regards,
=C3=98yvind
