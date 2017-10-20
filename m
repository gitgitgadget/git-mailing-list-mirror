Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FBD1FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdJTIwa (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 04:52:30 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:48888 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdJTIw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 04:52:27 -0400
Received: by mail-qt0-f172.google.com with SMTP id f8so17596988qta.5
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ElaT8C2HW5J7JnuR3JwDlKbau5zi3xQeQWZNgXH1nDU=;
        b=A7MsFsGIjdCUgmSEbkPQqldInbzdinczqs4zgE/ZBa26s/e7sgXG+WxmscsQjqd901
         l8Mt9Tel/Wa85zmV6EYbiyf1MdzdH902U9BMhgh4nCw87sW5Gs8zuWQ3PIWyGM01/jHe
         Cnyb4Ioh8/+mkI6gC8B/zUBrWUX6IGhdrpuv9zBfce4BCz0Hq3yFbwlK28aFQl98hMFj
         88wlkxU+r0M59QTJsdU3DMZiV6SM/hf3pIlJYrvfULK2YnPBIzPGBbG+RD3oIQkQuAa2
         6gF4mWtfmwhOHCjFvXfKtJuT4k1y/8xfHIuaRtUzMt1gLKSE3CO62i11IO+RfDE4r/Bn
         HjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ElaT8C2HW5J7JnuR3JwDlKbau5zi3xQeQWZNgXH1nDU=;
        b=Nhr12DG+wm/xDrGQ+KIls37oF9B5XiFiEuSsf3GJu+tMZzkKUu3ptVKHoc14WHmw0L
         nrLalHABiCYNza+8QwAQtd6B7WZhCSEkuQWfR3XYjGDnQQA9SblNeB6+LUVWLZAGzMOv
         NRDaftpg/ygTbJl5p+QsfdKTkVpL4isNaAGV5gWIT0882OMECWnKEUG8DI1ruNMKNFOz
         LoWyvQLDKcSiuKm037zde8S8VTl/vmCwPegLX59jJ4tIllKqVioylGKkE9PteeQCY9O3
         n7bSmmgAzfYgoFDN3c+lHLbLWbxy5fYu2XfXZAbzK/jvPlcEecgfFQNJszRi49CEZSgf
         BK1w==
X-Gm-Message-State: AMCzsaWOKDqFSm0jxJ2pgsSJ+qQys+5daG7GbGZRGhva1LAg0WGGhUQq
        um9+4eOuT27XS94F13/F2W33VZucflO5j3k707s=
X-Google-Smtp-Source: ABhQp+Q+a+cHBIzPKjkDYcul/Uu9uZFhQmvVKh6zhAMyFqn/iv3DjEuUsDI6PNI4YVL6sysfjOWyfpXLXOVDi833AcA=
X-Received: by 10.237.58.168 with SMTP id o37mr6463797qte.335.1508489546417;
 Fri, 20 Oct 2017 01:52:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.83.136 with HTTP; Fri, 20 Oct 2017 01:52:25 -0700 (PDT)
In-Reply-To: <xmqqy3o6gx4z.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com> <20171019174715.6577-1-marius.paliga@gmail.com>
 <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
 <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com> <xmqq376eibrw.fsf@gitster.mtv.corp.google.com>
 <xmqqy3o6gx4z.fsf@gitster.mtv.corp.google.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Fri, 20 Oct 2017 10:52:25 +0200
Message-ID: <CAK7vU=0m6qyFrPb9E7HY79v0Vxwn+So3gyhxJZBPVD1t7vX35A@mail.gmail.com>
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Thais Diniz <thais.dinizbraz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --o::
> ---push-option::
> +-o <option>::
> +--push-option=<option>::
>         Transmit the given string to the server, which passes them to
>         the pre-receive as well as the post-receive hook. The given string
>         must not contain a NUL or LF character.
> -       When no `--push-option <option>` is given from the command
> +       When no `--push-option=<option>` is given from the command
>         line, the values of configuration variable `push.pushOption`
>         are used instead.

Should we also mention that this option can take multiple values from
the command line?

-o <option>::
--push-option=<option>::
        Transmit the given string to the server, which passes them to
        the pre-receive as well as the post-receive hook. The given string
        must not contain a NUL or LF character.
+       Multiple `--push-option=<option>` are allowed on the command line.
       When no `--push-option=<option>` is given from the command
        line, the values of configuration variable `push.pushOption`
        are used instead.



2017-10-20 8:18 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> We'd also want to document how push.pushOption works in
>>>> Documentation/config.txt (that contains all the configs)
>>>
>>> Perhaps.
>>
>> Here is my attempt.
>
> Another thing I noticed while we are around the area is that unlike
> all other options in git-push.txt page, this one forgets to say it
> always takes mandatory string.  Here is a possible fix.
>
>  Documentation/git-push.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index aa78057dc5..a8504e0ae3 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -156,12 +156,12 @@ already exists on the remote side.
>         Either all refs are updated, or on error, no refs are updated.
>         If the server does not support atomic pushes the push will fail.
>
> --o::
> ---push-option::
> +-o <option>::
> +--push-option=<option>::
>         Transmit the given string to the server, which passes them to
>         the pre-receive as well as the post-receive hook. The given string
>         must not contain a NUL or LF character.
> -       When no `--push-option <option>` is given from the command
> +       When no `--push-option=<option>` is given from the command
>         line, the values of configuration variable `push.pushOption`
>         are used instead.
>
