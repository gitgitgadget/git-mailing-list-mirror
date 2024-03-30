Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40F2E407
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807750; cv=none; b=bHBoIFncsyRtKeyfu3HhHoFZ3YojLdx+dMO6l3CO2FfdpW/k5X3B3q1zcXIgjom84XWZeH4wKuHdHTiPUdXTcFTcs1/brKFPQSC4hGMDciDs7W2s0+c40rn7V8JY/Qvx8ud+y4CXZqBKgrPSd0gTsj4ngepOPT/EVQTwkK4Loz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807750; c=relaxed/simple;
	bh=cWCNv6+CSGTw/HolqlG8XVfgIKjxfnyKGy3Edsqg8DE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NXUHr/r00zY6Y4mXtYgtiS5dMNlkzPXqdF+VFAl6EeD2sFqeYY+kQFy0h8dWoKUAgG7ZMgFRRqEPHNz+i90NWcvOpJfd1E8oTqGjZI0A+0NDufEwcFbrNxI1uwO4IFcepjCCqgbXn/3PSCMXC/h9lxbjabb1l5/kkoftnScR/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUdDm8Yb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUdDm8Yb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4155bdc0bf5so1501605e9.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711807746; x=1712412546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hjdu2rY57ENFkmm6x/igLaZ21xle0sgwarZuWC25ufA=;
        b=HUdDm8YbwL/+P5nn+5h7RSQqR6zIar4QWlqgRc/nozlsO0wis5LHaT3ceinThy5ZRI
         TfFaj50IV/x0QEA5LQAnRHIb4cTiId2HL9jvmQBw4WIaLBy+tnOwuV8hm6OsiI4ON2It
         AR1CE/dau6igcALSvdr8GAm7a9VdcCbnWl2lLyo0fPRQ2htd9XADwpVm/3FYvfj3BEuv
         CBnmSdGxqWj1ReMGzZMTjH4zzBBRi/rCMwyge5JUhXD2JkFTF3LZFwrCOGX5qaneZ1EX
         uzCpwYZxM9b3cVQDMgZcFQFsTHAudoQkq/c5l1bCeSkAXYJMPwGB299fUgmUA5bCEw3K
         IyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807746; x=1712412546;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjdu2rY57ENFkmm6x/igLaZ21xle0sgwarZuWC25ufA=;
        b=j8QPU26Ncd8gJM1uK1eBHmp6k+45XS3b5v4ZljQMVZUu4IKZ5ZM987af5wG7wCGwku
         9Qgkt37+uGJpMm3LIPk4K8dBfK7cBYHaFIKa7eVaTNRxcBiHvYiUj4Rrow07UUaUJ5Ms
         MOj7RKBIgwT7QMIseZaFYE9LPDErvbHbrXcAbKamWknHImY4D9iqk3Blua6qZHE33fK9
         GseFECG4aWN5dMXns03HU1B5tklOAaTvcFiWThYRzC0oh7hm+c2S+9rACjz9KarrC1oV
         R2pOqEWipVUSewtxI2GkqWRi1dypvO71DEntX6EZ+/qWNoR7GjZeXybbKU4tDrSyAXMT
         rvlg==
X-Gm-Message-State: AOJu0YzudBK0di0suSc9CwmEkRzraD9wKzOKF2UlL/rc/oZEpaDLoGdI
	1yB+T2GKyQcKta8+Bff7eyUxbmnn0gnSPPD5NcSOn7EbuZh35KD4vvHT9P2z
X-Google-Smtp-Source: AGHT+IH94aEkk++m8AlXDLuWN+TLvg/z3MQ0gACLKh6NOUsYJeyxtHI0uW0AZTqpuZkB9oL0t/gW3g==
X-Received: by 2002:a05:600c:45c7:b0:414:204:df50 with SMTP id s7-20020a05600c45c700b004140204df50mr3604973wmo.4.1711807746435;
        Sat, 30 Mar 2024 07:09:06 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b004154853f778sm7436380wmo.48.2024.03.30.07.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 07:09:06 -0700 (PDT)
Message-ID: <444bb0b2-781a-4eb7-a251-a1bbee2d87ce@gmail.com>
Date: Sat, 30 Mar 2024 15:08:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] add: use advise_if_enabled for
 ADVICE_ADD_EMPTY_PATHSPEC
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Content-Language: en-US
In-Reply-To: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 93b0d86aaf (git-add: error out when given no arguments.,
2006-12-20) we display a message when no arguments are given to "git
add".

Part of that message was converted to advice in bf66db37f1 (add: use
advise function to display hints, 2020-01-07).

Following the same line of reasoning as in the previous commit, it is
sensible to use advise_if_enabled() here.

Therefore, use advise_if_enabled() in builtin/add.c to show the
ADVICE_ADD_EMPTY_PATHSPEC advice, and don't bother checking there the
visibility of the advice or displaying the instruction on how to disable
it.

Also add a test for these messages, in order to detect a possible
change in them.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c  |  6 ++----
 t/t3700-add.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8f148987f7..289adaaecf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -438,10 +438,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		if (advice_enabled(ADVICE_ADD_EMPTY_PATHSPEC))
-			advise( _("Maybe you wanted to say 'git add .'?\n"
-				"Turn this message off by running\n"
-				"\"git config advice.addEmptyPathspec false\""));
+		advise_if_enabled(ADVICE_ADD_EMPTY_PATHSPEC,
+				  _("Maybe you wanted to say 'git add .'?"));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 76c2c9e7b0..681081e0d5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -28,6 +28,16 @@ test_expect_success 'Test of git add' '
 	touch foo && git add foo
 '
 
+test_expect_success 'Test with no pathspecs' '
+	cat >expect <<-EOF &&
+	Nothing specified, nothing added.
+	hint: Maybe you wanted to say ${SQ}git add .${SQ}?
+	hint: Disable this message with "git config advice.addEmptyPathspec false"
+	EOF
+	git add 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Post-check that foo is in the index' '
 	git ls-files foo | grep foo
 '
-- 
2.44.0.417.g254ece0ee4
