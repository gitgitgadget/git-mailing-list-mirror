Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95B9C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 19:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiEYT7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbiEYT72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 15:59:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6B28718
        for <git@vger.kernel.org>; Wed, 25 May 2022 12:59:27 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j6so1166709ilk.11
        for <git@vger.kernel.org>; Wed, 25 May 2022 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=84/GEavKSPBmYsw66aWALkZmDs3rPiQAKxmORaD0YsE=;
        b=SSVl32AgZ3lOTrtI9dfHM6/kX2yEFrSmo+OUdVCN8h+5/Tp+wU7PSrvqzJkMD787mp
         h896nDduKVC4wSwcDefgZ1OCseiQfP76lu+nWzki2KRKS/vXEE1hT21nB+jOMphFSl/i
         1WAyPYz9ePHmDkTnaqilmN1gXohVHwVcVhbs8P2aYGs1/888XI05pVbwq4O00/yDrqYi
         mNPviEZlcoYEj96JexmNt13BGfXkwGzvpVGSDW37o6OJxBJQMc/R/Wt7R5dX1mUnL2ly
         qGzFbW0Jx7ESmkCh6DLrClPD/SibRKOGeUmhT9wHzKB2E27ATTap2VQeCYazzkAYJwuP
         sreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=84/GEavKSPBmYsw66aWALkZmDs3rPiQAKxmORaD0YsE=;
        b=p6V7D82kkPVlR9OCZVZet0bKtUsngKeQfT4rtv6vTsLdvs4A1oGq/ItpAS0hTho6X4
         oWYp1VykmcwwUjEmriseJeTI3FiMYhLvsS2HrC41YpOff8oIX/Kyyz/1g2RNgv2PbRX+
         aOLmTaWocPdtSZAOx66M8sfjb3zeSUo6ykmUbDxdIVSRPBg+k8wACRKHRWXbkNc2CI4i
         ZQvhDl5e2l0x5x+ixzB5q2YgC5JLP9+bYRJM5/iC+6M7wuhXUVIJE34/eY2xBzMPJQEC
         jXvvH9cYltTcfqB0KGNhTQQJreMwmPkx4l1etVovb1eXThZM3B0PPbsIFM5UugxbT7fT
         J7zA==
X-Gm-Message-State: AOAM530PrAY3iQmzMr8UfP0r6Xt1ghchUNBTCwcr2DaGDmflb8Ko36ba
        KYuYXRPvsCSH2WfhQGxwX25E
X-Google-Smtp-Source: ABdhPJzJ8Y57wGOJONYseCkLTj05Tdd6qe4GUlNzHtp6+n4s9Sg+DnGkwwyLLwmjJd01Ln3QzBBB+g==
X-Received: by 2002:a05:6e02:18cc:b0:2d1:8475:2f50 with SMTP id s12-20020a056e0218cc00b002d184752f50mr13597860ilu.91.1653508766914;
        Wed, 25 May 2022 12:59:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fc7b:47ed:5937:b714? ([2600:1700:e72:80a0:fc7b:47ed:5937:b714])
        by smtp.gmail.com with ESMTPSA id z3-20020a05660229c300b0065a47e16f4esm4555185ioq.32.2022.05.25.12.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:59:26 -0700 (PDT)
Message-ID: <7f5a6a6a-c554-c659-72a8-404bc39e08c7@github.com>
Date:   Wed, 25 May 2022 15:59:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 00/17] cruft packs
Content-Language: en-US
To:     Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com> <Yo00X0NEu8N0MnZV@google.com>
 <Yo1TIQqvlxhvLZ58@nand.local> <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
 <Yo1YZM2dI6t+RsWv@nand.local> <Yo3gl5Wv82mTZQb2@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yo3gl5Wv82mTZQb2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/25/2022 3:53 AM, Jonathan Nieder wrote:
> Taylor Blau wrote:
>> On Tue, May 24, 2022 at 11:55:02PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>>>> Moreover, I can't seem to find any formats that _don't_ use that
>>>> convention.
>>>
>>> It's used in the reftable format.

The use in reftable is the only one I can find and that implementation
is not idiomatic. Specifically, the way the four-byte header was
implemented is not easy to extract and share in other formats.

This series does the good work of extracting oid_version() as a
common method across these formats so it is easier to share.

> It's also used in the formats described in
> Documentation/technical/hash-function-transition.

It documents things that have not been implemented, such as the v3
pack-index format:

  Pack index (.idx) files use a new v3 format that supports multiple
  hash functions. They have the following format (all integers are in
  network byte order):
(...)
  * 4-byte number of object formats in this pack index: 2
  * For each object format:
    ** 4-byte format identifier (e.g., 'sha1' for SHA-1)
    ** 4-byte length in bytes of shortened object names. This is the
      shortest possible length needed to make names in the shortened
      object name table unambiguous.
    ** 4-byte integer, recording where tables relating to this format
      are stored in this index file, as an offset from the beginning.

This was added in your 752414ae431 (technical doc: add a design doc
for hash function transition, 2017-09-27), but has not been acted upon
yet.

> [...]
>> Sounds good. Unless others have a very strong opinion, let's leave it as
>> is.
> 
> File formats are one of those things where a little time early can save
> a lot of work later.  If there were a strong reason to use "1" and "2"
> here then I'd be okay with living with it --- I'm a pragmatic person.
> But in general, using the magic numbers instead of a sequential value is
> really helpful both in making the file formats more self-explanatory and
> in making it possible to experiment with multiple new hash_algos at the
> same time.
> 
> The main argument I'm hearing for using "1" and "2" is "because some
> other formats got that wrong".  That reason is the opposite of
> compelling to me: it makes me suspect that as a project we should more
> eagerly break the old bad habits and form new ones.  I guess this
> qualifies as a very strong opinion.

Either way, these are magic numbers. One happens to somewhat spell
out something when looking at the file in a hex editor with ASCII
previews, but that doesn't change the fact that it is most important
that the hash function is correctly indicated by the file format and
parsed by the Git executable (not a human).

I'd much rather have a consistent and proven way of specifying the
hash value (using the oid_version() helper) than to try and make a
new mechanism.

Thanks,
-Stolee
