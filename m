Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE727A139
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227102; cv=none; b=evJYGziq+rkl+GfTomDp49vhedngYY1zIycnB29/0mzZgCOmXYwNxRzMacGHOTJEE+EtdPDzSbAGP8cx37nSDL5CXIC86g7m9Pw2QFyKuNMEtCI6oEkfZnJb8Cul+un8mCF4bJMe25+GyRAXXaUUT8yz+A84UjBWaLgpjsiqZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227102; c=relaxed/simple;
	bh=IadBQtyJAIVuZ6ahW3Z7O9pHuZ6VSGZKdQforPEwh5E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1OHIIffxVIznxEAncf/bJsYgUfVjcXVr1JcIZTvr4x5SUocQU88EQ07FzKFqqmd79HhkxN1nBDEpPI7UNLenGqdtqC/J0mDRpTm4/rI3Ce1r90KZ2j3jjsxYWZQzAk7SaafFp+WLRs9bVWTp8lEOaJdRVN9dWlxiJwajexWhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkT7lU2b; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkT7lU2b"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-87ec9aee6dbso794421241.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227098; x=1752831898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sSaVNDI8d24CmSt3i78Gp/e9g86yKWFFNqQEUMjR3U=;
        b=kkT7lU2bQVlWEvbrvee0AmCVqMiG71+TLEJEiULIIh7uK2PsFvRVG6EIf4RQQCBxxX
         EPmptuXRtu0oACd12XCzi1YapbLnKbaLuDyF6h5Z5Kh5G9Poyd7puqO0aESAlbYLg6Od
         2/ZOqqEpbRRjcBNShD/O/Nu69Sa2YnG7BL5Vh+Ax86jIlyIl0NQVKW0OEDDpl+8pOtaO
         wkb+WuhWgRqDMlG0yI1O/aWWa+Q9EPVnetuOwa9INEiMPPhHCG7oLRgxcCpUcNoFCica
         GTgFgDK0o0VmNSQji7g1l0rk7vomI37sVrjmJE6dEWA9Z7CCJFLCwjPd5DIH0dPEYJu0
         3zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227098; x=1752831898;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sSaVNDI8d24CmSt3i78Gp/e9g86yKWFFNqQEUMjR3U=;
        b=m3+Nf6OJIxBL0mbd2PslE0UQzWPSLrdEZrDMguL/xuQZTj75DhbzL1MLDDYs/hH1WV
         JUTnL63OEZQGWtxi22EyTA7k+XbZVE4QOarh+TildSjRrN+eBepUcBJ1jAgT4B8gRt1r
         ADKhcTpO6IjeG1vp31jzkDnJNzoH8kjPwOSkfqBuli7WJFSBfexFWxMYZhnFPNIgqi+w
         qs/83mf/EB3dSxt3pNufDEGBssL1SpK0iPsemFhNGQ4CCs1FglDzYlEnl5OyeMasEiln
         esKMgjHOZjZfQG1Rr4+lDMZxUwihpckPRVivA3rQtBWMpD8AVDoCeY3qTFcxhbjDTpFT
         KyVA==
X-Gm-Message-State: AOJu0YzIMmtBTD8NOoZvNIp5DNFGy/Pa//TXtrpLWTJUKeooqFt9AF2E
	0aer2KanVzYFrMGadEw1CI6pciuZNxrEGY4gk1yEuW70LihTsWEsDPaHSyMpA4y6j6rm9eqM41y
	dd/+G524JbNpyBtxNVgzXB7Kczm5CruA=
X-Gm-Gg: ASbGncsnY6KqsqZLr0YoEjf4BfQCiYeCkGEGvWd+ss9NxmJzXwKQGHiuQrH0qxiqLlg
	1yDQayr7g4NJNq0kMIsLHIzAXHNdC0ZulQOHV3sA07L27iL4SgOTOSo0FYKeMILNl6yJmtsg0xn
	YZBYXlE8xXieImtgyFC6xSLTwXfncmu/EXRXKhr3CDwXk2OMwlT0dJTt/xlPktq1qcUc0T5VXQB
	fG9hWeioeyQuZEnj0L5xnyJTg9nku+AZIggetfk
X-Google-Smtp-Source: AGHT+IH6mK8a1VhVGmqWWP/GwWjgB71Xxi/nVJ05jU2makUVeyr64x0tKlyXsGU6t3HEwnNXgfIJHOiovkso6ZcybmA=
X-Received: by 2002:a05:6102:4b0f:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-4f6e2e3a18amr606812137.12.1752227098409; Fri, 11 Jul 2025
 02:44:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 04:44:56 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 04:44:56 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aG9hMP9gEFLhVgJL@pks.im>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com> <aG9hMP9gEFLhVgJL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Jul 2025 04:44:56 -0500
X-Gm-Features: Ac12FXz_xuusH7pEuZDQUWFO8uvpuaJwnQpEV77roTPyGaxC6VUemwsISvdSSPo
Message-ID: <CAOLa=ZSo==Ukdt546PHSPGUpD9zqLUn_=tkf1-5_pqnkTViDZA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000c45c100639a429bb"

--000000000000c45c100639a429bb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 08, 2025 at 03:47:48PM +0200, Karthik Nayak wrote:
>> diff --git a/refs.h b/refs.h
>> index 7c21aaef3d..7852ad36f3 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -1299,21 +1299,32 @@ struct ref_iterator *refs_ref_iterator_begin(
>>   */
>>  int ref_iterator_advance(struct ref_iterator *ref_iterator);
>>
>> +enum ref_iterator_seek_flag {
>> +	/*
>> +	 * Also set the seek pattern as a prefix for iteration. This ensures
>> +	 * that only references which match the prefix are yielded.
>> +	 */
>> +	REF_ITERATOR_SEEK_SET_PREFIX = (1 << 0),
>> +};
>> +
>
> Nit: I think it's a tiny bit confusing that the documentation of this
> enum is split up across here and the doc of `ref_iterator_seek()`. I
> think it would be sensible to move the last paragraph of the function
> over here so that the whole behaviour of the enum is explained in a
> single place.
>

Yeah I think that makes sense.

>>  /*
>> - * Seek the iterator to the first reference with the given prefix.
>> - * The prefix is matched as a literal string, without regard for path
>> - * separators. If prefix is NULL or the empty string, seek the iterator to the
>> + * Seek the iterator to the first reference matching the given seek string.
>> + * The seek string is matched as a literal string, without regard for path
>> + * separators. If seek is NULL or the empty string, seek the iterator to the
>>   * first reference again.
>>   *
>> - * This function is expected to behave as if a new ref iterator with the same
>> - * prefix had been created, but allows reuse of iterators and thus may allow
>> - * the backend to optimize. Parameters other than the prefix that have been
>> - * passed when creating the iterator will remain unchanged.
>> + * This function is expected to behave as if a new ref iterator has been
>> + * created, but allows reuse of existing iterators for optimization.
>> + *
>> + * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
>> + * updated to match the seek string, affecting all subsequent iterations. If
>> + * not, the iterator seeks to the specified reference and clears any previously
>> + * set prefix.
>>   *
>>   * Returns 0 on success, a negative error code otherwise.
>>   */
>> -int ref_iterator_seek(struct ref_iterator *ref_iterator,
>> -		      const char *prefix);
>> +int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
>> +		      unsigned int flags);
>
> Another tiny nit: instead of calling the variable `seek` we can just
> call it `refname`. That might give a bit more of a hint what you're
> actually seeking for.
>

Fair enough, let me change that.

> But other than that I'm happy with the new behaviour, where we are now
> consistently either setting or resetting the prefix depending on whether
> or not the caller set the flag.
>

Thanks for the review!

>> diff --git a/refs/iterator.c b/refs/iterator.c
>> index 766d96e795..f2364bd6e7 100644
>> --- a/refs/iterator.c
>> +++ b/refs/iterator.c
>> @@ -407,13 +408,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>>  }
>>
>>  static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
>> -				    const char *prefix)
>> +				    const char *seek, unsigned int flags)
>>  {
>>  	struct prefix_ref_iterator *iter =
>>  		(struct prefix_ref_iterator *)ref_iterator;
>> -	free(iter->prefix);
>> -	iter->prefix = xstrdup_or_null(prefix);
>> -	return ref_iterator_seek(iter->iter0, prefix);
>> +
>> +	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
>> +		free(iter->prefix);
>> +		iter->prefix = xstrdup_or_null(seek);
>> +	}
>> +	return ref_iterator_se

--000000000000c45c100639a429bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 14d8200f24ab3358_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odzNSVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memYrQy8wWTVoek91L3lzZ2dWLzZQaTlMa3VONlVaZAozMUtlRUNXUWhz
Uzg5TCtocWlMcE5GR1l6Z1BWdCtNaUt3VGFkanArNlZjcERlZlBmSUFCRHN6TmRnWC9RdVg2CkQr
dHZ6a2VpU2NyMVZMY1ZUSzhVeDRSZDVNM1dwV2p6WkxRU2pyaDRaUGN5MXJ1SU1VNUFWdTJhNkxR
N25XL0MKUW1ZcTdPSnhmSmg0UVplaW9uNUFFOE1sRlpKL0VUZGpCZHRuRmQzd0h1VE5wQVRKcEQ2
MG1lZzM0MXhvSFc3NgpyWlBIUk9IQzQzQzUwYXgrK0M4Qy9jOG93MXlQSy9MTkp2RTRZaWxLdzUr
dFhPZDE4a1VocVRiN2tZUkxIeTJOCnRDTHQ3a2owSVhad1oza0VVdGhqV2EzajF0N25Ma0dKcFRy
SDRBLzZ5eUU5dk5tSlFQekVGaTRsRExUSkFiQW4KNHRsd3dUREJSYTY3VzNFK2xMRU9ndVBWMWd5
cVhyTlhJQ1d2RW9SbU5RUE5sbnlZeDFkMGRLM0k1RzNFdG5mTwo2YzIvU3lsVDBNTk1sSS9EY0x1
a3J2YjFUNGFBR0VzQ2RaMkpVZC9KMWw1S0UrVnJ4Y09xd1B3ZDNlS01EWDdjCkZxaFkxbjFmUXFD
VC9UZjRQNHdDVkhLQi9SKzVsSU14c2tJenhxVT0KPUZtTmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c45c100639a429bb--
