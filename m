Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA07A13C
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230321; cv=none; b=YAmy2TaTb1clyqeX1G1L5BR4aVGQ31wz8QqQyNOO3E0BnSC2Eueqb0+5NqhF//UabF0aBkVldu6k8qMElXSckg9uYguojGI/MNxgwxsJGhzw5YlMGwljS13Wdk5380azbvlxIHqxCJRGu9W3buXhrRatgaW4YNxa5hhonJkOdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230321; c=relaxed/simple;
	bh=PV5HwLQxKnRdhjJJrbQtT1e8c47CenNcJTqxOCwBa90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0u1Z3StBxfOkHDRL8wzbHNhq5PeTBVL7ZPLR1D7+Z2bDbWrz5d6LmmbJ/kHNY5wM0wkxP0CUKIAZTn6liavsdDz+bdqgchqCTrPJITJomgnysq4nGDQ5ERy0vow8xB9gyQ/6UTOiynK2Ds31sRdIxWlN/YDR2MAj4Snl1hteHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787990149edso56982185a.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 10:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230318; x=1709835118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUBkGGGCj9x1iJpasbP4eqTYHhmdrPu/C+/yB6IBLUU=;
        b=plJ7jGZVB9SmZ6ZRp7TFjny+qtPgiE6KkN/sLJvNtLPvU46VLb5he0y4nosTEBQwy+
         lVaa8e2joe5/LOq7v1Bpy4NiynLFbgWmFLirSKzmk/3jLElhUmT4CVvhxeLYCM16knOo
         7taA3uev3dIq5Nc00UHHe8v69PAYXnj5gaLYIJavXsbYMA3xKNdDMwP0MwDlra09nFz8
         d4lPEBovrIpfC1XDxsPZnq8In8DFdRt25v2y8m2X3qVswWnVGyYg27mBt/8Vm0vzW/7K
         sM1yPcHkM8UIbyd9SGKpJ77C/QIny/xzm+9ShYqP+1lhOdrSyXbRojtxfOn1JXPnUU+Z
         Y0Jw==
X-Gm-Message-State: AOJu0YxVHnFocssvJ/zbEeNcUeb7RFqbMLFJyLa+wf0Mg7ktYqqlrW1b
	47fAm9YF1AfY5djzYScaS3KudnSIELHwyCcbcNNQsutmz/KCS1MPttn5ogtXQBtfwSmEsHcjBb7
	wyKHMZh2k6jB1GIf4Z2NwJUpmNaM=
X-Google-Smtp-Source: AGHT+IFaQGlpUmSRJPq5ALkd7soYfLK64dZiUOyb/70m2nUvyaKok1rNNgZWmSWBdWk7Gu+3XRdS20sH0e0Yuem27Lg=
X-Received: by 2002:a0c:dd92:0:b0:68f:e4a3:27ab with SMTP id
 v18-20020a0cdd92000000b0068fe4a327abmr3180560qvk.50.1709230318233; Thu, 29
 Feb 2024 10:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 13:11:46 -0500
Message-ID: <CAPig+cS5L=i2dYJnc+w5F-k0nSpOjdpqyk6T0gL7i0c01A40nQ@mail.gmail.com>
Subject: Re: [PATCH] tests: modernize the test script t0010-racy-git.sh
To: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, 
	=?UTF-8?B?TWljaGFsIFN1Y2jDoW5layBbIF0=?= <msuchanek@suse.de>, 
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQSBbIF0=?= <jn.avila@free.fr>, 
	aryangupta701 <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:24=E2=80=AFAM Aryan Gupta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> From: aryangupta701 <garyan447@gmail.com>

The name in the "From:" header should match the name in the
"Signed-off-by:" trailer.

> Modernize the formatting of the test script to align with current
> standards and improve its overall readability.

The aim of this patch makes sense, but the implementation isn't quite corre=
ct.

> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---
> diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh> @@ -16,19 +16,18 =
@@ do
>         files=3D$(git diff-files -p)
> -       test_expect_success \
> -       "Racy GIT trial #$trial part A" \
> -       'test "" !=3D "$files"'
> +       test_expect_success 'Racy git trial #$trial part A' '
> +               test "" !=3D "$files"
> +       '

The variable `trial` takes on values 0-4, and that value is meant to
appear in the test title as the script runs:

    Racy GIT trial #0 part A
    Racy GIT trial #0 part B
    Racy GIT trial #1 part A
    Racy GIT trial #1 part B
    ...

However, by changing the title from a double-quote string to a
single-quote string, you inhibit interpolation of the `trial` variable
into the title, hence the test titles instead show up as:

    Racy GIT trial #$trial part A
    Racy GIT trial #$trial part B
    Racy GIT trial #$trial part A
    Racy GIT trial #$trial part B

which is undesirable.

So, the title should continue using double-quotes, and not be changed
to single-quotes.

The other change, which fixes the style of the test's body, appears correct=
.
