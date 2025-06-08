Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3154CA5A
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749355025; cv=none; b=H7nsd+rmnFR04OLXm3trHndgqYaFz0P5Em+46DR6TUH6FoBTel50dFUsLq6ViksXoXPrvbjgDeGl7YEWPw9Q5GbOQTKr8PUCq536PglOC93PxIJS/rN9rRpiLqedhMxepfbf31cjOO+9o1dI+l4RWsyPdAO6Gpo1cDqfLqbzC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749355025; c=relaxed/simple;
	bh=+GUIwAy2u0ouApHl/DVUYKWmD9viIi46P7MUvzFMTAc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=p//tH8tcg4KTpwNr87ZO7YI9+f8pscfLDSgG5LODyHjiD8Zn8SAOSjSvHfpKGomSC2j2Sr1fo/helDJTuXhj9Vdk5hOB0r+H32811ZudQxlE8WnXnpnc3rrY4pyGMiIbe3x6AfvLAwY7JLomiwtN9ejdsJHCGuzF0BZtpYyzm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjg8jDGH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjg8jDGH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453066fad06so3228945e9.2
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749355022; x=1749959822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ndvxyJZFXTrIvVgRMEoui4689wcOEC/rQP/PEtGBnQU=;
        b=Vjg8jDGHNuwZKyWVXPZ2bcRgUlNPFJ6ssCkHibZXESjcBIGpbUN7X19yqZLMfHjBza
         eKYGQGAcz96hrEt/dyuXujw/B2yQDWRFVHHi7vqAWYOM8zKEgEaLoZeHSTfqIRpjqI5C
         ejgZCnpB1PnIWmcltj9sdaHOfRICyuXpfDMnywg8f1F27+DX13YJ0qBDK0ef36Zc1nEv
         r9ZhzaleDX00y6l3V5vpL3JWMFckkmoOoRfgzD0mHDkLYTfP1KA40pKy+LlM7ljLy6C3
         yvxIW/h2ZFGpdHy8SoMjewbmnzRibxXKBo5K43nI1Q10OLbH1mHtt/uWQTWoRVnN+JDa
         N88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749355022; x=1749959822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndvxyJZFXTrIvVgRMEoui4689wcOEC/rQP/PEtGBnQU=;
        b=bDG68XXa5kYruaGipMVZOdexZ6OwT2usvMQ3WHIAw7s2UCw3daSC8HtsOul3hwj2k5
         ErTTE6sHTOBua4d7rdvCOqgO261Ei4JBOUD/MEE7Qy2iZ3AHL6Q1LZ2hsv2ZdHCoa2It
         5tA9lNRjZ76riE8pVkcveQdNFLUlLwwBkqTA1u1lozxvgYmrfRX2bRqedn4h8BqgRX8G
         jnHIyCJ4vQrb/Ww6zo5/QcSnXDz+AP3EZ5VHJJKjtNsxdMZSVoHmNRVeHMkGyKLBGNHi
         wufBZkih9F36Hs6crlKfac/7NJkuK78nUtcPLRypDQMwpzbPHqmILsw3+fhd/1OMJXj5
         jpig==
X-Gm-Message-State: AOJu0YxZsayK0a+oC914sLepm/UydJvYgoMGStMaPaFeGR/OVHGnfWXO
	3pZsOh/ituMtNFY/uSdZBwrSco30ARwWL1AHmjuxzRxY13vv72SzhNOdvqmwMg==
X-Gm-Gg: ASbGnctqjw6cCVyP2fX9hIrE0gcOzh+mqk1chE/wBpCgoJ9Z59Dcs5tzAirRmOvm9qB
	H3KgA4TVtyPze1u2QAMSTNdG5wsQAfL9uTxmB+PSk5UpzKq0EmJwpUR7jY2EKLueT2nW49sZuHv
	Gr2NDQLcvnKIuMJBDdlXfSJdTq2z+CYMZ6I9/hGNJUkAmlpGucsor3sA/7KQtNc53wZ2iwoba6C
	AHSMWIyfwOcMDNELtgW8jUZQJ12H09BGOLwDaT8fy634xzoQ4jK2hi0gKwI+uelCSotRxRuiTvx
	dxvzYJBlgLgRNOzcf243gNYgaNWVNt3SVvyy5J9sS5abBmeVN6yoIWwkmAWW+Cs=
X-Google-Smtp-Source: AGHT+IF668w/UTJmRADG8DLYvZrKcwnNAHqpPcxTnyXzxnOF3dvwz3iOvdkUkbEdynzYYQHsUZiM+A==
X-Received: by 2002:a05:600c:8212:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-452014b5e64mr70195975e9.22.1749355021432;
        Sat, 07 Jun 2025 20:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b5147sm6346547f8f.37.2025.06.07.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 20:57:00 -0700 (PDT)
Message-Id: <pull.1987.git.git.1749355019495.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 03:56:59 +0000
Subject: [PATCH] builtin/submodule--helper: fix leak when
 remote_submodule_branch() failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In builtin/submodule--helper.c:update_submodule(), the variable
remote_name is allocated in get_default_remote_submodule() but
may be leaked if remote_submodule_branch() fails. Although it is
unlikely that remote_submodule_branch() would fail after successfully
obtaining a remote ref name from get_default_remote_submodule(),
it is still possible. To prevent a potential memory leak, add a
call to free(remote_name) at the early exit point.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    submodule--helper: fix leak when remote_submodule_branch() failed
    
    In builtin/submodule--helper.c:update_submodule(), remote_name is
    allocated in get_default_remote_submodule() but may leak due to failure
    of remote_submodule_branch. Add free(remote_name) at the eraly exit
    point.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1987%2Fbrandb97%2Ffix-update-submodule-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1987/brandb97/fix-update-submodule-leak-v1
Pull-Request: https://github.com/git/git/pull/1987

 builtin/submodule--helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf..640c0059c3e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2660,8 +2660,10 @@ static int update_submodule(struct update_data *update_data)
 		if (code)
 			return code;
 		code = remote_submodule_branch(update_data->sm_path, &branch);
-		if (code)
+		if (code) {
+			free(remote_name);
 			return code;
+		}
 		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
 		free(remote_name);

base-commit: 7014b55638da979331baf8dc31c4e1d697cf2d67
-- 
gitgitgadget
