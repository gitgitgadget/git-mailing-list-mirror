Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8776C1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbcHaXsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 19:48:00 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36656 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbcHaXr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 19:47:59 -0400
Received: by mail-it0-f48.google.com with SMTP id i184so38651959itf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kwAucGNFotzCycqDJGAuAmasli+9S3qzi5w2mGVpBBw=;
        b=KjjzMugKMKDsXljKKsOt/Wb1CNS1NnLWIQL885xQjS6ciuuQB9558ync8PA8pOu4Uv
         cnLMa/SFUTpvam4FJsgzB8433hfo3gCqGrLrLiGZ8f/QG5V9lBTrY2OVuHylL5WslnPy
         pjKW0IOqFNRgvRS0SQeORTE5nZNbS0BVukgKuFxztVLyFHE9awuSK7TnAKi2uCwgo5L9
         8KvigdjkjvZPAW/5yIey7OB9y4ksZeqK1uSzlRFQOFOpkPzKhh3GruNw296/9w9QWYLF
         0qRjh8yPRH8iSw6IzLveDCz1L+eiGn0AZY7f6qh8qiF3idS4opJUh0W137dXFBaqQGOx
         EhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kwAucGNFotzCycqDJGAuAmasli+9S3qzi5w2mGVpBBw=;
        b=NBmA6VtjwWInI0tyqUJcoSDr9kCTmMRhuWBt9jUWhZhHTjGOKhr2gMBRKmHG4NYAHQ
         gTRhjlq/2xsfeIOFwkToeAeAcPkWTK4jcTfAJj26Y0O4I+mn8chxFo1xjez64L8GRapF
         m8fv9xV1MLl9xWluZ/s4el4DHDhtj3mLQ+hD28lpfY/zFJWXTYR9BDCxlR85IpwksJTc
         8QtVoBFM7St0TOiHvECp2GWDBjV6o2HWbUsJmrWtEfcyCrI1szToQ2HU6fSp6SHn3Wq7
         DCKU59h6heqZ1XA4UQi0EXv0jCUlt8o9ByIB4JuQ4hliApcAXKe6hDWaUf0DrY9C4YcN
         E3lg==
X-Gm-Message-State: AE9vXwMmr5xPyg5XlQ+MYfxuTXIQ6mn9j8ZAjhlR3HbETQ30mMY335i7n9gw7OXWVZYJf7oTve+oSjDX586GDwz2
X-Received: by 10.36.227.7 with SMTP id d7mr1632562ith.97.1472687278413; Wed,
 31 Aug 2016 16:47:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 16:47:57 -0700 (PDT)
In-Reply-To: <20160831232725.28205-1-jacob.e.keller@intel.com>
References: <20160831232725.28205-1-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 16:47:57 -0700
Message-ID: <CAGZ79kYFze=WcA8ZxtL2buMa_sm5G_hrAHvd+1Ga8dZYH6W6AQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] submodule inline diff format
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 4:27 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Hopefully the final revision here. I've squashed in the memory leak fix
> suggested by Stefan, and the suggested changes from Junio, including his
> re-worded commit messages.
>
> interdiff between v11 and v12
> diff --git c/path.c w/path.c
> index 3dbc4478a4aa..ba60c9849ef7 100644
> --- c/path.c
> +++ w/path.c
> @@ -467,7 +467,7 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
>         return pathname->buf;
>  }
>
> -/* Returns 0 on success, non-zero on failure. */
> +/* Returns 0 on success, negative on failure. */
>  #define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
>  static int do_submodule_path(struct strbuf *buf, const char *path,
>                              const char *fmt, va_list args)
> @@ -523,8 +523,10 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>         va_start(args, fmt);
>         err = do_submodule_path(&buf, path, fmt, args);
>         va_end(args);
> -       if (err)
> +       if (err) {
> +               strbuf_release(&buf);
>                 return NULL;
> +       }
>         return strbuf_detach(&buf, NULL);
>  }
>

Skimmed all patches very quickly and they look good to me.

Thanks,
Stefan
