Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3B91F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756071AbeASTeh (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:34:37 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44386 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeASTef (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:34:35 -0500
Received: by mail-yw0-f196.google.com with SMTP id x62so1032568ywg.11
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SQJAA70OrpVhhMb9Tqo9fU9ZLwM0mcWb9xeABGTKK88=;
        b=mp0hA7EOV2OCCr3WWIDR1gM9Prg7bxLHGvcavdP7JO1bdoZHuRrbN675gZ50WkZKV1
         YKzkbPwcaNvhU8wOJrbvinVaXJmIeXGPR9HYg/Gi2+sF8JVU1njdGlM1ZIeSsv+AXnqN
         kcJdHfZW7gbTzUbntdAZ8kgtsysfG2ibTVuIBjzz3+D4zZsY9W3v1Gm1HIgzSx2jbdzQ
         JeimU9vrf49UctUQyD/4w69s5WmUXFcouvAFsiHA0L0FCeuLBRIR1g7TJl6iym/EG2cy
         A5CFXQeCSy5idiWAEvXw24eQOqyXja7rDFbf3jpFFxy3F0thCcvj0wMiyve/7Pn7GKNr
         n7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SQJAA70OrpVhhMb9Tqo9fU9ZLwM0mcWb9xeABGTKK88=;
        b=B15sVv3+DK/qPeiP1gBv5NsLFXXkWf5lvr1BSUjmTEoLNAAaCqIdnyPZmCf8vFLq9R
         xCkIkTNemG3vzAu1Ur828n66kXiTe3FbDpgwhoTELDpavls9UgYqvPGjyX327vnoYP5O
         aH2W97Yj4pXNFLFQKgDW07F5aV5z2sAuMbdvACpcrwn0lzSuHWjkZ6NDxsLY+LU5oNM6
         TLnRmv+hMtJRD3zIUEI4jxkQBHz7l+oZnJvSAXygwwvVN1Affq5GUB2V+17ns+n5J0++
         9WBAkzrhNMFHDLdsNPMU4a1nZGOd/Iz7hH/nY3540tMnk/NxXEGiNTPIPf3624hjsmaj
         FHQA==
X-Gm-Message-State: AKwxytc2tLuPgmh6GS5cLbRekT2ykQcYvwhwMPWd01Bp22tEQ7RkHVqz
        cZ+v80OEpAT8Ffj1NMUjRpPZ6KXANpZjO8GlHhe6/11P84o=
X-Google-Smtp-Source: ACJfBosuZVIRcx97h5zcgDaE6MKpZonhTdfvWZaQIWyYDDl0MuoH304borsEgKX400R5ra3xDb+QUvzSS/G5L3c7Eo0=
X-Received: by 10.129.108.149 with SMTP id h143mr10500899ywc.373.1516390474947;
 Fri, 19 Jan 2018 11:34:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Fri, 19 Jan 2018 11:34:34 -0800 (PST)
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Jan 2018 11:34:34 -0800
Message-ID: <CAGZ79kYUBRueisw2exRC7E-mpHZYE0Y07nnT4CNF_daAYMna9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
To:     randall.s.becker@rogers.com
Cc:     git <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 9:33 AM,  <randall.s.becker@rogers.com> wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> * wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled by
>   default on the NonStop platform.
>

Due to my review of a previous patch, I now know about the __TANDEM
directive and why we use this to guard this line. :)

The setbuf(0) is easier than sprinkling (guarded) flushes all over the code,
so that seems like a clean solution, which we currently don't use.
(it occurred twice in history, see eac14f8909 (Win32: Thread-safe
windows console output, 2012-01-14) for its introduction and fcd428f4a9
(Win32: fix broken pipe detection, 2012-03-01) for its deletion).

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  wrapper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/wrapper.c b/wrapper.c
> index d20356a77..671cbb4b4 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
>         FILE *stream = fdopen(fd, mode);
>         if (stream == NULL)
>                 die_errno("Out of memory? fdopen failed");
> +#ifdef __TANDEM
> +       setbuf(stream,0);

My man page tells me the second arg is a pointer,
so we'd prefer NULL instead?

Thanks,
Stefan

> +#endif
>         return stream;
>  }
>
> --
> 2.16.0.31.gf1a482c
>
