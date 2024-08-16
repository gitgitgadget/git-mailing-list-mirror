Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F91494AB
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852305; cv=none; b=ihGeP8HWcYr3gi4y7avvRj7mies79CthkF55HPP8mJ3f0MX1dqdES3UFt2h2E5XbCBJr065inX0Uqbx/LR84Oz2oUHmhThFYvpU+tSSkIqtCwXHQnFZTQpZltt/AQsX8dcv4ZCb7ZP7qaVLjr3iY6CILkvZYcEWGZRkGAFDpzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852305; c=relaxed/simple;
	bh=Pv38EZWjIEg3LOVuDggd1cefdT8kLs9SY33Wk/FmcaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFF1ci148O8HccuiNrWjWGPgUxHiFj+oLT9xWRCGxMD9TAZevPqI5Gdh8Yj99IYIvdbrTNShQn8jFWvkOEeAbeSnl6kfvnpGuYwMyscTGW1NY+UBYFYxtKqsQqQ6ype0ff3oXmNrhvUA+EKU63EPLLZ9EWXiBgtfrGoFFwnGWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf784346b9so10803876d6.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723852302; x=1724457102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv38EZWjIEg3LOVuDggd1cefdT8kLs9SY33Wk/FmcaA=;
        b=GddelolTfAQpK/UyY+Qn1aF5hjcgv+FCZzcWlxsZujw/61/y8zgmzL/Z2xFaFkYD9R
         RngapXjaVIvtAjjljz4HEOkX/e4KF1PmU1MI2AZw7M88QvbLxusqmUpKlRgfpQB1ymPa
         c/lm1SAbH6J/oslQL2UOpz8Md1I+Wkmz0aP2F74SM7oqO6gEGrW/aFGCLiqtpJiX+IGq
         CZ4cJvZxe0WypXl0DPOXFxuHkKr6YqmOHAli1e7Da5EjWqiLviKjKmhy1tZ/wudwtltc
         McDHhj5C92oo3RFx2BTdMcPvgxovOUUJcwPdinclqY5nMAhwYiYZg/FPtIwQDb6mTgMi
         VJtA==
X-Forwarded-Encrypted: i=1; AJvYcCW1st1ngizubV+h8ba0WgNrAxrZjzxdhWB+O8r7gWSTyAtzbgUffKXclK5gy6tLzfYacd13d3OF94wNaK3quuFfVhzK
X-Gm-Message-State: AOJu0Yz7cDZ0xRBiWroWe8ViXO7UZkxmoUId4vwMGDX+pK5+1pSpl7BP
	OZfI6b4IAEtX04CXvak0t2CId3rrjcUDmi3Y4lBvZUU7V2ZmywFOzxoHS5yURwNptJn45Iz0zcU
	EZcXo+nN/XItfE2d9MM5aYFUKgbQ=
X-Google-Smtp-Source: AGHT+IFguB50ZRG6lpUo0nXA04fvk066Yh7j8FdeM+fx94P+HtBfibhbFakuNOGyRJmTihrqDfXOdVSmfx6zFpcEL8I=
X-Received: by 2002:a05:6214:33c9:b0:6bf:5da4:96dc with SMTP id
 6a1803df08f44-6bf7ce65e12mr63994106d6.45.1723852301534; Fri, 16 Aug 2024
 16:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
 <20240816-jk-send-email-mailmap-support-v1-1-68ca5b4a6078@gmail.com>
 <CAPig+cSN-KU-TQ5UBR9KfxjmQ4zzjL-Y-anxDe9FaeqsV=1Xww@mail.gmail.com> <cf58f786-06b0-4ad3-a6fd-f593af639c98@intel.com>
In-Reply-To: <cf58f786-06b0-4ad3-a6fd-f593af639c98@intel.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 16 Aug 2024 19:51:30 -0400
Message-ID: <CAPig+cT8EOSmt+7bbNPsXa36AiPpbu2Et37o5TZb8JvRTxKXHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] check-mailmap: add --no-brackets mode
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:42=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 8/16/2024 4:22 PM, Eric Sunshine wrote:
> > What is not explained by the commit message is why we need this new
> > option as opposed to merely making git-check-mailmap accept such
> > addresses by default. Are there difficulties or downsides to making
> > this the default behavior? Do other things break if this new behavior
> > becomes the default as opposed to being an explicit opt-in?
>
> Mostly I did it this way out of conservative caution to avoid breaking
> existing users. It could be that nothing breaks and loosening the
> restriction on what we pass it would be sufficient.

I figured that was probably the reason for making this an opt-in.

I think my somewhat negative reaction to this new option -- and the
reason I asked the above question -- is that it feels very
special-case, thus it lacks generality (or at least the way the commit
message sells it, it makes it difficult to see it as anything other
than a bandaid added just to support mailmap in git-send-email).
