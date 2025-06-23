Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5140188735
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696241; cv=none; b=jLdQtMp/UvqdUn0wYz60/kB2YrAR1aY/YQJiosvYZewAUwnbyI6Jk7u+NNRMbAe45pI1Cb4373ttg9vz0k+3WFQq8lgWXj1lYH29AMAFfOQwNCtOvJFklZV4BYUhX0mjeO3zDXVzvjPw4U3Gec1+KpUO4yB89wfP+WaVyk0KOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696241; c=relaxed/simple;
	bh=KsiTmQXH2TcWqDsOlfBnagXaMgeysG8VOjg63O2frto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahRbDy3a8dGAZ3RD83u5glEI8O9pYS59Ij8nnAK2EOuZh/R73TPkCWLf9E3jRua1naPfOPiIqSzW2rdPhZKXSGhz5s6tYYswXzdi1I7GG/uOciPb0kWEKXfxNU9Yq5oR1K/iS28OeIUmcwg4gWaYgJPyvkmaqXnIGAitpVLaI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWH25oDT; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWH25oDT"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a4bf1eb0dso2819072b6e.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750696237; x=1751301037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyRm0UHpleJePg50CkPuwsu+BIQgX9b0hiVQDl89i4M=;
        b=FWH25oDTfjCQq+RmkDhmVmui8TK//XP8HN1ZwOI+vtPG4zfk0oTd5X+NaaTmbPAMmP
         Vel186tslNvHYysVxA0P6lI/JFAvSHbTF9ezRY2aemsNuqqbcr6YyoLUqq3L2/uSmgAf
         XG7yt+SUgM1yA3Max4b1DXGGZ8Qef9A4orhBeWAcKZCnP5eJeXkZvBbjuPl4S3C6i91T
         ++FHbeK3b1hH6HOXj89waNNspCvPrTYecAQP+zI72WIz12kiBbN1dGVD/N3QX/GZMmIQ
         mTsMKIqgzuSxP28cOl2YUfxcKYe3swHgjJWKaibudfLvHCxsGKI/ZYb5cP0tD22Hlkhl
         7ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696237; x=1751301037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyRm0UHpleJePg50CkPuwsu+BIQgX9b0hiVQDl89i4M=;
        b=teAMhbB/hLevlFqtbjB1PQM90qItnnl1Z+C9fniyVmztU30mLQ+m0lS9m9i0Q+D1pj
         g42Mlkem3Y9vPRDA9+mp/pfSjedHbTsySpwawf6WRjV3MGLCNCWN+/H4gFEYw6Ty8jXu
         YFMRqMmOFInBEI6oUsUaY3usLR/C9zm0Xx4WpzOlkmczUSoF/wnyaoqjOmTsoSSsnxZE
         zTIcoz8h1Jzi5jr1BLlIedRsCTJZ/Mg5tsPr2zZxdiGV1TtaBPsbJuDAyE4c777Y053c
         FLcT8WKY5ity6yopw+ri+EcVMypYmVpX99qwe0GQXuCet6wuWj9d7wx6rOca1R0n50+o
         ZopA==
X-Gm-Message-State: AOJu0Yz4zzjlci07pUecQvnC40WAehDy9NZgeutA/CDarY8Gsayizsnw
	isZdqtx2WbUDx8VKLafZbOHnTYbjkawkLMYHMddRYXFWppeOaCAy9DjpLNiDVA==
X-Gm-Gg: ASbGnctUexz7i7gXuSMdneXw7T4ASFponleO8e7T37KaiyOJtm+igRK3il+kA2yb1/K
	InEwjDHnXqz/IyBDLWexAW9W1Cun1BqohXFUZIQ+oglRy7b5Ho6GuneCscbXrj/p838Fz/UNrSe
	wPdT/mfJyjcVpF+oD3U4HFjQjjPk1kyMUkgHOLy04bMiLLiLFKS4nExN0UBvdppwGPt5IF+2qL/
	evw/rE35hMIqb6a4L6ytG656jz2v+7jz8mCKUujoVqK5nVkXus5tUIIJm7tl4EaTiBOT9gr4KPt
	53gjuhIdKeDzyXNXOFcQd2oIm21ZicVRe/lAq3V/k9hOaaa59/Yeiw0=
X-Google-Smtp-Source: AGHT+IFL8njnZsRd0bqMD06YFZqxJVg4wVRNlM1MzTNZ3Z8sduC5v1BU82WXqmq5+q8hbJPXc6N0aw==
X-Received: by 2002:a05:6808:3a19:b0:409:f8e:7296 with SMTP id 5614622812f47-40ac6e18ee1mr9738757b6e.0.1750696236683;
        Mon, 23 Jun 2025 09:30:36 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90b1383fsm1483066a34.16.2025.06.23.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:30:36 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:25:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
Message-ID: <oai7p5xmq3q7c3ovdpmbyimoidvgw4lhxfd727qdid5ulcdn3n@7n6vqa6wn3pe>
References: <20250623105516.GA654296@coredump.intra.peff.net>
 <20250623105625.GB654412@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623105625.GB654412@coredump.intra.peff.net>

On 25/06/23 06:56AM, Jeff King wrote:
> The "seq" tool has a "-f" option to produce printf-style formatted
> lines. Let's teach our test_seq helper the same trick. This lets us get
> rid of some shell loops in test snippets (which are particularly verbose
> in our test suite because we have to "|| return 1" to keep the &&-chain
> going).
> 
> This converts a few call-sites I found by grepping around the test
> suite. A few notes on these:
> 
>   - In "seq", the format specifier is a "%g" float. Since test_seq only
>     supports integers, I've kept the more natural "%d" (which is what
>     these call sites were using already).

Sticking with "%d" definately feels more natural.

>   - Like "seq", test_seq automatically adds a newline to the specified
>     format. This is what all callers are doing already except for t0021,
>     but there we do not care about the exact format. We are just trying
>     to printf a large number of bytes to a file. It's not worth
>     complicating other callers or adding an option to avoid the newline
>     in that caller.
> 
>   - Most conversions are just replacing a shell loop (which does get rid
>     of an extra fork, since $() requires a subshell). In t0612 we can
>     replace an awk invocation, which I think makes the end result more
>     readable, as there's less quoting.
> 
>   - In t7422 we can replace one loop, but sadly we have to leave the
>     loop directly above it. This is because that earlier loop wants to
>     include the seq value twice in the output, which test_seq does not
>     support (nor does regular seq). If you run:
> 
>       test_seq -f "foo-%d %d" 10
> 
>     the second "%d" will always be the empty string. You might naively
>     think that test_seq could add some extra arguments, like:
> 
>       # 3 ought to be enough for anyone...
>       printf "$fmt\n" "$i "$i" $i"
> 
>     but that just triggers printf to format multiple lines, one per
>     extra set of arguments.
> 
>     So we'd have to actually parse the format string, figure out how
>     many "%" placeholders are there, and then feed it that many
>     instances of the sequence number. The complexity isn't worth it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0021-conversion.sh                  |  4 ++--
>  t/t0610-reftable-basics.sh             |  6 +-----
>  t/t0612-reftable-jgit-compatibility.sh | 13 +++++--------
>  t/t0613-reftable-write-options.sh      | 24 ++++--------------------
>  t/t1400-update-ref.sh                  | 10 ++--------
>  t/t5004-archive-corner-cases.sh        |  5 +----
>  t/t6422-merge-rename-corner-cases.sh   | 10 ++--------
>  t/t7422-submodule-output.sh            |  6 +-----
>  t/test-lib-functions.sh                |  9 ++++++++-
>  9 files changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index bf10d253ec..f0d50d769e 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -281,7 +281,7 @@ test_expect_success 'required filter with absent smudge field' '
>  test_expect_success 'filtering large input to small output should use little memory' '
>  	test_config filter.devnull.clean "cat >/dev/null" &&
>  	test_config filter.devnull.required true &&
> -	for i in $(test_seq 1 30); do printf "%1048576d" 1 || return 1; done >30MB &&
> +	test_seq -f "%1048576d" 1 30 >30MB &&

Very nice quality of life improvement indeed. :)

>  	echo "30MB filter=devnull" >.gitattributes &&
>  	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
>  '
[snip]
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index bee4a2ca34..8c176f4efc 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1454,6 +1454,13 @@ test_cmp_fspath () {
>  # from 1.
>  
>  test_seq () {
> +	local fmt="%d"
> +	case "$1" in
> +	-f)
> +		fmt="$2"

With the `-f` option, the default format string gets overwritten to what
is provided by the user. Makes sense.

If we want, we could update the comment above this function to mention
this new option.

> +		shift 2
> +		;;
> +	esac
>  	case $# in
>  	1)	set 1 "$@" ;;
>  	2)	;;
> @@ -1462,7 +1469,7 @@ test_seq () {
>  	test_seq_counter__=$1
>  	while test "$test_seq_counter__" -le "$2"
>  	do
> -		echo "$test_seq_counter__"
> +		printf "$fmt\n" "$test_seq_counter__"

Nice and simple! Each of the updated callsites also look good to me.

-Justin

>  		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
>  	done
>  }
> -- 
> 2.50.0.385.g2a828bf5b7
> 
