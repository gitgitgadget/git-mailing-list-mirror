Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154366;
	b=HZt5uF/mBzcR9eHO3Cs0taTGjd6n545fB0U55nGLq3WmS5xk6npIXdGJEOVCW8Rz5VWN
	 3723sjXhmCrcKH572xE9b3QY8vVt71NtAzo2TrqN70dWmE8N321YxqkqbYrxpA+pmtPfJ
	 JvkviNyNOT04sCUmiGC02qIxkRGRGeHK1cWRwSbULjiZ1ILUhn/JusM0Oyya2d8kr4lWP
	 /NuRAmV0QT1vzJwVFsx+RJm8uP4GzW2ngLBDAYySd0Fh69F99xLabsDFoyepvf2t5edBW
	 vkjDEbFTavEu3Ul3XeNwsWI8/Wc3IjWt+Fc+aM9u+cTpDzUlMMz6H4e7ez4iQHAPaTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cSfQf4DDngbO7fSLArDZVmvqShzBl/1sP313ESuihdU=;
	b=1zn0zWhB2nJCdCt2/eNyblzzjupFBnmFQsQv6fHQFbYCQRZPtje3TMRQ2rKmXEGB+8lp
	 pPbhWmq7n9UpLieZMUD0h+wlnWtJ2WUMCfTTRaELkO/OIJtvwsRQJl48hfRU6abU8b5Nh
	 rs0tmORmXO3+4+J69nq/wfILVuCsM7OdEjCsyg5J+v2qDab7TH6mX+Yfi+mQl7kuQCJuM
	 zZPouSErfI7fiDE4gtqX9L/s5mMazFHga3hoJ2cmG3YFl42jjcCo3pRxQxMHAwRQTygK/
	 oWSGVIpK18W7OqSLDFc5IoL1lF5Fu3dWytnLT0oP1Y7uDc19oRtgAa9aF4NOGjHfWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q7d32qkS;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB70606A514
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 05:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB70606A514
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q7d32qkS
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so590909a12.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795154363; x=1795759163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cSfQf4DDngbO7fSLArDZVmvqShzBl/1sP313ESuihdU=;
        b=q7d32qkSoIdym/LbsWch9VkuDcZhLTMo/tmnMjkhpsVOAX4pAodr9dDPL7LzsjW84+
         C5FbT4Z1CzZoIiiGJN30gnEQgdi/ecY0qj0UM5y2QuM/pQ9oLNGZqsRx6wIVN6kohjPC
         ya1YgKIsYl5WszgamjK15yjS7bw+scDUZRtaAZYmaVdHDL/A8Hhjv8OKeCPxkorjkHuZ
         FUkS45auHIiHcZeGliBsdbT0OUpQuRyJoO0Y0UOwDtrATicjx+dvL0VObZSByTQobRVb
         fuRhI0yAPoR+J/NeYCkRg4gRcLDGe0ezoQhNiqmRz7rlyO9v6jh5EgKlFL1NvcdOsFEZ
         rkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795154363; x=1795759163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cSfQf4DDngbO7fSLArDZVmvqShzBl/1sP313ESuihdU=;
        b=EQPOktFsAJ1Dw2/sfm08bpeacJa8YQ01jv4YK33OOV0wsvXM7ePUy8Yqf2hnLgOeVh
         H6DRFAtVkG782hTEjagO+Cvv91CZ/HU+02RI6agRAE8ih/maT08GeE7CM7upBmG61j1a
         /l6voSh6t7gevJqMs0AYObuVmRIbhibst1ovnCVv04JozAiZk68NzXU7FgFykE1IytMB
         aqTZl5NngGIz4nAHFBSbEVyS9Ig+utJEzc47kKW3+Wg5LplalhZVsF6BKVuzH0MPHBuF
         Uv7T6g2XiVYlxl9/HLK5v0jAe7118kAcKzpKrdpoiAsHrbhu6H/Mcp5yUdcAIPcmOFbU
         LKcw==
X-Gm-Message-State: APuU4Z/TcrbrDGCNClTvgvdebHZ+TKWqI4j08Jl7Tqsloxnp2ppEOJZy
	Dpm+2NGn6ay6q+4cT97QoqteGL6owwJW7BlvWcPmjGJ9qWmEMGij8w2RPxZt8BC1
X-Gm-Gg: AZFdTZfo4a6vUYyr4MxOzWuj7RsNEu01/rNvhXmTsEVfC4BcHo30ZQ/udDNgVzx2gk5
	9Qek/E2R3mSRosvSIMk+tNvyOvEmzPun0PuJQDGDar9YLTwMmlNsuGr3aZMVFKBfBq7vv5Xiy3L
	8VARFKdClv42ygBiooOu8yrib7ImbrY3HT/H8dFxSGENmr9ISkA57ga0S4UQIVwlqjuM4Mu5I4d
	2O+yZ6nvkSP6fE8nZWMjOwXoibRh7uaBJYiAOZSzDPcLOhLMcDGvfWoaDHqf75ihMaRWDb8o45x
	USgopvomeiFenKCHiyFg6SfmMn0QhjIdVdlZsU9WU/ewGuBVhmsQMczTLlWrsaJKuihFEWOEDUZ
	xORoEKxk7hEsoxFLnDYjkcEUA0fCfyZI1w6zdhK9ePwgg3RblOWt1cGxCRdu9xBYEPY7nXebkQl
	hNmGi8VfitWCCNo8VGfKdTlle71XWxyF6rP5lObQa0M1Wh6o1vnjkxUOhSHHfUMAoOk8nKtR1ew
	KqApdbFxhEqYw/KLsBMpWlYN84R6PqNNKGmS/GYRhC/jZ6PtPmtbqq5IcxVn+Och+4eGuSva+N5
	yeV7T5y/u7BJCpyVsmmU9ULwe6ngnz+EYLl2xkSki3rprMgJcHj7uMkLCyes7Ahd9s1vXXSvFha
	KmqJQdmA1iyHU0+QLcan6o/f5X0KqmyAUGyXjKQ8lRWnGVA1racJPJgFPghDB+TNuD3CrAhccQE
	IgMl+bPK1WpBx/Mdts0o3vctFq8pJfCQ==
X-Received: by 2002:a05:6402:5606:b0:6b7:b872:27b5 with SMTP id 4fb4d7f45d1cf-6ba37d64e82mr719877a12.13.1795154363460;
        Thu, 19 Nov 2026 21:59:23 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37108874sm794479a12.30.2026.11.19.21.59.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 21:59:23 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v2] doc: wrap emailed text near 70 columns
Date: Fri, 20 Nov 2026 06:59:08 +0100
Message-ID: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119105300.95746-1-okhuomonajayi54@gmail.com>
References: <20261119105300.95746-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
not say how long an emailed line should be. State the limit in
each: keep the text near 70 columns so it still fits on an
80-column terminal after a few levels of quoting. Leave a blank
line between paragraphs. A block of quoted text counts as a
paragraph.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Also say to leave a blank line between paragraphs. A block of
  quoted text counts as a paragraph.

 Documentation/CodingGuidelines         | 6 ++++++
 Documentation/ReviewingGuidelines.adoc | 5 +++++
 Documentation/SubmittingPatches        | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 23a4d2186a..414ecc444d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,12 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - E-mailed text, including a patch message and a review reply, is
+   kept near 70 columns, so it still fits on an 80-column terminal
+   after being quoted a few times.  Leave a blank line between
+   paragraphs.  A block of quoted text counts as a paragraph, so
+   leave a blank line before and after it.
+
  - A label "NEEDSWORK:" followed by a description of the things to
    be done is a way to leave in-code comments to document design
    decisions yet to be made. 80% of the work to resolve a NEEDSWORK
diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
index 6534643cff..51da873840 100644
--- a/Documentation/ReviewingGuidelines.adoc
+++ b/Documentation/ReviewingGuidelines.adoc
@@ -116,6 +116,11 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   unrelated to your review from the email reply. Make sure to leave enough
   context for readers to understand your comments!
 
+- Wrap a review reply so it still fits on an 80-column terminal after
+  being quoted a few times. Around 70 columns is a comfortable limit.
+  Leave a blank line between paragraphs. A block of quoted text counts
+  as a paragraph, so leave a blank line before and after it.
+
 - If you cannot complete a full review of a series all at once, consider letting
   the author know (on- or off-list) if/when you plan to review the rest of the
   series.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..9313349bdd 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -700,6 +700,12 @@ WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
 
+Wrap the prose you send so it still fits on an 80-column terminal
+after being quoted a few times.  Around 70 columns is a comfortable
+limit.  Leave a blank line between paragraphs.  A block of quoted
+text counts as a paragraph, so leave a blank line before and after
+it.
+
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
 e-mail discussions.  Use of markers in addition to PATCH within

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

