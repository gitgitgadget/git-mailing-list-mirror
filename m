From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/Makefile: Create test-results dir for smoke target
Date: Sat, 14 Aug 2010 11:37:05 +0000
Message-ID: <1281785825-18255-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 13:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkF3G-0001hx-0T
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 13:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0HNLhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 07:37:17 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52798 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951Ab0HNLhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 07:37:16 -0400
Received: by wwf26 with SMTP id 26so2018560wwf.1
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=xajf359w2QXUCc0nks18l/hwT4l1/cQkmIARA5gKjdE=;
        b=dF5sNfC10hxtvLIOU7kb/BpOSE0v6pGps3GUpN0NfjgIZgy+SGxN8GlsjMahpixyzR
         jYv2K1iHZmEbIQl+mOtLfkLpF9dyEeKQF6TxTu16VE2KTnVnZ2dIbwFMKBAi1bZdLRMc
         I1h1fNUBPHEY/eexbjrOGen5eJ9YRXDgrH2iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=SUGZmgTZrGHNFb4ZdIETOuOtuSfxcslNoEEJDSDYchz0FYS4oxxEqRbd5waY5XWT2S
         IzT4HhmuIG3MIeTLaSXoQvHCYqLIeDcJ7fcD+6Y39jsmWMaflVN8YOllIEbL/UzqNxm9
         ZDZHdfn9NflPzzlk7LXCeDeyZvgi31HdMOxYw=
Received: by 10.227.132.129 with SMTP id b1mr2589015wbt.5.1281785832291;
        Sat, 14 Aug 2010 04:37:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm2119476weq.16.2010.08.14.04.37.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 04:37:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.ge1a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153554>

Change the smoke target to create a test-results directory. This was
done implicitly by the test-lib before my "test-lib: Don't write
test-results when HARNESS_ACTIVE" patch, but after that smoking from
the pu branch hasn't worked.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index b81fb91..d9c67f5 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -58,7 +58,7 @@ uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || e=
cho unknown')
 test-results:
 	mkdir -p test-results
=20
-test-results/git-smoke.tar.gz:
+test-results/git-smoke.tar.gz: test-results
 	$(PERL_PATH) ./harness \
 		--archive=3D"test-results/git-smoke.tar.gz" \
 		$(T)
--=20
1.7.2.1.338.ge1a5e
