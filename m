Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616623;
	b=hwaZKpWHERRqNHV3KmkVp3quUHOLm+Pr7vZGEvU3rXs6xAkheXuokplIO/4hlMGARmrw
	 8QeFsXhYXuTuNipwo78REBilO+1iyzA8q4UcOKgPB0UnbT1Wvo0WvcLcDytkDfRjCyTMT
	 V38gjXjmjUU4j+zfTve4+aTIBuOo7l3VwT0Hiwe9IVKF2LarzC0UTWQZSWuu3q0+5+ogm
	 6x4q25cbu+AnyQTGOPAdOTVBiN22MMp89D4sUm4+JSLayNxNVjhjpLI9qZmLqztBtpKck
	 76UMwlaqCDSUz/AZgfPyQHwj3pAompOsTXd0QeVmI0vBwVGH0WpH3yUIXluD312lktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=L/tbLhY8Wmjnzayazn9df+lvNtgmvM/HnVyQ4/KVTZo=;
	b=Nqhbnn3q3R46vFXNpFzPL8io/E6/LmNpMk/eIXskOp6uqJS+ScidEDT7GWReRBhZOC/J
	 Y0NKqzt3LGaE6hJtrbk23qnbSD1lptiWgd6EiPqKL1fTctJrSFfXeToYI5lGZLTux2WF6
	 H3Po8hxomiwN/+qoJjQddfREYC9lEf6IGJdjGvhj+Ub/34fNSMwOgoblB2RMcUVDCHWaP
	 uHv0sw+tBGLEWI0HNqwXD3GLSmFSnffOsHWK0R+SlShk4NA0rZMqu+gBxnfl6E/R1c9Py
	 SNgKIiNH2CvaTtW2PDBQn+FKq3i7l0i4Wv4hbQzVv8FiTQJ7ga5ec2KvYFzY556YL0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="I6KkSP/k";
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C0606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D4C0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I6KkSP/k
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ec9237600so657419b6e.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616622; x=1793221422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L/tbLhY8Wmjnzayazn9df+lvNtgmvM/HnVyQ4/KVTZo=;
        b=I6KkSP/k0PPhjQPOjkc4FCU3riy/E71xcqR+uX4wVtBg42beyxyT7VpnXzHFb4OARO
         jWqIuaQoilpk7cHPXdjkuQqRQl8R0HNPx2APp/0rDQaXsPYP1g2tbitXswutAum4A72c
         xqbULmR+NcSKAuybMZoLmr2KHLunDSpnOjC5cwQSGVSjTDZghUQ77k/oqiIfPSGNfam+
         bUyTLlJW6TcrMjBaWYpM2eUlpRCznZmLb9x9xFu0a5H3q6ilM+1N45iLKcoq1e3P8CLk
         3XggEOeaopBKu8yQDyXWdXxWN0oy0G5xRtWv/PjV6pGq1EKkIsBeaADbTQE1NWZdKDk+
         ZENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616622; x=1793221422;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/tbLhY8Wmjnzayazn9df+lvNtgmvM/HnVyQ4/KVTZo=;
        b=SY6+k+z/BdzxdGZkk7SscSpK2Ud0aoDLMy4x9k5STx1TjlK8a0oBIyizEpZe3Vj16J
         I4iLNX9FRuZomtIF0NKFrMnRSeYm4Sym+alvKs/ByTXoaDEohvX+R6sEcjEgkhxTHJ/7
         6m2Mdbr0TP6tahfuBwDhg9GfRbWoiKN05rgpNJ7a3sd+A3XSnKAtTiZb+BQQZ73D1gGY
         r3eTohWE87K+/P0U7+VJFlpUdFsgFKrx03+DLOFq2xfO4r8IZMLznOoFn/aVFu40PaVa
         C7k/DlOXkWj/utGZBRTY1zhhrYZT1GV0m4uMcztl8tGA1/2FI0CdK1UORhEv0508Z95U
         j+uQ==
X-Gm-Message-State: AFq9FYKEqQ5LqJEKxn6k2NfO9bkmLu1/ZtgE2KagC4ClnGhE7mNnbFXX
	xOxYDFt/BNaMgUi0g9r7Dcmry1I/Wt8tHu8QPuolcx52Z+6XYBWQToVa1EjfiFvI
X-Gm-Gg: AYBFou1ECnflzuappldRZ1eRxftZheiTdw+0BEfsFA+Qhn20EieeM+b97R2H1xIm6HD
	VGWkMPNiyEDdV5uUiHcHkqwQe+nwoQU2y5ORLu5E05CSJ3kWnmCBNkRumT8IBuHNsV7pGMWVzO+
	pg553v3Fzwuvx9tyXEQ2G7jIhpzjCwhhfNHuGifj3dSyaQS6GZ8JAuF09RJqGvzdh9eKuyOWm/n
	+5KThrwJ+O0I7wPvovYvvwJAE3rZ0kdys2FiHnfaEhS0rad4pgVYVBH/VK9mTRTBtizX3GflWyd
	1RlTtHZKIgwxMEKjBs0Aq/4UtQTPx4IthyMFveNMV+Emp3Xe0nobiu6xglGxTltIPHZXA9XZWLG
	xDCYfsm6gk7XOnR7vRclBJNaH5UfdfUqXHc42MtyEBdz3dTUBAGIIO8p2TpP5EouQUSGzXhcIw8
	kF1KDvFJzBXN908DoPN+IRbcSYVAp0V9suiqvs1Mvo3aW31aTqUK9JiCDp6yVUVkyhsrtLr+0tB
	+ZvR7EViIbh2J1XN7JVdwOGrz2mVbMfUphEZZOxxSUkzIycver7nNMx7n1f
X-Received: by 2002:a05:6808:150a:b0:4f4:d914:8603 with SMTP id 5614622812f47-5535a66d297mr2344839b6e.15.1792616622246;
        Wed, 21 Oct 2026 14:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.19.225])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b4104048sm2876623b6e.5.2026.10.21.14.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:03:40 -0700 (PDT)
Message-Id: <0d083bc81fdb6665333b4095baedefd90b652473.1792616615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2255.v2.git.1792616615.gitgitgadget@gmail.com>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
	<pull.2255.v2.git.1792616615.gitgitgadget@gmail.com>
From: "Matthew Suozzo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:03:34 +0000
Subject: [PATCH v2 1/2] Makefile: build the reftable record unit tests
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Aniket Gupta <aniketgupta3001@gmail.com>,
    Matthew Suozzo <m@suozzo.co>,
    Matthew Suozzo <m@suozzo.co>

From: Matthew Suozzo <m@suozzo.co>

The Meson build includes the reftable record unit tests, but the
Makefile does not. The suite was dropped from the Makefile when the
test was converted to the clar framework in 2596bef5841f (2025-07-24).

Include the reftable record unit test suite in the Makefile test
target.

Assisted-by: Claude Fable 5.1
Signed-off-by: Matthew Suozzo <m@suozzo.co>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a96be506b5..66b7270fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -1551,6 +1551,7 @@ CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
 CLAR_TEST_SUITES += u-reftable-readwrite
+CLAR_TEST_SUITES += u-reftable-record
 CLAR_TEST_SUITES += u-reftable-stack
 CLAR_TEST_SUITES += u-reftable-table
 CLAR_TEST_SUITES += u-reftable-tree
-- 
gitgitgadget

