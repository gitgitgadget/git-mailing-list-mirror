From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/20] Revert "gettextize: git-revert mark the "me" variable for translation"
Date: Tue,  7 Sep 2010 16:47:42 +0000
Message-ID: <1283878065-19349-3-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O1-0004K7-UU
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab0IGQsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51719 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab0IGQsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:02 -0400
Received: by wyf22 with SMTP id 22so4441498wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oOl6vUIQ/vx1HmvlrUD5D8Prnm8Novnon7zwACTILFU=;
        b=Kvh1XB86GVaQDzoRgqGVnkbu0EDplt4suRTsWJv4yocDFgo+zjml+O9X3FiJFzYY2r
         NR70BttHoHjCdgAit57XO4qq7LVLrxnn7tWI0cm/8+x89LLSRZulkVJo34Nf3297HHsb
         9CqrvfpeZkrFwUDDNmzGUK8FkcJHMn3dLMeZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fWlp5lbxT/kT8i0ZoCuUYe6P5RXqxhI+HfQoAgGaenNh8svrRzqJIt0I2mk4/BnOCx
         UB2rnTafcZJBlMDUkPBf6P64N/qd5pPNAbd2Esdz4FVReb1LodpaniFmUVgiAeTETeuB
         0NDbzDiZV8aK7Chf92RLwwd2a7HHoaSC8+5Yg=
Received: by 10.227.128.18 with SMTP id i18mr126487wbs.135.1283878080831;
        Tue, 07 Sep 2010 09:48:00 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm5895402wbe.23.2010.09.07.09.47.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155715>

The `me' variable can be either "revert" or "cherry-pick". Some of
these should be translated, but it's used in too many different
contexts for the approach I initially took to be useful.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7157ee1..a93a5ba 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -553,9 +553,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	struct rev_info revs;
=20
 	git_config(git_default_config, NULL);
-	/* TRANSLATORS: This is used in several error messages indicating
-	   the name of the current program */
-	me =3D action =3D=3D REVERT ? N_("revert") : N_("cherry-pick");
+	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
=20
--=20
1.7.2.3.313.gcd15
