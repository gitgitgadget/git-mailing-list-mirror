Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FC481A8
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M41Yzm9l"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33694bf8835so3504768f8f.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704888683; x=1705493483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZoG3e1pZCNGmkZzJN7ZY5Mbzfcyt7+OapHajdtyKxA=;
        b=M41Yzm9lrZVjM0MYBvrp9cdWWKc7VOQLR4/Dl8OZ/yOYOh8L6jmplpJm0oAUv0Re8j
         l+LcoaC6VSmE2RzknbPg0C1ssWMNDMTMbLmAYmQFJWjbradCdZmBlZva5i+xHHsdl+dM
         gL2uGvmOcwQzUdQNe9hXHo4RlsiKJ18g3M2v70rzq4mGyeY2W3FukkijmwhnrdmEGXex
         BsBBNX06aBuBLE2AFUzmkzrpcsfv975Opptw7fnhaOFkDnKA97tmJgdaSLE+aIEnQZAM
         O6MvjggoYRY3VwZNg6xyuLJTCaadrWjzylZvbqaEWp/WbyC+LImp6z9az6JWeGea1ZOD
         DwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704888683; x=1705493483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZoG3e1pZCNGmkZzJN7ZY5Mbzfcyt7+OapHajdtyKxA=;
        b=WwBpfVGs4dhY7Hsza7yek4Rn2bjT7y8Yv921xZ5ScqjzYQKkWdPvt3iwSTQy4hnHET
         jv33GoBlVmO/How7KYa/UUmpbshSchJGyg3FGMhGaD6f8U0H/BCu/DrHzlPOCoaAzkOV
         MsXjnkMTa73XmlvxdYI1aC8Mzs/G3OSSAIpZghvDzYjB++86RVjkWaecFfWS/xrvI1fZ
         gV0vN8q+9M/JOhO791WnBkLp0l2ddkVITAJQUnk6ojXS214C0XJUbibA8qy5Grt/LzbV
         seCAiwqyM87tTtxhWo/0ksyniQNxlbvXqzSXrD6zvIo1OpcoFBvN09sDnbmpYp0j6GUT
         WmKQ==
X-Gm-Message-State: AOJu0Yy/n8+zAjnaJCOQNCm1OlIoVcQ+aSsf143wtMlvIvLq6UX1/SCb
	qfuNQqmUUpkUS2aFlfF8I4Oa6Bds7EA=
X-Google-Smtp-Source: AGHT+IG05/8GRV8Mx1KqukzBq4t2QfOf9QY6DnpyDdxzBegup2UfHp6iaLq51D7Klf5E/nUmRV904w==
X-Received: by 2002:a5d:4143:0:b0:337:3f58:e309 with SMTP id c3-20020a5d4143000000b003373f58e309mr507529wrq.124.1704888683263;
        Wed, 10 Jan 2024 04:11:23 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id z15-20020adff74f000000b0033740e109adsm4787826wrp.75.2024.01.10.04.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 04:11:22 -0800 (PST)
Message-ID: <19bdce2f-a854-48a6-b865-32700971c34d@gmail.com>
Date: Wed, 10 Jan 2024 13:11:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
To: Taylor Blau <me@ttaylorr.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <ZZ2QGYBBmK8cSYBD@nand.local>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <ZZ2QGYBBmK8cSYBD@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09-ene-2024 13:27:37, Taylor Blau wrote:

> > +	[ADVICE_ADVICE_OFF]				= { "adviceOff", 1 },
> 
> The name seems to imply that setting `advice.adviceOff=true` would cause
> Git to suppress the turn-off instructions. But...
> 
> >  };
> >
> >  static const char turn_off_instructions[] =
> > @@ -93,7 +94,7 @@ static void vadvise(const char *advice, int display_instructions,
> >
> >  	strbuf_vaddf(&buf, advice, params);
> >
> > -	if (display_instructions)
> > +	if (display_instructions && advice_enabled(ADVICE_ADVICE_OFF))
> >  		strbuf_addf(&buf, turn_off_instructions, key);
> 
> ...it looks like the opposite is true. I guess the "adviceOff" part of
> this new configuration option suggests "show me advice on how to turn
> off advice of xyz kind in the future".
> 
> Perhaps a clearer alternative might be "advice.showDisableInstructions"
> or something?

Yeah.  We can then use ADVICE_SHOW_DISABLE_INSTRUCTIONS, which is also a
better name than the current ADVICE_ADVICE_OFF.  Thanks.

I'll reroll also with a description of it in
Documentation/config/advice.txt, as Jeff has pointed out.

> I don't know, coming up with a direct/clear name of this
> configuration is challenging for me.

Well ... I'm not going to show the previous names I've been considering
for this ;-)

> 
> >
> >  	for (cp = buf.buf; *cp; cp = np) {
> > diff --git a/advice.h b/advice.h
> > index 2affbe1426..1f2eef034e 100644
> > --- a/advice.h
> > +++ b/advice.h
> > @@ -10,7 +10,7 @@ struct string_list;
> >   * Add the new config variable to Documentation/config/advice.txt.
> >   * Call advise_if_enabled to print your advice.
> >   */
> > - enum advice_type {
> > +enum advice_type {
> >  	ADVICE_ADD_EMBEDDED_REPO,
> >  	ADVICE_ADD_EMPTY_PATHSPEC,
> >  	ADVICE_ADD_IGNORED_FILE,
> > @@ -50,6 +50,7 @@ struct string_list;
> >  	ADVICE_WAITING_FOR_EDITOR,
> >  	ADVICE_SKIPPED_CHERRY_PICKS,
> >  	ADVICE_WORKTREE_ADD_ORPHAN,
> > +	ADVICE_ADVICE_OFF,
> >  };
> >
> >  int git_default_advice_config(const char *var, const char *value);
> > diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> > index c13057a4ca..0b6a8b4a10 100755
> > --- a/t/t0018-advice.sh
> > +++ b/t/t0018-advice.sh
> > @@ -30,4 +30,12 @@ test_expect_success 'advice should not be printed when config variable is set to
> >  	test_must_be_empty actual
> >  '
> >
> > +test_expect_success 'advice without the instructions to disable it' '
> > +	cat >expect <<-\EOF &&
> > +	hint: This is a piece of advice
> > +	EOF
> > +	test-tool -c advice.adviceOff=0 advise "This is a piece of advice" 2>actual &&
> > +	test_cmp expect actual
> > +'
> 
> Looking at this test, I wonder why we don't imitate the existing style
> of:
> 
>     test_config advice.adviceOff false &&
>     test-tool advise "This is a piece of advice" 2>actual &&
>     test_cmp expect actual

As a reference, implicitly, that is:

    git config advice.adviceOff false &&
    test_when_finished "git config --unset-all advice.adviceOff" &&
    test-tool advise "This is a piece of advice" 2>actual &&
    test_cmp expect actual

I think the proposed test is better and understandable enough.

As a matter of fact, when I was thinking how to write the test I was
expecting to have a working "-c" in test-tool, as if we have a (not
expected) "git-advise".

So ...

> 
> instead of teaching the test-tool helpers how to interpret `-c`
> arguments. Doing so would allow us to drop the first couple of patches
> in this series and simplify things a bit.

... IMHO the first two patches allows us to write simpler and more
intuitive tests based on test-tool.

I hope this argument persuades you, but I am not against your proposal.

> 
> Thanks,
> Taylor

Thank you for reviewing this series.
