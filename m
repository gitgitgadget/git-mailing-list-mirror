Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0C7F9
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810078; cv=none; b=b7VgWSG3A/+SndSCQ9ht+EVCk/UwubGGwFRBTAVfrKfGQ7Fm0LSAItaKzbglF+qErlp7k1eOvzNCIyhgqZLZ179bQmQdCNA3+qDAOjHoqUz/y0RyRptKgpq0Yy1aNUIcbvKLQf1IuvyRUKx53R5xF3bZJbwcj763Rcsda5Dp9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810078; c=relaxed/simple;
	bh=gnwTG/+eo9SxWVJKhvkxDGvN90nunfqN7wWEdMpfDLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHBrm5UBvFkkJqPQ0gUteDBaZMs1K0Fdv8pReimFUfPOiSnikgr8nYYuaj6eWsJ7LzShnW8pWyPbD/XA0XnQa9ZV/Con0j/Sc+gBcPi26fd8zKTZOzabpANk22roPlne/eOOGf0kyGuSo4j7dd04lLprX4Sg7SxGhH9Z75vu/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuzTeF7K; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuzTeF7K"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73ac5680bb0so299053a34.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810075; x=1751414875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MalwcVJO/7jgzmK7OS3zOXG8HyPGTcM1nbJZufXVS0M=;
        b=MuzTeF7KghDT7K39xR4qU6Llqd3EhQj6bBLpi2d8RBsLRh4hthr80GEJnULtiOVqK3
         6+NDDLSAAXxVH+zbN96aRE/iPPFyNvEsUTqcI/hJr2juyMHKov7kHtqHxXTRNwXrgpPY
         HT2PTyHVbqVX3Mou0n3w0VtE/uDzMOjbpWcjqu5xfFD9AMTqCI+hMZyHsmn/JEjt/vwY
         8PMqLBWiz6QGTSrYvZuOOxQzx3Q4anKUox3K7rQyUUC9KuUbGAKaT7pDlPa9noAXqvpW
         pLGvUHAe12paLSm/YBndBFTXYtHpw3L8MRCnihrAHqOuJEICWfClHz3eFErmZ3/Hl6U7
         IHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810075; x=1751414875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MalwcVJO/7jgzmK7OS3zOXG8HyPGTcM1nbJZufXVS0M=;
        b=GIpm5bR9IJB1UAlxLs846+XyTutfU0ArG1Lp/g9ayrX+PmNu7EQibeZG2Wg3VR7RMN
         pV0Eb9+mkVx62bbOr5qv+zOvOI8QxTH5Eci+eBTzre0dIGma1tsOG8zX9T7YLZYxasX3
         +PUpQQt+tptTZs75Au+cMzLt85FeF+ZKc4jPDHJpM+fCoqEKpRrvEkSVQMnTX9ok1Fvl
         RsqPQ5HV9yHHfY0fhotB52jBK7qi3J/8tsdkf3cuWvG1QGE6AIA5BYPkXArBSd6K8xsK
         dSFC7LQ/WzCO0z98+o6ciiIb89hFIWbgNq4OW6K1phPXdzDEvvdFRfyCQi3aU3sjLHf9
         gwAg==
X-Gm-Message-State: AOJu0Yw0PxbEg+NrlP+o6CggXF10gb+t7fDnVj4Gm7W1FSsa1+oA9W8G
	VmWVlZQArEN/DIAJM7l7qurridKkYySaHNzM1KqoBD7vtWZiGS6diDAR
X-Gm-Gg: ASbGncsMcglRmTB0JapbV7bYo2MoGwN+jMpsAw/6+2CKq0yconHLVm83c1SRjjuO+yt
	NFixM47wVDptTdeezfdlaOqUr3tu9NKzF+Ido62ctmpPpaCjaaUCml2S5dXUf4Rb5Cx/AoCMMuP
	OsITVuEEAa7SaElnHrtLz2w9CleGGVL7viiCdHjFf+udaG+xJv9nPQhpzThvsQUuniB//cSzD9k
	oMSkJoP7Qkft8WHqXv7GvZTKSa+oHR0Q7dptS1jPB1TBGlgo/JGqk6GgdCtOnz5TJUbaqFduwOX
	QGhsHqadrXLDqzLELIrtfp5uE9hyEdpy8tXH5jIUMjX1pdk1baWhUWQ=
X-Google-Smtp-Source: AGHT+IHC91WqFuw8JmdaePbJxP+XF+AxqvAahb8kLfKrRaZHzSzNbDOiSD13KbiQ2da5j93lpw3mqA==
X-Received: by 2002:a05:6871:4409:b0:2d4:e96a:580d with SMTP id 586e51a60fabf-2efb21a6c66mr912711fac.16.1750810075451;
        Tue, 24 Jun 2025 17:07:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ee66559d90sm2304992fac.12.2025.06.24.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:07:54 -0700 (PDT)
Date: Tue, 24 Jun 2025 19:02:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] test-lib: document test_seq's "-f" option
Message-ID: <k7znp2shqtfpuwpuzmku7o6txi6lph5kjwo6tsrszh5fzv7i2x@2fmrwxxpsify>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
 <oai7p5xmq3q7c3ovdpmbyimoidvgw4lhxfd727qdid5ulcdn3n@7n6vqa6wn3pe>
 <20250624101124.GB636332@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101124.GB636332@coredump.intra.peff.net>

On 25/06/24 06:11AM, Jeff King wrote:
> On Mon, Jun 23, 2025 at 11:25:20AM -0500, Justin Tobler wrote:
> 
> > > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > > index bee4a2ca34..8c176f4efc 100644
> > > --- a/t/test-lib-functions.sh
> > > +++ b/t/test-lib-functions.sh
> > > @@ -1454,6 +1454,13 @@ test_cmp_fspath () {
> > >  # from 1.
> > >  
> > >  test_seq () {
> > > +	local fmt="%d"
> > > +	case "$1" in
> > > +	-f)
> > > +		fmt="$2"
> > 
> > With the `-f` option, the default format string gets overwritten to what
> > is provided by the user. Makes sense.
> > 
> > If we want, we could update the comment above this function to mention
> > this new option.
> 
> Good point. I didn't even notice that comment!
> 
> Perhaps we should squash this in? I don't think there's any need to keep
> it as a separate commit.

Ya, that seems reasonable to me.

> -- >8 --
> Subject: [PATCH] test-lib: document test_seq's "-f" option
> 
> The previous commit added the "-f" option, but didn't mention it in the
> function's documentation.
> 
> Suggested-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib-functions.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8c176f4efc..6230746cc4 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1451,7 +1451,12 @@ test_cmp_fspath () {
>  #     test_seq 1 5 -- outputs 1 2 3 4 5 one line at a time
>  #
>  # or with one argument (end), in which case it starts counting
> -# from 1.
> +# from 1. In addition to the start/end arguments, you can pass an optional
> +# printf format. For example:
> +#
> +#     test_seq -f "line %d" 1 5
> +#
> +# would print 5 lines, "line 1" through "line 5".

At first I thought it might be nice to mention that only format strings with
a single specifier are supported, but I think this can also be implied
since the comment mentions the format string follows the printf format.

This looks good to me :)

-Justin

>  
>  test_seq () {
>  	local fmt="%d"
> -- 
> 2.50.0.399.g566d3d7b27
> 
