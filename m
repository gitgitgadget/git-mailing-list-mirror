Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C13C461
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1ZEOVFHM"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbce1202ebso3129527b6e.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 10:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704824859; x=1705429659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPFq6K/XdtZcuNKlIv4kpKSdiMRtFBwhw2lpzdyc3vg=;
        b=1ZEOVFHMrmSfr+0I/oCBwFOouM6BbbUYEAoo04kZlOsOzfw6eczj3/Srl5qS5IYNar
         KRHsXlOGHkamBMoSi2ow4l0uEusFurKIHHY8TBhtHSd6aBUIOK4jBw/1hzOw8OL/23Tt
         lUj4Bw0wI4xN54A8Ab6+Heg4nsovAGYlLUC06bT5cmnmliGvhkRbM2aMlEYEioKqaLeV
         JFsHTUKqNHx06PE5mV7s2C9f/CgGQKlDYi5OC7iUjiIf8+3Q28CtgcKYSUNHm8wrsJnc
         wmyAmF0kAoRKdwS/WdB4yr79/7CKDRP2OtJRc3mMNuXFCkbKkVbH6JI4e7gycGz1MbQG
         9C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824859; x=1705429659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPFq6K/XdtZcuNKlIv4kpKSdiMRtFBwhw2lpzdyc3vg=;
        b=T9GqEWDJeFaBWd/CkkIf5Ure9Q//BilOn76rQ6WReX+w29D7Kn3DK3XorlPYX5cboo
         7/WS5z2wwQ6OiVPYl6+tGkCxmREdGxc4k/aT6kjlKt7VdA3EDyr2e5LhtkhUkkfAGx3n
         c59/9KgKuQIsEa1iN/P38qwkPY+rdkyHPunzN5mN9kvu/NoKR1E9iISM2ibGAenvIFL/
         psyr5xBGYbER/JF7A++fsDQKej0t3zBCi+bOw6fCFUHypzu84wOwlZ2WN+JuqhRyK9O/
         bF01SpkvQVcuOLZzxAPQydhRXXOgLKRuybm6YkbjbpiNTq90j+PrX9YjQf9uY67UIVhT
         NqGQ==
X-Gm-Message-State: AOJu0YyW3DiKHl3Pe+bFeA6ZBWdnteOmu3C8BtKC3cFNscT/a7zly9yn
	rFpW/qQ8fvFidz2xeUI358UiTnI8LRl5ew==
X-Google-Smtp-Source: AGHT+IEPIPE8Frswh1s/EKGPQwE6F/A6dJGIl+tQIYA6DbtUR7J1al3LwH8jG/Q+rfYmcRUqYaQagA==
X-Received: by 2002:a05:6808:3c8c:b0:3bc:9169:a0c3 with SMTP id gs12-20020a0568083c8c00b003bc9169a0c3mr10278506oib.2.1704824859001;
        Tue, 09 Jan 2024 10:27:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id lg10-20020a056214548a00b0067f75dbf08fsm1088038qvb.11.2024.01.09.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:27:38 -0800 (PST)
Date: Tue, 9 Jan 2024 13:27:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Message-ID: <ZZ2QGYBBmK8cSYBD@nand.local>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>

On Tue, Jan 09, 2024 at 04:30:16PM +0100, Rubén Justo wrote:
> Using advise_if_enabled() to display an advice will automatically
> include instructions on how to disable the advice, along with the
> main advice:
>
> 	hint: use --reapply-cherry-picks to include skipped commits
> 	hint: Disable this message with "git config advice.skippedCherryPicks false"
>
> This can become distracting or noisy over time, while the user may
> still want to receive the main advice.

Presumably for more trivial pieces of advice, a user may want to
immediately disable those hints in the future more quickly after first
receiving the advice, in which case this feature may not be as useful
for them.

But for trickier pieces of advice, I agree completely with your
reasoning and think that something like this makes sense.

> Let's have a switch to allow disabling this automatic advice.
>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  advice.c          | 3 ++-
>  advice.h          | 3 ++-
>  t/t0018-advice.sh | 8 ++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 50c79443ba..fa203f8806 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -79,6 +79,7 @@ static struct {
>  	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
>  	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
>  	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
> +	[ADVICE_ADVICE_OFF]				= { "adviceOff", 1 },

The name seems to imply that setting `advice.adviceOff=true` would cause
Git to suppress the turn-off instructions. But...

>  };
>
>  static const char turn_off_instructions[] =
> @@ -93,7 +94,7 @@ static void vadvise(const char *advice, int display_instructions,
>
>  	strbuf_vaddf(&buf, advice, params);
>
> -	if (display_instructions)
> +	if (display_instructions && advice_enabled(ADVICE_ADVICE_OFF))
>  		strbuf_addf(&buf, turn_off_instructions, key);

...it looks like the opposite is true. I guess the "adviceOff" part of
this new configuration option suggests "show me advice on how to turn
off advice of xyz kind in the future".

Perhaps a clearer alternative might be "advice.showDisableInstructions"
or something? I don't know, coming up with a direct/clear name of this
configuration is challenging for me.

>
>  	for (cp = buf.buf; *cp; cp = np) {
> diff --git a/advice.h b/advice.h
> index 2affbe1426..1f2eef034e 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -10,7 +10,7 @@ struct string_list;
>   * Add the new config variable to Documentation/config/advice.txt.
>   * Call advise_if_enabled to print your advice.
>   */
> - enum advice_type {
> +enum advice_type {
>  	ADVICE_ADD_EMBEDDED_REPO,
>  	ADVICE_ADD_EMPTY_PATHSPEC,
>  	ADVICE_ADD_IGNORED_FILE,
> @@ -50,6 +50,7 @@ struct string_list;
>  	ADVICE_WAITING_FOR_EDITOR,
>  	ADVICE_SKIPPED_CHERRY_PICKS,
>  	ADVICE_WORKTREE_ADD_ORPHAN,
> +	ADVICE_ADVICE_OFF,
>  };
>
>  int git_default_advice_config(const char *var, const char *value);
> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index c13057a4ca..0b6a8b4a10 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -30,4 +30,12 @@ test_expect_success 'advice should not be printed when config variable is set to
>  	test_must_be_empty actual
>  '
>
> +test_expect_success 'advice without the instructions to disable it' '
> +	cat >expect <<-\EOF &&
> +	hint: This is a piece of advice
> +	EOF
> +	test-tool -c advice.adviceOff=0 advise "This is a piece of advice" 2>actual &&
> +	test_cmp expect actual
> +'

Looking at this test, I wonder why we don't imitate the existing style
of:

    test_config advice.adviceOff false &&
    test-tool advise "This is a piece of advice" 2>actual &&
    test_cmp expect actual

instead of teaching the test-tool helpers how to interpret `-c`
arguments. Doing so would allow us to drop the first couple of patches
in this series and simplify things a bit.

Thanks,
Taylor
