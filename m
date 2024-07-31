Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E831BC4E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461815; cv=none; b=WQY77dtWncYquYvFXc+CYlKe32VIw06f08rHTMBXRTJ8F9uNPVPync3zICYYUVXurT470mOYnJANNjOiVpb3Vimyad9CqXeTXX9iMV3xFhovKoK4j/k0b0tG+/smjN3XW8QIMkPAWWFhC7yubjrsT+sQpuBZLTc1tE5L3oGR4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461815; c=relaxed/simple;
	bh=ZpcOCpAF4BdG9az4z+PO+dBw34zS8GrX5xxikT2a0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txF5HMdWk3w1/hwStLMEtHB7mUnfr9v0xOIpR61+GrwDkI3PrZ89BSI1H+uRfGDXmDoyOUyKOL0CLQnuUwdBE8SEX03tPioRL8G3x6btIJPspaZ7KlnWfRKlHkiXgyr01IJUl3EFNqAiovaNH0u48splBSp2DlHQyuR1J8ZieH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fvlAYKhb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fvlAYKhb"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bb687c3cceso19669406d6.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722461812; x=1723066612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGa33sdtCfK8c5JvJYfs2YzLb6L2L2beLX6rx/9bzmQ=;
        b=fvlAYKhbadBPQ6qDuKjJl572WOVht0SkvsRjNpRRLrP6TzEkvhV7DW8iSrPtXkWdaL
         S8YBVv7xlnorSPuLKDXJnsLdJOVUABT3twp2curIEeCe4QMNfNo/CvCqMa/fweDh5Fhq
         BB7gOnaCf9HwjvkXj3gsI1ixJw2EnpwKKWLiJJfiqOLKadRj6Cwh9cx2NOejITCgDpFJ
         kLBV8xWOI1/yL5/aAUnlejr+xpVp3G9QL7vTK+UbTbLjgJ93bWhha/HsMnN0ECdDbmLt
         EaBrRVtg9sMo1C00kBsPxxlYiw4FYSmzZ3/s9tnnCyO1/b766Mi7GyI9RsFR+BKTJoXD
         ofKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461812; x=1723066612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGa33sdtCfK8c5JvJYfs2YzLb6L2L2beLX6rx/9bzmQ=;
        b=fcSAXFHf9Nu+jONAT5n6Ki1ZgdH0NOf1E+b76Eox/pGJXRmGEdQ6ITYhparNaysDON
         r9NCvHHnXICRUzz486QokkMswumugtjaKcW8ud7mz70O0KOOurv3AXpkwFrVdHJCdb4m
         9xfZxhVe/Zk7OW3Qu6DNnWnK8yQUIo9JHPdiA436dVv8d8bkFRppaEO67hGiV/Fv8mP/
         F+Wtvyd99a43UEYBA9TeluH5x8+c5kOeLeGMxABWSkA3/ETgFeaU1ljMKjOCFJeoVFyr
         GJ9v3/IYvlYB5GtBPtnF5QT89utKc5fCRcxY3qtGM0+n1xRepyc4nnciN92meEAzKxwj
         TNsw==
X-Gm-Message-State: AOJu0Yx4s99/3FW7vFF+h9EqNj3NL+oUErkxAQ4LZqfGAaz3szezUhem
	qGcP/mbS04Xj1mxK/FmyhuCqkf+WgIdyiBaDIFCm9ed0ybr4EQyBRnPtuzdHjSw=
X-Google-Smtp-Source: AGHT+IEL9I49o8LzLNNt1+rIUzPUk/qiRg4e8EkUKvPjHS9OW7T8BIlWXL6dcEgLl1fshN5viyJtMw==
X-Received: by 2002:a05:6214:440f:b0:6b7:4712:c878 with SMTP id 6a1803df08f44-6bb8d786428mr6327376d6.41.1722461812171;
        Wed, 31 Jul 2024 14:36:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94a16sm78900466d6.86.2024.07.31.14.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:36:51 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:36:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: git config set --file, key-value pair without '= value', gives
 Segmentation fault
Message-ID: <ZqqucpNgqSgZDPtA@nand.local>
References: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>

On Wed, Jul 31, 2024 at 11:55:06PM +1200, Han Jiang wrote:
> Thank you for filling out a Git bug report!

Thanks for the bugreport.

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> input:
> cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
> cat >'./config.txt' <<'EOF'
> [section]
> key
> #key =
> key = value1
> key = value2
> key = value3
> key = value4
> EOF
> git config set --file './config.txt' --value='[2]' --fixed-value
> 'section.key' 'value6'

I was able to trim reproduction script slightly to the following:

--- 8< ---
set -x

rm -f config.txt*

cat >'./config.txt' <<EOF
[section]
key
EOF

git.compile config set --file ./config.txt --value='[2]' --fixed-value section.key value6
--- >8 ---

, which just relies on having --value, --fixed-value, and a key without
an explicit value.

The script you provided bisects to 00bbdde141 (builtin/config: introduce
"set" subcommand, 2024-05-06), which is the commit which introduced the
new 'git config set' invocation.

But that appears to be a red herring, since the segfault happens in
config.c::matches() here:

    (gdb) up
    #1  0x000055b3e8b06022 in matches (key=0x55b3ea894360 "section.key", value=0x0,
        store=0x7ffe99076eb0) at config.c:2884
    2884			return !strcmp(store->fixed_value, value);

where we are trying to compare the `--fixed-value` argument to `value`,
which is NULL.

So I think that the behavior dates back to c90702a1f6 (config: plumb
--fixed-value into config API, 2020-11-25). I think that the fix looks
something like:

--- 8< ---
diff --git a/config.c b/config.c
index 6421894614..05f369ec0d 100644
--- a/config.c
+++ b/config.c
@@ -2914,7 +2914,7 @@ static int matches(const char *key, const char *value,
 {
 	if (strcmp(key, store->key))
 		return 0; /* not ours */
-	if (store->fixed_value)
+	if (store->fixed_value && value)
 		return !strcmp(store->fixed_value, value);
 	if (!store->value_pattern)
 		return 1; /* always matches */
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9de2d95f06..f13277c8f3 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2704,6 +2704,15 @@ test_expect_success '--get and --get-all with --fixed-value' '
 	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
 '

+test_expect_success '--fixed-value with value-less configuration' '
+	test_when_finished rm -f config &&
+	cat >config <<-\EOF &&
+	[section]
+		key
+	EOF
+	git config --file=config --fixed-value section.key value pattern
+'
+
 test_expect_success 'includeIf.hasconfig:remote.*.url' '
 	git init hasremoteurlTest &&
 	test_when_finished "rm -rf hasremoteurlTest" &&
--- >8 ---

I'd like to hear from Stolee (CC'd), who is the author of c90702a1f6
before submitting this as a standalone patch.

Thanks,
Taylor
