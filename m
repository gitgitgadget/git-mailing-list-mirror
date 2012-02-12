From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/2] git-svn: remove redundant porcelain option to rev-list
Date: Sun, 12 Feb 2012 00:23:05 +0000
Message-ID: <1329006186-21346-1-git-send-email-avarab@gmail.com>
References: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 01:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNDz-0007M1-K6
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab2BLAXW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:23:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39202 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab2BLAXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:23:22 -0500
Received: by eaah12 with SMTP id h12so1355298eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZlMIIl0ZpknCg9WsB3lhOOm+nvl8yERgaYcClMUhHOA=;
        b=thfJEt+YRTPWZJkoMGCJLwBENFgw2wqXcsrkVSN/7XSfGP1hcwl8tteml4Lx+81Luw
         3Pf92HrLSuWxMLBd5JeG/ofvyBDMse2YnNLJPjqXLIKNSarbazxf0llsy1zhGKuLAO++
         d2PzO5QuSKXkCvCo0AXQUfyQDIhwjNJzqo6e8=
Received: by 10.14.39.148 with SMTP id d20mr3616474eeb.90.1329006200907;
        Sat, 11 Feb 2012 16:23:20 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id n58sm41705117een.10.2012.02.11.16.23.20
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 16:23:20 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190551>

Change an invocation of git-rev-list(1) to not use --no-color,
git-rev-list(1) will always ignore that option and the --color option,
so there's no need to pass it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..712eeeb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3920,7 +3920,7 @@ sub rebuild {
 	my ($base_rev, $head) =3D ($partial ? $self->rev_map_max_norebuild(1)=
 :
 		(undef, undef));
 	my ($log, $ctx) =3D
-	    command_output_pipe(qw/rev-list --pretty=3Draw --no-color --rever=
se/,
+	    command_output_pipe(qw/rev-list --pretty=3Draw --reverse/,
 				($head ? "$head.." : "") . $self->refname,
 				'--');
 	my $metadata_url =3D $self->metadata_url;
--=20
1.7.9
