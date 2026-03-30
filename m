Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC91465B4
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853148; cv=none; b=gYb3jcdfEwg/B9Ii8r+r0oliEHN5ex+Q69Z43kmIy3wi60p/ojH7rbJJfYKPdPsG45cWq3oQr7rb5BPG9sAijeySBkmUu46X7HkOhY6sBGHA3tmvA0/yTbw0B/roxBa776qY/sFwDqxhLEjDuIhaYodei4Xd6VfTmSWvdFuItWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853148; c=relaxed/simple;
	bh=kdE8URUqMhDC2Kl6cFR2LLw6DrQ1vG3gd4AQuL6M0Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmI2LiseUK0YJENvVtrnyrld7uW5sMW6O9JpfVA+1jD7j9/kAb8/jIRcoQsC8bbKTecQ6NJhrKC7njf/NUzmicRaUdvibDexoxCNtX59YtBvDG6xm1evY3QP9NpC5A3GaEiDnTp5Clbw1viV8hjgIrq9KuMR4f5owERa8J3xBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in; spf=pass smtp.mailfrom=sithyd.siu.edu.in; dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b=bUWHF2IA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sithyd.siu.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sithyd.siu.edu.in header.i=@sithyd.siu.edu.in header.b="bUWHF2IA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b23fcf90b2so20698605ad.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sithyd.siu.edu.in; s=google; t=1774853147; x=1775457947; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wrc1HueQCGaJnobyFBMDjyp01b+W/ppn9MPdpqdIXik=;
        b=bUWHF2IAcVS817mc/9KvzMA78ZM9ulI15EGnRlvOF+Ph9LEupzOwpfP9Rb0PCRXSmy
         tRsIMzwm+Fxlm3TzvIZ1olSu0npf/2sar/n5W2An/yayN+d93UktvH7uuCQT6awFhhss
         DbPs7WeTpxrrBiFe7NPrMFGcpMIfzBqILKOPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853147; x=1775457947;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrc1HueQCGaJnobyFBMDjyp01b+W/ppn9MPdpqdIXik=;
        b=OA1xV5qUinIT/5f/5r465T66cPQ09EG5AI9bAT5d/TuXo1tYDHsNtryVpRxY5Vbkz4
         yPYRwCfAKT9Qaz2Sn+KDkCPRpPm28BI+IXf6dnQzNQPGTrj+hLsS66LjkHBRWFR/bg/1
         a4aRqxOS7HmgHHjGtfpgrz7cMapSUna34I5UudIPRBCWQ9vJMkSZ0PPItIrzI9kTGEZV
         Wgynyxe0bjGW+SPSJfNuDgW5vAvWSxdWs2BTq8Df1iA8M5pqEUYfUVB+ANWftJFy5EEI
         9lRU4jO4cyVjyIWeaIvZYAftXdDk6HTw/Fbr6+StYufCyn5bobu8ml985JlW0OlaAGlT
         kUDw==
X-Gm-Message-State: AOJu0YzFImS8CwXBcxBUqtPiC4KVjUZIkTVUJGqodQ7Z+rB0NYBAXQvf
	sJzZyea17bxFonND9JnH5uJuc7Bbe1XF5ulA5yn/x9lg2/1/1pA4miRYnp1+DtW3+jAg/GNNM19
	eCKSEyYlSrp+fi/nIcHkGnN7itxeYweHRRVKkoecYQrdjNYnkYSkeg35C46M=
X-Gm-Gg: ATEYQzzi3M0h4D9wSSdcggS/Xo2fJbIM3atK5pqpmRNQO497R5fGvYaCRbWgFoCuIWM
	3K7I5g68AG8EK7HvBJEG50kzH93cb0+kPadR9Vsywhs/zJqPEKQ5lxQ3T83RpEuGJTZbHKKppPD
	6q7U3GFvwLbqxj4IriW/mGVqx13GWx0Jd2MpUYGdm/Eu2NRHefYkNeE9f+bpXkTNUCduGwvJa6P
	hqY1JP7guWpnpXa1UeH+vEL+LAWGHJ4YaPBm8FKrQAriy3lMAJAiLDisEoGiDfIRyRSVSbkDd3y
	too9vSpenFGzG2Z3efN9zlpVxuyvjMNxKw25ERu6+Gh9mlbwvNd98n1bRKCCXHdo/iM3xKGr/4Q
	0sX62Nsbgsh0Uz/uF5N2B24tRkxaFe61eE2MNxbxdOM3SSPvrcD+6ENfONuPT3Ed2NXP7lOHULb
	eocqxXw0jnVlkOrhn6cR5Hv1qXIKF8LOgxV8Edv7K4e6mnElXDqS/+EPRa55/J81rF
X-Received: by 2002:a17:902:ccce:b0:2b2:523f:50d with SMTP id d9443c01a7336-2b2523f085bmr28259285ad.29.1774853146735;
        Sun, 29 Mar 2026 23:45:46 -0700 (PDT)
Received: from LAPTOP-A2K1CSVQ.localdomain ([103.157.13.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427acdb9sm70621115ad.68.2026.03.29.23.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:45:46 -0700 (PDT)
From: Smaran Jaianand <24070721037@sithyd.siu.edu.in>
To: git@vger.kernel.org
Cc: smaran-jaianand <24070721037@sithyd.siu.edu.in>
Subject: [GSoC PATCH] bugreport: clarify usage message purpose
Date: Mon, 30 Mar 2026 06:44:44 +0000
Message-ID: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

From: smaran-jaianand <24070721037@sithyd.siu.edu.in>

Add a brief description of the bugreport command to improve
clarity of the usage message.

Signed-off-by: smaran-jaianand <24070721037@sithyd.siu.edu.in>
---
 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed..3b3fdd4dfb 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -56,7 +56,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <path>]\n"
+	N_("git bugreport -create a bug report with diagnostic information \n"
+           "              [(-o | --output-directory) <path>]\n"
 	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
-- 
2.43.0


-- 
* <https://www.facebook.com/symbiosis.official/>*  
<https://www.instagram.com/symbiosis.official/>  
<https://www.linkedin.com/school/symbiosis-international-university/>  
<https://x.com/symbiosistweets> 
 




**Disclaimer:* This email is 
governed by the Disclaimer Terms of SIU, which may be viewed at 
http://siu.edu.in/disclaimer.php <http://siu.edu.in/disclaimer.php>*


