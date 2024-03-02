Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6847168A8
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709375141; cv=none; b=UKXdd+j0NOomyfrtndf7a4/BPTtKkJ/IDv5jUlD7ABY9kXqG2eterugDAdSEwz5mkxgFCX5jUsX/itvfhJd/VahyIq9DtKsQpa+/QLCV+8fYXTwIMXK08gOzRH/fexR58GVh6FQKpDGwoaeUbCkEGu7F6Hz2K3FFjx69YmEC5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709375141; c=relaxed/simple;
	bh=UiKtxTgWlBtuuSoKOsgPgx5YHsTAY0IAoUgmXbVfwoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXtkg6l1nDHHOraTegyyvn2gv3rG+wHU32Z37dTP00d+okF2caTTn3b7sNJnARXz1hNCpIRw3BfLixbDRqcHLvGl7gQRzImuc/fSeHvgIHvmgTUZDYVCeXz/NN3G9axKBfmv+IXyyc/uD1YIrxuIQBxyFBBLVLJBAjAzjq6OA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a0919f2022so1032302eaf.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 02:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709375138; x=1709979938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NYSw5jxY4VKRKMMWzeSnpeXvZEoFjziyGXtO95o3to=;
        b=B4g0GkjC4YynZS2crNHrZQXIHDEz5vP0t4CQ+HVv3+9w/rdA82K3e4D4pc1y+rd6eo
         240LMtb6O6s/KV7NhSrhTJ5T87Epmop7ytf/Xzr7mOe8+g/1p448tusIduA5ZZEWToBI
         ahKf9BgG3kwni+avAeq7HA7GCu3hGvHeAcTRSJr9D81b5u5XWy1RHfUfv7m+CeNDTYEe
         vSiabI76lwydm3rFY4lHPaM+v7NjSsineYtaGCNETXCKgLd8hzoywQk+8mAX7ooBGJ3x
         CcjTlCdwEjuvMeLhgNRc3CjR5Tybs4CYlYTcwLNhyMLUKZtnOprs9rmLV8+IKvvJ2iUW
         enzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbhs88SwxiT0QVsL1HwqtLQQ+1cUCfx5YuxifDH3/GMX0unDVMuf452KkVPu8lo4jSoDwZuME1mbwCSNWxc8khbR+U
X-Gm-Message-State: AOJu0Yy0ZQRMH7J5/FgthqC1iNYrGvKLBtN2gC8unAO0M/dq+14yFDoO
	cxL1jZg6LlfBYsbsKdyVP92SUCa9OfkTAg9QF3pZXoxb9n3Jk6Tk93pCgFHzhhFQ4UiHFFXupm3
	ybCJXNdFD0eT9rQ+BE6bRx7/gGKJgx4Br
X-Google-Smtp-Source: AGHT+IG6nn1r/Cd0WT1HmPHqR673OFq+r+glJd80vDeUXo77/1WGPEMWsscKk9l+ktvYpQrQfc3hIt/jo9IRyYG3iwo=
X-Received: by 2002:a05:6358:7f17:b0:175:4f0f:bbb6 with SMTP id
 p23-20020a0563587f1700b001754f0fbbb6mr2709420rwn.25.1709375137960; Sat, 02
 Mar 2024 02:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <20240302095751.123138-3-karthik.188@gmail.com>
In-Reply-To: <20240302095751.123138-3-karthik.188@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 2 Mar 2024 05:25:26 -0500
Message-ID: <CAPig+cRXtk0f=gMSkRka8mCFfT2=PKSBXMQGGhA3J_t=O_rpAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: add 'diff.wordDiff' config option
To: Karthik Nayak <karthik.188@gmail.com>
Cc: oliver@schinagl.nl, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 4:58=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> The git-diff(1) command supports the `--word-diff` which allows the
> users to specify how to delimit word diffs. Provide this option also as
> a config param 'diff.wordDiff'.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/diff.c b/diff.c
> @@ -209,6 +210,23 @@ int git_config_rename(const char *var, const char *v=
alue)
> +static int parse_word_diff_value(const char *value)
> +{
> +       if (!value)
> +               return -1;
> +       else if (!strcmp(value, "plain"))
> +               return DIFF_WORDS_PLAIN;
> +       else if (!strcmp(value, "color")) {
> +               return DIFF_WORDS_COLOR;
> +       }
> +       else if (!strcmp(value, "porcelain"))
> +               return DIFF_WORDS_PORCELAIN;
> +       else if (!strcmp(value, "none"))
> +               return DIFF_WORDS_NONE;
> +
> +       return -1;
> +}

Why is one arm surrounded by curly braces when none of the others are?
