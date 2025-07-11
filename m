Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF992D78A
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247759; cv=none; b=MOJND6Uz3VWCHGKuuRNcJYVEz90c0u8eTzZkgfTnDfxQ0HwLJEYdhuWAr6RUFUCEmhaVw6leIZhN+dlQbFuKm3kwOTVjfo2liZR/brXno+zk8S/syPYEWtgS2Yn56nkRzQQam1rtM2ZZuJFI4dLYsB1iLVUx1ZNwvYtAeWOhzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247759; c=relaxed/simple;
	bh=xQQ/X8twO2ubGdHlB+8+d/ZQOhoarsm6JDJHk7Ep0uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvkKcpZmGjkQFtDQLl1pNwL1BOZAju0MIyImHb75LyZrYd1S0WMey5e3opI+88OBUAj2TLuP863gXi3yELEGZqJrHyatZQu3mi2UI5ADLEU+qu7DnD4B3PIpPEbCn6l3rCx4Y85q6sg4EqTi+SQq0iWQGx/LumRyOt08WktETyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3g3ytHJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3g3ytHJ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-735ac221670so1294140a34.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752247757; x=1752852557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJyed6PYGJqDMqNZ2vLfjjtMBuAVw6n3QeOeMaybe/k=;
        b=e3g3ytHJKRix4fSWz9FCid4N30XCCnPz8WePWPBTQX4LbbGRDGhrMgul0Y0/QZaDVp
         6Jb2WkanpCdfD/tiMr6O0zQV7/essvSk+SN1V6+wlUSdAQ8D8sLKJm55alth6FvZPdRD
         Ml3XS7+4jBimeKyIiF/kAsILryXL/YLPzuXwtYOFYaxRK3agZeRaRzSGDkDt6U8lEPS4
         T6H02LN5BbY3N55a5s6ii6zILtQURSdgD75+SP4c7rfHSoG54hVHVHa+El4wAwmbm311
         zd8m5jKzENGTlAM7Ugoiwj9hFY1HZdwbaUqZIm/McZ9Sv+H/jf7kVw1S3ROvrc04QiY8
         SiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752247757; x=1752852557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyed6PYGJqDMqNZ2vLfjjtMBuAVw6n3QeOeMaybe/k=;
        b=JwCQS44J6fahVSsgukKIjCErZiSXzMZU4j1QRAWIWLGog908UsECbOHuP62uUDbSFO
         5SeHA5N4v1It/IxD3wA+WRCGcpq5ZTMVOwcL1v62R+fgeP3ToHSbeUw/UfTW2yOh/Yyk
         Jhge9smamIr1RyxaFqnrGKgHlTlvvtzXfN2nlQH49QmzBdSxNHSVq3RJscb9CXuLyu6Q
         Qn4w+H/lg/Qgh88iyq8LwTwOWxejza4ed8ngwQSp/90hgZPou3jpDU6+mskXLfH93uuF
         xppuc9a8IbFtEieTBVUs1HDo7jzR99aiotpey7h1fMO7DLttPVxike5t7xBAnVOArEVM
         zarQ==
X-Gm-Message-State: AOJu0YyJGBmM52fTK3UtWBP0eUqLOIPL50Puc5c8ff3dl9aloavkDYAW
	ihMLrUoHmOH6io295cYNxcnP8yBogiJ3fAlYQeTeuDgVcHxC6lS9/ppI
X-Gm-Gg: ASbGncuxDpNG7x4OBLgKK0uXZU7kpm+uaiKUEukjNOspfwvpuoCiRGwLMS+EAtC8SNq
	U/WXnqtvCkSbrBbFzvwtOxwZzkbPivEWGW8K7TuUIdeDx1yklm0U6YdgmuTP1ylKt97VyJtVTem
	1+JFPOuaVGwdSR1yFTx2ZoCAnyTSVZ8lCWOP/yr30GBoQ+I2ZJPUIin2H1aUYHHd9UZywgTY16h
	Lley/lVuRuU9NpUkmmVyIY1ej5NkVRlFr4Suwy0j0SawmhSpQteIpBp1yzRAM9cwLaYMjAEmCEz
	/wMxEIInfccjuCEOaXw+7sNXCoBw5a5ZIYrlNmzwG1vr7fhf5X2ooLeqGEGqF6KHMIshHjrrzY2
	pRxpXomGXOeH9hiY=
X-Google-Smtp-Source: AGHT+IEpgCQ/ATetCwPnN+bGuR++9leL6hh9qJ1samI3aEs2kqwB5HAC1rqUM1CNh9Xy8e96ClKpXQ==
X-Received: by 2002:a05:6830:25d0:b0:735:a6b9:3b48 with SMTP id 46e09a7af769-73ceeaf0f3cmr5983691a34.10.1752247756457;
        Fri, 11 Jul 2025 08:29:16 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12a6935sm592452a34.55.2025.07.11.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:29:15 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:23:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, Yi EungJun <eungjun.yi@navercorp.com>
Subject: Re: [PATCH 1/1] http: don't send C or POSIX in Accept-Language
Message-ID: <r34i7fhxwbxhppc4ia7lpyr3xqj4tgusaeikaaonpwtywlywxw@ygfmv3f3q67u>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <20250710221641.857081-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710221641.857081-2-sandals@crustytoothpaste.net>

On 25/07/10 10:16PM, brian m. carlson wrote:
> The LANGUAGE environment variable is not specified by POSIX, but a
> variety of programs using GNU gettext accept it.  The Linux manpages
> state that it can contain a colon-separated list of locales.
> 
> However, not all locales are valid as languages.  The C and POSIX
> locales, for instance, are not languages and are not registered with
> IANA, nor are they a part of ISO 639.  In fact, "C" is too short to
> match the ABNF production for a language, which must be at least two
> characters in length.
> 
> Nonetheless, many users provide these values in the LANGUAGE environment
> variable for unknown reasons and if they do, we do not want to send a
> malformed Accept-Language header to the server.  If there are no other
> valid language tags, then send no header; otherwise, send only the valid
> tags, ignoring "C" and "POSIX" wherever they may appear, as well as any
> variants (such as the "C.UTF-8" locale found on some Linux systems).

Ok so the languages returned by `get_preferred_languages()` are used to
write the Accept-Language header when making requests.

Looking at `get_preferred_languages()` when NO_GETTEXT is defined, we
already filter out "C" and "POSIX". So doing this for the LANGUAGE
environment variable when writing the header also makes sense.

> We do not reject all possible invalid language tags since doing so
> would require bundling a copy of the IANA database and would risk poor
> behavior in the face of uncommon languages or values that are not
> registered but meet the production for private use or other restricted
> interchange.  However, these two values are widely used in the LANGUAGE
> header, are well-known and widely used non-language locales, and have
> been seen in the wild on the server side.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  http.c                     |  8 ++++++++
>  t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/http.c b/http.c
> index d88e79fbde..a96df4fcdb 100644
> --- a/http.c
> +++ b/http.c
> @@ -2022,6 +2022,14 @@ static void write_accept_language(struct strbuf *buf)
>  			s++;
>  
>  		if (tag.len) {
> +			/*
> +			 * These are not valid languages: do not send them to
> +			 * the server.
> +			 */
> +			if (!strcmp(tag.buf, "C") || !strcmp(tag.buf, "POSIX")) {
> +				strbuf_reset(&tag);
> +				continue;
> +			}

From my understanding, each language is expected to be defined in the
following form:

  language[_territory][.codeset][@modifier]

When we parse the list of languages we only care about the
`language[_territory]` part though.

From looking at ISO 639 language codes, only codes with two or three
characters are valid. If we wanted to be a bit more strict, we could
check the length of the language code (everything before the first '_')
and filter out anything outside of those limits. This would naturally
filter out "C" and "POSIX" without having to mention them explicitly.

Not sure if being more strict adds much more value here in practice
though. So it may be fine to keep it as-is. :)

>  			num_langs++;
>  			REALLOC_ARRAY(language_tags, num_langs);
>  			language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 538b603f03..96a6833e67 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -86,6 +86,24 @@ test_expect_success 'push to remote repository (standard) with sending Accept-La
>  	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" git push -v -v 2>err &&
>  	! grep "Expect: 100-continue" err &&
>  
> +	grep "=> Send header: Accept-Language:" err >err.language &&
> +	test_cmp exp err.language &&
> +
> +	test_commit C-is-not-a-language &&
> +	GIT_TRACE_CURL=true LANGUAGE="C" git push -v -v 2>err &&
> +
> +	! grep "=> Send header: Accept-Language:" err >err.language &&
> +	test_must_be_empty err.language &&
> +
> +	test_commit POSIX-is-not-a-language-either &&
> +	GIT_TRACE_CURL=true LANGUAGE="POSIX" git push -v -v 2>err &&
> +
> +	! grep "=> Send header: Accept-Language:" err >err.language &&
> +	test_must_be_empty err.language &&

The above two tests demonstrate that the Accept-Language header is not
sent if no valid languages are found.

> +
> +	test_commit ignore-C-and-POSIX-as-languages-wherever-provided &&
> +	GIT_TRACE_CURL=true LANGUAGE="C.UTF-8:ko_KR.UTF-8:POSIX" git push -v -v 2>err &&
> +
>  	grep "=> Send header: Accept-Language:" err >err.language &&
>  	test_cmp exp err.language
>  '

And here we see only the valid languages sent in the header. Looks good!

-Justin
