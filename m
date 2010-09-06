From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/15] gettextize: git-revert mark the "me" variable for translation
Date: Mon,  6 Sep 2010 12:21:41 +0000
Message-ID: <1283775704-29440-13-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaix-0000aR-61
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab0IFMWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0IFMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KJxSnCym5l67nuTsZAZjkUY0dSbTLyuNHoA+EyenQ9U=;
        b=dgeP/QVKcKLgRfwudsyuW5Fq2sOIdDBH+6bjVrBC3gMGRw7kKChUXEYyf8luBZKY23
         tbc+nK1tuSTmajq1NwPrAMBGtDik+vhV8itc3j5nNClbb6rOvHREMBNC8YgsqjDuxysz
         iQX8A2mOi9g81971cj9n/09MJfEAUKeD/R3Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HxHzLAT/NgXS4MNBTDqa/OPfR9O6PGEPIstnoSYyF9MMbQ/MpcXm4+DVjc5kK2IVxJ
         szbL9x17xomSpIPj4KOx2lauWKlVaHwnpUCEe+m2H0LWHo/GBO9VBKTxeeRN4k3O0LRT
         7yl2talMq2/fVjj/0GWsxlFMQ9Is1LjKOzzl4=
Received: by 10.227.141.136 with SMTP id m8mr287262wbu.227.1283775760700;
        Mon, 06 Sep 2010 05:22:40 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155561>

The "me" variable is used in many later messages to indicate whether
we're using revert or cherry-pick. Mark it for translation for later
use. Also leave a TRANSLATORS message explaining what these are for.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ece0c0f..2f319f8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -552,7 +552,9 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	struct rev_info revs;
=20
 	git_config(git_default_config, NULL);
-	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
+	/* TRANSLATORS: This is used in several error messages indicating
+	   the name of the current program */
+	me =3D action =3D=3D REVERT ? N_("revert") : N_("cherry-pick");
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
=20
--=20
1.7.2.3.313.gcd15
