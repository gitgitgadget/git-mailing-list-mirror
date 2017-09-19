Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDE12047F
	for <e@80x24.org>; Tue, 19 Sep 2017 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdISSHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 14:07:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38540 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdISSHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 14:07:46 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so207204pgn.5
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZ8XUtzdFpxmJ7zdrcraNPI5iE+0jd9cddXi0AZNBVQ=;
        b=kQ1jojekOQxzwcAFeUOCUEWMVRwoznZrgmzILft37WNFMS0p46i0hGACF8tObvVTdd
         YBnXORjhgUPhyOXgn5rejqnEVthiHl5Ok/6RmW7FEmPl8q7+6TV4Nkoencl2QDoVmWFl
         jCGRBOeZ7t/Q2VZ9CzjsMDj4kCs1zbe3nWobu2WaT8jpoCu/AFXDrtmJxTWlRVOmJqEt
         KgkoTKhuYrF9mnZ3jnOy9VHWtuMVgGbsHmgZwYkldvyrVG+204nSX9Q8/TlOgS97pNAA
         o0GaB1USFyW8sxgDWqbvifMi8frfXjYtbZfGILt+qxfRG8jacDmI4D/UivrGfAJLmFj0
         MHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZ8XUtzdFpxmJ7zdrcraNPI5iE+0jd9cddXi0AZNBVQ=;
        b=Mgwge9uyb1vUzahnR+7xoQ6ajLwj6gfvanDJ87cRB1169p77dYyNjNK8yALRG8Qbt6
         pBW2HG2fYaM6go3xiOGe6dZjn+a10HI97yR9Ju+lk6PhJmfpk+/1L2O681HCp+lMgjKl
         3yZjons8yCGVi1f6Q5/JYkSdmf0RfV88AGH4FwOuODIbgh0fV99tJM1BKFu19wJKYG4S
         XPc0Rw7nam1W7pdT7qnoMVweTAv97Nzk+/VxFznjaCXOVZaKhUrhHNv/IHjze5qbByC3
         Z275pQvHEydyzjHzghW4ciWcsVNO2xyQ8e8OUF/XMmdPGYzNj8aFcYNcJCJmHoWYzRZk
         xhjw==
X-Gm-Message-State: AHPjjUgHAEcxybOvcFekjtEj8MkC/SXy74tjq4RaW4Q7dvvoKSunc3DK
        +3BuB3N0rgBwWVioYo+A1YU=
X-Google-Smtp-Source: AOwi7QAkR6zv9qB1eHypBrWqFCLHZga8xf+vc4sCks464wT/YHVQmIm4bbIbDlhxvvsS2x5opAcBAA==
X-Received: by 10.98.66.220 with SMTP id h89mr2077965pfd.270.1505844465677;
        Tue, 19 Sep 2017 11:07:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id f9sm4374632pfe.150.2017.09.19.11.07.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 11:07:44 -0700 (PDT)
Date:   Tue, 19 Sep 2017 11:07:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] Win32: simplify loading of DLL functions
Message-ID: <20170919180742.GC75068@aiede.mtv.corp.google.com>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> Dynamic loading of DLL functions is duplicated in several places in Git
> for Windows' source code.
>
> This patch adds a pair of macros to simplify the process: the
> DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
> ...<function-parameter-types>...) macro to be used at the beginning of a
> code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
> using the declared function. The return value of the INIT_PROC_ADDR()
> call has to be checked; If it is NULL, the function was not found in the
> specified DLL.
>
> Example:
>
>         DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
>                           LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>
>         if (!INIT_PROC_ADDR(CreateHardLinkW))
>                 return error("Could not find CreateHardLinkW() function";
>
> 	if (!CreateHardLinkW(source, target, NULL))
> 		return error("could not create hardlink from %S to %S",
> 			     source, target);
> 	return 0;

nit: whitespace is a bit strange here (mixture of tabs and spaces).

Could this example go near the top of the header instead?  That way,
it's easier for people reading the header to see how to use it.

> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Just curious: what was Karsten's contribution?  (I ask mostly because
I'm interested in kinds of collaboration git metadata is failing to
capture correctly --- e.g. pair programming.)

>         So far, there are no users (except in Git for Windows). Ben
>         promised to make use of it in his fsmonitor patch series.
>
>  compat/win32/lazyload.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 compat/win32/lazyload.h

Are any of the Git for Windows users something that could go upstream
along with this patch?  That would help illustrate what a good caller
looks like, which should help with reviewing future patches that use
this code.

> --- /dev/null
> +++ b/compat/win32/lazyload.h
> @@ -0,0 +1,44 @@
[...]
> +/* Declares a function to be loaded dynamically from a DLL. */
> +#define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
> +	static struct proc_addr proc_addr_##function = \
> +	{ #dll, #function, NULL, 0 }; \
> +	static rettype (WINAPI *function)(__VA_ARGS__)
> +
> +/*
> + * Loads a function from a DLL (once-only).
> + * Returns non-NULL function pointer on success.
> + * Returns NULL + errno == ENOSYS on failure.
> + */
> +#define INIT_PROC_ADDR(function) \
> +	(function = get_proc_addr(&proc_addr_##function))

Probably worth mentioning in the doc comment that this is not thread
safe, so a caller that wants to lazy-init in a threaded context is
responsible for doing their own locking.

> +
> +static inline void *get_proc_addr(struct proc_addr *proc)
> +{
> +	/* only do this once */
> +	if (!proc->initialized) {
> +		HANDLE hnd;
> +		proc->initialized = 1;
> +		hnd = LoadLibraryExA(proc->dll, NULL,
> +				     LOAD_LIBRARY_SEARCH_SYSTEM32);
> +		if (hnd)
> +			proc->pfunction = GetProcAddress(hnd, proc->function);
> +	}
> +	/* set ENOSYS if DLL or function was not found */
> +	if (!proc->pfunction)
> +		errno = ENOSYS;
> +	return proc->pfunction;
> +}

strerror(ENOSYS) is "Function not implemented".  Cute.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,
Jonathan
