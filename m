Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296228;
	b=MvN+WI9r2KsZXlgVAFUfBcJ8FaU1qeBe1KjVDwHH3m3gqZ/HkLC2zJXdntxouYfBPAe/
	 ekwie3MjlGIc7i0OJFv0UvlvT6uScY4XOO+J6oAYvDwNfINBgjkUxkurkLgvlZhD1mZrD
	 mEaYc2L6QWokD30H3BZJV9CN8Jr389OejWkEFAsTEPJ9HZyyS6cwb0sNEeRc8Xp9hBowo
	 pOCvzOq//IWXvuqrNP4+Ht2Z1ta6orVGc7ieEL0fRX4/w3eqoKOqRtZre6ecXhyWbFDuD
	 cn9oROikrnm9bz3SBuFo1vvKy0EbIaGG0lbj4VZeDjKMqbXRYI+nPjFG+RLJDjeD5KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mOb7Z7vPsNDSOjE0F3kOxagSp2mu/SmEVOeHUSZhVmI=;
	b=EoDCGSgBrXJ31sNeLAQ20bUW3ltcV8M+/snlzubcljI3ONVJlbUXtDTtCohp3fu0eLcV
	 ylkvXYbVH7rsRo8MVkLWc08khk05EIdIGwdnvll+R/FuKBNz/POpN5yGnb7Dg/WlIAxwG
	 fp5rwXTLyQzmhyxpguJvd6zWxVspQ9I1Dwsoiaf++5lLYWOxOqNtp8/Gv4IEDm5A+3OpG
	 M8fJ6el0gDpP6see/Vu6rrQQeIwsKy9naG/VcWwtbXGNCRIHhgIlzJvk0AhHNON2rW04K
	 0kjEjZ222YKS4iQoSei5SpIQQhizO0lFrpR8VVD6IJQNZVcbX8t/3lRQ09X8DSMNYQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhCzBHm5;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF460A6F4C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13AF460A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhCzBHm5
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6f5a0893610so1044994eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296227; x=1794901027; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mOb7Z7vPsNDSOjE0F3kOxagSp2mu/SmEVOeHUSZhVmI=;
        b=rhCzBHm5AW4j7yBhShQ2xV7yJe8YIXZzGaPd60gHkAPacmzDIQcwYoBnGJiLpwvIlb
         oY6VNXkSvEwRMRLdN5EmzfZPuT3109oV2AxEuDwxaiLH5D0G1HaRGNp/rt1t7mAoVp7I
         sc8V4fDwAoIlt/oytmVyq5qvhigN1aUjS7J2s/CDijRJ+/ntu8P3suTwT7p/U3A7GNIi
         rC3zGYkY+uqeFdxpyrM98v4iixD9m0w2b11SAzaXT6I4IDS7hSgw39F7dz3g4Ma2vhWO
         02WP9ZwApu3HDnmQj8TAOhDmkrkF+BUq1Ya91iq6OaME3iF5DFQSN0kiadqKPyLXKNgI
         5x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296227; x=1794901027;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOb7Z7vPsNDSOjE0F3kOxagSp2mu/SmEVOeHUSZhVmI=;
        b=DvMSUly1iAFI7o2TPI7Y4bWgrU0DtL+YsX5aCYic/Wz4aRKPiTN8TlduVikmcjF5Pa
         s6xLuwe+/WkQJfx2T0fTguqIoaF/t4p1hng6hcS+ZvxaX6dKqRS78LOG76Xqw0cVXJfV
         D5TPnx8rTsE+atu2uBx8Z2kDk/57pSXASpfiXDBMVNiss5I7nRxlb0CgoQzodqcb9VQy
         qEvB2hm39c5UbWmOl+O0wn+F5ZMLlJMLSm+fu+x1aACbJ8LPpONma6xl7RCV7Gyji7Pw
         YNCA0ao51/L1szQU9+JNE2PpVMvb/MiflULuy1axnnneC0XdGzt5jBupjg/kfRGTvYm4
         WuXQ==
X-Gm-Message-State: APuU4Z9/1IWS0TvOEYiD9QQZQsm86C5ojw5z+ZnPBnPuMuXSfGbFrBZ1
	29dr0itoPUrQeYxr1A5rzDil9cT/J9A6vks++5uWdrHco+cUfq8bOlrVo+35NeLi
X-Gm-Gg: AYBFou1CiAWlqFbctLNusigueP/mMqH84cZ6CXGipTS+Xz++3CVEZ3oYR3RRwy5J+JK
	D9+NDpZo129erpaTGjC4XRMr4qJru0CDEZu5HtcVStsFUihDEFT/9fdKyLEUd6whdkWpnlMhtk9
	dH97IvvS7MaNHP0rEOwX8OlWv/erHaWgN70lxvXsmOKT5hLCpBvOT2nWlam6OQ3zGDxJsF74Lpq
	K8RiV+YXW2dYIj9sTmJN4oKQhCrrwlb7RPH12zkKvaiMMDZ9r9aBHDl/ZInjJo07QZ+KfSRf3LL
	O4a/2uHz4SfVBuMgoHWx1Rdr+0SSSU0tjqqn8ACpJ8OBlF7I5CjMVy1NsAVo4BMqQ5vIR1aG6E/
	MXp4m93zq+3FOz1hxH2g45fkgeID/7ZCCEiFlh/6uMCOEoSMbtCT7ppBPtezJW3txm+2/P4m6Vk
	lyp1IH+Kpe1q9E/cg9nKq7IRCeLz5mHq9yx3K8ClUvFjnPSiELhWkWS8nd92R4fJvURL8s1eQnc
	hq7oVGA0ugR6QSfkRY70K4cMt9n1CvVHNH8WBGW3wDgYJEMMR+NpIuvaPwDcxkchyJqpY+vzH9L
	/aGqE9ocUG/l9pvleaHutVySq6CbWuYL2UA=
X-Received: by 2002:a05:6820:2206:b0:717:163:aeac with SMTP id 006d021491bc7-718a654c1f7mr847223eaf.68.1794296226662;
        Mon, 09 Nov 2026 23:37:06 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fc1041sm1105979fac.7.2026.11.09.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:05 -0800 (PST)
Message-Id: <25843b43bfa414319a8cb36cc69638dcaf7c5edc.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:37 +0000
Subject: [PATCH v2 07/15] blame: handle NULL values for color.blame.* config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A color.blame.repeatedLines or color.blame.highlightRecent without a
value makes "git blame" segfault: git_blame_config() passes the NULL
value to strlen() or to parse_color_fields().

Reject a missing value with config_error_nonbool(), as
git_blame_config() already does for blame.date and blame.coloring.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/blame.c         | 4 ++++
 t/t8012-blame-colors.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1e753a0b60..15cacd1002 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -783,12 +783,16 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
+		if (!value)
+			return config_error_nonbool(var);
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid value for '%s': '%s'"),
 				"color.blame.repeatedLines", value);
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.highlightrecent")) {
+		if (!value)
+			return config_error_nonbool(var);
 		parse_color_fields(value);
 		return 0;
 	}
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index d2653b3c31..5eeb7338a3 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -69,4 +69,11 @@ test_expect_success 'blame color by age: new code is different' '
 	test_grep qfunc colored
 '
 
+test_expect_success 'color.blame.repeatedLines and highlightRecent need a value' '
+	test_must_fail git -c color.blame.repeatedLines blame hello.c 2>err &&
+	test_grep "missing value for .color.blame.repeatedlines." err &&
+	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
+	test_grep "missing value for .color.blame.highlightrecent." err
+'
+
 test_done
-- 
gitgitgadget

