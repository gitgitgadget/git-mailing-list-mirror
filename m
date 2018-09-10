Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9461F404
	for <e@80x24.org>; Mon, 10 Sep 2018 22:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIKDfP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 23:35:15 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43662 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeIKDfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 23:35:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id k5-v6so8603445ybo.10
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FELCXtrglbj7Srn1c1YcEnV/TTOgSnJ7zjdxeGBcFsw=;
        b=p695txtfmhLsIKvSyP5jPpU/Qsv1Du97pSIvOPWWa9i3W2Efevb6CzUsiTMFg7Cb1z
         6q8P2VmGMBDq+XNW6xW1nBopTxFm30vaOW9MLi1iAjLkdGSTpcFS0SBB/snEEtSlbshT
         Qx7kMDjs/N8jCVCChFDu3PJPi2QnS1gnSK2F4Bvo8nDw++c1a+eMbBJb5FJ7JbJuW40e
         pIG6OzryJA6Hle06AZBEulQqE22BMueHzRb7nfhTfdi3DwbreCXgQUoNZ6rzHaGRQK0W
         vylmei//8hQ58D03tHXmlW8zte2JbZkC6BuZbkBHh9Blc5yaduGHPiQ0itrIUGzMaX/0
         GDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FELCXtrglbj7Srn1c1YcEnV/TTOgSnJ7zjdxeGBcFsw=;
        b=JNSlclvTIOFNh65WdWnc0lm/xrnsIeeM4bhBwdmkfRV16VMrSl+ciVL975Oq1fgjxv
         OyczCHoj/txIYbvUUXBR1eM/x7rfih2IoC50Q9S1gbcpsZJOVpD5Lw7WQ3aM1OBH5hg/
         R4W64vlGTs1BlXoE5qmg1YOh1bVZAN3Zti1vjhZesXFgv1R/AcRDmFAT3g/+JTsMfY4d
         ZGdpZ9NXZlIkfudjqYSwkzmm5kahKJ634ViuSlWFnMNlctgreQEENtxlGHE7zwyvyeS/
         wr/DfgVWu2i+yfDpUP3GMIlxdb07UCTQqOOrUaGjFTRf2BpDoeyFY2V38hKiU9p7nblM
         UKtQ==
X-Gm-Message-State: APzg51A6EITM6IhIRbBpuY4D5pBgndrDicn35Okvxq8ykvrlrxMB/cub
        7fstez94rXUAG5aYxYCRDuHybqQnhEUx44OrsUcipw==
X-Google-Smtp-Source: ANB0VdY9ylxSWfde7YeKEn2A8R9PbVIFadB2vF2sruuepq8Lfp/ib+TNqsGkXQdAXgc2U598QCA10QXXGzhdTBCY068=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr1843518ybl.521.1536619140438;
 Mon, 10 Sep 2018 15:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
 <20180910215831.17608-1-sbeller@google.com> <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 15:38:49 -0700
Message-ID: <CAGZ79kY2XpB4nJOJc0LLueqsutpncgwdN8uC=Wj0Uxu9Yjgd8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] trace: add trace_print_string_list_key
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 3:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > I separated this from the other series, making it into 2 patches:
> > This first patch adds tracing for string lists and the next patch that
> > removes the unused function from the string list API.
> > That way we can decide on these two patches separately if needed.
>
> Of course, even though these are 1/2 and 2/2, only one of them and
> not both would apply.

Or you could squash them once we reach consensus that both are good.

> Thanks for sticking to the topic.
>
> Given how simple that "dump them to standard output" code is, I am
> inclined to say that anybody who needs to inspect the contents of
> string list at various points in the code under development can
> create one from scratch even if we did not have this implementation,
> so perhaps 2/2 is a better choice between the two.

This sounds like the consensus is not to take both but only 2/2,
which I'd be happy with, too.

> It is not costing us much to leave it in the code.  It's not like
> the function costed a lot of maintenance burden since it was added
> in 8fd2cb40 ("Extract helper bits from c-merge-recursive work",
> 2006-07-25), so the alternative #3 might be to do nothing.

True, but ...

> somebody else in the future to propose removing

is what is actually happening here already, see

https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/

> I am inclined to say we'd take
> 2/2 ;-)
>
> Thanks.

Feel free to take Alexanders patch from 2015 instead.

Thanks,
Stefan
