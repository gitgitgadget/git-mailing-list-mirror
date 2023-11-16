Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP5n2QJV"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B8187
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 04:06:46 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c594196344so9104361fa.3
        for <git@vger.kernel.org>; Thu, 16 Nov 2023 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700136404; x=1700741204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U6g+KZu0ruRnBEISqzHkc6YhRbciHHO+Xuo7uTYa40=;
        b=NP5n2QJVFmDZp+OxP4fVTHMmWF7HG8wncIDBRzoOGcRq8WXuMUrzkfeQY2JuJa9+uT
         ErCeHJbz//iaLRs1PgXl7OIe2jzyn29ywki/x786+BV2GQV1XBLbBax7NQUw4PfLx2NP
         UNA3ABbgP22SDJX8926Klb/yYy8HYcu1KoBViKF/dpvmbwzLK8Jtz/9Md1rA426F96jg
         UBoted5hVsRbHftcBjkS7TfDFZb/XnuyBhkTi6usBAyD1Wb15QzWYmMs7nXEgWXTx5YJ
         6EHOKbp1fxaR+Nr2uedfM8UYipCv5lo5cRnPC7Hhyao5E55fcrzoKtXXcvwpET8//nkL
         CFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136404; x=1700741204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U6g+KZu0ruRnBEISqzHkc6YhRbciHHO+Xuo7uTYa40=;
        b=llYS5B/I1sFd+2rwvVmFclXOTV0ld8JotdKJH62AVGeV90lHAo5M9xi1Z4dmU8oWM2
         M2JzHHRLZ7cKVGp/9cVIm9uRFu6gisEgSRGWQx5CsgYKw733XL7yqpMN4jzNSCktF2vB
         1SWjmFg5yjD2oWIdwGb30VZnhvIGh3aHbdBopYzslN7rBmHXI6kL49PqD+1BKeG/H3kK
         uLseHvCb0yqAIbVOx88WhE03JAexkuxv0C6QMhxch0V7uWT19nKLBugKtv7ncYxy8VcN
         QUGOUd7hoIONpdVKPjnAKGNzJeSehiIJ4in+4XM7pN8/1kEOAEpfZoIzoklNfjskkKaR
         V9rw==
X-Gm-Message-State: AOJu0YwvqP4Uozp+OG/5rQ/WMm5tPd323moGVY9jjrl91fHPJsfEQ0HJ
	Z6faihcw7i/ndrmX6gW9S4E=
X-Google-Smtp-Source: AGHT+IGgAqTox9Jqh2YJpOi38Cg3KAD5wjFe7zZgASlKGiX1V4Jo7tZGK7QlreJdpYDSCSEPJ5173Q==
X-Received: by 2002:ac2:4831:0:b0:50a:72e6:96c7 with SMTP id 17-20020ac24831000000b0050a72e696c7mr1510081lft.3.1700136404176;
        Thu, 16 Nov 2023 04:06:44 -0800 (PST)
Received: from localhost.localdomain (ti0036q160-3744.bb.online.no. [95.34.202.203])
        by smtp.gmail.com with ESMTPSA id v23-20020a05651203b700b0050097974ee0sm1938973lfp.224.2023.11.16.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:06:43 -0800 (PST)
From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: gitgitgadget@gmail.com
Cc: code@khaugsbakk.name,
	git@vger.kernel.org,
	oystwa@gmail.com,
	ps@pks.im,
	vdye@github.com
Subject: Re: [PATCH v2 02/10] ref-filter.h: add max_count and omit_empty to ref_format
Date: Thu, 16 Nov 2023 13:06:27 +0100
Message-Id: <20231116120627.3029-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adac101bc6022d5477371d6a94225f38da7fffee.1699991638.git.gitgitgadget@gmail.com>
References: <adac101bc6022d5477371d6a94225f38da7fffee.1699991638.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Victoria Dye <vdye@github.com> writes:

> diff --git a/ref-filter.h b/ref-filter.h
> index 1524bc463a5..d87d61238b7 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -92,6 +92,11 @@ struct ref_format {
>  
>  	/* List of bases for ahead-behind counts. */
>  	struct string_list bases;
> +
> +	struct {
> +		int max_count;
> +		int omit_empty;
> +	} array_opts;
>  };

What the benefit of having them in a nested struct is compared to just
two distinct members?

Regardless this is the kind of deduplication I wanted to achieve when I
added --omit-empty, but never did. Either way, I meant to ack this in
the last round never got around to it. Nice work.

Acked-by: Øystein Walle <oystwa@gmail.com>

Øsse
