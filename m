Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C051F51C
	for <e@80x24.org>; Wed, 30 May 2018 10:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeE3KTi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 06:19:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40519 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeE3KTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 06:19:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so10814445plo.7
        for <git@vger.kernel.org>; Wed, 30 May 2018 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AGeUQtyZi3FgCjjIISQTnAYs2tegJpkk7vJkQljM1BY=;
        b=W5XOl8yADk8zKyVLN9fh1KjG+h8NP/xT8FwwDMh9MzLlWFDh/zpSrMrY5XDw0UKmX3
         APeeTd+t+B6/dGPY2BvlVueauKW4YAcnSvjBYGoZknn6HgW9KpsndAIllLUMbXJ9Ll0G
         rzeEWqCF7xVAMe0SZCnvr9TYWuZwRdjULcGzK8k2mGnE8wvvYnc+79IKtmc+97vT0Om+
         6UzcIv7N19MxoaGuxRMYJ3AgnJai6/876DwFTWnk9VWVFAAwyKGNYLZBiYsFDVE2EYzL
         hjKVPCUc8NMqH26j+W3Kq68SlweI0iRLdMoTZlcKjMlPXdf2kvMCv8DAiMKZMnyh1E09
         V/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AGeUQtyZi3FgCjjIISQTnAYs2tegJpkk7vJkQljM1BY=;
        b=dY4EA4eDgWwsY8+afjcWqg1Vy3DKhlq7j3nmEbwLzH4sTwx/G3aGqQVHNuw7UzbQqS
         0MMz7Jy7IIFuufZeIjBdDogMgVWDxSwaAq21nm3rKvqRqcgKxYIKqs/VryILF6pnTkmB
         JwpfQDyAcrpTCbCgL2PINYaFG9QzTo3H/pLuePx4vlD2JrZzxBMwbC7jbYQNInvUgfyE
         NdWmJVk029e65Llu7LWDLlaM/rPpRDMBaRHnLV4901zKnOstAdXRSA8v3zMK4tJQPpj6
         Yfv+F3T5YESJM4RBKKCLUmIniBGxEmdgU5t3+DGvI3VXAJ86vATcEojDgrWkHoKpAB7R
         wgAw==
X-Gm-Message-State: ALKqPwftvYtxKniR3ikyG+0ugIGtmabxAN+S+CHAKSvFYyinteCsMuGB
        fTKwuCuQvs6r35tZTtO5H6jgRDBlqBNI02jnoPA=
X-Google-Smtp-Source: ADUXVKLTji56YuGdq4dDBsNmTv2X7Ex6iNOziMjJqvnfeuX5kIu4S6JxmQANLiimwaGGXoxF1RxIIyqLU9pz7Nejy+s=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr2300469pls.321.1527675577288;
 Wed, 30 May 2018 03:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Wed, 30 May 2018 03:19:36
 -0700 (PDT)
In-Reply-To: <CACsJy8C-BT158DW_Tz24ea_QUfQHQpToCC-=E+-zZeZeAD9heQ@mail.gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com> <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
 <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com> <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
 <CACsJy8C-BT158DW_Tz24ea_QUfQHQpToCC-=E+-zZeZeAD9heQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 May 2018 12:19:36 +0200
Message-ID: <CAN0heSoeuSDyeJ0sFgYo689AaHfj4q0SC5bJt4cpv2TeQX5uVA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 May 2018 at 17:50, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 29, 2018 at 6:49 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> On 28 May 2018 at 23:45, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>>>> +error:       sub/added
>>>>>> +error:       sub/addedtoo
>>>>>> +error: Please move or remove them before you switch branches.
>>>>>>  Aborting
>>>>>>  EOF
>>>>>
>>>>> This shows the typical effect of this series, which (I subjectively
>>>>> think) gives us a more pleasant end-user experience.
>>>>
>>>> Also, very subjectively, I'm torn about this. To me, just one
>>>> "error/warning/fatal" at the start of the first paragraph feels much
>>>> better. If we have to somehow mark the second paragraph that "this is
>>>> also part of the error message" then it's probably better to rephrase.
>>
>> Would you feel the same about "hint: "? We already do prefix all the
>> lines there. It seems to we we should probably do the same for "hint: "
>> as for "warning: ", whatever we decide is right.
>
> It may depend on context. Let's look at the commit that introduces
> this "hint:" prefix, 38ef61cfde (advice: Introduce
> error_resolve_conflict - 2011-08-04). The example in the commit
> message shows the hint paragraph sandwiched by an error and a fatal
> one:
>
>       error: 'commit' is not possible because you have unmerged files.
>       hint: Fix them up in the work tree ...
>       hint: ...
>       fatal: Exiting because of an unresolved conflict.
>
> I think in this case (dense paragraphs of different message types) yes
> it might make sense to prefix lines with "hint:". But when there's
> only one type of message like the "error" part quoted at the top, it
> feels too verbose to have error: prefix everywhere.

Hmm, that's interesting. Deciding based on what has already been output
seems feasible, although it sounds like the potential target of infinite
tweaking of some central logic for deciding which way to go. Or, lots of
various places to try and make consistent. I am tempted towards
indenting with spaces in v2, and to leave "hint: " alone as an outlier.
(It always was one. :-/ ) I'll keep your feedback in mind.

Thanks,
Martin
