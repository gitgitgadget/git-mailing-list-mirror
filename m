Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B411F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJIFlp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:41:45 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34601 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJIFlp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:41:45 -0400
Received: by mail-ed1-f47.google.com with SMTP id w19-v6so3803727eds.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EI8PYAusR15VVFrYvxm0fARulJhCO3nhnwEnyv3tQsM=;
        b=QIypfwo1WuiH6SW39tiv9Pf7m6nffJ8i8VSDmKIv4sD5I8g81bE6Dj2ou1gRpdFSAZ
         xq6fope5JkaHODJB/7ziZL4GeZUJVQCO7Lgq4phdli9S+sYvQQcaW8b+p06LRBIEENJD
         fOiGVUj7zHL8GJN6wKMEnINLsllnC8g4oj8R1NWQkA/Yvmu2GoNfOaoLJFHhm4UljeAx
         50Sz0KbceuuzGX/BBdLYn/1bhT70UUGkxltvzg2R1Uq5th1GwVsfKz4iDYktD8WOdqmB
         IE/hdawcXE87VKh9XFjdzGZCcn2h7cfZKm4eGlA4HQjZCfJkMLglrrDfYjUV0KXR53YA
         ZAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EI8PYAusR15VVFrYvxm0fARulJhCO3nhnwEnyv3tQsM=;
        b=OarMVUX3OXWDPPysYuH3O7cg3JZ9kgrEFnazxZVhpSr8iKqFTb8LouWIr3JYlMTM3H
         eHLgcdIKaAEFm9yCJtb+hlIAtUqBHaEcPK0Y2JGADB3AuYqKmy3Gz3IchJY5A2X2XYZH
         J46IZSmYyNl553Xk02JoMXaJ0/S8ouZncJlqerzgQozeoY78PnvWIq3fd/6sRynNiCWK
         ZGVPjsHwTGDiakxjosSBWH3bfoVC6YkPz/Jf+1rXiuyOsUP8aRJsnDFeDyel1BlpfIq7
         AingulqCaWvlkMzvl+J3EA07aBQ4QwAQ4CP9Kt1hCJexLAqyhoky4nwsCExkDukD5fWJ
         g4Qg==
X-Gm-Message-State: ABuFfogWB85UHrs4fF7oNQ80h85G5iqb7ZQ/+i+crTgIHgN1lCWeft4u
        a5KkaS+HwR5ZKBo2avLZWo13/3/7mvPO+rhoG5N/TlEu0oBmbw==
X-Google-Smtp-Source: ACcGV61Efk0sMLQR1xOqQfy/CEQyooVU0C9V4bV0cbb5egfMiypeOkyAiFhPmcX1sa5/OP2+ESmCzIfsb0kzp70trac=
X-Received: by 2002:aa7:c742:: with SMTP id c2-v6mr26731990eds.231.1539037668486;
 Mon, 08 Oct 2018 15:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-3-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-3-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 15:27:37 -0700
Message-ID: <CAGZ79kYvW2PFdLfvd3W_t6rPs=oMBDxgMEgDRLtC4MHyo6MXVQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] builtin/repack: replace hard-coded constant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/repack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c6a7943d5c..e77859062d 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -407,8 +407,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>
>         out = xfdopen(cmd.out, "r");
>         while (strbuf_getline_lf(&line, out) != EOF) {
> -               if (line.len != 40)
> -                       die("repack: Expecting 40 character sha1 lines only from pack-objects.");
> +               if (line.len != the_hash_algo->hexsz)
> +                       die("repack: Expecting full hex object ID lines only from pack-objects.");

This is untranslated as it is plumbing?
If so, maybe

    if (is_sha1(the_hash_algo)
        die("repack: Expecting 40 character sh...
    else
        die(repack: Expecting full hex object ID in %s, of length %d",
            the_hash_algo->name,
            the_hash_algo->hexsz);
