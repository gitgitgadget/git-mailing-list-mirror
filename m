Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10902C69C
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807779; cv=none; b=nGJOyFxSpjxNXfB0tst1BXMg1fk7WT1bPQEc74qc94CDCewFT3wztq8Azxtck0CjHJUD2CM3Klp/IaKROvEQ8g8hU+qrIq4w348RR/aS0u31pwQCKDwbi+5bfBxgFkPr1/r1xBVFw3j0LW+C7amkvs1AVH4FovqK6f5xnEPfw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807779; c=relaxed/simple;
	bh=QQ/La8fuUc4SrmLmOPhfqg8sGUUCuVvZDXw44vxgsNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KqVNWBd6uyQegr+OsMu/NkF9V7H3BEMbxPVPHkUTZfdf+Qor2Le7wY4iRBvkoZ7VslTZVsmKF6/urDsUJKVzWRpAVd1oqFolZCpYeQiYpMr5nEhYx7jHMY6fq/7s7ORu/vxy0c2BV1XmA11wVYhprbgivflijww3nMNHt/loPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0wx8DBs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0wx8DBs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so2444233f8f.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711807776; x=1712412576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Yk7M76DvN5C/1GY4kKAcS9oP/S7K2343ZiRx32ktMs=;
        b=f0wx8DBsqf8H/oUqjgrWex2JDdZtH2fADcR5sBDtB4zwJ9QonjPwJTWsYuOQU7DJrY
         aJtPy4mwggicKdgrOZ0rv68sUCa7vjzu3+V2g/2Lt3DPZ/vH8id5jCR20T5tYqm6qHu+
         q/fqP4GcG17IS5bNBeP4E1wTBTuKEipnPXFWQl8BqxwC3o0M1Pf/1UDl4WOmTY6+J8kt
         4H9+iHCOCFwmjRHRg8HCZH/W44llkM70jYbz3yhDRSqsAY0CQyQ5IZSU98cSEjg4uNYw
         1TOfZep0i+Jfu7kW+rN164i1yM5nRqcYtNae3HndDxiVoECl+EMBQhfKXmGE1aM3RrvX
         iWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807776; x=1712412576;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yk7M76DvN5C/1GY4kKAcS9oP/S7K2343ZiRx32ktMs=;
        b=u7HpHwrBz9z0v3Cf4PlxbD02tqcUYCcykdbugPBSv+IuYVzVEFk8lKNgD+Gimo9F/S
         OarAdtV7PFRxhgnM4bLPNectM7/KuQGwZqdLUJGGSf2UYglRcADQ1dkb+pO7+vt5i1iE
         83v5hGmvstDbZvTpYM7BdSxR/FhLKqBldn8sYhhSHzGt3Lb2awgJFyPa5cvRsnDAnDGv
         4YMbhIzrWU1c/eTFdAWXnxGX1Tz1cycSREnNcarUdk9xdGCjadEfS6/QgNNmBICgnQlO
         j7vS1DhSZX+RaE6cxYseFCwOTPW5/iug6T8iTm9zlSUXFRD9sBThYrysri51FvRZQEt2
         F1vA==
X-Gm-Message-State: AOJu0YzzvD7f3Efyo+vp9Z+OTf1H6MUO4FFwKUzLq3n5t3OaR6XxXho4
	9khy+zh/m7zg6wQHpEYQspD+rv7NsN1eriZXnnmwiNdvxv2vU5kLG+LzfbZq
X-Google-Smtp-Source: AGHT+IH1MbnctAITcs+J8nT6oySwNKd4zGITRy9nRSva4SCiAwgU6z1zyhdGIRE0z5u+AwS0E8G+aQ==
X-Received: by 2002:a05:6000:124f:b0:33e:69db:bf9e with SMTP id j15-20020a056000124f00b0033e69dbbf9emr3856989wrx.67.1711807776146;
        Sat, 30 Mar 2024 07:09:36 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id f10-20020a0560001b0a00b00341dbb4a3a7sm6498767wrz.86.2024.03.30.07.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 07:09:35 -0700 (PDT)
Message-ID: <aade9864-660c-4238-92ee-4a67758bedc6@gmail.com>
Date: Sat, 30 Mar 2024 15:09:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Content-Language: en-US
In-Reply-To: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By following a similar reasoning as in previous commits, there are no
reason why we should not use the advise_if_enabled() API to display the
ADVICE_ADD_EMBEDDED_REPO advice.

This advice was introduced in 532139940c (add: warn when adding an
embedded repository, 2017-06-14).  Some tests were included in the
commit, but none is testing this advice.  Which, note, we only want to
display once per run.

So, use the advise_if_enabled() machinery to show the
ADVICE_ADD_EMBEDDED_REPO advice and include a test to notice any
possible breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c  |  6 +++---
 t/t3700-add.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 289adaaecf..e97699d6b9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,9 +310,9 @@ static void check_embedded_repo(const char *path)
 	strbuf_strip_suffix(&name, "/");
 
 	warning(_("adding embedded git repository: %s"), name.buf);
-	if (!adviced_on_embedded_repo &&
-	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
-		advise(embedded_advice, name.buf, name.buf);
+	if (!adviced_on_embedded_repo) {
+		advise_if_enabled(ADVICE_ADD_EMBEDDED_REPO,
+				  embedded_advice, name.buf, name.buf);
 		adviced_on_embedded_repo = 1;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 681081e0d5..839c904745 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -349,6 +349,40 @@ test_expect_success '"git add ." in empty repo' '
 	)
 '
 
+test_expect_success '"git add" a embedded repository' '
+	rm -fr outer && git init outer &&
+	(
+		cd outer &&
+		for i in 1 2
+		do
+			name=inner$i &&
+			git init $name &&
+			git -C $name commit --allow-empty -m $name ||
+				return 1
+		done &&
+		git add . 2>actual &&
+		cat >expect <<-EOF &&
+		warning: adding embedded git repository: inner1
+		hint: You${SQ}ve added another git repository inside your current repository.
+		hint: Clones of the outer repository will not contain the contents of
+		hint: the embedded repository and will not know how to obtain it.
+		hint: If you meant to add a submodule, use:
+		hint:
+		hint: 	git submodule add <url> inner1
+		hint:
+		hint: If you added this path by mistake, you can remove it from the
+		hint: index with:
+		hint:
+		hint: 	git rm --cached inner1
+		hint:
+		hint: See "git help submodule" for more information.
+		hint: Disable this message with "git config advice.addEmbeddedRepo false"
+		warning: adding embedded git repository: inner2
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'error on a repository with no commits' '
 	rm -fr empty &&
 	git init empty &&
-- 
2.44.0.417.g254ece0ee4
