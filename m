Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6031120954
	for <e@80x24.org>; Thu,  7 Dec 2017 20:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdLGUxu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:53:50 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43601 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdLGUxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:53:49 -0500
Received: by mail-qt0-f175.google.com with SMTP id w10so21062966qtb.10
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C8Ns7S4ETZu7nMUsQM6TaPbkH8O0mtxfg36liUNMm4k=;
        b=gpODlxDZmwJonzHVINAvvkta1Ww72PxBRhVEHgJir/5suQrOy1TjCpbX8KtaFpgxH3
         fUtXU06tkKyXWFs62f21PEDRRx5TamIOin1wStfUshwd6WDy6OPTvV2biteotCteB/4o
         3JIEWY+FPOQbtOYB9UmG3VpWYe4k6djkB0sbhWxIA1T7931cHF0HpOOgOZvTJC/MwmZ7
         u7e5PfNIrl1zLpfjZqXxWZbiOWkxDN56aesP8T+nhjVlbqf0mp0+4g2vbvplJg6OVi7t
         dd1qsdL9ojz+PkmxSaRDLRrGjQwddxKMZOS7T5Ufq3znolc3eDJL5a9X2QB/Yg8pEHKc
         ezEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C8Ns7S4ETZu7nMUsQM6TaPbkH8O0mtxfg36liUNMm4k=;
        b=Z6rqNGY+lgDnA+BhITjbetIa7KbHd6iyOZYPPrXY0KmW69eG3LewaQ5qMvVmc4ISal
         CgEeCtjxY401pAuPxf7hHte0aT6emKFwNHVmN8FtIeL/O7JUjFAPTt6nupXaYndEgUqZ
         L2zO+UxibBUWvZjqKi7XkjW5Vqu8zme/qZAA6Kbgb3DL03flzpLCgOpXIIZNfYjbtrKO
         r0BHddGkCBba2sSDgzNF7Qj/BsMQroxeUvZya3gP+m83voLl30sbxyUFNYk5KnNP+3y9
         QlI0mfCqqiEDwwnpyAgc/ilEMoohaZDnDOkB2oTWNpJT3M5vc6Wjbow0VDO+F6bXrFhK
         CHlw==
X-Gm-Message-State: AKGB3mKl3G63rqQposuWeOGWky4e40bKJQW/jusOUuppsR8qSKdCuCE4
        lOC2ggRhriJNwBA9AuvUpbWpazIW/wZsZppE8g/NRxngGLU=
X-Google-Smtp-Source: AGs4zMYRSdiETjR6gjP8LhK/Ky808AWS4iT6KUNRve1gz8kmfFJw4SzHOQhTaIcBbOZ9nj6X0v3ze2y9dCGmRKoC4HE=
X-Received: by 10.55.203.156 with SMTP id u28mr33260578qkl.353.1512680028375;
 Thu, 07 Dec 2017 12:53:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 7 Dec 2017 12:53:47 -0800 (PST)
In-Reply-To: <20171204235823.63299-2-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com> <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Dec 2017 12:53:47 -0800
Message-ID: <CAGZ79kbV07BsKde1P_3EHjnSj7APTMQk+bbGx79X0nvpU2LD+Q@mail.gmail.com>
Subject: Re: [WIP 01/15] pkt-line: introduce packet_read_with_status
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:

> diff --git a/pkt-line.h b/pkt-line.h
> index 3dad583e2..f1545929b 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -60,8 +60,16 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
>   * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
>   * present) is removed from the buffer before returning.
>   */
> +enum packet_read_status {
> +       PACKET_READ_ERROR = -1,
> +       PACKET_READ_NORMAL,
> +       PACKET_READ_FLUSH,
> +};
>  #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
>  #define PACKET_READ_CHOMP_NEWLINE (1u<<1)
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> +                                               char *buffer, unsigned size, int *pktlen,
> +                                               int options);
>  int packet_read(int fd, char **src_buffer, size_t *src_len, char
>                 *buffer, unsigned size, int options);

The documentation that is preceding these lines is very specific to
packet_read, e.g.

    If options does contain PACKET_READ_GENTLE_ON_EOF,
    we will not die on condition 4 (truncated input), but instead return -1

which doesn't hold true for the _status version. Can you adapt the comment
to explain both read functions?
