Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB63C2774
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072154; cv=none; b=sz1bLomVJzrcCrJugpflC4hs/7zuc9xWtZw/gf8FADecFyC9mRvkpMD4eGIWdDr1IVJzwoPRRe5pyc9ki8sZOfZfhSDOPO4UZuektgUVoIP6fZk05Cw5LXvQL8urTGuWEbFMDXmxYFBegZ3FDrjTsLkxL5T4VJJTM3nautPe+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072154; c=relaxed/simple;
	bh=sT+CtIy6QF230MlIG6TICDJ7iXaS8G/o0yQna44MXVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d64bQl7uezjZXrq1fDpiQ7+dyhfGxKT85sfNc4IjKX86rkiy1yzyLoc/f4KqJsba/NAfoDs+mAnBDpJBSiVUaeQfOjHy0gHFdkLdfvNpCVEzxFKRzxMhmQHVS1FJEXqCXWMNwrjgodReP6JVAr0pc6RHvxOT8t1d7iwJZ0jUBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgWF92Sv; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgWF92Sv"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-464bc03efd8so6914977b6e.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773072148; x=1773676948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYfyNhlVFt4sDnSBrrwprDZswwK8WFD2EHOFeOTcZxU=;
        b=YgWF92Svswo6YSA40B3Oh73afSw5UGfANypgvt/s8d9iTQ1Wo5FsXbnB8plEJKrUU8
         uEI1pAgG3jP57EHMsenTf8eWR6zPCYWGIzJ7rx8tCTO7bsWkJpwFFpTvRPQGR7d8WRG1
         XC2Ts8bRj2FtWLeIbKclyKa3gbHp0DjnqdZiVPyAJgaNs3PKMoVFA4jmxb0lhTRH5cVU
         a6Ut6bVDr1pgcUDSG6v6GylK383F++NrYHj+vwwvv8ibWu3gZunOgKiUM9qkdbWA9zs3
         d/Q678xZ9P3aOhYkrPMQg+bhptEBBc26giCZ4cCA1+uT2RWdLOdZbp416d/tczY4PHeB
         lkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773072148; x=1773676948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYfyNhlVFt4sDnSBrrwprDZswwK8WFD2EHOFeOTcZxU=;
        b=uXZIl6trEVvnRYwVywR8UVEkJ1Fg95ZL3FTb8Ng7kHrHUy6XPlVK7zqrKShyfG7Ebe
         66y/QYQ1PAteJGsmlDzKp8Oa33RAYqSpOSlEqFRNhew7faVT8SMYSkdtfK3rJrp+LABt
         OmsLuUzYO4qxYd+pJUU6e4HXkNX5XgVaciGo+reYO15PKZ+42n7Gfb+vUpDnBYKI7Xiz
         1/H6mGoywTt/JnwbVyD3ut+50vA55v1CORIN7LUbm8zSBzpg4Kd/EGvHHnnmrCTCYjoH
         Lx3QwZYMYWIHC1Jx+jfT0IhZizz/79TBohIkToWECxuj9Y/lE6iUyy2G+ylzSngqdSCq
         wHhQ==
X-Gm-Message-State: AOJu0YylSDXUMg0JLA8QwuwEzqUHCzb3lJD1UR/CjMWlc7c6YCGxC52J
	eTZislsvWtL89jXvrm3Xj9rdnqXvthUeEiazRJnCIvma0aAbqQwBfXyZ
X-Gm-Gg: ATEYQzxD+Lgej0CGxqrR5LQjsFbG1EbUQTkU0xRlXd80ECPvgudJgFuqFWnbWPO8L8D
	kzEDHGJHkMfunXrAjLLRSKc6cnx7zDuanPKMqEUibqMS17xDU8ZfFHJJUM24AgzHU0/qbHPp+mG
	eKoFWMCejWcMhQf+7wqU6OwFXIP8gFOeGjXzc2CpqBOq3o6tlgCyC5zUFQNG6aPCVHMIZuKkzKF
	O9PRdudK5zrtt9OAkbkaCPSuY+n3UqY3JYm5qYJXGb4oLp1W//Yba0vAkhc6SA6Gd1hP3Wnm7FK
	DG3DvkFtxERxEEwTzJ0b1L6e0xeoGPl86vI70g3Q05WeBmEoY7O6kdUAMCjilIT06uCpyan5VT8
	DpqhndGE9Jr/2Cnx4aQh7MIr9FDqv+BXac/FPZEay55ltTE2MG85Ul4UbrsbP2bMdFbSzbJd6KI
	u/EvtuIAogeJGhSplg
X-Received: by 2002:a05:6808:17a6:b0:463:f569:360b with SMTP id 5614622812f47-466dcb8cbdamr6935170b6e.56.1773072148176;
        Mon, 09 Mar 2026 09:02:28 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466f429c7fcsm3708757b6e.9.2026.03.09.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:02:27 -0700 (PDT)
Date: Mon, 9 Mar 2026 11:02:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] meson: detect broken iconv that requires
 ICONV_RESTART_RESET
Message-ID: <aa7pwTbyv8TT9WBB@denethor>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
 <20260305-pks-gitlab-ci-macos-16-v1-2-ce8da0ff29c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-2-ce8da0ff29c2@pks.im>

On 26/03/05 12:20PM, Patrick Steinhardt wrote:
> In d0cec08d70 (utf8.c: prepare workaround for iconv under macOS 14/15,
> 2026-01-12) we have introduced a new workaround for a broken version of
> libiconv on macOS. This workaround has for now only been wired up for
> our Makefile, so using Meson with such a broken version will fail.
> 
> We can rather easily detect the broken behaviour. Some encodings have
> different modes that can be switched to via an escape sequence. In the
> case of ISO-2022-JP this can be done via "<Esc>$B" and "<Esc>(J" to
> switch between ASCII and JIS modes. The bug now triggers when one does
> multiple calls to iconv(3p) to convert a string piece by piece, where
> the first call enters JIS mode. The second call forgets about the fact
> that it is still in JIS mode, and consequently it will incorrectly treat
> the input as ASCII, and thus the produced output is of course garbage.
> 
> Wire up a test that exercises this in Meson and, if it fails, set the
> `ICONV_RESTART_RESET` define.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index ee3d9ced92..1b9be3d36c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1060,6 +1060,32 @@ if iconv.found()
>      ).returncode() != 0
>        libgit_c_args += '-DICONV_OMITS_BOM'
>      endif
> +
> +    if compiler.run('''
> +      #include <iconv.h>
> +      #include <string.h>
> +
> +      int main(int argc, const char *argv[])
> +      {
> +          char in[] = "\x1b\x24\x42\x24\x22\x24\x22\x1b\x28\x42", *inpos = in;

This appears to be the ISO-2022-JP encoded sequence that switches
between ASCII and JIS modes. Might we worth mentioning this in a
comment. :)

> +          char out[7] = { 0 }, *outpos = out;
> +          size_t insz = sizeof(in) - 1, outsz = 4;
> +          iconv_t conv = iconv_open("UTF-8", "ISO-2022-JP");
> +          if (!conv)
> +              return 1;
> +          if (iconv(conv, (void *) &inpos, &insz, &outpos, &outsz) != (size_t) -1)
> +              return 2;
> +          outsz = sizeof(out) - (outpos - out);
> +          if (iconv(conv, (void *) &inpos, &insz, &outpos, &outsz) == (size_t) -1)
> +              return 3;

Here we call iconv twice. If we have a bugged version of iconv, In the
second call we expect that it forgets the mode and returns garbage.

> +          return strcmp("\343\201\202\343\201\202", out) ? 4 : 0;

This appears to be the expected UTF-8 string. If the output doesn't
match, it indicates we are encountering this bug.

> +      }
> +    ''',
> +      dependencies: iconv,
> +      name: 'iconv handles restarts properly',
> +    ).returncode() != 0

Should we be more specific and expect the return code to be 4? It is my
understanding that these other scenarios would not be indicative of the
bug.

> +      libgit_c_args += '-DICONV_RESTART_RESET'
> +    endif
>    endif
>  else
>    libgit_c_args += '-DNO_ICONV'

The check here looks good, but without the surrounding context, it is
not immediately obvious to me what we are trying to do. It would
probably be nice to leave some breadcrumbs for future readers.

-Justin
