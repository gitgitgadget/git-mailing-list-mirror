Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D417C72
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393036; cv=none; b=cx7KzihMR8xBZBUPSReGCg1slpyn+51FhBSZiZ6aQxSTN7YmqHsbtIKq2IJqy5DOrbOyROi635OfP/jESAL+Ky7/I0DvfneIVghEaMcAjXsDGG3/sOu6XeJmzvagKM8Y8pSOxeXnu5lIig8RW/p6n3Zcaq9naWJp5tp8/JCS9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393036; c=relaxed/simple;
	bh=c3ZRQjRO3x6Ewy7+9lqjlqXhGLfRkU4AXRnqA9LxOrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX2JNofCFnuVZhnby7Naywt5GMNajfN/0ZoEpCOzBSQfV3iMVFdAAHJ2FNjAjBklYzuLsownHcKz+BYzJ/4jYiKeOrPQHvthV8BansmHoEcp9TpIqjc819NWIamsW8boYFdDyLT9r6Pv7trS0X9AcnJv+QqCj9VEUD1OJpd3WBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XPSEz6Zb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XPSEz6Zb"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so12845166d6.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718393034; x=1718997834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avE3jGoM4USURxvMt2u/xwBY8XYf3l9ljDlU13lhcBw=;
        b=XPSEz6ZbMm/twOwx3ret7nQ4kA40OHk/sVMQlLQ3nFGj9BDniQCAQ4epove/hgMm8j
         76KfByqLqqjhAGscxwVFdKNvgcWdYeTabFsIEPDsHJwuJd3/6PifkvidAjp4EdxzaGR+
         oVBre7jleVNpWn8I3ruzfJCteI8hy4zKyxgJ+psKX3ULM4fzdeOQw5jp2q/toejjiUdX
         ZDwHR2NRUYZekooiwCKAe/nlrOSnFbefwfXuIUm8jYTE/lmrstmvZlVjKwWX9iUUzPdo
         eVtZwOCB821202HFGyJ0Nt6rtVZDDyp/X6YPsAOCcQ1cJoB1YV+oxIlWeFdfHbXoLNrj
         kX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393034; x=1718997834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avE3jGoM4USURxvMt2u/xwBY8XYf3l9ljDlU13lhcBw=;
        b=r5WglpgNRY2bPhLNyhgrDeZr87PemubI9GVOsEb1lcJrMSOFo+F86zDZ28L0PY6tx3
         HOjeQbT8IEQfL0rIzFJSWKXxUxVsgzJ9RsHAyx+lc2X28ttpLq3mZdyJVxPHuPyYWr32
         y8crlsbIw4IOVN2FCs0oFGsg9ySWdXfnVjlH2eUJQGnnRf9jCl78pa025nborqUYokAV
         Jp3n3rUcjbopaiw6A2Dc7M6jdoQll0Fwbc5KqpLkTiOdVN6jJ9Eg1lp0fgWB5JPF4iP0
         kmHGe0aXbQC52qVjKiBYRuhWH7ipTiA7YodspP8Egshv8zTJaGKoyIxTqFBWad0vcYjH
         L1+Q==
X-Gm-Message-State: AOJu0YxU1f1qrj2Y1QPByWgVcizExhHJOM8He5n4k5oLkSQFtwNxalgB
	/2/nmIHjVoAJgyuc7V+Ej1iivC9ZT0tsoKN3tid7PaTzmr2esv2e7R3j6FPu1A0ZR+940HCYqLk
	po2A=
X-Google-Smtp-Source: AGHT+IHe/mrwFNj3aq/ETP9iEVBMvrOC3SfKSK6k16EQU3n3S+RG4SnxpohlrxM43PSaufKC9vVOqw==
X-Received: by 2002:a0c:8e42:0:b0:6b0:7b72:4f7 with SMTP id 6a1803df08f44-6b2afdb567emr36312486d6.55.1718393033804;
        Fri, 14 Jun 2024 12:23:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-442187175e5sm9883861cf.24.2024.06.14.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:23:53 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:23:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] pseudo-merge: various small fixes
Message-ID: <cover.1718392943.git.me@ttaylorr.com>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>

Here is a small reroll of a couple of patches I wrote to fix various
small issues with the tb/pseudo-merge-reachability-bitmaps topic.

The only change since last time is replacing:

    if (st_mult(index->pseudo_merges.nr, sizeof(uint64_t)) > table_size - 24)

with:

    if (st_add(st_mult(index->pseudo_merges.nr, sizeof(uint64_t)), 24) > table_size)

based on helpful review from Junio. For convenience, a range-diff is
below. Thanks in advance for any final review on this topic :-).

Taylor Blau (2):
  Documentation/technical/bitmap-format.txt: add missing position table
  pack-bitmap.c: ensure pseudo-merge offset reads are bounded

 Documentation/technical/bitmap-format.txt | 9 +++++++++
 pack-bitmap.c                             | 5 +++++
 2 files changed, 14 insertions(+)

Range-diff against v1:
-:  ---------- > 1:  a71ec05e5d Documentation/technical/bitmap-format.txt: add missing position table
1:  0a16399d14 ! 2:  8abd564e7c pack-bitmap.c: ensure pseudo-merge offset reads are bounded
    @@ Commit message
         end of the mmap'd region.

         Prevent this by ensuring that we have at least `table_size - 24` many
    -    bytes available to read (subtracting 24 as the length of the metadata
    -    component).
    +    bytes available to read (adding 24 to the left-hand side of our
    +    inequality to account for the length of the metadata component).

         This is sufficient to prevent us from reading off the end of the
         pseudo-merge extension, and ensures that all of the get_be64() calls
    @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
      				index->pseudo_merges.nr = get_be32(index_end - 24);

    -+				if (st_mult(index->pseudo_merges.nr, sizeof(uint64_t)) > table_size - 24)
    ++				if (st_add(st_mult(index->pseudo_merges.nr,
    ++						   sizeof(uint64_t)),
    ++					   24) > table_size)
     +					return error(_("corrupted bitmap index file, pseudo-merge table too short"));
     +
      				CALLOC_ARRAY(index->pseudo_merges.v,

base-commit: 0b7500dc66ffcb6b1ccc3332715936a59c6b5ce4
--
2.45.0.33.g0a16399d14.dirty
