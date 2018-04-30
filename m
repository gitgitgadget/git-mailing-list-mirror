Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D531215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeD3Q3i (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:29:38 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:37272 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754713AbeD3Q3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:29:37 -0400
Received: by mail-oi0-f53.google.com with SMTP id f63-v6so7925752oic.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qP+KSYF8gZFRsUNjo6wYqX1OJl56A+YrHs7juGtY2RU=;
        b=KTqj3Zd9k7gceRrW61JCnSpAIKFucpluGM5IJObfC2XHFqIoHzFD6KHpGvfF+tjnIC
         vGNrMxwzaEeDvnAXAdhUDkdlzU/ymD+Qi6TeEGVAGghR1TucHJUOqkDZtFTo0pr0lZP1
         1Slder2XQk9wVBwp2h4x1WqfBlpSTLfuGkhGFN2av8hCE0+YgVzJwq0HysSVGx2GroTs
         PyyBwWIFKuZQEAcQozeuh4U701m/Jb/j++A8mu6RmsRQl1n/JX6xVfiPkuDNjcXlNTHq
         djYAru8LiriLpTasWTL2vfbJR8fXLAs0dP6hJrAaLOp8ErKSWKiNBuRZL5uAh0B5pS95
         lTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qP+KSYF8gZFRsUNjo6wYqX1OJl56A+YrHs7juGtY2RU=;
        b=CvshZfuxfrxfIvwj3CQtmaImoRBIPgyKungIPoiKese3QjQpi2BYd2PDhB7aXdPxh0
         L1AoEl4Nea3tI9iYaFGsjwd05fan+Hw+0Lx7cUMbaYF49jWgqpNT80Q7wzpNuG5TwTE0
         9XskaBtHfOuQBnWD8faiQx1zxOsfwoYJWNZkW6oYKiCJqIo3UePwsUomqV+0J6k3qKdI
         AYeepYQR9DQx3y+ZTsNwwRTHrm/9rOVacHzDq80wo97oxepas8lI25/Xsn9aatVBs8xy
         SNof38i2oPSjzB0yJ4xAei6HFWKHI6yc7xqPVvzxnOXknEFsH2o25AiY6pbNck878hia
         1/qA==
X-Gm-Message-State: ALQs6tCULkos9SKHPBAowaLF8lCCGThsvT0X2XhaReteWInZe7cJNuaw
        KmS14CV6iXqkjm4165UudrYbQn6lGVfPPB5Ss+s=
X-Google-Smtp-Source: AB8JxZpzWTI2mExtOB56lrNKFuk8/r1cOcTg+UuopBVMPvJAH4rqqfVuS6y6LSOc2Vk6jtcNt3W6cD/kUZ1c8RITvtM=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr7978418oib.32.1525105777353;
 Mon, 30 Apr 2018 09:29:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 09:29:06 -0700 (PDT)
In-Reply-To: <CABPp-BFsEPbTXq0cFE+gkXcXtP_1LOyQAUMMXBOdB16OJknDig@mail.gmail.com>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com>
 <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet> <CACsJy8Cqq5c1QC=2EjfajS3=+ofAF8eoFG2V4QeY+LzSykJOFw@mail.gmail.com>
 <CACsJy8DhDDzLCQNoAdc=F6jLUSJK=dDWhhqLBecGG5ru01gRCw@mail.gmail.com> <CABPp-BFsEPbTXq0cFE+gkXcXtP_1LOyQAUMMXBOdB16OJknDig@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 18:29:06 +0200
Message-ID: <CACsJy8CeDhrT9GXe9q5gqsAeq_sSQ8jyF2nMOFxzjwKtE31oPQ@mail.gmail.com>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 6:19 PM, Elijah Newren <newren@gmail.com> wrote:
> Hi Duy,
>
> On Mon, Apr 30, 2018 at 7:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Apr 30, 2018 at 4:42 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, Apr 29, 2018 at 10:53 PM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>> > @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>>> >                                                   WRITE_TREE_SILENT |
>>>>> >                                                   WRITE_TREE_REPAIR);
>>>>> >                 }
>>>>> > -               move_index_extensions(&o->result, o->dst_index);
>>>>> > +               move_index_extensions(&o->result, o->src_index);
>>>>>
>>>>> While this looks like the right thing to do on paper, I believe it's
>>>>> actually broken for a specific case of untracked cache. In short,
>>>>> please do not touch this line. I will send a patch to revert
>>>>> edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
>>>>> which essentially deletes this line, with proper explanation and
>>>>> perhaps a test if I could come up with one.
>>>>>
>>>>> When we update the index, we depend on the fact that all updates must
>>>>> invalidate the right untracked cache correctly. In this unpack
>>>>> operations, we start copying entries over from src to result. Since
>>>>> 'result' (at least from the beginning) does not have an untracked
>>>>> cache, it has nothing to invalidate when we copy entries over. By the
>>>>> time we have done preparing 'result', what's recorded in src's (or
>>>>> dst's for that matter) untracked cache may or may not apply to
>>>>> 'result'  index anymore. This copying only leads to more problems when
>>>>> untracked cache is used.
>>>>
>>>> Is there really no way to invalidate just individual entries?
>>>
>>> Grr.... the short answer is the current code (i.e. without Elijah's
>>> changes) works but in a twisted way. So you get to keep untracked
>>> cache in the end.
>>
>> GAAAHH.. it works _with_ Elijah's changes (since he made the change
>> from dst to src) not without (and no performance regression).
>
> So...is that an Acked-by for the patch

Yes, Acked-by: me.

> or does the "two wrong make a
> right, I guess" comment suggest that we should still drop the
> move_index_extensions change (essentially reverting to v1 of the PATCH
> as found at 20180421193736.12722-1-newren@gmail.com), and you'll fix
> things up further in a separate series?

I think I'll stay away from this file for a while. When I gather
enough courage, I'll need to read it through since it sounds like a
mine field.
-- 
Duy
