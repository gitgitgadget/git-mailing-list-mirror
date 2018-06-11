Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB1E1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 19:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeFKTT1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 15:19:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41915 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbeFKTT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 15:19:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id s201-v6so6691246ywg.8
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MnLBSEPNO8uVOKunR99M3iaCWff9gTsj8Z7EHa2268=;
        b=uIDpgiANbcwP91qb3G4GzcG2Riw5woiGhWyGPaO5sCkuGQzIUi21YJP/9/Lw1K+PrZ
         eFuaLrxVpaoo/0lw7kqYRDjiIdmorlV5M95BMrQxKh2Xtnq4A28zeN6ePnHQvykqo5M/
         eVqnyKQDvKEecAG6TVpDqWZQ07Y40xXtX2jbAxOTOLWPvhUkZDnQoTflNNge+O+22h+R
         VrCbL7w1Zstpjtc/AgmmTAvz+PE9qAb8aZD0dkyQg9Fmp2wOEw3WRvXnWM+n9yzm/s/+
         ohVMc4409AkhIcPMmBW8jZWuUpbsfBWAzVvc6oI5+BPjpEOEQfA4Li7yR5QRhzaN2rwY
         tCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MnLBSEPNO8uVOKunR99M3iaCWff9gTsj8Z7EHa2268=;
        b=q/Q0fFN1x+3f4aWAOmpP3sJUvqHlZtHp1SN4IiTGRKeS1bH7ypHqdl3IVzsm47plPB
         2EsLhiEJ++RysyUtUBRmFhTqwnzAleNST3+ULlKKeU5eEJ6a+dNc678ghWNoJvTYDk2A
         6zCoHWOdcfcJs2VVG3WGtYBt+E2qX6XB7+xc0LnT8cxPj1sHs3Q+WI2bTnAv34ntBX7d
         9KFboNNh6ksT70gVZLdq3l41m8etk3AWhBxQmXmxO4mXzw7UU0EuUeyqZUbq+RxzPu7L
         5GPTBm7LU+ZU8bz5XpV7fRngLu4P86Cg9n47gfWR48m1aB6Ehg1nui2cvDkkc3W0oKRo
         +Kng==
X-Gm-Message-State: APt69E0FoMxCwaeBm23fMNJYLcY+AsGjaA6CzZlxqqJ7v63mh0Zk6pa2
        VrXmZAx8/gDE3IVwUSnyqQaEYQTBJZ6j9Z/p3EBw8Lyl
X-Google-Smtp-Source: ADUXVKJ0rDc1dWBvwazAEj1Ie7VyzyAVJiU8Yx/YV865RHyYS28mIWEOi34raDpZjdC2lHh6Qj7mBDu48hGnjuC4NRg=
X-Received: by 2002:a81:3712:: with SMTP id e18-v6mr269751ywa.340.1528744764826;
 Mon, 11 Jun 2018 12:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-3-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-3-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 12:19:13 -0700
Message-ID: <CAGZ79kaDiXnAuRym3HHQPEZh9z0-sPL5V4Yur5-_RojsyLJsYA@mail.gmail.com>
Subject: Re: [PATCH 02/23] midx: add midx format details to pack-format.txt
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,
On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> The multi-pack-index (MIDX) feature generalizes the existing pack-
> index (IDX) feature by indexing objects across multiple pack-files.
>
> Describe the basic file format, using a 12-byte header followed by
> a lookup table for a list of "chunks" which will be described later.
> The file ends with a footer containing a checksum using the hash
> algorithm.
>
> The header allows later versions to create breaking changes by
> advancing the version number. We can also change the hash algorithm
> using a different version value.
>
> We will add the individual chunk format information as we introduce
> the code that writes that information.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/pack-format.txt | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 70a99fd142..17666b4bfc 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -252,3 +252,52 @@ Pack file entry: <+
>      corresponding packfile.
>
>      20-byte SHA-1-checksum of all of the above.
> +
> +== midx-*.midx files have the following format:
> +
> +The meta-index files refer to multiple pack-files and loose objects.

So is it meta or multi?

> +In order to allow extensions that add extra data to the MIDX, we organize
> +the body into "chunks" and provide a lookup table at the beginning of the
> +body. The header includes certain length values, such as the number of packs,
> +the number of base MIDX files, hash lengths and types.
> +
> +All 4-byte numbers are in network order.
> +
> +HEADER:
> +
> +       4-byte signature:
> +           The signature is: {'M', 'I', 'D', 'X'}
> +
> +       1-byte version number:
> +           Git only writes or recognizes version 1
> +
> +       1-byte Object Id Version
> +           Git only writes or recognizes verion 1 (SHA-1)

s/verion/version/

> +       1-byte number (C) of "chunks"
> +
> +       1-byte number (I) of base multi-pack-index files:
> +           This value is currently always zero.

Oh? Are meta-index and multi-index files different things?

> +       4-byte number (P) of pack files
> +
> +CHUNK LOOKUP:
> +
> +       (C + 1) * 12 bytes providing the chunk offsets:
> +           First 4 bytes describe chunk id. Value 0 is a terminating label.
> +           Other 8 bytes provide offset in current file for chunk to start.
> +           (Chunks are provided in file-order, so you can infer the length
> +           using the next chunk position if necessary.)

It is so nice to have the header also have 12 bytes, so it fits right into the
lookup table. So an alternative point of view:

  If a chunk needs to store more than 8 bytes, we'll have an offset after
  the first 4 bytes that describe the chunk, otherwise you can store the 8 bytes
  of information directly after the 4 bytes.
   "MIDX" is a special chunk and must come first (does it?) and only once
  as it contains the version number.

> +       The remaining data in the body is described one chunk at a time, and
> +       these chunks may be given in any order. Chunks are required unless
> +       otherwise specified.
> +
> +CHUNK DATA:
> +
> +       (This section intentionally left incomplete.)
> +
> +TRAILER:
> +
> +       H-byte HASH-checksum of all of the above.

This means we have to rehash the whole file for updating its contents.
okay.
