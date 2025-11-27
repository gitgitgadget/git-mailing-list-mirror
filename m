Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE652192590
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211100; cv=none; b=CEzTeSSTDH7YwfRHzY8lUKVWliJ6OPrL/qLdHBDGk2+vNxvtfIgV0KOm7hPmsXdNodiUu2l16jg9w0Igk9R9B5ZFzFxCjGTPxVXlc14rvDx1XgYKUbAoDMrrXl3o73ACJcFZOpzNguTTL1mNDiZ/6T5MCHu+crmLVGxEg5r2BAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211100; c=relaxed/simple;
	bh=xHK0dVh2ixD8Vv/sdubBG1WkUS/OTyEDDgWcb/RyQ9Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EuIonVl/RRbk+E370OU1WvpAx4UGE7TF0m4/gFiKHi2feyjXy8A0MZYBBqI5MFxLhZCce/1qpTn+Ib7cO3/H7/K1ptsaj6OsCcx2XehOb+RfAj1wbQRYu0CuzFVH+XG4YhqKe+voiCRIT2ljL7cJuKFxL/pRFw2WkJUVB9WSrAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBttcB1T; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBttcB1T"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso302789a12.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764211098; x=1764815898; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFrZ9IKsU1DWn0/BFwzSJLWr+qP/6bSbD9H76ybSM4k=;
        b=SBttcB1TRI8CjiMSCPtHU9MJ2V0QoJtLAbS2IK0hXX7Gg15xqOAZR3en0aPnaBbUB9
         w1LsuNrm86+k1179SQviytr5OAlLtbtOsC5X36pb2goMcZvTCPjc27n9k7akh9S/ejIp
         +eoZErArQUyMNzsCRpf6pQ7ieSX8tS/q2dYqyrYD/VMKGXsWmqg2Vh5RuyzLLlZPxDqC
         3fS5S80h+d+befpcNWt96HU/ePPLmOHqP1Fsl/0Mk+pRy6JidTeaIHilps03AFEpUgFU
         YXkEJeK0cSoa7WBrm7ZkwGVuzdsIQI/i9OFKOFV83i/HOqKg3zjhupLiMQMHPWRWgrP+
         hLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764211098; x=1764815898;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFrZ9IKsU1DWn0/BFwzSJLWr+qP/6bSbD9H76ybSM4k=;
        b=p+7wwehIurMdbru+yC0zURUPKGd3H3JQqMQ4Rc4dscaUjypuaH9y28BhV1bQ5lBecG
         rBareOZBdCtnvJ/D4gyR7ZKUVviop3pLzy/P/H9PEjA8Y/OxHIbG03MTDEGPycUC28Fh
         kOOmpmjFxjEZoD+jTXIhpKLu2wr+bSnffVDD+ws5GbbVZcKu/nKQQHUIZZ83p7cN5ncx
         D/jBVISK77K/QaD7tCtKP4fBETRRAQvVEtmMJJwxzaF02Py1nAY4hKls2eSKf5wH8ayk
         ouLctNKOlegzjOzRuSjYUeF9gQGEVd1QjTlTGMIZiwtFREdg8Mz5swJBppmH8MajKkls
         YW/A==
X-Gm-Message-State: AOJu0YzPn1L6gr4kvxltE10NFXnq5dqimCnr7qSLZ8gbJSfucuPLnvAt
	Y8VaVUqN1vPuXUXo05hbddc8p7iyoM/z3YIW+cX0gxqOjIWGM2P9PWFY+ZxqFw==
X-Gm-Gg: ASbGnctKRDgl3L10WMJBmSg9vNufBTMqx1UyrJBAbGoZ8MWkQ9/LhtQd08V8qCdFJVl
	44lBNI0ngFWY4FP4WMvwhgn03LyGAPXj6zAUgRKOEeChZ+BENEj4Bt5YEJ/Go2ld6MHZv4Wlh5g
	2IcyoVopZ9QK7AsUsn3jg1DgQJj9VGD31kMa2CwyVcs6eQqz7yxosFTslPO6PP519/HAJ+F9L2m
	x7Jobi0gPJ4DE5L0TOM5FvzPPaThHqGtn2OMnzRHV9Sav1DPeBoXIrgmd57Rz3rrABWfC65NpJL
	4tnHVzUBdki/CcVLpYLPKCEbjIBa/4/ZYSZKYEhG3yPCj3KXiMvie7BnNfqck4G/5Fc1BAQPOql
	pRQU8d2afOBP8SmVOQld/HhwEO+uPNF2GCiqZd98A40FekgXoUASm3InBH1MVAL051Rb2vQaIGM
	JFPTQoV/4Ma/4=
X-Google-Smtp-Source: AGHT+IFm/Xw6zksynIZR0aNmxWAfd86tGJwNedPtXAD5P/hvZdt74nIXaH4m0GUj9cWt/Vi8MAhNfQ==
X-Received: by 2002:a05:7300:598a:b0:2a7:127e:bff4 with SMTP id 5a478bee46e88-2a71927a7cdmr10662277eec.24.1764211097495;
        Wed, 26 Nov 2025 18:38:17 -0800 (PST)
Received: from [127.0.0.1] ([52.234.41.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965ae9d06sm1576927eec.4.2025.11.26.18.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:38:16 -0800 (PST)
Message-Id: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 02:38:14 +0000
Subject: [PATCH v2 0/2] userdiff: extend Scheme support to cover other Lisp dialects
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

Common Lisp, Emacs Lisp, and other dialects have some top-level forms, most
importantly 'defun', that are not matched by the current Scheme pattern.
Also, it is common in these dialects, when defining user macros intended as
top-level forms, to prefix their names with "def" instead of "define"; such
forms are also not currently matched. Some such forms don't even begin with
"def".

On the other hand, it is an established formatting convention in the Lisp
community that only top-level forms start at the left margin. So matching
any unindented line starting with an open parenthesis is an acceptable
heuristic; false positives will be rare.

However, there are also cases where notionally top-level forms are grouped
together within some containing form. At least in the Common Lisp community,
it is conventional to indent these by two spaces, or sometimes one. But
matching just an open parenthesis indented by two spaces would be too broad;
so the pattern added by this commit requires an indented form to start with
"(def". It is believed that this strikes a good balance between potential
false positives and false negatives.

This commit disjoins a regexp employing these heuristics to the existing
Scheme regexp, so it will still match everything that it did previously.

Changes since v1:

 * unified with Scheme driver
 * fixed whitespace bug (tabs were allowed incorrectly)
 * made "(def" case-insensitive
 * improved commit summary line
 * improved commit description

Scott L. Burson (2):
  diff: "lisp" userdiff_driver
  merge with Scheme regexp; fix bugs

 userdiff.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)


base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%2Fslburson%2Flisp-userdiff_driver-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slburson/lisp-userdiff_driver-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2000

Range-diff vs v1:

 1:  da99bb0bcd = 1:  da99bb0bcd diff: "lisp" userdiff_driver
 -:  ---------- > 2:  86315aa3e3 merge with Scheme regexp; fix bugs

-- 
gitgitgadget
