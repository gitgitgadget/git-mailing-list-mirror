Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC901EABC2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529584; cv=none; b=C6wVOisNoLPJLtdsI40iPA3bYPOZAA6rhsszR0CvKO9fT6nJSJVg1h6/QPbZqzfY87ZW1AQ+z/HIE4z1A9C+fShi2mUBwSeTT5I4f5YR/6nBdCG+dQrVL0M5k5ohC3C82AzliURuhMhTvDkbwacR/Z0lUNr86IACkhBvvufmFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529584; c=relaxed/simple;
	bh=rRnrd00KOQKqSySPH8r/21cXEFDKRxSJdywSO1VrDT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz/owKz0TFq3jHA1EwqQ8+n7WKRPnAUleEcb/eK064C4+5Chx921edYX8lzhItSrnZ5sb3obldtu7Vrw42sUSKdGBJS+7JjPzib+c03c+/+DxaGlBPWNiyQMapkP/kEIHuT/dWV8BXz13Q3T/R3JgBo5GSNi6bYJu4DQiUj9yd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b0ypWg76; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b0ypWg76"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e35bf59cf6so53105077b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729529581; x=1730134381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtGMgAIoODTpC2Qkz6aKQwERf27kfbnX57NmGtD6IRo=;
        b=b0ypWg76Ve7ESOmBXrLJtKv8IgKMOcfzREAXjGr3yAIFR2dg+HVACFMFbyI2P5Zfsu
         i/4wEdf+MNCRVPK+xRDzL5U8/EkzlRDogouDMP7egtkREYVKHElwkuFf5IdGU2bwsXRN
         Nysj95PZy2EWgSqKy2Om5q/9fixP6zkzFW7a/5skfMOEGfLSaPKq+DjJeTKREfp/Rs9d
         7Pp1vAhpuMq6T0OG37r9GoooeHIKPKJSSdYJ99mxC+Mzx3guDGp9cxYT0Ktm3kfBERgo
         RyfCqlnTEqAdpq4rzcZuh9+bdagBLEc+9vlECEuN5AFX8TzRDMFzHSVPaY8BOx5NzxmY
         k0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529581; x=1730134381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtGMgAIoODTpC2Qkz6aKQwERf27kfbnX57NmGtD6IRo=;
        b=Ez65mMLFb6OLaJmLV6JVlCAnvszh01E26NGcVyVKmuse+AzZI0oxPjI95hE7rb/NCo
         q10soKWrXghWoaO+5OQAvYaBI9FUFa4JShBNTG5PzUA2lU0dAYfj29ke+TfqKWUPRGJ3
         GwPJKb/A4Ld1czX8FY/X7LqarHrYlRtMP9bNemCvWp/3osrGQ13eY3eH53e0Pg4fosot
         OEBg3XmcDflFHvLMpvDTkw2PKDuPYXMQBvcsvKd0hA7dD8SkwZaK3nLqWCGwrrepDBmb
         gWtl8nbAOv7zf/5EDQLbpN+SsFhnNVcmPwsIJp+rg6Kaynz41PGPenIqlR2fv3kw6dTa
         2UtA==
X-Gm-Message-State: AOJu0YzwwhMS8e3f3JuoxcjIl9BWxQMFmDk3HyCe3Bl+oONto+30mqf5
	grF3GaWBMNsVei8SwMFT4EhtKTatp/NM2S27yT+P/wxSezzuTnuZ1gL87dtWu9A=
X-Google-Smtp-Source: AGHT+IGSgJKTlFai+tV663egRH2oHRzH9NsyR9MXubsxDv4kCGBoCfTTADhW2YfUDCW+PSAlWNawIw==
X-Received: by 2002:a05:690c:30b:b0:6d6:5186:32b2 with SMTP id 00721157ae682-6e7d494597dmr3268227b3.21.1729529581088;
        Mon, 21 Oct 2024 09:53:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2212asm7292187b3.129.2024.10.21.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:53:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:52:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v3] notes: teach the -e option to edit messages in editor
Message-ID: <ZxaG67wuvjOXc5kr@nand.local>
References: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
 <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>

On Mon, Oct 21, 2024 at 02:38:15PM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> Notes can be added to a commit using:
> 	- "-m" to provide a message on the command line.
> 	- -C to copy a note from a blob object.
> 	- -F to read the note from a file.
> When these options are used, Git does not open an editor,
> it simply takes the content provided via these options and
> attaches it to the commit as a note.
>
> Improve flexibility to fine-tune the note before finalizing it
> by allowing the messages to be prefilled in the editor and edited
> after the messages have been provided through -[mF].
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Nicely described, this commit message is looking good. Let's take a look
at the patch below...

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 99137fb2357..2827f592c66 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1567,4 +1567,75 @@ test_expect_success 'empty notes do not invoke the editor' '
>  	git notes remove HEAD
>  '
>
> +test_expect_success 'git notes add with -m/-F invokes editor with -e' '
> +	test_commit 19th &&
> +	MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
> +	echo "Edited notes message" >expect &&

Very nice use of the fake_editor script here.

It is a little cumbersome to repeat the same message in MSG= and when
populating the 'expect' file. Perhaps instead this could be written as:

    echo "edited notes message" >expect &&
    MSG="$(cat expect)" git notes -add -m "initial" -e

> +	git notes show >actual &&
> +	test_cmp expect actual &&
> +	git notes remove HEAD &&
> +
> +	# Add a note using -F and edit it
> +	echo "Note from file" >note_file &&
> +	MSG="Edited note from file" git notes add -F note_file -e &&
> +	echo "Edited note from file" >expect &&

Same "note" here. ;-).

> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
> +	test_commit 20th &&
> +	git notes add -m "Initial note message" &&
> +	MSG="Appended edited note message" git notes append -m "New appended note" -e &&

It's fine to use shorter values for -m and $MSG here. I think "appended"
and "edited" would be fine for each, respectively.

Besides applying those suggestions throughout the patch's new tests
(including the ones that I didn't explicitly comment on here), I think
that this should be looking good after another round. Thanks for working
on it.

Thanks,
Taylor
