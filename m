Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE776C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD54C611CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFQIIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQIID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 04:08:03 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F38C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 01:05:56 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so4696931ils.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25lbsp6AZIb1L+eTLOsXFcF1MxXz57Os3SJULZ6S6g8=;
        b=CvAwRtruBctpB7HRtgUM5bfxtoj2zTdl51pH4sw3KASgKyKEOv1OrCkKimYArT/cNO
         +Zj940LtregVrmEyMBCkfDJXUrGPs5b19TGnJnNLw4xhc47GoMFYeTIttrYaRQtyQtp4
         nnr2mFdGoxJxPkchrZcgZTOdLi9vKkcsgH7HApzg9l1N/MxtSA000t0tMsJdAyj1cy5D
         fj/fg9MFlDtn+RKp47WLNmrq7Pzr7ywjuSeYmFYvP2hoQ+5l1I+XCgYl/+ETbsIWY36G
         YIWLRhJrS95rFDkwqxtafj2NFwHZ4c5jRSrdqUxPbtPQkO56XuBNAiNoXprgJcEqwzaf
         Qj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25lbsp6AZIb1L+eTLOsXFcF1MxXz57Os3SJULZ6S6g8=;
        b=HTHMYBHpCyeimpeqW1Ajusgafl40A7yPWtn7MPNzwIy8my+KtAnVXqK2aExQ537cdY
         Kt9Y2uQwPqBES0VNFLy4vlEWfXUsLI/2RV0Si6r2CtzkJvVV4I4InF3L5Ui/o0a3b0jf
         obLUrMsdNzjzzYubtOHxSbvDwH6K30ZReH+oVxQ98Js5DH5C7DLPt5Om8SsNU3rp7zqS
         WkCXiggo1/Sial/chHpBIWQzDoe7WZSdKbLszyNwf24nCZ5wNmzFO6IxyiRqUTog7eaf
         MnMI8zVQmejjhI1BSDNtFJkAWKEE+9WLDW53Z6TycEf6iPdTPEsZc1GHe8/SkxrJj6dC
         pdow==
X-Gm-Message-State: AOAM533g00OitgY1BPebNnsyw4O6VJOc3/wjrvrThhNZkHJJw7G/RqDa
        9CpjdJqY7vDpOSsvt0FvCovITDl62KTPAFiIjcU=
X-Google-Smtp-Source: ABdhPJzjebUQbsEbYBuk+hxKK2e4NDzEWtVOqRRP7lv5Vjz/D8kXXVEGQCmR7g2BBvTwoUUvFHCxSihOneRUI7J48LI=
X-Received: by 2002:a05:6e02:1486:: with SMTP id n6mr2642656ilk.174.1623917155748;
 Thu, 17 Jun 2021 01:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <d31059c391d0c3f40ba45be0803a5ac6d49d5c6f.1623496458.git.gitgitgadget@gmail.com>
 <8735thx8nn.fsf@evledraar.gmail.com>
In-Reply-To: <8735thx8nn.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 16:05:44 +0800
Message-ID: <CAOLTT8RQDzE=-8VXRQr2-R1m7G11bTUm-Mz+4WHGXJtNNF1dOg@mail.gmail.com>
Subject: Re: [PATCH 7/8] [GSOC] cat-file: reuse err buf in batch_objet_write()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:17=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
>
>
> On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:
>
> Subject: s/objet/object/

OK.

--
ZheNing Hu
