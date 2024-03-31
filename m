Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072A567D
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711865868; cv=none; b=hmxRR7gIiagt2jjcFpJWZQv3hYW3Q5aZsqVOQPUCm9v1ptrfRxL0dULeKu4sGIqJrD339l8IPC7UF/U/7fE5vHzE/bXZHl8tr2w5Jfb/Dw2kJQQFGL6+KrsViP9U3ndwfxnQz/XGgNAnbpyN8AocuwUU+mgacsSGeU+s28YebxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711865868; c=relaxed/simple;
	bh=PGA8UE8HhnlG5VXAlv8O3HnExzMxXAfg1/f7JVIsaSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XVE+0+eZfCmJeysYSLjedUgOUW78yWmDxXpdYxD6Z5HLilo+p0LLJqVpWyxASYImKTqh5BjnxgHOueVac/w2KW2+kijAtqXPa/0T53CJOqUNuj7egrH52km1uhw1wdeIc0YAPERbdEc75gHvsEv8dGoAPo4GC+ovefvfQ12dDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjqauLit; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjqauLit"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-341c9926f98so2028172f8f.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711865865; x=1712470665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcxJJ+4M3KTBF33vjM1w7cwO7bwlvC+LOCCv6wZQy/U=;
        b=BjqauLitjk4uH3HTu9dUC0W6WG515HUPYB+SBq/XbfpJqz5NfBlf7d09J6bMQTxHHw
         QdXS7l1+EA38hyIhnH2/8+n1rcxyuqKik7Fg15pgHgExodYFfDyOvXv5HHwwyaehLKcP
         NpezOvfexLxnm0Z9jWBgywin940b4BcpA0zrL8aFQ2fHdWVZYGlu4Zlz2PBjVn27jDMc
         SZpblogShFuO42+2+yRD0M+hy3eC+u0hqwr1hQMIDEBml70w1XSogI28LUNpUNU+ftM2
         lUCYRmZ340UKrWTBXERrlAqwILnesDAAF7YySpuTDtphQaJAHe2JDEvkCzIVO26qOK5/
         w1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711865865; x=1712470665;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcxJJ+4M3KTBF33vjM1w7cwO7bwlvC+LOCCv6wZQy/U=;
        b=LmVS062pmBkopn/4S/vbF8vi0l0Vt3nvEUKfIA+hFk4I+HbbYPxx6euqOArmU75mJJ
         XlmvtRPA34NwW8hCYVq7bGXES3zIkhAOo6EquPm4/lWf+PHBW3cSZiQa33Yv5ALsZmSo
         0aSUEmMIMQmgKRCE88V91lssnRif/+pp9ptUec/LQwh66Rg9bTP8lPcwsYwV21HFIdPB
         YoZ9WY8NIXtFhAjKQBEPuCGhJrLhKfhPeWVIPOKorQi7ccl4bDaa1NdnwtHPyT9jYjvr
         jHx2ePsgGmwtkgoXDYVeirzlGKFeRRdRDtalSLJenaOwEXJs838hcHJeHTCbmdSUo1zE
         rW3A==
X-Forwarded-Encrypted: i=1; AJvYcCWoV7e3UtrqGEs5N5s9KT1Xl/ylJLDZ0Gkp4UdSFawZ4LzUWA+yrXbM5T327uUuYaysvVt0pXtRgnhmbqSHo2d2MY3u
X-Gm-Message-State: AOJu0Yzs0CZ7WfpYH+5lk1/O/soUy5fcClgbT93LVgAi1fY1VIE17cw+
	hFLMMBshTCov9/MioSKamtHMgCmRPX0J7lP4a87kUAwUPJv2uvSo
X-Google-Smtp-Source: AGHT+IF0O6bh8d6eXg7YWP76qlFhqST1prETSir9Ojnkk0lfqiWUN7YegfdC/GWEg6QjayaZ+l5ZxA==
X-Received: by 2002:adf:f083:0:b0:342:a8e0:6f3f with SMTP id n3-20020adff083000000b00342a8e06f3fmr3911722wro.42.1711865864817;
        Sat, 30 Mar 2024 23:17:44 -0700 (PDT)
Received: from gmail.com (26.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.26])
        by smtp.gmail.com with ESMTPSA id m10-20020a056000008a00b0033ec91c9eadsm8169831wrx.53.2024.03.30.23.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 23:17:44 -0700 (PDT)
Message-ID: <4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com>
Date: Sun, 31 Mar 2024 08:17:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: omit trailing whitespace
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4jcooddp.fsf@gitster.g>
 <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
In-Reply-To: <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 30, 2024 at 12:23:41AM +0100, Rubén Justo wrote:
> On Fri, Mar 29, 2024 at 03:57:06PM -0700, Junio C Hamano wrote:
> > Git tools all consistently encourage users to avoid whitespaces at
> > the end of line by giving them features like "git diff --check" and
> > "git am --whitespace=fix".  Make sure that the advice messages we
> > give users avoid trailing whitespaces.  We shouldn't be wasting
> > vertical screen real estate by adding blank lines in advice messages
> > that are supposed to be concise hints, but as long as we write such
> > blank line in our "hints", we should do it right.
> > 
> > A test that expects the current behaviour of leaving trailing
> > whitespaces has been adjusted.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> 
> Yeah, ACK.  This is obviously a good thing.  I'll base my other series
> in this.  Thanks.
> 
> >  advice.c          | 3 ++-
> >  t/t3200-branch.sh | 4 ++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git c/advice.c w/advice.c
> > index d19648b7f8..75111191ad 100644
> > --- c/advice.c
> > +++ w/advice.c
> > @@ -105,8 +105,9 @@ static void vadvise(const char *advice, int display_instructions,
> >  
> >  	for (cp = buf.buf; *cp; cp = np) {
> >  		np = strchrnul(cp, '\n');
> > -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> > +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
> >  			advise_get_color(ADVICE_COLOR_HINT),
> > +			(np == cp) ? "" : " ",
> >  			(int)(np - cp), cp,
> >  			advise_get_color(ADVICE_COLOR_RESET));

Thinking again on this I wonder, while we're here, if we could go further
and move the "hint" literal to the args, to ease the translation work:

--- >8 ---
diff --git a/advice.c b/advice.c
index a18bfe776f..5897e62541 100644
--- a/advice.c
+++ b/advice.c
@@ -104,8 +104,9 @@ static void vadvise(const char *advice, int display_instructions,

        for (cp = buf.buf; *cp; cp = np) {
                np = strchrnul(cp, '\n');
-               fprintf(stderr, _("%shint:%s%.*s%s\n"),
+               fprintf(stderr, "%s%s:%s%.*s%s\n",
                        advise_get_color(ADVICE_COLOR_HINT),
+                       _("hint"),
                        (np == cp) ? "" : " ",
                        (int)(np - cp), cp,
                        advise_get_color(ADVICE_COLOR_RESET));
--- 8< ---

Of course, this is completely optional.

> >  		if (*np)
> > diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
> > index d3bbd00b81..ccfa6a720d 100755
> > --- c/t/t3200-branch.sh
> > +++ w/t/t3200-branch.sh
> > @@ -1154,9 +1154,9 @@ test_expect_success 'avoid ambiguous track and advise' '
> >  	hint: tracking ref '\''refs/heads/main'\'':
> >  	hint:   ambi1
> >  	hint:   ambi2
> > -	hint: ''
> > +	hint:
> >  	hint: This is typically a configuration error.
> > -	hint: ''
> > +	hint:
> >  	hint: To support setting up tracking branches, ensure that
> >  	hint: different remotes'\'' fetch refspecs map into different
> >  	hint: tracking namespaces.
> 
> 
> A quick run tells me that this step also needs, I think:
> 
> --- >8 ---
> 
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index b41a47eb94..03bb4af7d6 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1780,7 +1780,7 @@ test_expect_success 'recursive tagging should give advice' '
>         sed -e "s/|$//" <<-EOF >expect &&
>         hint: You have created a nested tag. The object referred to by your new tag is
>         hint: already a tag. If you meant to tag the object that it points to, use:
> -       hint: |
> +       hint:
>         hint:   git tag -f nested annotated-v4.0^{}
>         hint: Disable this message with "git config advice.nestedTag false"
>         EOF
> 
> 

Your queued version already fixed this.  So, nothing to worry about.
