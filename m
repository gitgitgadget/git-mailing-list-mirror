From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] bash: complete more options for 'git rebase'
Date: Sat, 17 Oct 2009 11:33:38 +0200
Message-ID: <4AD98F72.1060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 11:36:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz5iD-0004Hf-1c
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZJQJdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 05:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbZJQJdh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 05:33:37 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:44005 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZJQJdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 05:33:36 -0400
Received: by ewy4 with SMTP id 4so84371ewy.37
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=C9DvsRow+b+449q2sIUTS8ihIy2ZyqMa3oYpKPMfTUg=;
        b=lSJXdfESI/Qms9De1mG0v2zr0dzjzAfWSCLtr+alHn66Ali9vvFuF5+R+pX7ub7G16
         BSpj6Sku0R223TGigcVKHVklvFWLLvmRDBHt7hUId+uuJ8xZ2D0K2qWW0gJGtdYnydcp
         K5CtB0hMDJB6oSUQ5ni8Ni1BujAFuibRS+l1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Sjn14MLDbX/pxEo4JigCD3ozVtfIMs+QdJ0vI8/u4vsTdnsCvZZUT3R0mOL9ouQuxe
         +yQFsnj9VpWJ7Bf1UEZYkD6aLjbmJGgmrGe8noIdTGumZoScjd1YyfZF9q0uZw3JUYUB
         xT0BLua1IEx/m8/piIsMF27Vy4ZtTxa7eeIoM=
Received: by 10.211.156.13 with SMTP id i13mr2847430ebo.22.1255772020744;
        Sat, 17 Oct 2009 02:33:40 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm3450552eyh.25.2009.10.17.02.33.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Oct 2009 02:33:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130554>

Complete all long options for 'git rebase' except --no-verify
(probably used very seldom) and the long options corresponding
to -v, -q, and -f.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
I am primarily interested in having the --whitespace=3D option complete=
d,
but while at it I have added completion for the other potentially usefu=
l
long options.

 contrib/completion/git-completion.bash |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d3fec32..7c7318c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1323,8 +1323,18 @@ _git_rebase ()
 	fi
 	__git_complete_strategy && return
 	case "$cur" in
+	--whitespace=3D*)
+		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
+		return
+		;;
 	--*)
-		__gitcomp "--onto --merge --strategy --interactive"
+		__gitcomp "
+			--onto --merge --strategy --interactive
+			--preserve-merges --stat --no-stat
+			--committer-date-is-author-date --ignore-date
+			--ignore-whitespace --whitespace=3D
+			"
+
 		return
 	esac
 	__gitcomp "$(__git_refs)"
--=20
1.6.5.2.gd6127
