Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F1B1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGMUhh (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:37:37 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36145 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUhg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:37:36 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so13243900ybk.3
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaHPqy7OzLMJCSrpJfmdMCWQpR56z1R0fJtu84D1aoE=;
        b=kKZVctm1cdr9cISjAeY3d6Ppym/oTbl1csXfQNK2fVk1T5iKLvT9aTCR1iOpMWlb+k
         vAUDhAiYzg+zYJzqt2HJhYjAb3rGh/lS7q6djiKe6ZUHADvtxHvWqjRa+Cz/+lBniB/Q
         TbWCYJmmE9I67+jThl0hsOENyXuekVGoOKebNhPHcuUlavoz5xillbI9yeOJxGRnaS4F
         k20dCfI7wVBDAa1kexIwi2r6Gb0smmhQq5drTDjlF953vykYsJufg83Pf9OFuneRuRey
         DFxagzmMT2w9Qxu7dY3DdFuUXryQkO5HM1eAIzqoSbfPyzU613oDoAIIAwjOHMnKmoTD
         Z5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaHPqy7OzLMJCSrpJfmdMCWQpR56z1R0fJtu84D1aoE=;
        b=s5WMf+3ndJwnFLVIA6w2S7+kCE0w+YeE70qPZPGC7j9adlMyi3JwtqkR1FfKyLdwOC
         d0S4lWnb/s4XSzQME8PFbfsfiHRWaSXjemYCEz5Ua3+Id8BDqX0ALW4xdwONHC+zr/zm
         X1gRQsoVjVqAPmk4Qul0cACDQOLaKWxv+IwwZS+ufV6kuaF+MdZ8Oo+4x/mjU9M/64G5
         42iSyD4D+j/spVLfAKJ9YFj0LUAit5KGu7D1Htr9qqP8xNfNT5tYDtAcsRXY6TLL9DmA
         lPE5Vb8tNfx+vWAvYWlTHguE/zt8xTrkIf1zT2Z1Z+ESH4siXs98WsOF6srN5WkeLzBH
         CRpQ==
X-Gm-Message-State: AOUpUlG46LNX8RCG2YZCSyTxdx3sDPkubUw9o79ALDir2X6F26QM0mEs
        2LpAdKFeB8AgXaQkj8bd7fmu95F2C/lJTK7M04NnTA==
X-Google-Smtp-Source: AAOMgpd6WGOXD0bje0ZbfOI4iJ+iaKJasDNGoVjfIZO55rmbuqkkPfdpTjD7ykNcbAkNKIwwMwASWSU68+gEAG51yMI=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr4259937ybb.292.1531513286306;
 Fri, 13 Jul 2018 13:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180713193759.GB10354@sigill.intra.peff.net> <20180713193958.GB12162@sigill.intra.peff.net>
In-Reply-To: <20180713193958.GB12162@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jul 2018 13:21:15 -0700
Message-ID: <CAGZ79kY1+tH0foab-pjWp4pW_gBxi5tOD_yYPsu03Q5A2oLUag@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsck: downgrade gitmodulesParse default to "info"
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Considering both sets of arguments, it makes sense to loosen
> this check for now.
>

I agree with this reasoning,

>
> Signed-off-by: Jeff King <peff@peff.net>

This and the previous patch are
Reviewed-by: Stefan Beller <sbeller@google.com>
