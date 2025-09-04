Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D81308F17
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995744; cv=none; b=mbb2u69ZU+zkhQDNKfneHQ8TpJ1DETvJ9vMPo/jOQQfReOXoGTrydlWzKrGssG9CcM9t1AOxvaoaz39LtpbXFKyCyj4Uwj7P36FmQ80R+YFeXFRG7xK0ALeoD5cncLQpvdDgKBSFuOzzXtZynjOrArX1Zm/fexUYLEhIw2ySzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995744; c=relaxed/simple;
	bh=miJLzEwUDqXIWLKM9rf6wXE2C+KMlm2yErI/wUje83w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szIJnqk1AIgUnsm2VjR9+bitYZxpbKMiui7cj8HmsFpv5patbu4+8xGq+rIg0No88ICd4TzXRsHXuf087bs80V9ddaCu2rs64Zd3LvmnSqekM1hTb32yA1cjgTXp9vPQyPm7kb06VV9zahfYT+ZpabVd7gVY/FK+h6SgArQQcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efo1O3A2; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efo1O3A2"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-544ad727e87so876857e0c.2
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756995739; x=1757600539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9qXTUEaTGJAPyEBtsR2SLhdGtj1LhgM+3Xta21GEYM=;
        b=Efo1O3A2fiMc9tythKuGULJ7902a3dXUkWI4JCFZFvYeDb+aZ13csYGTrc8EX50z2j
         cxyhRX3+973zXXymplg5AO+mJTzfn6AktG6lwo0JWMb35SmNG69YmeagoBVvnrQQmZwd
         bQoZYn6Vl6jVJSc6ZkJxZ2lKKiRd6S/asGB17QrF0fibp5Em/Psep+1Q6rAGSJxn5iFp
         jUIbZhu4nQ9d/5STd5QKzOVDRGDXnJJERROuRkdTV9YHmdJuAvY/WTNUhBYFTOfo0NxM
         iVIyW+KcwjtmRfd8mZNOKuQsKAh5pIsgRyXovJQEQd/M2/JZ54NrslaGWmLgNNUSB72U
         DrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995739; x=1757600539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9qXTUEaTGJAPyEBtsR2SLhdGtj1LhgM+3Xta21GEYM=;
        b=gSBFhA4HYtC7SQYHcx8gikukfYfcsrS9AgwYf/T7oOCKLSSjRiIJZRRfpDOMtKfocv
         5uYQYkHLAzBEF4bsWyMVAs/ydn9eGlnD0OW7CHpiDVcF87S9YSd0mL4RffzRU2/uRKzp
         eXpT4Y/W4PWFJwZAVKZRa17YRLw4K2h2JHsJoBuK9FWqgmzDBFZoart0nR2PEn4EV4n/
         2c0FftakifsOt6ZB63qGGjA4tUnR2844uOuejsgSZSxYwb9U5zLAa0ohW2qBJ+t4v3Sm
         XPCHNKA2gIa/TnHIVgCMP7UhYy3BfUlLlHR8SGv6pxrUglBNMS5y7siEBXRtDG/aAUys
         CjQQ==
X-Gm-Message-State: AOJu0YwOx6ZHr/9l6Dx68jWE3Jw3e0mW2FVPR1ovts1cJ5UGkn99MODc
	tR1LWVOWbnH7ZQcc9fxj3wJtIRnolKClbfcZ/sxhKF/8DSO1mGcfRGZYVu0hNw==
X-Gm-Gg: ASbGncs0YnTuPIqK9gEz8koZH56gjqH8DpeWLTwJwFw9W+guuJPEVUqTnQ14+PjEij1
	QTDbOodxQCIuNvApGawqexpfyp7xHEAvo+ipueHMW4CLPlcToSc8+h17/s50fThAkGKAB4hLWsl
	6MPh6bMcl0ssfmF9k3+ytWQoF9d3V6kQJvqLtC6S1lfNzvAwzIkESMKBb2BGgXTCeWWP0SvtSOw
	IOKycIz63SuHm7EOtkjw1loV47xKRX0+95SG8gHwUqzM2T3WRUQyYg9F1TjvBafBiMg28zPWwHz
	cKpw1AU945i/cIiRr+3KhFU08OWQd+YoSBfN1wuuLF1Y1pBj4TlnwTm2Npe0UDo+BLYPTjwhKGq
	a/+CWKZiPUsWsu8x31MAYA8uOaTMl9b91lxj5WxgqWxNuPvTE8qRfX6jl2iokLZ4=
X-Google-Smtp-Source: AGHT+IHqVlfuufFGjIabfcFB6ta5Bf26CbvxglixyRez3rEH22MRd2/fvwd0Pvx1doAdHRcXsNvqkQ==
X-Received: by 2002:a05:6122:1350:b0:539:5717:ecff with SMTP id 71dfb90a1353d-544a018be5dmr6066080e0c.6.1756995739101;
        Thu, 04 Sep 2025 07:22:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:3d64:69a5:cf8e:268f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm5409732e0c.9.2025.09.04.07.22.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Sep 2025 07:22:18 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v4 0/2] repo: add -z and objects.format
Date: Thu,  4 Sep 2025 10:40:15 -0300
Message-Id: <20250904134017.47364-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This v4 fixes two codestyle issues:

- Break line before opening a brace
- Add spaces surrounding a `|`

Here's the range-diff versus v3:

1:  0323f1fa75 ! 1:  19c84e1a48 repo: add the flag -z as an alias for --format=nul
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
      }

     +static int parse_format_cb(const struct option *opt,
    -+                     const char *arg, int unset UNUSED) {
    ++                     const char *arg, int unset UNUSED)
    ++{
     +  enum output_format *format = opt->value;
     +
     +  if (opt->short_name == 'z')
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     +                         PARSE_OPT_NONEG, parse_format_cb),
     +          OPT_CALLBACK_F('z', NULL, &format, NULL,
     +                         N_("synonym for --format=nul"),
    -+                         PARSE_OPT_NONEG|PARSE_OPT_NOARG,
    ++                         PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     +                         parse_format_cb),
                OPT_END()
        };
2:  b2b241f401 = 2:  6258316d93 repo: add the field objects.format

Lucas Seiki Oshiro (2):
  repo: add the flag -z as an alias for --format=nul
  repo: add the field objects.format

 Documentation/git-repo.adoc |  9 ++++++--
 builtin/repo.c              | 45 +++++++++++++++++++++++++++----------
 t/t1900-repo.sh             | 18 +++++++++++++++
 3 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.39.5 (Apple Git-154)

