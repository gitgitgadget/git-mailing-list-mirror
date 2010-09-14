From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 05/20] gettextize: git-stash die + eval_gettext messages
Date: Tue, 14 Sep 2010 13:52:05 +0000
Message-ID: <1284472340-7049-6-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 16:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW3P-0000uh-6Z
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 16:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab0INN76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:59:58 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:49094 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0INN76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:59:58 -0400
Received: by wyb40 with SMTP id 40so9225897wyb.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mbmraObPPVn9KBEeNljC3yNFr2z58cNrAsMdZ2TDpMw=;
        b=u3ra0T/L2sxYb2hQErj5qxoyTMe6Mioz/pz5+Dl+7v8YiLP4j1n6behO0TH62VVeP2
         0xvrRPyER9AZWXIqx/0wtqKWl8Vs+od15pMJPIp63d9EQ0xDJj+taiTc4Srw/VezjrSI
         C7S/xijTg4rM0tFSq2HX2W1Vzg9RcDvCxVyBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AEl2k5Fj45q+lqHDNWwoJmsH1fSCs/M5+ob34/kUkqZMjEvmGw6UilXnx7iy6o7aim
         YhybOIG/+x4q+LL43mLaSriafSvWmJa+3jzO4lD7iDI/nqjp8C2Okz44GdcVbVmcYmLG
         81MNaBXoBVqcp/89txzrQPd7fGOBo+b/cyFGA=
Received: by 10.216.54.16 with SMTP id h16mr5776717wec.6.1284472373864;
        Tue, 14 Sep 2010 06:52:53 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156189>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 3a0f917..38720b8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -301,7 +301,7 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "Too many revisions specified: $REV"
+			die "$(eval_gettext "Too many revisions specified: \$REV")"
 		;;
 	esac
=20
@@ -325,7 +325,7 @@ parse_flags_and_rev()
 		# this condition with a non-zero status code but as of 1.7.2.1 it
 		# it did not. So, we use non-empty stderr output as a proxy for the
 		# condition of interest.
-		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$REV does =
not exist in the stash log"
+		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$(eval_get=
text "\$REV does not exist in the stash log")"
 	fi
=20
 }
--=20
1.7.3.rc1.234.g8dc15
