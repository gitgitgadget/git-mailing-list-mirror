Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112900;
	b=r9A1qJb9Y2XrWjLI4PMr9HtowDb2q+71lI43zxQEMqFjn6l2/wqcfjMljBbXq/s/2lIq
	 qxyXQpayrRLaCc0PuPENhP9+zWHSvKqiIq1u+2d99lDFEpogseKVgfpfnnFnNxAmJGms0
	 Hgc9aU/pc9UVkzZzDqOYiZQBevuJWjeZwWMOTUTlq8O+MSmYrg3ubHjCpl5PJEsZgXOE4
	 FuOd+OBiSjF1rLLnPAjx76MObVsGP18CmCr+m8f1Lpe9+KJUz1GHKcRbXBT9D4CrrFYoN
	 +UJx6LeWybK+ixjn3X++g7vyO0EftFdfQslLPGEEFbJWbgvxDMu5jwv7q5aIb/ai2bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLrv4YRPzOjaxI+BO5ZflJZZfK9iL8uU63W1deZ57E8=;
	b=aApv4w6MMjSH65TPsSvH2nLV9Y5aqy6k7Bs1EeTowht/GWrjo/neTX2zSGe377U8XpZV
	 8R76S28QCKR0lwjJC0y2VmUwDx8tOczzqApLSKpHXde+tTUfXIRweW0ZlOwB/5/Mt0HwL
	 SbuvEfgsrJoW0nCuiRJ8BSeWBfkrStr9IAtCFgXzD12iVR69G9g2/lqVJTEkUOlMWUxFQ
	 eogojMH1Y578J1lD49oIe9L5JteTPrgkz9GlX+Xhs5fck7z3RBLn30397Oi7DHo+Ffh5V
	 lnqoN1mYXC9/ODv2FXJvqv3sfOs1N1U+2lPy9hWs8LTxtLksiZtD0bP6nwTTUig0MQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xefeo6nZ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F4606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97F4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xefeo6nZ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so3837548f8f.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112898; x=1793717698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLrv4YRPzOjaxI+BO5ZflJZZfK9iL8uU63W1deZ57E8=;
        b=xefeo6nZWIctYGzqem/J3qjQ3TaK373MGmienc85CtWsynK5licJk3T9is3qO7hNW6
         7uTILGL4bxYFng6qwZGOyuihvSdISi4GpDQXNUFBSopCpajSEPZ5cvSRhMUWyio9qblh
         6+VkYwexKUOQK+AeGYEhp5lBu8/mmkO9XJKyJ31zox/PdPhRilMzmxnS02Sdhppl2yY5
         eM2NA+gwWAtPQhlf+ty78va7plxZ61ZYdX7sCnGAqAhKbEUnc1sG1Fl4HjIXIgegtVCF
         DR8bMPPJjXvGqmirI+48YED14lz13x4cfP/CClokZupvTrZb5672fgKKf11UKJMotkSF
         +W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112898; x=1793717698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLrv4YRPzOjaxI+BO5ZflJZZfK9iL8uU63W1deZ57E8=;
        b=QHUs5tsMauYNbzG/rtGmhGJi57vSMijdQ0K44t1SlS3zyxMMYUv/KWRGOtfAnLnlea
         Fp+I+vNzQFwtYPFLB7Eo/RE9nU9FuOnCjESFfzfaV1w2jpfbr34o/DUDz91BiNPZuBTW
         oW9YI7KOt/TNVoVui8hBsounN+1ZRXV2w+jnTNCkpJkqz2UhbuLyXZ3/44oxkJdtgNjB
         Khachm3U9enb3LU/lldyIYKwZiR+T7tMCR5e7vbGcyh0rQeGNFXdkfcp6Cf5P+jRZDvZ
         BDB2oWX+5AAKZDfga1iBePUFUzyIu8rgFSeVAa1UdtFXSdoAClYXyw8B0eAEQP8FzCeP
         8nsg==
X-Gm-Message-State: AFq9FYKE+bPPRpr2ZcWMQ+I0B4LHVcrg+qHtbvD98HH5XZ7Ctao8b3wz
	k+510TmlG8jUJrDN8nxCAlFGGC5huRPTowGdes4wJE1zifcygy8Z7mm6fKNMRR9lZA==
X-Gm-Gg: AYBFou0m4LxtX7h430wNADXGThb4HPAW7w/2ULrqmOf90GyehSdq4gM2H1lDWjSxWZD
	qkXvlI/ivst0vWjflG7BHSYLRIzj+QunNRahf9avfU9ALc/q0bA3B/B9wcHhYMrCwYOs+EgIEvO
	qw1kQUPoUOP3KWU3Slaftu+nOTdBT1uR9PlUamrfqmUSPDZHRGL9rlj/kn5rIxKe9c6OlF/eLmZ
	lLUP9BKk4EeDhvd+Xnm9phboToEDjzhcCHyaKM+Yss+57ZtJ3pSnrVTWwmQCuQHpLlvoxjDBrN8
	YXguKcS66yf54fK4lRQJJBOb2mnqCbmn9UQfMWf/i6vu+/x2lyYVjPIw5bZwgMa4MUyyjmPbJm7
	y2s9ojsyDuUzl39SeGUAI/zvJEZal+07BuKJ51wlSwV97UNPmT9cfEhZugJZcKP2ga0t2GA5Vek
	C346PeyYI6h0OL546iXN5i1SDpnkhto9yzQjr6QKIsvtKdEqkW3jSJbibNMuxq3mgB1IrtRn6B7
	55tDqVxA+XMkZ4A85zR/Qguaty80M5lblB7QduvxTFkfd1JXlAYuKSOMUKQhz/Q3qo4SppQpYxx
	KFWAl1w=
X-Received: by 2002:a05:6000:4386:b0:48d:ba3b:af36 with SMTP id ffacd0b85a97d-48e3eba7fdemr17782280f8f.37.1793112897739;
        Tue, 27 Oct 2026 07:54:57 -0700 (PDT)
Received: from localhost.localdomain ([129.0.101.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm23920834f8f.10.2026.10.27.07.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:54:57 -0700 (PDT)
From: Fien Dora <fiendora5@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [Outreachy PATCH v2] t1402: test --no-allow-onelevel option precedence
Date: Tue, 27 Oct 2026 15:54:51 +0100
Message-ID: <20261027145451.8617-1-fiendora5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026132525.45414-1-fiendora5@gmail.com>
References: <20261026132525.45414-1-fiendora5@gmail.com>
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

Unlike most Git commands that use the parse_options() API,
check-ref-format relies on a handcrafted loop to parse command-line
options. Although the --no- prefix is commonly used to negate options
in Git, the precedence of --allow-onelevel and --no-allow-onelevel
is not explicitly covered by the existing tests.

Add regression tests for both orders of --allow-onelevel and
--no-allow-onelevel to verify that the last option takes precedence.
The tests confirm that --no-allow-onelevel overrides a preceding
--allow-onelevel, and that --allow-onelevel similarly overrides a
preceding --no-allow-onelevel.

Git's planned work to improve argument parsing includes replacing
suitable handcrafted parsers with existing APIs. These tests
establish check-ref-format's current option precedence behavior
so it can be preserved when its parsing logic is updated.

Signed-off-by: Fien Dora <fiendora5@gmail.com>
---

Changes since v1:
- Explain why check-ref-format's handcrafted parser needs
  explicit option-precedence tests.
- Clarify how the tests relate to Git's planned parsing work.
- No changes to the test code.

 t/t1402-check-ref-format.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 9dd64662b2..6036df0210 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
 ref='foo'
 invalid_ref "$ref"
 valid_ref "$ref" --allow-onelevel
+invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
+valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
-- 
2.50.1 (Apple Git-155)

