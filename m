Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931417;
	b=dTBTe1thlZjJNVqigRcKTuBLsqIYTKzszy0wAd0oUlBeVO+Fyo+i1UPFnDaMFuREZ3k5
	 HOvyyBFljNrIuFDCeP1Gbytv6tCeZIPmKPClZhhVEJJsrPR0X8xfMx/7Lpynf0zqEijhd
	 QMi0qVhPL317m9oT4wptgtojwp5+o4PMu1nX+8r3NHdYqnE9TPP47jfZZbnwpU1+KoLaY
	 emIJ2CglZPNsutqBnKzUKx6cAR6roy2SO0ZIUFe9n0pcWlPcu0LEBkiy0ZjWPea54PPGz
	 O0WYapEOtwLzHvu0ZTSs3MrQ8UaOv90btkrl1FkmGtmxDLbcD8JwuMlUx5SyCwW+Bqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0AsenNdiqH/MwQfhN4ts+uUEZWwRktO9XXC7+si+Ei0=;
	b=rQoujDprMKrcwbbYOZZgVo3UTiT1mW0apnjo9eXbzkMwJvDJrM1kijqjqQjFnRBCK6Zb
	 24iGq97BnW892CJbp9BiUuMeOGE6lsWhkLzQreTfTlyEkDKRo8fSbLrVGt2Vv+yH088ab
	 y/B3drhJCgtX7oKr+cgBMJ/wsOw1oQVkP69ft33fTcmZXn7N0e+CGqXUEN8+pkmZaUm/M
	 8E66sXFZa1ZhznzCAKgfeyqRsqDWsHr75d5kEPQDM0544vr26MdTctdqjGk1U6zPcx6jL
	 AoT6QzWIDncHvFjk0HiYaQwbXBmwU2/T9eif6UsVbLdC5iMzno0tSE7zPAjewZNoVpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POn5BFFy;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9E606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD9E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POn5BFFy
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so1485403c88.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931416; x=1795536216; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0AsenNdiqH/MwQfhN4ts+uUEZWwRktO9XXC7+si+Ei0=;
        b=POn5BFFyVOrt8qma9v7/IPbDafuMRtlmv8SILR3PZlpOVrH2ePZt5eRq83kjizP1Wg
         gGOGuICdjKTmtyV77mVz6Q6pFFQcf79GFMHv7TFbpPziTD8wvkLHGg0A6qu9w35i97sN
         W0ps3qgx3VbJ9Bwexam6F2MYOPw8kAa8I01MbH1wNETdJydmSqu53zxGRlResvWzCYQk
         My+AWQoJUdZ1QxOsv4HbIKL30F8iPTulPbnVCkjGDHLCMQJJul+U9VHugh/Gy4F2gjmD
         pcMaYAPIILYHzmmBbqKSemgpWbGa/yIy9Bb59tqOHqDj2idcyd+hjdN4qnBGilM9QoxZ
         NCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931416; x=1795536216;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0AsenNdiqH/MwQfhN4ts+uUEZWwRktO9XXC7+si+Ei0=;
        b=wBm3lC4AmiWzzQ5U5GiNGJDJ/HcMFpGqvIJuiK6UCTjjMcn8ZhwyUvTbYvf2yJ4KyY
         4m1AHTE6ACYwpGgncYrm9QUB6Z2ShJyo7xCXkKT09+ycjM8bYkpk3e6xI7SCkSdKcyxt
         88KzLcXSXHH5YDsxIuKXulXTfvJtUgJWy92P7+ogo6YEDXZz9jHDSLAfNkoP3hcrN/Sl
         bYxrS9yVkWKGNKtZDvIYArU7g2NnXpgz4IbEhPY6kH5PrYLx9D5jeqPhsSWe25UOJDra
         gN83ghR3BOWTWtsvdzaBXp+a+m1+LdlbMWNJERXgcww9uVDyPPK+rpU2OXz7ot9AkFG6
         xz6Q==
X-Gm-Message-State: APuU4Z9KvP0LLSFRXHxGh6J5dPfwxqwCuH/kTzQQfM3qC0h0OY2wbCJ9
	GC+fjC/Cmvf/gtLZJLDTL8HBSzE4Z45/f8YCCEmgg1QZ40S1nPeWetUwWf1rE2vj
X-Gm-Gg: AYBFou22f+5SwydD1RXJwAu1dhCu0TKP4zbS9+fSmfa04zpO6ZZy+chJ3uuUMThLSb4
	Juf8WpkAjjwj2sPksKY+K6XaSHTZ80cLBAwfrFIgEVxM192logmh6yQdjLJ+ou9ijLgfYKgC14+
	IKuf8vJTWPkPniRFSeGyfumKiNbLA2Yjr7txiasrdTqUzeFyjvhwjneDcuxO63Y+Oe5UgXQRjXh
	dk+rpN9PwVeU3nzGqVAJ1opnDXHFyJZwfnqM6wpUlPjjlvC+zNBzjiVYHmwZYNTBd8VA4tpsE83
	QHjVdApUPwS/cZS3aas66tbJFjehD5YmgR3e/yYF3jcjJdBlveolq7qbGUiN4txsUevmP5+amrb
	LYSujEB/xNvXdxu/AzbxxcE7yv0UJp3nisWaNRpTDeP8MM3vVUz1KHD3lY4IM7byIx/1h09j28Q
	6gjfCJ9DGWXC4bev+fVx7fnCRSDsMzv4n45wSa2VoYvm2aAQuryP0YfOKCyI758R9/UFYSvI6yL
	Vg6wsmC8zhH5KqwgYM05bz05BeOf0MSrfuUKZLoBOTfSgmIICDOOSuraWiua5hd19ClzifHhqVq
	+JDncb+Bh3KBNq/lRS2Mc9arEy1CznD120oklg==
X-Received: by 2002:a05:701b:465f:10b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b543be9aefmr52571c88.15.1794931400912;
        Tue, 17 Nov 2026 08:03:20 -0800 (PST)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm38039687c88.7.2026.11.17.08.03.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:03:20 -0800 (PST)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Tue, 17 Nov 2026 21:33:05 +0530
Subject: [PATCH] fast-import: do not show the path when "feature
 export-marks" is forbidden
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-ks-fast-import-consistent-check-unsafe-v1-1-fc1ed53c79b2@gmail.com>
X-B4-Tracking: v=1; b=H4sIALl6/GoC/yXNSw7CMAxF0a1UHmMpqcp3K6gDk9rUVCRVnCKkq
 nsnwOydyX0rGGdlg0uzQuaXmqZY4XcNhJHinVGHamhde/DedTgZCllBfc4pFwwpmlrhWOfIYcI
 lGgmjo3MnMtBx709QY3Nm0ffv6Nr/bcvtwaF867BtH/yi5daKAAAA
X-Change-ID: 20261104-ks-fast-import-consistent-check-unsafe-0a94ffda7518
To: Git mailing list <git@vger.kernel.org>
Cc: 
X-Mailer: b4 0.16.0

Since 68061e3470 (fast-import: disallow "feature export-marks" by
default, 2019-08-29), a stream that uses "feature export-marks=<path>"
without --allow-unsafe-features dies with

    feature 'export-marks=<path>' forbidden in input without --allow-unsafe-features

because the whole feature string, including the "=<path>" argument,
is passed to check_unsafe_feature(). The import-marks variants pass
just the feature name, so their messages do not include the path.

Pass "export-marks" to match, and make the existing test check the
message, not just that the command fails.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
While backporting patches for a security release, I noticed this.
Was waiting for the security fix to go out before sending it.
---
 builtin/fast-import.c  | 2 +-
 t/t9300-fast-import.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ab5d2a2344..998167794c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3918,7 +3918,7 @@ static int parse_one_feature(struct fast_import_state *state,
 		check_unsafe_feature(state, "import-marks-if-exists");
 		option_import_marks(state, arg, 1, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
-		check_unsafe_feature(state, feature);
+		check_unsafe_feature(state, "export-marks");
 		option_export_marks(state, arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 15f511fb6b..33c04e0315 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2337,7 +2337,8 @@ test_expect_success 'R: only one import-marks feature allowed per stream' '
 
 test_expect_success 'R: export-marks feature forbidden by default' '
 	echo "feature export-marks=git.marks" >input &&
-	test_must_fail git fast-import <input
+	test_must_fail git fast-import <input 2>err &&
+	test_grep "feature .export-marks. forbidden" err
 '
 
 test_expect_success 'R: export-marks feature results in a marks file being created' '

---
base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
change-id: 20261104-ks-fast-import-consistent-check-unsafe-0a94ffda7518

