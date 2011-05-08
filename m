From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 22/48] i18n: git-submodule "cached cannot be used" message
Date: Sun,  8 May 2011 12:20:54 +0000
Message-ID: <1304857280-14773-23-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ308-0003rg-VZ
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab1EHMWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab1EHMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:54 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=X1KPXzQAThDTXIF1oeD9Ypg3bSDA/fz+hvuxV/Mkph8=;
        b=HkVvS1yHEzBsV8fchdhrfEPML3Z2F7qm9yaruwZXaz8BGi7auRANArw3RvT/pwien+
         s3ux0p3ORVQV+x9ga/w7ERvnLuxcmGya1HXhmVo5vEFwST+LN63z686XwYY0a6WaA2PI
         WSVvI9qCdoiNCmKJq+/EMGbhKsE6b5GsHBG/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OWuua8R6aT8UxAunMAthDbBibnK9bHfjkX4Gl9PoMrhSpYiGn8NGaoSe5b2i+jMhBw
         ZSMd7idV2Rnvl0vl3vtLGP2s8HAaLPyxy3FuU+4AzgVxhdB2ipUyXF1Z7nEPjSuDE4Hv
         vv9jBk9/4r0OsrglLsAjmHr5TuNwhqcUrxBBk=
Received: by 10.14.15.2 with SMTP id e2mr2710352eee.229.1304857313684;
        Sun, 08 May 2011 05:21:53 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.51
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173119>

Gettextize the "--cached cannot be used with --files" message. Since
this message starts with "--" we have to pass "--" as the first
argument. This works with both GNU gettext 0.18.1 (as expected), and
the gettext(1) on Solaris 10.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ecd0b68..f0f885c3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -617,7 +617,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "--cached cannot be used with --files"
+		die "$(gettext -- "--cached cannot be used with --files")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
--=20
1.7.4.4
