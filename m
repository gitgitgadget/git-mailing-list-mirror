From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: fix syntax error in "Use advise() for hints" test
Date: Wed, 18 Aug 2010 14:36:44 +0000
Message-ID: <1282142204-14720-1-git-send-email-avarab@gmail.com>
References: <20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 16:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OljlO-0001uz-PI
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 16:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0HROg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 10:36:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34551 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab0HROg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 10:36:57 -0400
Received: by ewy23 with SMTP id 23so394417ewy.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qPgZvVIaQDkf1+EUAMCS3eYDOdS+dR4bC07Vtogok0g=;
        b=bSxVbctHwTV3nwoHLb8tlHV+fEymBqDkYpAdL6XA5oO/FigqUnwn0zbQhLmTIgWC0n
         reoIvH686bf4Uu+JviMC4fmPYus/4kQ3nTnAECmKiPJ2Z0iifRtKTKhFbswM8mJqz7NV
         i8oCQYVDTuoqpekdZ1guAsqQhXYHm78n8x9f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JTDkuOBuDTwSNzLW5NlFz2WVLc3VVoRJLEIW/pxcO9vXrhssNNtlgCvFURwjDhjhSi
         lKdKTYcT4Ki+YDj/sOfceu6/c0niPiHeiZnhGdYduV9SPXF9/mWKrnw3AwtWx6I+3Sqa
         Zo948oqeuFcTAJ56piaB5QoZ2402W1R03HVLw=
Received: by 10.216.3.12 with SMTP id 12mr2079728weg.109.1282142216159;
        Wed, 18 Aug 2010 07:36:56 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n40sm243740weq.5.2010.08.18.07.36.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 07:36:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.414.g9bf49
In-Reply-To: <20100811083100.GA16495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153858>

Change the test introduced in the "Use advise() for hints" patch by
Jonathan Nieder not to use '' for quotes inside '' delimited code. It
ended up introducing a file called <paths> to the main git repository.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3507-cherry-pick-conflict.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 3f29594..607bf25 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not adva=
nce HEAD' '
 	test "$head" =3D "$newhead"
 '
=20
-test_expect_success 'advice from failed cherry-pick' '
+test_expect_success 'advice from failed cherry-pick' "
 	git checkout -f initial^0 &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x &&
@@ -46,17 +46,17 @@ test_expect_success 'advice from failed cherry-pick=
' '
 	git update-index --refresh &&
 	git diff-index --exit-code HEAD &&
=20
-	picked=3D$(git rev-parse --short picked) &&
+	picked=3D\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
-	error: could not apply $picked... picked
+	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit -c $picked'
+	hint: and commit the result with 'git commit -c \$picked'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
=20
 	test_cmp expected actual
-'
+"
=20
 test_expect_success 'failed cherry-pick produces dirty index' '
=20
--=20
1.7.2.1.414.g9bf49
