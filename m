Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958983;
	b=Kgz/Ff/tmYxUKwTjo/jkoJJwYNocu8VwgBqND3O3DDXf1ps40mhlmSwoYtGehVRtLWlk
	 HSarKEz+uUFDQdAysN1QsknTMYGeZt+mlBzWPAdszAwHverM72P/2jQeIsSUSPE+D/rgr
	 n62/WAuL7fosH7XjV/jj+eRR6F4sB3bRAOM1UzjI/24QeR1K1KWarS876WXRzeLxohhtm
	 HbOR32Xhh1/xmAQI6GU8pbvqrbJ+gVx98MAV1xUS/+l9Xwdf+eAje750gyGMV1u2QsLk+
	 0vyCPo2D4wAbTumfpx5P5uzCs9N/WV/F2kez0ITWFI+AFuVsndaP75km5F504vd4ocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gsBEsNzrjgWoxKPRryKBf83Rk/Fs36ipa1/Ert0gzok=;
	b=5ePLMLrFqZng8lBYEiz4l3SebWNoYYkS7Cjkd85juueVIAHYCSiNFBo8PE4UeLzocDV1
	 ZhxQPfQ1P4om5MoI/4bqJptJuFXt3zjJ6bvYzyGmBNQ/CR+STUEs6UkT8/upDi2HWJGKt
	 X3U5HhqywMvKYRh9vnbsMv3c/+wz/kiQIHtHTbCjigeinWGgSEDnn/O1plpc09G2SII5a
	 ZzhjpcckyAdeOxWqtGHu9Yo+YNfI/vshwsr+oHwkZhnYgbeRGk62LEeIHB3iPJWWcTeN6
	 rCyqGqpRymvGEjDSaxQXA4dUIcTeoMJ0DZLCnYCHmLQLTMNMPMzHz2Va+G+VM8+DzWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3mSTxar;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9C606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE9C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3mSTxar
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8629ef8613aso151155a34.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794958981; x=1795563781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gsBEsNzrjgWoxKPRryKBf83Rk/Fs36ipa1/Ert0gzok=;
        b=U3mSTxarBeO42MpCQtTnaTP10bXB6klU2gBZeWjsy6hg1ltG0l+ew9jpDP4ChxKvCA
         GYZHTFqdcIZKgWn8bIQJ4dslPZ3g37N0mx03ex2BxPxUtblNBatlRDmNX5df67GC1j2I
         mky6jobrmq+OEoNIeLNMkDx3+6P3EW0IC19Z6K81g4wlHXx0X9HC+98LYM9+JH4nDh+4
         +RzyLz/Jv3zX/a/4twtyqpKkU0GvhzkOHWUnnKNIfoU020bFOFhJhRu4JbzBPG0jIP/h
         CsTjMsktxiP0/nmoy4dgBpgwWFGPws7WUoV+bnbF8+Z8Goi07UFl5WV1KQnRvJdDBuzr
         G2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958981; x=1795563781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gsBEsNzrjgWoxKPRryKBf83Rk/Fs36ipa1/Ert0gzok=;
        b=lK/JDS0D6vCJ4pd+UM2GdT0o7Kk6/pL48KUC/LrdBk/Cmza2a3FCYqcjuROPxq/PlK
         s9XHlVlpfW8Jtharn+yLwVDXjjodXd7Kr3Fih4PCbA5wLM1E3nlpsFLcPxs0XN3QcIcd
         a7bPaOy4IwbFN80rn37sCqJPC9cCyjJAiQnzY7sfC9b6p4AV/Wt+Dxow8KsX56VXZ5qZ
         P7vzsgpqehEEyeEDoZ8Iru019gDv7LOE5eIFGrsktnHimA9ii5Pl+KtGbZFqJFfA8NVe
         QIGMMirUiQxMt4uU2pJdAN+6jkG0elnCXO2PFgd+v4V8SCL6DyuC2U9f985b44UA/8ov
         LKAg==
X-Gm-Message-State: APuU4Z913IeLb5v8jvRrTP5H1Ko9HtNYByqfCqBlrFkI5A4WY8ia8JkO
	SWB2i6wrsjvp1pZFmIlvQ8dfpySsNIworn+3szf7HRw3VGNZX0dPCzet
X-Gm-Gg: AYBFou0kmr5C07wTT3oOJuv8pQSUDnST/mvuHTjaEbhTkuat+NeQ48NzN6ET1zZBWOZ
	NvUw5OVqMW+4lTohszDqssLY+84iYF2MDHZfRRjbPNZvrmkDVkvRSVuzCN05MxOJj3gzl7ygz67
	DKYELUy4v3Iy5vf0FADuhHO8rot8oooYzkLRAiWFAu6G+5Z4E7OkcpMRBHrSlriv8P+lQ3sNR/B
	L8PvwqvgOxZfuXgrDumR8+FPgvwqYgw6HHDxqYknAleqcsJtn9mf52yo5So9M9IlUnucmC4H1bK
	vPZtKU6m/F+I+He/b8/fKQaZ9pfbT4jHivYMWK2pSHzJv5CG86EnTCNq64GuT90r1IdiS+09n13
	RC7ceAc2XGAFHoSQm9KJ+xRgB+jQJ7Xpc2YiPDfvSf7s34gnGgvtFqu5Zl5axrerd+8+joun4ZN
	tS6i64VMAIunw+k+WJsGpD6FgcGO2Youw611FncB5J8BMPz1Pu8vE27JRe0MBdK8J43WBfL/2/c
	daBBfDyYYnru1MtMB9C3Nq58l9etWz2wnrmnpWBjYuISgenq7iuNGIo3AMPrI3jYANtm9Du1jYL
	8Z0ip9wbiskgv75PH+yhz/TMv9vHk8C6XVJjJJ6RmH15rBZ+FPcbGg==
X-Received: by 2002:a05:6830:7188:b0:862:a2ec:dda8 with SMTP id 46e09a7af769-862f0950fd8mr828043a34.26.1794958981318;
        Tue, 17 Nov 2026 15:43:01 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f0138042sm700466a34.2.2026.11.17.15.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:43:00 -0800 (PST)
Date: Tue, 17 Nov 2026 17:42:59 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] object-file: only flush batched fsync writes when
 enabled
Message-ID: <avzlrYKsGIbyMz8r@denethor>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-3-jltobler@gmail.com>
 <CAOLa=ZRp=JeAGhN3m6-RCos3F82__6Wzt2UsKvUjqHSHUg6o_Q@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRp=JeAGhN3m6-RCos3F82__6Wzt2UsKvUjqHSHUg6o_Q@mail.gmail.com>

On 26/11/11 06:48AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > When committing an ODB transaction for the "files" backend, a full
> > hardware flush is issued against a temporary file before the staged
> > objects are migrated into the main object database. This flush acts as a
> > barrier for objects that have been written with batched fsync, where
> > `odb_transaction_files_fsync()` only issues a writeout request for each
> > object instead of fully syncing it.
> >
> 
> Does `fsync(fd)` even guarantee syncing of previous writes?

I believe the answer here is platform specific. This feature oringally
comes from c0f4752ed2 (core.fsyncmethod: batched disk flushes for
loose-objects, 2022-04-04) which has a pretty good explaination. :)

> > The flush is issued whenever the transaction has a temporary object
> > directory though, regardless of whether batched fsync is actually
> > enabled. For transactions configured for git-receive-pack(1), the
> > temporary object directory is always created, so the flush is also
> > performed when objects are synced individually or not synced at all. In
> > those cases there are no pending writeout requests and the flush is
> > unnecessary. Only issue the flush when batched fsync is enabled
> > accordingly.
> >
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  object-file.c | 43 +++++++++++++++++++++++++------------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index 201d9d6490..da189111bd 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1330,6 +1330,29 @@ static int write_pack_lockfiles(struct odb_transaction_files *transaction)
> >  	return ret;
> >  }
> >
> > +static void flush_batched_fsync(struct repository *repo)
> > +{
> > +	struct strbuf temp_path = STRBUF_INIT;
> > +	struct tempfile *temp;
> > +
> > +	/*
> > +	 * Issue a full hardware flush against a temporary file to ensure
> > +	 * that all objects are durable before any renames occur. The code in
> > +	 * odb_transaction_files_fsync has already issued a writeout
> > +	 * request, but it has not flushed any writeback cache in the storage
> > +	 * hardware or any filesystem logs. This fsync call acts as a barrier
> > +	 * to ensure that the data in each new object file is durable before
> > +	 * the final name is visible.
> > +	 */
> 
> Nit: This could become a function comment, since it now describes the
> function well.

Will do in the next version.

-Justin
