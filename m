Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1DE1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 13:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756279AbeARNhE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 08:37:04 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44006 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755874AbeARNhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 08:37:03 -0500
Received: by mail-oi0-f68.google.com with SMTP id t16so15658668oif.10
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 05:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y08kT30KiAYCsy0RPs3/yZ7EV5CiIEynqMSgKcziRP4=;
        b=YFwSqAv4C0SLivpDPwcvEMQ7LMvTEum7Z9AyRj4LuNRuBWlfK5o68kme8GT7UVLVpc
         3uUJjNtvtKLnk5EkjmehstDLMZnkZQFUq8WK1gvdKZUWtgH35Uy9XRFAu4ikzUkh5xxX
         pUzd90/BFSwpKFcb8p/YFTimfGvBJMgMzBq37I/APMtDEQReiNY1Dpmpc1bCEImg4I9j
         9U3avemIBRTH1X6E95KAG6MlXQPx/9rCtzGgQ0itmtJQzhCqwuwLC4pEyJ9b4MMdpxQm
         QudxUQp2Ymr2rjLKR6zyIIH/+kqaKy5IVjIsV0rYGXJD1AAyNzOpWb4eFwYQRTfOCsrf
         lHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y08kT30KiAYCsy0RPs3/yZ7EV5CiIEynqMSgKcziRP4=;
        b=jOCE+TfO3pcvsZbZrDRwB3F+nJZdVF0RS/nTJuLzsG4nZE8MHqaDj8VMluin1dfU3x
         z47roVb0pOkZwTOn3e1pfOMS9fSfw3SeH3wxhLiW70DRYspx4krJHHSTtlLZsgL9cGFB
         X/lYrtoRbkE1CBATHwYAq07vpt/h9Lw3x1S5TP4Zo+TWkgj0PXAZzRSB9XSPEnY80IRf
         wzZKNbV+HMOwlI/W74ckF/iFeyMXrancgePsiXakcooGw7RG0afaUsytgDguyB4Zj5gX
         /R+wxW/TMBrMNnrWnpgfLtSkp3PEsw0X0XNvGajhUF4W32Sr1ruJChNytcxlFkR74cnt
         QsYA==
X-Gm-Message-State: AKwxytciUFIN8Ks9A++uQ+fWutucMQ6zFmxYsZMDrgytVSc+jzMS1joF
        cs+pJ4VKLcKfkRWOrgvaMP+tJeW+9qiEz5SMLjY=
X-Google-Smtp-Source: ACJfBovl2fIG+r4Zdgci/9NDcaLGQAy3J0++A5PCvTwdYYq3xWt2JuE2SIMXXj2y3iypD8XHvUJtX8EVt6jyR1w4msU=
X-Received: by 10.202.60.134 with SMTP id j128mr3267438oia.268.1516282622843;
 Thu, 18 Jan 2018 05:37:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 05:36:32 -0800 (PST)
In-Reply-To: <20180118132931.GA21914@sigill.intra.peff.net>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com> <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
 <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com> <20180118132931.GA21914@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Jan 2018 20:36:32 +0700
Message-ID: <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 8:29 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 18, 2018 at 07:47:50PM +0700, Duy Nguyen wrote:
>
>> I may need help getting that log (or even better the trash directory
>> of t1700). I tried -m32 build, then valgrind on amd64 (because it
>> didn't work with my 32 build), running the tests with dash and even
>> the linux32 docker version that comes with "ci" directory. Everything
>> worked for me.
>
> It fails for me locally if I run it in the linux32 docker environment.
> Here's the end of the "-v -x" output:
>
>   + GIT_INDEX_FILE=/usr/src/git/t/trash directory.t1700-split-index/new-index git -C ro update-index --split-index
>   + chmod -R u+w ro
>   + rm ro/.git/sharedindex.bbdf63f5a51242904dba2ea929ea4f56fcc340b6
>   + GIT_INDEX_FILE=new-index git ls-files
>   fatal: .git/sharedindex.bbdf63f5a51242904dba2ea929ea4f56fcc340b6: index file open failed: No such file or directory
>   error: last command exited with $?=128
>   not ok 23 - graceful handling splitting index is not allowed
>
> I don't know if the trash state will be helpful, but it's attached.

Thanks. Somehow my way of forcing mks_tempfile() to fail, well..
failed in this environment. I see the same output if I remove "chmod
-R u-w ro". I think I have enough to continue from here.
-- 
Duy
