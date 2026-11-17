Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876273;
	b=vzh/IiRCHmwsQoqdXLhPZkHp0aG3affJxneGpMyKjcFEl2DrW/+42y/0ohWkQkzMMOM2
	 hVYNXp34zRg89VFeoe3EpNwwrFvManGspVTU2EuqdAK3x9BXTFKJNx2xC69OLdamAiPzq
	 IwG9sSjfiEHUfdcKg2dMiUeUbEHuRV6Btbe0dAif08In4DuXlF8HjcZlssn0sx9VkrVhF
	 9xJAeMVbYQ3Ufgvldy2fEF7LK7X2dpnl2k+2nNIb3CzoxalPnYvHbklgQc3WYmKc9ZX32
	 KLAtakCVtBuWOHg/NA/ulrTllV5TIgezM0pNaIi54CSTooETGdihIDgvxgRLGdey+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2a083vG6blZsqfA86EPzPG28YeCImlSJwtcv9p8cqOA=;
	b=L7u9ykrDzn6NKYmNTPVWYu7VV+mx+1AofoPx4f6vAxaNnZClM4zCejMxAvKecR+hZF03
	 d2kyAl8uOPzjHW3qTgyN7onuxt6qpxnkoiFqoquyLUCYeL6L9Ax/EjuRI5GFDnqJ3QImW
	 evwYKP/HtU+polC0KakhvDEnIAFcL159coMqNYeHqhFr5MWPAGmtgk6Y2XYJ37uwmLYSg
	 2LLBnXJgQWRt1HM4GZ1Ts0UqzVW4IMIqUvqN7U2dAvTZXmbPkpPRii1fDNTJ3LU4M6QaH
	 V91GzBQxYHz69BM0rqCxb+a/HfywdwxSDI0nTdQmp/uIeH9g+xNJq1eqWpmCLu2vfaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I2WxsAqP;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F2606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030F2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I2WxsAqP
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a32576da88so317695f8f.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794876271; x=1795481071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2a083vG6blZsqfA86EPzPG28YeCImlSJwtcv9p8cqOA=;
        b=I2WxsAqPNFBn29IGYm7JbW+212+9at/0vngtECxcVfLbwB/Yrcth1XUxax299gfWQ1
         6MRHnzS9Iav15/SAybR4ixc+4wmR4i76ymOdMlPZIrv2OfclaOGKnWnnHK8ivTzVe21I
         inCBxCupHMwLsuw2IhLLo8pbXGvVc+hyvksXKygFh8vzHQT35rHOl1ffxUR/mH0Uq79M
         IxKJtkyOANO8rwejiWaVLEV00PnCgl3GWAguIONwoZmMsZZ5WTj268jZ+Vnx3G9KJH3j
         hYkiXMdmyKul3snplEOv4oYvIiIqmwhmNm5OeRmGG6PjI7buoIX/yGqWslN88YZwj5yC
         MQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876271; x=1795481071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2a083vG6blZsqfA86EPzPG28YeCImlSJwtcv9p8cqOA=;
        b=rfXCjDJkthkIJuFpHcFxdOnWpFi66EItjC7EHVCv/Cz7Crdp+RWogKayBFmfEArETz
         WjuIWpnbVWHWQhxY8GJaIfoJ9p2D35JkoV+NinJEPU8KFvt55AN40miJCzfgS4wyZWhS
         IdBywoyr7YsGIzR5qsuEtj0kKMZ10vO9HfzIa+l/UuSNIhsoB5SaG1znfcq+RsBPb+6D
         8702TWNHOXBwdofvCbKD/kHbeVz8xDF3TUuIAZZcpZtE/B2KqChM7CuwG8efas0RDdmQ
         8jWKMBU/B792q5vYGu0AJ8+W4KuYVVSCeM9asR0RT5fu67oKJyDCLYHCJ4dV0eL4xpr+
         T/PA==
X-Gm-Message-State: APuU4Z/t0EEL42ciVx/tuAifwLbYkruL1cwATMZg6cq3YeB60MfuEk4P
	Ls+PptghNIejxUUCnjheC+25KlwGjhKJLl9lbIL7jjQYin6bBGIfuOZq245SNulGzoc=
X-Gm-Gg: AZFdTZepC1Bg+uRR0m395J0wzz3cCo5M1kw2o7LmxAe7cx6Ve29bCP0F6T5629TCZ36
	PsLrIU+zX1yqwYqrsoTha+QC8ClSa5db98TPQuxKU0gA1o7BvxgL9Y6x07D+wsRhfNZV8mdbigV
	iTUGyqtiHqecQRE9S56xI9SKe9g6SrYcxPm/ufyfJBKzsmXTo0lBi1cblVkFR/2hB/q3JMB1oKr
	6IY5xZ9tBbR1208/8a3aok5x1pq/lW11OJ/DivyH7Vcto0SnTNOvD2e1nhiwg37FsN1LI4ZZZHP
	lq5edJ+t+rYC5KCN8W4+wOi2ob3bdEOzWYka7pRNRD1rs7NLMA+W/3GqbAf+wZ6OQITfLkQXw10
	Q8nog3htWe5leWX4mY2F7D1b87OeX9GeCrLyqbGCn8cG+Z70l4OuMBI7Nkpr6J/IVGdN0dSwFnE
	4bjsUwOy8rcHKB4IxFziY25ZeTt/QiORC63fXsoF+s54sqU0xKb6xlw6w0VEirKzCTSyEeYys3W
	oMbRjl9m9Jh032z7pNplZUdwzoGuZXlbHgnmIvSS5v0q03iBeNsqVVvxIOyeL5GDhpGf/Jt5DHd
	3SOadbPskqgsDQRwrWdZipjC6n++0wChS3KDnZ2lRMFaVm2RSjNMpSxn/RFnlrwvLfORIjLpHUL
	9aGOA4sSq591pzyGPZEoRWMnap+9LETozDw==
X-Received: by 2002:a05:6000:240b:b0:48c:6f3a:fe30 with SMTP id ffacd0b85a97d-49c712ac861mr26596954f8f.15.1794876271218;
        Mon, 16 Nov 2026 16:44:31 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a3d39b8a37sm953876f8f.46.2026.11.16.16.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:44:29 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 1/3] apply: free the old def_name in parse_git_diff_header()
Date: Tue, 17 Nov 2026 03:43:46 +0300
Message-ID: <20261117004348.806694-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261117004348.806694-1-tangajoris@gmail.com>
References: <20261114012055.127905-1-tangajoris@gmail.com>
 <20261117004348.806694-1-tangajoris@gmail.com>
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

parse_git_diff_header() sets patch->def_name from the "diff --git"
line, without freeing the name it already holds. find_header() calls
it again for each "diff --git" line it finds, with the same patch. So
when an empty "diff --git" line is followed by another "diff --git"
line, the first name leaks.

Free the old name before setting the new one. Both callers start with
a zeroed patch, so def_name is NULL the first time.

Add a test that such a patch still applies. Without this change, the
test fails under SANITIZE=leak.

Suggested-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 apply.c                    |  1 +
 t/t4133-apply-filenames.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/apply.c b/apply.c
index f00b7ba4d3..0847835357 100644
--- a/apply.c
+++ b/apply.c
@@ -1373,6 +1373,7 @@ int parse_git_diff_header(struct strbuf *root,
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
+	free(patch->def_name);
 	patch->def_name = git_header_name(p_value, line, len);
 	if (patch->def_name && root->len) {
 		char *s = xstrfmt("%s%s", root->buf, patch->def_name);
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3cab1038cf..f8158faec0 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -60,4 +60,22 @@ test_expect_success 'apply diff with old filename missing from headers' '
 	test_grep "lacks filename information" err
 '
 
+test_expect_success 'ignore an empty "diff --git" line before a git patch' '
+	test_when_finished "rm -f g" &&
+	echo 1 >g &&
+	cat >empty_section.diff <<-\EOF &&
+	diff --git a/g b/g
+	diff --git a/g b/g
+	index d00491f..0cfbf08 100644
+	--- a/g
+	+++ b/g
+	@@ -1 +1 @@
+	-1
+	+2
+	EOF
+	git apply empty_section.diff &&
+	echo 2 >expect &&
+	test_cmp expect g
+'
+
 test_done
-- 
2.43.0

