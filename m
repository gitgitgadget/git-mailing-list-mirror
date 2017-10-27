Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8696B1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932137AbdJ0RGZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:06:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:53172 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdJ0RGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:06:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id 31so9234877qtz.9
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z6nxCIgSk4i+kOotVDBb2BcxXYvU/0rXvLDZv4bL98I=;
        b=LLDvIGzyRx5+Pap/ge6XoG5ZhITQs1CAuxxJrC+4wPhh4TOzcOvBhKDvJVJW+rOa5p
         7e+zgRJKVLUZiFNqNBL7raSx6fkQse6G7d3V0oIrf1R1x8XLs21ecpxvdxKYRRZPxYp+
         a/oPEAg6Aqbdxbrj8NIzjQMbiEIW1eHlJzrvYvGTZDtgqhO2YXa5s9zt7LFPiDQLTITQ
         Tcz3TjfWAAYCs8Wl36ehrYbqFuqAjnVa+Rt3rjafBLKVKnLEoVMoeyyWekoVRO1w3vqY
         ZWCsUw9GaY10xE3mJnjLe9Sqt4J98FiyEF8cANC39O2DvWRX3uaDCeq2syAcuuiTr4cq
         UqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z6nxCIgSk4i+kOotVDBb2BcxXYvU/0rXvLDZv4bL98I=;
        b=LYU7agN6UoDfgh8y6hI20BhdbxaZWYUrag+p4+bKRh4ns8j7Qyegp5FqIG0wffI/Tt
         LTAkjTlitx0FW0tclSaaDLyi5O6B80KL6W0Sn4IvwmYXbBMl8j2hflWOh/vYSRxZXfAw
         xN4ZP2x4kQEMSn8g7aD7nbwJXj7S/MOWQYATx9ZZPvTCkUR2h4boTQzoNaGaqT7uciAL
         6ylcsjuZwiSgpk8WuJZRl/ME8yMHNd3MPGuSu9uFSf6QqGDeR3/ooGxn5q4b1i/4WTcN
         AXdz387jNeiog6Ulw3Teb//bzOchnY6Kir7ArPtGO0VEcDuWw0CqQprquWlgrELKAhQ9
         LU8A==
X-Gm-Message-State: AMCzsaVlXE2B7kPdmzLi1gOYRLxQFqJDkCOCzbnvW70zLWiFuoqG9/Jp
        6KzRRfmOpumaoLpd9/eTzpK9oyYPMKXwaPmMbf69hw==
X-Google-Smtp-Source: ABhQp+Qh6vVlYDhWVNMsZMyxrRiwWkeRaBDNpi06by0U3iXDdproCq6I7e2kCRYmJC18tsqhDedezV6fvQX3eKStEdw=
X-Received: by 10.200.8.53 with SMTP id u50mr2037008qth.260.1509123979324;
 Fri, 27 Oct 2017 10:06:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 27 Oct 2017 10:06:18 -0700 (PDT)
In-Reply-To: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
 <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com> <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbgjgOhQuK0-zF7oTvuM_gWKF25+uAf-hsHK2Xg4yshhA@mail.gmail.com>
 <xmqqy3nye9n8.fsf@gitster.mtv.corp.google.com> <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Oct 2017 10:06:18 -0700
Message-ID: <CAGZ79kY0eL42fC+QC9ifvHt-Z_PO7FfVYaEZysGWq+LqLcjduA@mail.gmail.com>
Subject: Re: Re* Consequences of CRLF in index?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] xdiff: reassign xpparm_t.flags bits
>
> We have packed the bits too tightly in such a way that it is not
> easy to add a new type of whitespace ignoring option, a new type
> of LCS algorithm, or a new type of post-cleanup heuristics.
>
> Reorder bits a bit to give room for these three classes of options
> to grow.
>
> While at it, add a comment in front of the bit definitions to
> clarify in which structure these defined bits may appear.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  xdiff/xdiff.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index b090ad8eac..457cac32d8 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -27,22 +27,24 @@
>  extern "C" {
>  #endif /* #ifdef __cplusplus */
>
> +/* xpparm_t.flags */
> +#define XDF_NEED_MINIMAL (1 << 0)
>
> -#define XDF_NEED_MINIMAL (1 << 1)

The whitespace flags are also stored in xpparm_t, though
these flags can also come in from other sources (e.g. we
just pass it in manually via the interface).

>  #define XDF_IGNORE_WHITESPACE (1 << 2)
>  #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
>  #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
>  #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
>
> -#define XDF_PATIENCE_DIFF (1 << 5)
> -#define XDF_HISTOGRAM_DIFF (1 << 6)
> +#define XDF_IGNORE_BLANK_LINES (1 << 7)

Is XDF_IGNORE_BLANK_LINES a whitespace option, just
on the lines level instead of the inside one line? I think
it still makes sense to keep it here, slightly separated from
the IGNORE flags.

> +#define XDF_PATIENCE_DIFF (1 << 14)
> +#define XDF_HISTOGRAM_DIFF (1 << 15)
>  #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
>  #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
>
> -#define XDF_IGNORE_BLANK_LINES (1 << 7)
> -
> -#define XDF_INDENT_HEURISTIC (1 << 8)
> +#define XDF_INDENT_HEURISTIC (1 << 23)
>
> +/* xdemitconf_t.flags */
>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)

This looked like it was carefully crafted to avoid accidental bit overlap
with XDF_NEED_MINIMAL; but these are in different flag fields, this
should be fine.

Thanks,
Stefan
