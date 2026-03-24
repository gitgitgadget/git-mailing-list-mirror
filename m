Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AC178372
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326051; cv=none; b=ajNy9F7fdeG7b5qQz0wEwWEwDfUguEc1cac1wLqiN1vwmPnjMiaphr429MdFaf9PSeMYQISQBFZ8uN3hBABnS8esK9VDK88iLo5PojfYhQJrWn0LlOV1fZ/ITSSUBMixXLXa7EXurbQg1oc3OpeH048XpMsWFVRS+fbnjREPEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326051; c=relaxed/simple;
	bh=tmmgrYXnR9REdfZbZxBKndZZCvYgvIspCMPtEAG9ww4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArJaGRLG/2YHW84Iyrr9qOTYtXJWXTRm8d58gicRCaHfz2o/pr5KYiz4EVp25HdjXimth7PMYVS4RXA2uDU3k7HXYweuuv/c3SHq8Qyq180bQY6CFVc3e84flaG9DkFa3BiqfDg0df9iUKx2UtKuPOiHHLhx+KGkh5F7BANQj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEnIcemb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEnIcemb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8fba89cb5so7495325ad.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326049; x=1774930849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5Sm9YoJI6g1lRK7wcOQe82ueFfmoSgs29hGkf+q4rk=;
        b=CEnIcembGFKAWOEFeQznRpnltkFS3LkvZKeVx2XNbfyYFYAiZdwmGSaoK+v3/uuftd
         DccEY1QVem6WmtcL7uV9eox45mfZ8lOh/PNf0jJUSpC+GuOtIVuDK5vUAc+kLyjYg0YC
         NDP5zj/4HM6OL+j8ImZV453EJjFR9FNxromk/V1ic/jYHMf0k84yZNWIfyNpLOno3zUv
         HOl97nOx0S3KrgisLc5FJUcl9Jj2c+91Pe5uvxxzlrNexyXDSzDo4iNVR5mAcqjICKzf
         6EltPNgOx6ZNmM6h63tUW9PDsYbbV62zcoVLkfQ5sIs46ZtN9dxvJWvuVCLfgANneFvh
         YWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326049; x=1774930849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5Sm9YoJI6g1lRK7wcOQe82ueFfmoSgs29hGkf+q4rk=;
        b=Mz+thqJsdhyGDtNJpl7/Dm2hmFEOkIz5D8qUWCpti1jB6rdTnIYRn6uICJVAxjLNkk
         T0M0PUEee5p44fWaHJtZCPAKE57AuZgp4rDWFRMhs+I6xFId1feGdQgkDF6SJ8gxp6bG
         I+zXRCZ61Fsu6Ay94DkWrre/2fTTxRX7WCpvb9gmUJ5iVRdRAT5PaneOt99lkO3Inm/C
         HDz4wqW8wEH7rs/kP/7HB++DDwhiGtv0hHHMpXP+haxX35M78BwLbjs2HzRJVmR8fYE3
         aiFSsH7ZaiiQGAijb7dQKlfJ1BGDhR19I2XwZXRtJ0lkO0jSCyxpQbAxXH/4j+feYQRL
         WWTQ==
X-Gm-Message-State: AOJu0Yx3iKiXV646wGNjnNvOGtcpAcMSWS6yR1B+EURL6Ctn4zwxiUdX
	VQ1oUJP5pyl7514KiD58+iy/le3X+rQw0dD6xEQLgv0qCpq4l0zezBhfsTxyelJb
X-Gm-Gg: ATEYQzzVgDX2geAeshwYjpd4f4VMxCX2teAtjaVmo6cKbi4zajqH6BEq8aFGTIQP95N
	vAL/chjFz1trW1E7DFmdVpUdAWP7Vxcf5JhjPIIvtCcXG0OymrmzLxpHifGIESnvh0xXrXHAKXD
	3scVQlroyB+RxxUuD2MUOrNuvZevgUJrlq2LcT0aJ45tF1ybpekfu5MuxwtlxUa3hu7NHuIBP9r
	qEbrmBCie2qb7hM89DRycuGz120ri29Q9Rf8MD33A1GqR1Q34ZfRj81vvjFed0BLuruCe5kej7f
	Lumhezr/non5vaPy/lgRem5qNvnz5LP2W/anyjcNC4ukgtE1SBllycjxFfzrpBpAXdNng710tbS
	FZohoN6zvR7zjNm5vknWasrKSDKGpJlBVttvWLcX7217OL4qgsftmc95Oe0cZPKtfxwtF7/LIa1
	f4ixLkGxkiMJUQC/+T/BQEtBm5MjvL5bgMS+TcSxNrujdVb68Arfzq0ZbwCrX7nE4AeP123oQ=
X-Received: by 2002:a17:902:c410:b0:2ae:5d79:a163 with SMTP id d9443c01a7336-2b0827e3cffmr103658315ad.5.1774326048765;
        Mon, 23 Mar 2026 21:20:48 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm162529375ad.60.2026.03.23.21.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:20:48 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: gitgitgadget@gmail.com,
	a3205153416@gmail.com,
	jayeshdaga99@gmail.com
Subject: [PATCH v2] t/pack-refs-tests: drop '-f' from test_path_is_missing
Date: Tue, 24 Mar 2026 04:19:03 +0000
Message-ID: <20260324041903.43155-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
References: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_path_is_missing expects exactly one argument: the path to
check for absence. Passing '-f' is incorrect and results in
"bug in the test script: 1 param" during test execution.

The '-f' flag appears to have been carried over from the
equivalent 'test -f' usage, but test_path_is_missing does not
accept such flags.

Remove the extraneous '-f' to use the helper correctly and
restore proper test behavior.

v2:
- Fix unintended removal of shebang and test framework lines
- Keep file mode unchanged

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
-- 
2.43.0

