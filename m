Received: from sonic305-2.consmr.mail.bf2.yahoo.com (sonic305-2.consmr.mail.bf2.yahoo.com [74.6.133.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1373377034
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765233; cv=none; b=DcvXAWiJd3iK/5FNc1NqRYCiPzbSVNfEnY3aLmxDig5HkhNxylMzpr42mmNJg4Yyt35J2hp3XMaP89o6qr7gp073cow+0wJYwsenRh0tsqGKXSlh3QP2i1Fp8ig1ALK7YN76PsXtHpdVwWF07P2NFitR1Z9tfHhHxVbhITo0SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765233; c=relaxed/simple;
	bh=ef8y+YATv2BetHYMYpc7tKq6UyYfVK8mZI7uV6ELD+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdAa6UZFLymKORRqSUzxS0/ftnSXSCBZpyz8f6r2fkQaBjkZpKaf2jqHAeKU/8cz64fnyat9V+u/D6KXWNajbN4IKfu7Sltlkm+V8YI1eDsYQl+huFGqQ4ulx9dqfC/CtnOREDDu+E69kdin56esytBT0jE2F+2+lgvq+FntUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oxxp6m8j; arc=none smtp.client-ip=74.6.133.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oxxp6m8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773765225; bh=4dTwniQklVeXx40jYpQSYlPTndZRhNM/ZbcC+qX1Q6w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oxxp6m8jvoX3rmPktJHZuRocTLmmhaSQakrKFu6PS9YSqt079q/0gDzJrSm1v5v6GevbWkh3kZ8HCrjF6JlS7K6lNM2IZ4PoIB2Ht/TRVy6xLUluVR4QCDPSD2H26ru6ncnULD/j9vKZDL414AEjRTO+Zf2Cl/vOkIr4YumTxDJM6epp4F2qVpkHMincpH/c56tgVuFg0WwAf2QJNM3LtW+ZsW0RF09qSpWw5wGrQgGifd9blEKyKwLwgxnOHHr+XXG8PbsiRwOdn4jxwAJby0IL5HQwhPJ5PlIkwh2tg6eAxV4mVBHYQPGJSNrZbividlv4T4UuyGKnizmCK5NMvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773765225; bh=DT7cVv4BtGfSkkJ3yN0Z9i9Q62tY2qFLC++j99NT19x=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Vao+FZ9ya9QZl6BimGfOv5GqXNiJ6zWF50Lsmiw1VXbvCiyL6rnXOEu9r0HrpjQmuxxekHundhTQYXVbqHXvKmhUHUSL3BwbUyFa/UhKaDQyFPgJamFy4rQWpFI9n9fM+VHuBaBU+Bq/XknjclFCs46StcqbwQQPr/BTyTg2xWG2abXItt8XfGcrW0c4GXAYsbOeh3NuwjvL9fX5se41dIrIdrXLqM72ddmFcc/MvUeIfwhwR3GkqRLlFk8km+rfiKZsAY/gCibbtKHa+FEJWb2SpEptRIiqGBoQ28d9HlTuUe+aUj+VQcA0bALsKoLsvImxJkKy+sjPB3EaZypJTw==
X-YMail-OSG: mBHHVkMVM1lP4_nZvEC_eFzZB3HStYy96QgxDuGeNICO7B7PG3Sa.h2CD1cWpwb
 8_M_lZ3uM75XzQqNuH3.sPSSmBk0ARWmE0AvTd3IkxJzDAKJK5JcF3KvDBLJnL20.GM1Dc53BPBt
 RfUxvJmInF5ZljwVP7ddiTfi.2kCztEAc155gyOUwSnyhuvEHbnDJ8x9dlaxQGNWgxjlIPR6G8Hg
 L_NV.Rl6Cn0fzsNMuLBxcXuE4mtJg6blKSv1wU4R5YBcE6sN3iB8.i_t15KwW4HZc1AwL3tDjV_t
 MTux3d3v.wdBsFqUuWu4dlm2JmA5Et.lEo5Yudls81lOAfQUEVab_3Hm3YjmPvlsrpbH4Yx.Nzzc
 reHW7d.JmKliIEG.Q9OOUUsfXJq9oKNihXz6QOo8a2q8aLLpbksSlZGLFCW7ios1pTVLg6LYqeuJ
 XiwBEWoxC2qlG1Pbugd3qLGafxYWXiKu4wPJAtr0lCrk0lNnMYnljnUPu7cq5Flka1pz_J7jrj6E
 OPWREKSKK6HfRVdmY1STh1JuhXylXPBopGr8BSCyr.s0B0Vh3aCroSANLSiDT4n.18xrW18zLLz.
 gL6NHZRyFD8QOiRXKAfIfRTqzk_ukbXotYQoMI561OxjRKR.8NJ0VQX86mWCQ6P8ArKgI4TxcGRw
 E1ZOmkT_B8BrsYplvUszXwLkdRFK812F.SFFnZJ9TONygDEyuTazmg92PXbkn2_wEE60CcPqgSq2
 pxMCgYdkNVoldh2nAM00JfGReEHobQqt22N9lnGExOUYy2GSKGwqyG6XDRbvwXa.4tG6rrcByk3L
 K1fRFyEFt3jqBiYUCpDvCA5bsPfo1zMGZduIZu2ruTJj4GAsGH6ZW2r9fFOwsMGQZfuq6aCjMzfN
 BlHRIaUht347LggF11xUWW1nTvPnmWBaXOdkUHeOgqlpGbBmEBIJQzSBv0OjK.D6arV7A8ra9nUa
 b5NCSg3r0K4bT7oi9Oh49lIdaRvkikjJFqNROIW893t5QeLjhady.jn617_RqYmt4.jpaV_V6QVV
 sfg3jz5j4q73f2EkZsh4EzQd4cYq1M9HsyNgijDs_c9SvYtMFUEDodi6NXGXFE2xq1foIIDVJiuj
 5g1E5G2gcdlBP9iGLGDjNwVoKGXO17ln1eTDKmIMls1vj7hpT4wRBRi2BxJqiSIsGiXozwZhfxy.
 sc8Nd8HL0o6EEwdBWiEI9qXOgrurrgbnd5rzpcfM2MWdKhwcY7FKqgndKX1x.8iYW9WLbrCK1bXM
 rhqPoWmx29sEbukbt7bXyibPrBLs_bTPPMj6iRDC_E1IUxAaCkyHF859StM8x3XdFOxoTGmBqpyG
 tvPm5pSei_k2A3N94ADABKxt4HcKpTEGfVCk9JxJdwCRGdnhz3DzQf9boiJMtRNh_MYtflRbV3AN
 0pJ95WGXXq5rSWzW9JJfYME.QU_z36z41BPV83PyX0iIXLFEFf.JdL79uh7vde5DMFWvrlKh.DYb
 bx8_MYxG.xvFEcTDLLSmN1i9sN4lDjtUonRUaplWO28epu4qAjqO9lAQPAOb9pemXiTYz_0q3wrh
 uwr7_esdevX4HqQFOoAaLhMDGa5SvaJuyRyuJAYUfWAoJxKATNFMwTldt.0gZw1JBKifKhAh.22B
 ok66Ww8ksc35YOEr9f2yjdXNwtNP74fmKiJEdJ8l5mkwRIB1y7aCds44klfmldiCCFqMMyCvNbSI
 DczXMakaWGjlL5oRKKSWR7BISijxVHbfUcfKuMMbspae5jlnahVszYd1Tp8QjA83Vapvz7MGSsja
 GoGvLzcC1rzbBj3PGCVX.q.wUZc8z7NF_PfUwOTSCVqM4acRi_0mmNr9RiAJSDx0ezjehgsQhOF3
 RHG1OcN3cPtsG1T7mbqu02o2rm7sUk_XcsNwJU59AILzclGISe5rXryPd6xd7bDcZU.Hri4RTGhb
 zPR6nZr2ZNJUv2m0ZcoGrlw__c1Alp6cz61breMAOf.OjgnUYIog4Fzb4K.aMgrAlVD5hJ0HipDS
 yHpkNR8zDYwq7csiGIaZk9lggzbu9PW1tyVr00W9I035dVZf_pinp.MEwTfdlABT10y.kt.8qpUa
 XzVFYn5J7XcIK7_weMsFEOTgOMc_vc_c5ZqqckbxWEdYk5Zklm6h7xuzRNCa4coDIcVs1HMOo_9e
 _sldIKYEWKlRwK.mxzmvRA.bdnooLZ2oqQyroRWUvepALfdLmhvd16B7UB2ZdMQFb55PVm6yOsHM
 Q50eGohU6_eqpR_9pTVLF8CUb5vRndTxQDS1MNan303upMqIWP5U.N1XvmW2l3dgrZaMySjZ020t
 ZLI0bKxAmKNmgaYaNdDDrfO4zOXFK8y64QecJD4PhWg--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 13852b48-c9eb-4a1c-83a1-50b2c0ef816a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 16:33:45 +0000
Received: by hermes--production-bf1-697f88457-f5brd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 275727739a5229c22067aab3db4f1e1d;
          Tue, 17 Mar 2026 16:23:33 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH v4 3/3] apply: report input location in binary and garbage patch errors
Date: Tue, 17 Mar 2026 12:23:21 -0400
Message-ID: <20260317162321.71812-4-jerrywang183@yahoo.com>
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

Several binary parsing paths in apply.c still report only line
numbers. When more than one patch input is fed to a single
invocation, that does not tell the user which input the line belongs
to.

Report the patch input location for corrupt and unrecognized binary
patches, as well as the "patch with only garbage" case, and update
the related tests.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 apply.c                 | 10 ++++++----
 t/t4100-apply-stat.sh   | 12 ++++++++++++
 t/t4103-apply-binary.sh | 20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index 700809f3e6..84b4a569c5 100644
--- a/apply.c
+++ b/apply.c
@@ -2110,8 +2110,8 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
  corrupt:
 	free(data);
 	*status_p = -1;
-	error(_("corrupt binary patch at line %d: %.*s"),
-	      state->linenr-1, llen-1, buffer);
+	error(_("corrupt binary patch at %s:%d: %.*s"),
+	      state->patch_input_file, state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -2147,7 +2147,8 @@ static int parse_binary(struct apply_state *state,
 	forward = parse_binary_hunk(state, &buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error(_("unrecognized binary patch at line %d"), state->linenr-1);
+		return error(_("unrecognized binary patch at %s:%d"),
+			     state->patch_input_file, state->linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
@@ -2309,7 +2310,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch))) {
-			error(_("patch with only garbage at line %d"), state->linenr);
+			error(_("patch with only garbage at %s:%d"),
+			      state->patch_input_file, state->linenr);
 			return -128;
 		}
 	}
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index b3d93d8ed6..8393076469 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -125,4 +125,16 @@ test_expect_success 'applying a patch with an invalid mode reports the input' '
 	EOF
 	test_cmp expect err
 '
+
+test_expect_success 'applying a patch with only garbage reports the input' '
+	cat >garbage.patch <<-\EOF &&
+	diff --git a/f b/f
+	--- a/f
+	+++ b/f
+	this is garbage
+	EOF
+	test_must_fail git apply garbage.patch 2>err &&
+	echo "error: patch with only garbage at garbage.patch:4" >expect &&
+	test_cmp expect err
+'
 test_done
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 8e302a5a57..f2d41e06bc 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -179,6 +179,24 @@ test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
 	" <patch >patch.trunc &&
 
 	do_reset &&
-	test_must_fail git apply patch.trunc
+	test_must_fail git apply patch.trunc 2>err &&
+	line=$(awk "END { print NR + 1 }" patch.trunc) &&
+	grep "error: corrupt binary patch at patch.trunc:$line: " err
+'
+
+test_expect_success 'reject unrecognized binary diff' '
+	cat >patch.bad <<-\EOF &&
+	diff --git a/f b/f
+	new file mode 100644
+	index 0000000..7898192
+	GIT binary patch
+	bogus
+	EOF
+	test_must_fail git apply patch.bad 2>err &&
+	cat >expect <<-\EOF &&
+	error: unrecognized binary patch at patch.bad:4
+	error: No valid patches in input (allow with "--allow-empty")
+	EOF
+	test_cmp expect err
 '
 test_done
-- 
2.51.0

