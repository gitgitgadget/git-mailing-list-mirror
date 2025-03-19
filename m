Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12852505BA
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372189; cv=none; b=ZXu3qNR6a5XhRLOZyi8vKlLXcgLx4B+O0lGUpG+67pmF2QM+u8ZeZwEtvtcHyBmNGatpAeBcfcfURAUtPDgbmYpjWZnfICkqxNtx616nLiGH2IDr+KEIklLyNAepgRNxPsEX10cVg7ApxGvkGvh+KUho+h+zcXFSCSZ+1WrNS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372189; c=relaxed/simple;
	bh=Wm30MwozU1jdz0OA+qZ08vzmfJNSsoBBv7kN7ZgZU2Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=g1Sey53fk7DM06sW/5WfvTHovawRdS5HnZ2qrTWDm4bHnd7OxQuKFXKDw0bopuAETdT1h7HsN1ZmC7HbWJPgSfCD+7YOS/nQfN7ZlwL4cXPzVyMoIPY6M9SaqVj80a1txPV0f/OR1CYUzFHoX6xe5o5e0RxbXc99c9QYmMNAUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkFiNqAk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkFiNqAk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso4323227f8f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742372185; x=1742976985; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUUJjuIVJDlhZXailVlhIKyDOgTwU+mE9LDEFazWwLk=;
        b=WkFiNqAkzehfEnOYf9HglcfcWGxdh/QQBEbBXeLuldN4sAgg1SpxBS+dV+Se1Q0Kss
         XGY8ssYFVIaEu2xfvqzvc9UoDIzlEfg489FWYJ8KX4CO12+a/RgPl5sA2pLU6Maor1lH
         1V3TwOrbbZOBxY8POccnqP10F1AtdAcl2CZiw+ZLuwMLLbgMSWSYfZc1FZyJAndyrWrT
         CXClXTT9TvXGOsNCcM9kF7x0Z1PperEadQ8mBRLr2goP98FWduOSksoAxwvFHsJqakOO
         ZAEA1HE+lLfcMUeXdhy6E2cD1xj3g2JgSMIVr+F4Z/gc/xiQN0aNxlTNA4NG7a4x8ppY
         p3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372185; x=1742976985;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUUJjuIVJDlhZXailVlhIKyDOgTwU+mE9LDEFazWwLk=;
        b=TLfKarWqGjR20KIdvICytWI+NSJf2LTy8U7ZBXwpzUjdKcPP6/DbxBZDqxyVmUQOIO
         vXDp08fHy3bBP6lHr2fLyTqeYC98Si1inpO6IcYQT8TOYDmY/C7TXwgdKTSAWSStkrCN
         wz2dK17IyiwJvkkkFgjYItH80HGvXfJNHkvT2qyROJSwxdE8DkG//ECSSpBi0MffOVlH
         jTQgrj1ReMj49TudiOt2h2fcZ/5k1RvUwLGkJn9NiDw2LF6+4dBV2/zuF7RSu98j8NCL
         qV4IKOhfFB61x0o5bkz9ZmbaE7w05I35bkpjdo5iMWEnMJiyYSMDjw9RAhvcJ2wqlnxZ
         Kg4w==
X-Gm-Message-State: AOJu0Yz9OpSGuFiGILKkb1GWXo/1NMKO01ugibYrpP/LnIOOCXPwTGwK
	bUL53V+jn7n/2Ml9XF/xOctJt+9CjLmcM1EkkvCKVRaXyei9wAWI2X+w1w==
X-Gm-Gg: ASbGncuGLu24s9V4fHmfDRLDOjwETRbRkZ6kvRctVujlog0RmQ4Z/AxBTzX/UivCNCi
	VJ/lzYqV+oO/3lSI6X9Byp6QrZ5JDEqvKVMMYq3/KsaVwzOTw0awMkVYvfgFv7CZitUCDmpwkN1
	IEw8azz1qkvwPHHci3OEUH/KaN4IigbrBJ5dA6gEGeXQP/jpHES5kfj30I+xCw7x552N52FJDCa
	NCqx8XHt00OM37+nQVDvQsC0OiDHErPjQYWlJoiSIDxxaNyt9xqru5cyDTSX7ONlLp9zSiEI2jr
	VUnQk+TJ+To1StnKI/FdlcmGw5fR9Ur/c81GRBCMJD/Kmw==
X-Google-Smtp-Source: AGHT+IFk5JE7wTcJ8QhAeX0FQtnE9KaZ8Ftuz+ta0lXqi45FXsztp1pjZZGHLxKFClYJRsWmuHLnwg==
X-Received: by 2002:a5d:584d:0:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39973b72b34mr1222318f8f.54.1742372185330;
        Wed, 19 Mar 2025 01:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb876sm20167041f8f.83.2025.03.19.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:16:25 -0700 (PDT)
Message-Id: <cd907cc4ff4f05ccb6ae98ad52c0f3382a9b4f0e.1742372183.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1880.v2.git.1742372183.gitgitgadget@gmail.com>
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
	<pull.1880.v2.git.1742372183.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 08:16:22 +0000
Subject: [PATCH v2 1/2] completion: take into account the formatting backticks
 for options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the modern formatting of the manpages, the options and commands are now
backticked in their definition lists. This patch updates the generation of
the completion list to take into account this new format.

The script `generate-configlist.sh` is updated to get rid of extraneous
commands and fit everything in a single sed script.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 generate-configlist.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index dffdaada8b5..b06da53c891 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -13,10 +13,18 @@ print_config_list () {
 	cat <<EOF
 static const char *config_name_list[] = {
 EOF
-	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/*config.adoc "$SOURCE_DIR"/Documentation/config/*.adoc |
-	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
-	sort |
-	sed 's/^.*$/	"&",/'
+	sed -E '
+/^`?[a-zA-Z].*\..*`?::$/ {
+	/deprecated/d;
+	s/::$//;
+	s/`//g;
+	s/^.*$/	"&",/;
+	s/,  */",\n	"/g;
+	p;};
+d' \
+	    "$SOURCE_DIR"/Documentation/*config.adoc \
+	    "$SOURCE_DIR"/Documentation/config/*.adoc|
+	sort
 	cat <<EOF
 	NULL,
 };
-- 
gitgitgadget

