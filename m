Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3A29B0
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755466168; cv=none; b=UN+Fy6Ca01+9NGxTeVPBf9E68x38aZHz47+ZF0VmNCmkU6uGFsh3e/Mix0Sj+T6xioQ2nAMAai1KXQz4qOPIqYh64U2ST+ntfUOOZYWN9mYvP1l23czKANrH6nuIfmyGQLWnL9JB73t+dGiR+yKxled5C19uN6ElZ8rlj91cORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755466168; c=relaxed/simple;
	bh=dM9y9AqXrJDXAyn5BkSaJloQjxtejaF32Q4gHhh28yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkrv8KHmHbZa2065EE9oxLFk7eQUHIU6PDtJdPuJ2o0w8HtKVUvGH9S0mSsn0xwZAuOYmrqfw0RQmPLAiAi76vlDgADV8mOFbVcxsew0Wr++SrcQzS3yJIgXX8and9Rfm9NkfFohfUKhB5Ms3/S3tO9RgoDySfff6kJUWu6jKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0gSCChq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0gSCChq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so17104085e9.2
        for <git@vger.kernel.org>; Sun, 17 Aug 2025 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755466165; x=1756070965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rb2WG9+Mx3HjrQm4eL4Zo39Km6Ls67tVTd1UJTwf7NA=;
        b=H0gSCChq3iH9yXy3yQYFR/lUAFJnzuaCBUHVHSXPDH1ZvhIcpzo5ORgyWzOe+F0iDC
         XnGkUe2w1czs0D206y6rc53EzzLXITbMs/61Mo52NaVgniChlJE2QPCOzAJMUXfURVCo
         XX9AvfyVHyKmXT9APBVA0OtAPxfmzPCLd6p6DNGT3xrhKc2xaXLQIgyBazkxqvqrt+9k
         fkFY3urH7HtDDyHGWZ6gNSPTcSjv02T+u8QGwvNcT1PiSx/wNkdxOjpiNvKz10SCIJWt
         iAuSWBvdksAEZCpmx6u3APSOMr/AdPA+zAS2zjjBJ668OcVm8gyBx5mFSpBdpoiTenN/
         Z6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755466165; x=1756070965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rb2WG9+Mx3HjrQm4eL4Zo39Km6Ls67tVTd1UJTwf7NA=;
        b=mAYpayVXRPn0F2M23eGwy9/VFMm6NmXeigkT34dmAwsxvb6EEH1pJA+OuLg0slGcTE
         pSzlTiObehk4s+YMf85QWDWY1f4UVmttiCPCtk/sCpgvthWglk5aCAmrrMEvMC/m65G6
         D9QJ6jTyp+FzFuQeZN6md2MqQ7ruNqQxHr4hO2dVDt+fmQGGDZmI3lzejaNuGZM4Mfj0
         DibRz6/moOzRQmX2KJphrVr9l+KIjBy2278MY9YbaP5PmG+O68Y64h+4a7Bz+H2oZgoc
         aNT2nkHdBO0nVGwYANNPpqacQNgqYodidA4J/seEzlJ1iHEgBWN93xVpvSkiA7E0a+/Q
         BWNQ==
X-Gm-Message-State: AOJu0YwuGwKKitUX1+GN7eAVkSuiQEszYmhU0hMxzqc+cPHTc0xKZcFj
	bZpSoymZB7h+3Q6WySeqIz+2Sawy36qYOkiIURwFCODEVSVvXkBMUeBC
X-Gm-Gg: ASbGncsOe5PWnxuFv/tKdmFm+xpjCbuv1TFhDnMTwpDYJbT9kHHxms+FZX+H5tfcmQO
	DQmcOsB559vNAJBJCnkBTQFkr2DQE91+H3dCH8HfsMwqfzMkWtJcGH0Y5Z+O+JmjbhqugmqyHd0
	2i4YtwYBqgn6BUNjIcEFFmtZmpf6TezVf4OQ1xMK7PInzwzo2SblAs0spfHC7XaX6V77T++ba+A
	ylqmFchVV9feSwIwVR2OxdecSBaibYY09GjGRp/g0Grige9olB7cEKFiRti7UygVNiD4f3EbCyS
	fJbuZLzrFFPV7rvoS3eVZgsD5CXWxBNv9h1XfhWjIFQWOwAJ+tJZhOkk4Ust02jGrb1Q/q1eH+S
	PukeyHuO1HYvg3hv7RWwVlK6DPArpaMWFPu0G+Vdg+ZvEt2gM0g==
X-Google-Smtp-Source: AGHT+IFtG/K3h/4cQ0s9mzOjtgaJSVtJRUa8YgiDZ1KElO7SYON/KGkzooqVNYtrtGsYebtJJ6OB/g==
X-Received: by 2002:a05:600c:3147:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-45a21857fa8mr51952935e9.23.1755466164906;
        Sun, 17 Aug 2025 14:29:24 -0700 (PDT)
Received: from localhost (94-21-29-168.pool.digikabel.hu. [94.21.29.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c790689sm152159315e9.28.2025.08.17.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:29:24 -0700 (PDT)
Date: Sun, 17 Aug 2025 23:29:23 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v3 7/9] doc: git-log: convert pretty formats to new doc
 format
Message-ID: <aKJJs7OkBIg7Y9J0@szeder.dev>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
 <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
 <0d461544c9d720e379a867a9713998bf09136885.1751914412.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d461544c9d720e379a867a9713998bf09136885.1751914412.git.gitgitgadget@gmail.com>

On Mon, Jul 07, 2025 at 06:53:30PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.
> 
> For all the formats in the form of %(foo), the formatting needs to be
> heavier because we not want the parentheses to be rendered as syntax
> elements,but as keywords, i.e. we need to circumvent the syntax highlighting
> of synopsis.  In this particular case, this requires the heavy escaping of
> the parts that contain parentheses with ++.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/pretty-formats.adoc | 283 +++++++++++++++---------------
>  1 file changed, 143 insertions(+), 140 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
> index 07475de8c337..9ed0417fc811 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc

> +++%(decorate++`[:<option>,...]`++)++::
>  ref names with custom decorations. The `decorate` string may be followed by a
>  colon and zero or more comma-separated options. Option values may contain
>  literal formatting codes. These must be used for commas (`%x2C`) and closing
>  parentheses (`%x29`), due to their role in the option syntax.
>  +
> -** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
> -** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
> -** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
> -** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
> -		      Defaults to "{nbsp}`->`{nbsp}".
> -** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
> +** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}+(+".
> +** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
> +** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
> +** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
> +		      Defaults to "{nbsp}+->+{nbsp}".
> +** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
>  
>  +
>  For example, to produce decorations with no wrapping
>  or tag annotations, and spaces as separators:
>  +
> -`%(decorate:prefix=,suffix=,tag=,separator= )`
> +++%(decorate:prefix=,suffix=,tag=,separator= )++

This section now looks like this when the man page is built with
Asciidoctor:

               %(decorate[:<option>,...])
                   ref names with custom decorations. The decorate string may
                   be followed by a colon and zero or more comma-separated
                   options. Option values may contain literal formatting
                   codes. These must be used for commas (%x2C) and closing
                   parentheses (%x29), due to their role in the option syntax.
                   parentheses (%x29), due to their role in the option syntax.

                   •   prefix=<value>: Shown before the list of ref names.
                       Defaults to " +(+".

                   •   suffix=<value>: Shown after the list of ref names.
                       Defaults to ")".

                   •   separator=<value>: Shown between ref names. Defaults to
                       ", ".

                   •   pointer=<value>: Shown between HEAD and the branch it
                       points to, if any. Defaults to " +→+ ".

                   •   tag=<value>: Shown before tag names. Defaults to
                       "tag: ".

           For example, to produce decorations with no wrapping or tag
           annotations, and spaces as separators:

           + %(decorate:prefix=,suffix=,tag=,separator= )

Note the unnecessary + characters in the default values for 'prefix'
and 'pointer', and in the latter the "ASCII art" arrow ("->") is now
replaced with a unicode arrow character.

Also note that the last three lines are not aligned properly and the
example format string starts with a + character as well, but this was
the case even before this patch.

I use the distro packaged version of Asciidoctor:

  $ asciidoctor --version
  Asciidoctor 2.0.16 [https://asciidoctor.org]
  Runtime Environment (ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]) (lc:UTF-8 fs:UTF-8 in:UTF-8 ex:UTF-8)

