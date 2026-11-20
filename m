Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187316;
	b=qQkJrkCOwh4V7ujYM/jPx7Imekr353IAmQmISxSLqXY1ZJJbEVFuYdSr1LBf0e1a5prl
	 JoCehuszrLfipxQdK88JASKzCk9yCmAjcCJu68rhKYhgWAc8iLe+kE20mDYGj8vr5f4En
	 s4O8I9sorbogpsZ0bsmCDUsAKz+tLnq4UNOFO9pbLwhi6kBxTBPCynOnHlW/bz98NLUTb
	 /Q4GWwkWiYalS8G/eV9qek1pI7loLBvkAWDlj3LhHBPmEfDxuFn1QltDDAdI/dmBMXq7t
	 Agu30SEy7kQwc+JrxVNHTI4CTmeJt4FC9LX99LsbK+c79S5UX0H36LL47CeAVThKTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=pMT4od+Cx6zZ6UXJoJwBEdnHQfudho55LXm7qBt+49c=;
	b=E/+xfrdKwbJ3Wd3XxlX1Aa++fybISWtFJlP+wfmNoXbYc8dpgVF4JaSkeFiiKT876kq1
	 3eVxziLn+lcnCT5y3lomW1noVa2Tc8BMnhDnP5nGdtDjICr5VFrGgbJ9ezvv5LzkVEzxW
	 9BExEszCMZSbJUI68e4KJjzx/0LcG15ccIBiiW1QcYtKLAA/ZJBDzvyFWkpzYFTROH+6u
	 sGzdhDVGKZO/XZkwJwqGRMKeM4IJRJ+bej5DPGDP6twsqB1I45trn/++IEQr0MYkIcxRv
	 tmjHSKCVBkIP9aneJ9wubqhRkh0ePbAgNEK4KMyCjxrm3w4IVRAQ/Ge2DOI2/bu7eUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=br8ISYOI;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65347606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65347606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=br8ISYOI
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so921624b3a.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187315; x=1795792115; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pMT4od+Cx6zZ6UXJoJwBEdnHQfudho55LXm7qBt+49c=;
        b=br8ISYOIjwlmXxVVcjxWYByjSBFtquboNqmaX+JC0lt1KMvpotzNSH/Yxj1J6YS/L0
         AbgtC+E7hskLayxPc3sCEZHW1M183/T9RPJn0ft01g/OUHsHeqBowH8mk1upjPjeVBg3
         i4WUdR5C5l0s+jkn9WLNdMSKeU9LpMtjKZ6maabBxvmjpk7QEh41xXDwXX05FXjxjSBL
         j+8RnOV3GmoqzE9Out0m+6KLwDMH66dUI2tUYlbpcm9XJp7rsjFqde3/+USMm/HWbTQW
         emsDGfTzmO0rtjiIvNBL3hIzeSMZXLf28jmI9336nli8fUxF1ODHbW9Vta9gp3ZscRMm
         sJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187315; x=1795792115;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pMT4od+Cx6zZ6UXJoJwBEdnHQfudho55LXm7qBt+49c=;
        b=lBfG3popY3YBPL6lGo/9CrA5graTdmk5q7+57JMljodKdg4Q0tDbzhNho2rtWVcI3W
         MzgT0s+kQcnCa6PdVyj1GskFpW8SbmWTlVsZtiYHhd3S/38rribQiLJSkPnymNs+FOIm
         pXr172MAPAFtOWicrnCdIF6Y97UPfe0COwLE+86z7ccz9wVpuyee2f8phVhp5fcOcu5K
         P2yTKANuRQQIRupIjmLCxIiYJ/njoaaDP/eUIcmSYr+EWzxN+liOC+xWw7iOpFbkKkRn
         jCXNp2N8TmshYUkHfsy+3jnCDVLbPa23Oexye6NjSYSBqMwxozFTaDmEQZfxu6FRrwU6
         svuw==
X-Gm-Message-State: APuU4Z97z15zqMj3Q8tQmH2t/cRxV1v6vPX5VHNpuZmxmiR89JanfXw9
	5/21WI+X7ROhi6eO72wXYvzSAGa+Z6MGUrVCwLnFOjL7bTNfQSshCTzwxhHUug==
X-Gm-Gg: AYBFou3C8emOhF32TzJBy/Nr+Ss9sUWZtkt+QsyZjn63AxR52Ug/uBLtEnExuccPWid
	elmGBUwa8/iJwjRgxc5IbaYsboktVxn7VQkLMxW0chAsnASzntAyn3uHbZK5r2qSJtYRuba2ACJ
	8TE4eWTRk6FNdMb+4muVzoXAkspE2cnBcRSuBC0Xm3jtcQ8y5D2WuHaAzIKySP0chujPD9w6Uaw
	r1JVQLlvC55/5GupQPiwj5yR+dG7CLjVhYEFx/BhfUMKVrocQtvSGTDu89JK3OzNUFDhVCJfwib
	hRWFZGXM4pOtPDzdzO06YWo8Z51kPxjbLL3KuBib3hjLjnFAha4UUAyGRMsfISKm7VOJSpifLvx
	tj/E8vFs+Baexv+ePidX3Q7UMXvWr5FsXSencsk/GM19eBEKrSf2kVAu6q5CARYPFtV0SDj+6aO
	5PZsQf4mRfKhtsCN6iCCtvWL4xzGM1bzuactnddiTMsfsq9bvSWiP59CDfuJu43INa6zTuCAcA+
	4FKrSxd8u8cAqVRJ8NSME8L8zVWt75ji6pgoPUxSQfUd78LCZnUg6+lbpFvT03TdkQWcL5snwxc
	ijK+LVpfs+1bU3DVet87WmuTsq8f0WYxww==
X-Received: by 2002:a05:6a20:6a08:b0:3e1:180b:402b with SMTP id adf61e73a8af0-4014ce3f394mr3524225637.39.1795187314501;
        Fri, 20 Nov 2026 07:08:34 -0800 (PST)
Received: from [127.0.0.1] ([20.168.128.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f571sm1612546b3a.34.2026.11.20.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:08:33 -0800 (PST)
Message-Id: <pull.2494.git.git.1795187313105.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 15:08:33 +0000
Subject: [PATCH] rev-parse: output requested object format in SHA-1 compatible
 repos
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
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

git rev-parse --output-object-format=sha1 <oid> outputs the wrong
hash when the repository uses SHA-256 but is SHA-1 compatible, and
the requested object was made before the repository was SHA-1
compatible.

For example:
git init --object-format=sha256
oid=$(echo unmapped | git hash-object -w --stdin)
git config extensions.compatObjectFormat sha1
git rev-parse --output-object-format=sha1 "$oid"

The last command outputs the SHA-256 value of the object, even
though --output-object-format=sha1 was passed.

Now an error is raised instead of outputting a wrong hash.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    rev-parse: output requested object format in SHA-1 compatible repos

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2494%2FOphirBleicher%2Fsha1-compat-rev-parse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2494/OphirBleicher/sha1-compat-rev-parse-v1
Pull-Request: https://github.com/git/git/pull/2494

 builtin/rev-parse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fbc5ef8727..5d3ac2a865 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1175,9 +1175,10 @@ int cmd_rev_parse(int argc,
 		}
 		if (!repo_get_oid_with_flags(the_repository, name, &oid,
 					     flags)) {
-			if (output_algo)
-				repo_oid_to_algop(the_repository, &oid,
-						  output_algo, &oid);
+			if (output_algo && repo_oid_to_algop(the_repository, &oid,
+							     output_algo, &oid))
+				die(_("cannot map object %s to %s"), oid_to_hex(&oid),
+				      output_algo->name);
 			if (verify)
 				revs_count++;
 			else

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
