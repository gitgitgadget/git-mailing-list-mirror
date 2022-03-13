Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3673C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 17:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiCMRKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiCMRKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 13:10:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23640A24
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:09:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g19so12287836pfc.9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=KEZeIJiueZvvm9ibTyo9KdSengZcgoFFINpokveC0m4=;
        b=lLQU/L2QFmfBpY60LXxrrrj+dsAzTKhUIjLAB0Z6qy/OZXGX874nAnJu6v/BSdajav
         M7Rs92O3XWZ0QZ1+awdtF4s0SOa9DLX6VNgTSVshz/322Vuom45Jaz5OPaGZgsyCi5LF
         l3k42wrs0pjfeENI/KlDFh3ectCqSBsSetgAYrq84SblOWOi1EGbmEdr93FHefCwfoFF
         +JeGYGBStY7k0kZCgwPCK1n+UQP8YHY3/pLAb8f5FQ30xquP5ilxrAdHdQACvRPi+7vq
         0IltJY8BtQzZU7Z5cD4K9hgqulI+hRau40n5AatGQ/qgkd83eUiU/asxWCxiJNrIfiiR
         vR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=KEZeIJiueZvvm9ibTyo9KdSengZcgoFFINpokveC0m4=;
        b=kXzap6oB8cSuyVGGFGYolVpV08I3gX022RJglFMiMf5XoCV+FXUJ7F6Wo56meAuv3D
         RkPzWgrATDc/GAygNlzniOWoAd0UoE5RLaLlRutMgXEyrlhTFBcZW9MFF34evy+6L2qM
         r3HzU1ena8ggqc20g9zzZeugHzXkZxZj53mGmQBO+j185hmBwQ8CjEQOfCTGnhS1KrrB
         vu7aYE/zJ7lU8f8JbmG5OgA20K2qmfppOePTKL2INPbzDwZ/A5fFanXTKCrTLqoIFJc/
         Y5yfvAL4fFKB6nuo2O12s/v6diD6Or/2b3W5jgqrxLKn17S4XS48KLJM1syKIeqMlx8G
         T7gA==
X-Gm-Message-State: AOAM531wUjW1HV72jduqjRtspA5V9445F/Q2wBcjqWyvXkdVh5Kvs4fW
        W7url0266rY1QA083ulNmkE=
X-Google-Smtp-Source: ABdhPJxx4LaJEw7Fivo00Bs9etGLhg7DYmLh4Zj2VzVs/m8lzw03UQLNBuveCxiFCeZteQSchNA63w==
X-Received: by 2002:a65:4845:0:b0:325:c147:146d with SMTP id i5-20020a654845000000b00325c147146dmr17105737pgs.140.1647191348551;
        Sun, 13 Mar 2022 10:09:08 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id t190-20020a632dc7000000b003759f87f38csm13702873pgt.17.2022.03.13.10.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:09:08 -0700 (PDT)
Message-ID: <d7516e3e-b30a-ea77-3d84-131d704b9ed8@gmail.com>
Date:   Sun, 13 Mar 2022 22:39:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     jaydeepjd.8914@gmail.com, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] userdiff: add builtin diff driver for kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220312044832.718356-1-jaydeepjd.8914@gmail.com>
 <1f10cfa1-83b8-49b1-f4df-829cada788bd@kdbg.org>
 <634b6049-7b06-876d-499f-7aa5880a47f4@gmail.com>
In-Reply-To: <634b6049-7b06-876d-499f-7aa5880a47f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, since according to GSoC timeline, the current period is to
discuss application ideas with mentoring organizations, what should I
do next? 

I have seen the GSoC application ideas and integrating
the remaining git commands to work with sparse-index looks interesting.
Maybe I could start off with that?

Thanks,
Jaydeep.
