From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Mon, 7 Nov 2005 10:54:14 +1300
Message-ID: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Nov 06 22:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYsTE-0005gD-QL
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 22:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVKFVyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 16:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVKFVyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 16:54:16 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:5027 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932256AbVKFVyP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 16:54:15 -0500
Received: by zproxy.gmail.com with SMTP id 13so299885nzn
        for <git@vger.kernel.org>; Sun, 06 Nov 2005 13:54:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lk0j1jz4TU/v9VcZBL1yV87FXM3lO1rRK4xBpctXy405q5w57lroPSmdixCfD9bLp7DWCRKRRc1drgNwdjIzLIJ6JNFEfYyqXGUWILCdwz+lonRnDy0WpSnnfZ/7eUgS3IeixOh3qWilYHK9SFnDNR3joZNHroQONzrZFwBiwqM=
Received: by 10.64.185.7 with SMTP id i7mr4643785qbf;
        Sun, 06 Nov 2005 13:54:14 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Sun, 6 Nov 2005 13:54:14 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11229>

Strange!

I'm getting errors when cloning over http

git-clone http://locke.catalyst.net.nz/git/moodle.git mdlfoo
(...)
error:  (curl_result = 3601440, http_code = 200, sha1 =
f04241b142edfbf28fff2babb426cbab5b44e26b)
Getting pack list
error:
Getting alternates list
error: Unable to find f04241b142edfbf28fff2babb426cbab5b44e26b under
http://locke.catalyst.net.nz/git/moodle.git/

Cannot obtain needed commit f04241b142edfbf28fff2babb426cbab5b44e26b
while processing commit 0965f28d4d75f324b86c8f7490830fea471c65c5.

This commit object is easily reachable at
http://mirrors.catalyst.net.nz/git/moodle.git/objects/f0/4241b142edfbf28fff2babb426cbab5b44e26b

If I use cg-clone, I get a similar error

cg-clone http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti
mdlfooo
(...)
Cannot obtain needed object 214e6374d49e6d014f0ba6f159d585a3fe468909
while processing commit 0000000000000000000000000000000000000000.
cg-fetch: objects fetch failed
cg-clone: fetch failed

This commit object seems to be in a pack:
http://mirrors.catalyst.net.nz/git/moodle.git/objects/pack/pack-094560c0177ad659a6e172739c4be53da749e5f0.pack

git-cat-file on the server works correctly, and cloning/working over
git+ssh works too.

cheers,


martin
