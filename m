From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/20] gettextize: git-clone "Cloning into" message braces
Date: Tue,  7 Sep 2010 16:45:37 +0000
Message-ID: <1283877955-19105-3-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1Jc-0001wS-Ek
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab0IGQq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:46:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55184 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab0IGQq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:46:27 -0400
Received: by eyb6 with SMTP id 6so2467431eyb.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jXrkeub54xkJa9/oaRLNp6DKcaR5iUjLPsz3u25lgWs=;
        b=eDRt6YEsIh3c15XOLmjrfCW04d99SHc5gMU1URlqd6i2DT67BgirCj7EViMuJ+RTZa
         8FUWYI9ggJxCQFnjux2psy9rAVGkYfBZztbJ64KUP0AkLcn2tpEfoSm192n5aPQSYnbr
         R35wnRhoxUCJsAI10B+eLt48bg+qAFbpW0uFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XWmHrE34aPbA59ZTkFC/HZ+W+QLJluGds9tpJCFTxYmAewNZNmx3hiJJjNW/mBPxBw
         Cw6HdTQUMOc+ObcPs8ZMe0SZIAQtbnKFOJONg2r3Y3zOfend3lQIxDHw6Bv5DGaQhDHe
         Y91l2q4S98H3i5+ZyGSOfxDPKzAVWHDxdeMOU=
Received: by 10.216.47.140 with SMTP id t12mr1529808web.102.1283877984971;
        Tue, 07 Sep 2010 09:46:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k83sm4304468weq.14.2010.09.07.09.46.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:46:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155711>

Use braces around a nested if/if/else to appease GCC, which'll whine
under -Wall and "suggest explicit braces to avoid ambiguous =E2=80=98el=
se=E2=80=99".

This code was originally added in "gettextize: git-clone "Cloning
into" message", and tested under clang (which doesn't whine about
perfectly valid uses of C).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7b0d104..1f10f3f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -465,11 +465,12 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
-	if (0 <=3D option_verbosity)
+	if (0 <=3D option_verbosity) {
 		if (option_bare)
 			printf(_("Cloning into bare repository %s"), dir);
 		else
 			printf(_("Cloning into %s"), dir);
+	}
 	init_db(option_template, INIT_DB_QUIET);
=20
 	/*
--=20
1.7.2.3.313.gcd15
