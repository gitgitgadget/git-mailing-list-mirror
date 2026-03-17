Received: from sonic303-2.consmr.mail.bf2.yahoo.com (sonic303-2.consmr.mail.bf2.yahoo.com [74.6.131.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A013E3C6E
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765232; cv=none; b=Yly9oDalVkYMWUoICn6V5a7KDxAi3013Lhb9BKZtyygN7ARlRL9uUIzXbryXLUqd6bTfgjz5nJD/FcXVsKYFoWLrBJI8kWT9eaJ1wvV4s69ik9wT4UF4lN8dyrW/bO1sO5vAywKt5xs6N+jq7PsCZUQHX2gYEjIWMt9xXQMKFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765232; c=relaxed/simple;
	bh=CbpZINd/8Uv+V8a/Az+rEgQ4RtRexZzuzT6QQB7r+/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QN2xqrKAwSnemK1pOisIi85KZS58oGGeWXyL8lMhL503to/VRNgNMkxqi0mkn1LnP5WSw4AJY73L/rNXr3dFSEAnwQDHYZM+200Ek1xsaI3hvBCFB5+VR3BJ6/iWV81hG44lU9CcX4aByDKTjrcZDEGjdiYQAoHiFBLXQ2xKtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KW9gD7Xj; arc=none smtp.client-ip=74.6.131.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KW9gD7Xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773765222; bh=5WzUM3w9htQIoZdCr9aSuQnZYhegZtk/Lg+RNslxqDU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KW9gD7XjtdVi1ium1mXD0HLkPp74gg/yH3tXC/nqbgkQbIo5BSRXiOy/G5U/wRHER7540/d1+FERqgzRHhOmns+UxII6/dkbU6LtKWDGs3okyEqBD1pEJO1PceVSmH2pvo5t+HkObEV/29ljkBpJ180w8NBDkN7TPCZSdjBg0/kZyiVhEGt1NWPs9B9cPOU6gMJoYboMyM2jTJwjHi9cyUqz4TfcoXkdUxeLKz45yFqF+OAH0SikT5lWSRWspVg/bBq302GmdVPFRSK01iarege3EGGsjAfgOvTTlXSsOUvES4fGMPyIkc7YfAgk474xeXeVmJ1gZYz4jjSfuaoWEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773765222; bh=N0rwN7BVVUReeXjj7HgM6AIzDvapeOHubacWrNAw/Zm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=a6frqtISv6AStvmL3T+aKfKW5bSYhIEV84bZCEY7UsK6lPh+TCCsvThdrtSPcfzAS0uem5t0+C1ADdmjjissMrkzT2NU/9Vo4YRyn0HDOw9ZFrvuLm3bCwAEelsTqO86mK0psHRfZCgX/vsM5HN1U9c0PMq3YTM0St9Sn5ocDhd423fbgRbPhGpD6x/6Q3TXeYmJ1R23WbSR2xp3xs/dA1CKFyXQpSrQoGplUOCpd0lgAkrOeJXAVTnN5e7LX76WqYY4s+d7QSmbNfzmHy71RzwtsAy7dpLzeQBq7vFnXEefWx1tvyZ9Z9ZB6zuv8gzr/19x7Y40M1mVvkwQ8b1c5g==
X-YMail-OSG: EcdnIOEVM1kAh9e.r9OpKURAOT_SqAAXKAZk9l9PIfKApOYqlQDJpXlWiLcf60a
 HP9CC2XwzOpAu9JVmsGZFjIIrRy3sGepgfBViyv5vFWrrbfc_WU_F3Seovjg7lXlMVNHZQ2YY37w
 xeHMJu.X5X7fbCPtL8FzBK..PxOtmsoRJcdPn.px96.vh183WrZqwWFGdzWd2XcMTvz.KLhgNAT3
 1eeXRbDFty.90HqKTVdGqkB76iGLTyBqljgNncEh5WV7KtYkgpWqty.uw8upLZ9zn0rMbUCyh3GA
 z_T4.vdNKk1p2jR3GPloz5CY1ICehFaC2aqvlhFErP4Gox7vvsEG9A02VrdMMT6Va3L42p_vPCvC
 3JZjNuwkC9jBQLKs51fkjd7jlocuKXMKb9Gwhwrd0a19vhDihIknkD4kVq5gjfUlr0bY3NZ5SPFn
 _6Eda8YngOkVw_io9c.ECLg7zZXEkiwdRQZSW0um8S7ZB9_VrVW0EMgyo.N611kdDalH6QkLHxN1
 gwryfobcmn_NFT3etmz8CkJwFgmY98m4jb.f6skWiOjhBx5RFmIL4VYZI_CJjqO6xSmWoV4ut3Zd
 YrZUVA4kW2wQkJlpNMZExqU2uJG6yEjzTyHAFlhtYIEZXdrgF1DcMDQJB9u4FUIii7CYF0CCPLDy
 SvrMlgv6YGYPi.TF6HqcebPcJhE0h7XM4ya1P.sj7vaECUmqQm2XWvyRPuZV5LNqkanXPRo2K.pK
 bQFFQhNzRNx3kjqL8RCI6SJSJJWXUhwHi4SBI9ZST.rPZzubmeaEquBRa0pZ9Q.Ozt7vjDND0aen
 wB1jImYsfsI1grFWlzc1aT54YpN5JvSXd4Ayofxh8GrtrA8u0ydNl.PH2ErBtfOb5YlqJs6vwmm.
 DSDABFokxCL8w8eZ4P1cJ_MaeYv66Ih0a0Zpehkta_GGYKPs8Hjhh5Jm7C6xWRMX4A3xz3boHThX
 nJNxveZ6FDZurmVVVqdHqVpxmOhM2qeFLppjMedTHRTsAmQlDAomlCcUNmwAqGpvfd7qZBy4uQt2
 V35DFbuMeeBQcca1ckQ68dPzH0o.SOa7oGo4gp3Av8YzUxG76R6rx3qQUd4SRB4KKxBWAjU44.tA
 dQF3o1PRl9Cg_PH9pPV6KXmBirgtRxu0LnR8wI.nmaHa2RhjDF3ta48bNmBEGOdxYstpl4.niv3h
 .mbKhc1XKiveTCVR_oaAqT8whr0pStjmUFdTTZ8WO8CiITzPk342pSPrZQFsHS0hCpjunIbdkGg5
 6KHnmMG.uRP3YhZSxzgDtWM442F_VuLMeitE092H1CvX6lEw2FxY_UG0o7LuT4l2fGMr20n_BIF4
 Ekdn3JSIQqVKKyJyX0OlR.cTdkaD3OkWoB_YHq6c4_qmUrX3352gJmO7jP4BAF1qwR6BfE4jbWU9
 _TPuerEFJTCyUfPkP0vTg4Z5f7RqgZCFEB9Ze.MdN0zCrko215QmIHlNlDvyNprV1a7jobW9P.Sa
 fSMb0sn12awCxzW96mc49r1iFPdSViENVCiVnCWBOcxWS2_hxnNJ8ZJ3Uhdw7xhWF0oK93e_9PD8
 OXtsXfmc1.ZVQUmScjb1KPBj5TdRFOewjo_.PaY97g9h9XTlpjMMyAphSiEUnvKCZa7VBh_cWsCz
 b54SeCFPyR3aF9sxxCoQeLKygoqQpR5O9NbLuuR_mVlnC3Y92vEwPAQdphzS1Yh0U1kPEi4mpgol
 7TVhOJpHoqacb4iV6PLWmM_fwLgCOehwgTI5_8Bzs1Ua21.l_tfHm4oo5dU.CfY7VOZ0Jxweg1zF
 .Ghs_67PwwkmWoatoPTIPGK0z1eTZ3vErIg0Htpe0Kk8uGt.cKt9o3VMu3DcnQ.ItiTFogo_tgmu
 hgOs5v_Lh6.GHZEuPMl7gJziDaJMl8ywExfGpoqnob79_XE01RNidcX4.wPOk_PYFkjaFBvyKNbg
 P0KVgxF.dJWHbWzNoXNPQs5ZoM8l8.3nBTAeV.5DyArGvVWmZedC.c4XsDN54rXMdYT7DWEgSXow
 Fnr_qFiS9Hq4HOIlgb1Wr_Q4GypJFlf6FEus9MPzRXF2b4QKiXbPD24ioJV7iUygMu1gUGvHZ.H_
 e7BGv3RDVTM5dU66t3Dp4Dd19O54yCfPNX4OyPdearYqGtkKTdGyVedegr9FBSjFf_qPX6MIIyHL
 bI0Bu4xXJmfEG9Ykm72Zn_3e1ftUR7otpFcIG1UQmb4mVt7NkoyahkWt1Kc2NjO6X59YNT16p6Q4
 SzdhnZZ2z0HlLXLhSArNVIZYXv87I92VhDLMqOFrx0KWugoHfh2fFaINQKsMpo.LX45JvdR_F3GY
 yAooIAqWuC0UYgLc.BaQtqiXX6XE6BqolKaL0._U-
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 0344cdac-d01d-4a9c-8bcc-b7458eb06ed3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 16:33:42 +0000
Received: by hermes--production-bf1-697f88457-f5brd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 275727739a5229c22067aab3db4f1e1d;
          Tue, 17 Mar 2026 16:23:32 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH v4 1/3] apply: report the location of corrupt patches
Date: Tue, 17 Mar 2026 12:23:19 -0400
Message-ID: <20260317162321.71812-2-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317162321.71812-1-jerrywang183@yahoo.com>
References: <20260316162123.84532-1-jerrywang183@yahoo.com>
 <20260317162321.71812-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing a corrupt patch, git apply reports only the line number.
That does not tell the user which input the line number refers to.

Include the patch input path in the error message so the reported
location is easier to use.

Reset the line number for each patch input so the reported location stays
correct when multiple input files are provided.

Add tests for file input, standard input, multiple patch inputs, and
existing binary-diff corrupt patch cases.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 apply.c                |  4 +++-
 t/t4012-diff-binary.sh |  4 ++--
 t/t4100-apply-stat.sh  | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index b6dd1066a0..b7b0a201b3 100644
--- a/apply.c
+++ b/apply.c
@@ -1875,7 +1875,8 @@ static int parse_single_patch(struct apply_state *state,
 		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0) {
 			free(fragment);
-			return error(_("corrupt patch at line %d"), state->linenr);
+			return error(_("corrupt patch at %s:%d"),
+				     state->patch_input_file, state->linenr);
 		}
 		fragment->patch = line;
 		fragment->size = len;
@@ -4825,6 +4826,7 @@ static int apply_patch(struct apply_state *state,
 	int flush_attributes = 0;
 
 	state->patch_input_file = filename;
+	state->linenr = 1;
 	if (read_patch_file(&buf, fd) < 0)
 		return -128;
 	offset = 0;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index d1d30ac2a9..97b5ac0407 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index a5664f3eb3..b19fc9fe50 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -48,7 +48,43 @@ test_expect_success 'applying a hunk header which overflows fails' '
 	+b
 	EOF
 	test_must_fail git apply patch 2>err &&
-	echo "error: corrupt patch at line 4" >expect &&
+	echo "error: corrupt patch at patch:4" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying a hunk header which overflows from stdin fails' '
+	cat >patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -98765432109876543210 +98765432109876543210 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply <patch 2>err &&
+	echo "error: corrupt patch at <stdin>:4" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'applying multiple patches reports the corrupted input' '
+	cat >good.patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -1 +1 @@
+	-a
+	+b
+	EOF
+	cat >bad.patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -98765432109876543210 +98765432109876543210 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply --stat --summary good.patch bad.patch 2>err &&
+	echo "error: corrupt patch at bad.patch:4" >expect &&
 	test_cmp expect err
 '
 test_done
-- 
2.51.0

