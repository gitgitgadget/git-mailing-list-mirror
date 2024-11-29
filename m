Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812914A624
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901031; cv=none; b=egvDVCf6w/o1LYdIRg7NWif+VZrKIkuRnNb96v9P6cJN1RE7GcvXMwdvCU5srK5uQ0WD2apiDFWsD8nwtQTpEwQaACVxYaD95HxPSZtWop5WTGnrV1Nq4cVwT/j0v4awTheRzcIqItNMOZIE6H2jdyT4MAUk8wuXuGJX2sW5cT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901031; c=relaxed/simple;
	bh=X0NF49f78PbKNBhT45Myp1THxd4OPYNGqaUxVYwNYrY=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=aft8tvc8u6ZAz0kglDvtxyhPQWpCOjHwTRqNPotuCnWK1kxYKO2MOXBydwgSQUce1pkWfpNo1FAOTN6Ceo+SiYzK2+2larZX9GZCtK2zCtON5SWrJDgwZJyushtMIiY9dlcZtT0rwX2Kg9H57h/X6TYu6zudmwx/sgMdw1iElzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI5kIBS/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI5kIBS/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so18919535e9.2
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732901028; x=1733505828; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP/mfO++brfmuPD1cwbczi/ogSEGkHCbu1fm6iey5W8=;
        b=UI5kIBS/Z3g7E1/GQe0Y0Opo6zcKL6ZuY9wFfpS5zbAfyeuabYCfEVHBLmdz/qNJ5V
         n0zXDNt1K48SGRTfemsF7dHSsrzm7EaE0/tZeiFMPHaTQVn2e4ntTXYRXJzIaBL6VVPW
         8caiPbhVy9HzYUjsfEQDoofoexfiM516hRLFbKihjf9KDXZUEvd4YORlfQWPcgNhhdXP
         BVlBnFuohDMwp4BrT5AKBYXWVDfK4qrDwZB/HOypvuXdkyUzHcB59WD4it49B0nm1ozs
         dQHG1R2Pe1Relybhav327SaeWQIYCz+cwCdSLA0TlrsB9245+HN4wpN1PjUMR01TMx4P
         nb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732901028; x=1733505828;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RP/mfO++brfmuPD1cwbczi/ogSEGkHCbu1fm6iey5W8=;
        b=tnKbyxed+TAzjJP5xqNvYpVduLxRwcVkO6U9McC7wxNsp+k1jAMq+nchL5d2fNY2cp
         qdWUdalJkVMrpshzzj8yS6SDl/YXW3HI2fgMf/g+64zHHF/aNjaO1UKsaASib1vdjFzK
         rjL6kdtGcozBI4FPGIlUWc4xE5wuM2SkBL+wly1yxUYpWsbhZnYyjal+Oeo+YAo0CWgR
         hyB3WSvQryUsKWtOisk7MDl6DqtkYHalTgSDzf7hh7lxT1RIwACAKt4VwnGG+8okWWok
         VTCJQCpzlmAfxqRXhal93CE2kG2ZHxDdycV2KfvdR4yBb/FUi8SpLN622L8mubRpAgmW
         EdRg==
X-Gm-Message-State: AOJu0Yz92NfxnlQRIgqlPECcdrgf6J1i+0dCxP2PRMemfOYWvh0BNlHI
	od9z5tnz/XSovUtvGi10CrD3Euvt3PcBXYN8sddyAkreTaHTMRfOy0WKmA==
X-Gm-Gg: ASbGnctpQuw8qu2ftNMaXLUrw0mFLiYzPwjvBe7aUQzauf4auRQMnluP3Q1FfBcB8I3
	GQhCn3vXODirQoESy1a7WwyI7zQO5cfHhdt3PTQ1+SHod93stouZ4pLlRXYgsxEnIKWqJp4RT12
	i8GZIepDCz3rxl+3myGx07tt9FHRUL4BgnFM0CPtYvj9ZsUbvCmeZZRqFoXyvwSiBzohZfLRv+j
	e+011xIP1rihvZRthSq1mq3YX8knxU5bv5IQTF9m6Ds3qyEKdbaAGds2A9dL7HUKeNCtD/vV6PV
	8fi9RY+H
X-Google-Smtp-Source: AGHT+IHDpdv8nvY/BxRcEul3kiNvU0dosUzl76C3M2ErP/zHLAdFzjBoG5Zqolcdbr8B87NMraUBdA==
X-Received: by 2002:a5d:6c69:0:b0:382:5351:5bbf with SMTP id ffacd0b85a97d-385c6ed75dcmr11237187f8f.41.1732901027314;
        Fri, 29 Nov 2024 09:23:47 -0800 (PST)
Received: from gmail.com (169.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm1607714f8f.60.2024.11.29.09.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 09:23:46 -0800 (PST)
Message-ID: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
Date: Fri, 29 Nov 2024 18:23:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] strvec: `strvec_splice()` to a statically initialized vector
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's avoid an invalid pointer error in case a client of
`strvec_splice()` ends up with something similar to:

       struct strvec arr = STRVEC_INIT;
       const char *rep[] = { "foo" };

       strvec_splice(&arr, 0, 0, rep, ARRAY_SIZE(rep));

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I've had some time to review the new iteration of the series where
`strvec_splice()` was introduced and perhaps we want to consider cases
where we end up using `strvec_splice()` with a statically initialized
`struct strvec`, i.e:

       struct strvec value = STRVEC_INIT;
       int s = 0, e = 0;

       ... nothing added to `value` and "s == e == 0" ...

       const char *rep[] = { "foo" };
       strvec_splice(&arr, s, e, rep, ARRAY_SIZE(rep));

       ... realloc(): invalid pointer

Sorry for getting back to this so late.  This slipped through in my
review.

I know the series is already in `next`.  To avoid adding noise to the
series I'm not responding to the conversation, but here is a link to
it:

  https://lore.kernel.org/git/20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im/

 strvec.c              | 10 ++++++----
 t/unit-tests/strvec.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/strvec.c b/strvec.c
index d1cf4e2496..64750e35e3 100644
--- a/strvec.c
+++ b/strvec.c
@@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
 {
 	if (idx + len > array->nr)
 		BUG("range outside of array boundary");
-	if (replacement_len > len)
+	if (replacement_len > len) {
+		if (array->v == empty_strvec)
+			array->v = NULL;
 		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
 			   array->alloc);
+	}
 	for (size_t i = 0; i < len; i++)
 		free((char *)array->v[idx + i]);
-	if (replacement_len != len) {
+	if ((replacement_len != len) && array->nr)
 		memmove(array->v + idx + replacement_len, array->v + idx + len,
 			(array->nr - idx - len + 1) * sizeof(char *));
-		array->nr += (replacement_len - len);
-	}
+	array->nr += (replacement_len - len);
 	for (size_t i = 0; i < replacement_len; i++)
 		array->v[idx + i] = xstrdup(replacement[i]);
 }
diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
index 855b602337..e66b7bbfae 100644
--- a/t/unit-tests/strvec.c
+++ b/t/unit-tests/strvec.c
@@ -88,6 +88,16 @@ void test_strvec__pushv(void)
 	strvec_clear(&vec);
 }
 
+void test_strvec__splice_just_initialized_strvec(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char *replacement[] = { "foo" };
+
+	strvec_splice(&vec, 0, 0, replacement, ARRAY_SIZE(replacement));
+	check_strvec(&vec, "foo", NULL);
+	strvec_clear(&vec);
+}
+
 void test_strvec__splice_with_same_size_replacement(void)
 {
 	struct strvec vec = STRVEC_INIT;

-- 
2.47.0.280.geb6a512a19
