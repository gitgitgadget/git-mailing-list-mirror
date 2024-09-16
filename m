Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAED2B9AA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502058; cv=none; b=Insu6IrjzvyrpnBfwYJbu9GF4bN+sDFyzVnjGdmanutcmdF2YTfqEJgoLbUkRLi2/HEAt3ytS17EHIeB0zE9vB/aB2LLp9X43sPVArJ66uUcCrMDXZtTtyEmOmYp0PZmqUTtEsWJDNuh7JcIsY4XB7R7EJDgT5DxSWQMMnBD+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502058; c=relaxed/simple;
	bh=ep4dipoJNsynvosnNitPTXrO4HCYtgidc+K8uyez/nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih+CiNdc1ddd5UDZ633KmFEII9jIRs3fm1PDGAszxEKHCujQQMCw40UifrU5iNyBcVsi8/fR/Zflg1AUpXZrPDcQRFR11shaPQqPkWPtAeeXSYHNqYCHAFQ17ykUGkHxKW4KZsv5ftivZgwO425+iubwDTkc5a0c2lzpkSHOnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fxKiIPC6; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fxKiIPC6"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa6be8457so137908439f.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726502056; x=1727106856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOIqqT2FiSQx60w6RgKZNvqeehAyYP5OrEpDw2yQBqk=;
        b=fxKiIPC6hZG4lsCHzFJg3OGtE0omdhfz3Ni9KrvwB/djLc46lPUmw/qlG/wTQSwgYQ
         w15Fkq1d916FQq35Eb+zJ9awCZTqHOEw78txcLVael2HgRHefZtYA1Cjt/BiouHNLk4M
         0SqtBPzjNPZE66MDmluEQrT9qIJIEYwSS1yzQ1p8QBVzZnefrD9Jrfp06PKVWyODiXnc
         clULOP9jEWCYRlZJ9Spi+HNVW8HkAYeJ0glpj96uhgZ9srYG1O8TXNr2I99oBX8pngVd
         57cwWvJNsVuYvcNW4dgPmBbl/Woa9/vtTlhmVcvvjcuEbMUXX1zdMf+ajddEvAaX/Sbb
         GcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502056; x=1727106856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOIqqT2FiSQx60w6RgKZNvqeehAyYP5OrEpDw2yQBqk=;
        b=kdd5HjESCzOVKRxXIXt+sb2wAivmI55Dyf5roduKPpi4BFKwSBbGoi+3ileSLNTXKi
         fQrN55aXDuNO5xmfHtK9zKogZilb2+I1eptMfS58i5sN54coNTxLXGVlXxf/R5GkIWaQ
         BGYlXAUEhR2MeIG9DqIJG/77XeZZgogqqgYu6FPfvGu6KqjyAwjJ6vpvm7ODTjynyKyH
         c6+B5eaPuew/7Nzl6bazsS7alquCEhRICM6BX3L3N8L7PtLMVsnDYrDvWmU//M0/xqhc
         0z9JdlsKAG1Lljqort78POPQdncHXJMlcsz9vjnL6dA7ZNrZxJQwRJlbcidEjpcJKuGi
         3pNw==
X-Gm-Message-State: AOJu0YwNsSw+x11Qb9HKP4Py+VOS00a0iJY/DkgjoYNkZ9YQMzQ2WIKE
	62ylSSKQCBQtPEq1IEujwMvRnAnw7OWthwRrNBBmvB0vABfreTi9t5Bu/of/1Ws=
X-Google-Smtp-Source: AGHT+IFWxt55HvRZ+RCbUCyEyV4/5TO21gRAUiPUEZbHufXNoizHjBnkW55O+kURC8wDBVZ3+m5QLQ==
X-Received: by 2002:a05:6e02:1a8c:b0:39d:2aee:e4e4 with SMTP id e9e14a558f8ab-3a074bf2361mr130883745ab.2.1726502056085;
        Mon, 16 Sep 2024 08:54:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec17e90sm1527278173.52.2024.09.16.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:54:15 -0700 (PDT)
Date: Mon, 16 Sep 2024 11:54:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
Message-ID: <ZuhUprZXvcRvgpp5@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
 <ZugMUv1xbnjYH-el@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZugMUv1xbnjYH-el@pks.im>

On Mon, Sep 16, 2024 at 12:45:38PM +0200, Patrick Steinhardt wrote:
> This function compares the exact contents, but isn't that wrong? The
> contents may differ even though the object is the same because the
> object hash is derived from the uncompressed data, whereas we store
> compressed data on disk.
>
> So this might trigger when you have different zlib versions, but also if
> you configure core.compression differently.

Oh, shoot -- you're right for when we call finalize_object_file() on
loose objects.

For packfiles and other spots where we use the hashfile API, the
name of the file depends on the checksum'd contents, so we're safe
there. But for loose objects the, the name of the file is based on the
object hash, which is the hash of the uncompressed contents.

So I think we would need something like this on top:

--- 8< ---
diff --git a/object-file.c b/object-file.c
index 84dd7d0fab..2f1616651e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1992,10 +1992,8 @@ static int check_collision(const char *filename_a, const char *filename_b)
 	return ret;
 }

-/*
- * Move the just written object into its final resting place.
- */
-int finalize_object_file(const char *tmpfile, const char *filename)
+static int finalize_object_file_1(const char *tmpfile, const char *filename,
+				  unsigned check_collisions)
 {
 	struct stat st;
 	int ret = 0;
@@ -2044,6 +2042,14 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	return 0;
 }

+/*
+ * Move the just written object into its final resting place.
+ */
+int finalize_object_file(const char *tmpfile, const char *filename)
+{
+	return finalize_object_file_1(tmpfile, filename, 1);
+}
+
 static void hash_object_file_literally(const struct git_hash_algo *algo,
 				       const void *buf, unsigned long len,
 				       const char *type, struct object_id *oid)
@@ -2288,7 +2294,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}

-	return finalize_object_file(tmp_file.buf, filename.buf);
+	return finalize_object_file_1(tmp_file.buf, filename.buf, 0);
 }

 static int freshen_loose_object(const struct object_id *oid)
@@ -2410,7 +2416,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		strbuf_release(&dir);
 	}

-	err = finalize_object_file(tmp_file.buf, filename.buf);
+	err = finalize_object_file_1(tmp_file.buf, filename.buf, 0);
 	if (!err && compat)
 		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 cleanup:
--- >8 ---

But I'd like for some others to take a look at this before I send a new
round that includes this change.

Thanks for catching that!

Thanks,
Taylor
