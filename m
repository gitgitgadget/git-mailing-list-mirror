Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiGUQ0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUQ0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:26:24 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054C88E00
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:26:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l3so1677228qkl.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K2qEBpe3pUomyWh1pSOGaZwehFbImH7cjAJ+PEbKkE8=;
        b=g2s4mzlQ8Ol8UNuGssQUe30G0AJ4Fax+J2UuuPa56cWoIAsUo7FTntQLtMPrgZVEEQ
         EJEmgC6cpIeQfAnC3vcbzUDo4fOolap/af93I15nYnKyrzqAF4LsCGMXDPn8teficr9u
         9sCsj39sBD5h3xK7kfwUYKV2fuVM6nfbiNAtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K2qEBpe3pUomyWh1pSOGaZwehFbImH7cjAJ+PEbKkE8=;
        b=BBnYK0m+hlvP/D9sw0+QvOdumGatVYmlMIjsuvXQTcoDHORGwyu3gAdrCGANMOUTBP
         UaaECntyQc/gRG1FUG2AGv83V3tz9j3Y/NMlJDUaO+Mrqxo+lZ4FKZEn3uZ0aX4zZiig
         1Z2yzM+th1mTozRBO05nUqYla85AuTFjI+u6CpohQwdMYsktWK/yQfNkdx/EPiMuhlpA
         9qwjpLz6PZQyFGR0pFKOe4OTqFK5pDHVMbcCSHrUYsLHFv+w17qtWVdzC3l05BKwa36b
         HvzFQyA7kcaaDeKw7TwrOPYv1oQgq+00bRd2hOwWaNNEQU8S+Bl9rWVkZwf9Urs5lvfM
         wH0w==
X-Gm-Message-State: AJIora95Rm+TB0FQx4UHJajxGHTvEFA3tK0LcjNkD1hY/jZ5jWIJeKN0
        Dq3tubZcaJWbi5k7/8lYbSMEhMMTohmvJw==
X-Google-Smtp-Source: AGRyM1u9TPZAn7h5xz/5ypkWNQOIWQQfrzxTOLK2O0VOPAz2oZTwflWaqtDWu6THP3NMkOnGu+Vlwg==
X-Received: by 2002:a05:620a:4043:b0:6b5:f695:69cc with SMTP id i3-20020a05620a404300b006b5f69569ccmr12702370qko.31.1658420782727;
        Thu, 21 Jul 2022 09:26:22 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id d21-20020ac85ad5000000b0031ea1ad6c5asm1583613qtd.75.2022.07.21.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:26:22 -0700 (PDT)
Date:   Thu, 21 Jul 2022 12:26:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <20220721162620.f5ffcedkbvvdhhu7@meerkat.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 04:53:18PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I tried now with "git rebase --rebase-merges -i", and it supports it
> properly, i.e. I could re-arrange it so that it's:
> 
>               A---C---B---M topic
>              / \         /
>         X---Y   ---------
>              \
>               master

This is clever, but it has a hard restriction that nothing happens to A:

- you can't move it so it's B---A---C---M
- you can't squash A+B

Unless all the tools are taught to properly modify the merge commit.

Or am I not reading this right?

-K
