Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF9B1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeFLVfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:35:24 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50618 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933518AbeFLVfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:35:23 -0400
Received: by mail-wm0-f44.google.com with SMTP id e16-v6so1271290wmd.0
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WoVBkF/DgNxXTLTPi/Y4xRbVOLo2lXAKhQxksjBuLeA=;
        b=bpHQpFJyhBejYqV0VZpzR+pZgCsokahyc4g2cdpEXFzx/qnAoI9aRxX1644urGOWsP
         dhsYOe0O2G25NvUwArTS8sVKYZQYRr/Tn44yNW/1Ao4T3A2ylg7AHtKjN/fZ/VKvcBlD
         6WBMLMfp3N7XTXyotzunxRMkSLo/aD4guVrer3/LhwzZ9r9zbrtGnOg9rs2Y+uhEhFjd
         //ge/HO+gqIWvdyeRRT3+fITeQGrcMN786xXEBPhECzMTy1Q8a6IUCscZ3Bqan/qz4O+
         JWTqq6bZd8k71FQxlT80NNoAgb64K8ngUI9CwLo/5KuzGBh1S3rYnARTqj6ShIGegM1L
         Vhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WoVBkF/DgNxXTLTPi/Y4xRbVOLo2lXAKhQxksjBuLeA=;
        b=dqR2yayo/OE6UWayk27aKzEce8cs35bQ91UuPEESRUcr512gM5SfGb3OEw+Bj41TLp
         AURouWWGqND0nsQlK8SA+0tFe07ZbhwhL9IZjH+D40cUSs98bDL0Cmm9SZgVum1F0lF/
         uTWnTmQes2ahnomYzCvDltgIMX7yRk26NklSpWdxSlAHCjiUwxkZeYIOc2WStpazjWkh
         bHZJqB/ebw9cYTdKaxvjaNmTpBk8XD5h8Jm1mh9sc+ysQ+mXrmMTsPxX/j4oL3OMbOHI
         oQQ0zAhAfpkpT+vmzOjyWywHFnNHk4Lh2P7vY0A9QCixLuQ5uny6zSoPbnimOEcpbCSg
         Tpug==
X-Gm-Message-State: APt69E2wxlhPYO4wuU7S4gQBs4JcCuc8czblyRxK6rFW2kRuY16SIEI6
        B6YjNX9LoXSQGYfDhbjEN/Q=
X-Google-Smtp-Source: ADUXVKJ6YfWuxquVZVB7d0iXulMQ9ucOolT2adusxMI7qdAXRibvATiT1zDwOh/liCmTRYJYcU/s4A==
X-Received: by 2002:a1c:d543:: with SMTP id m64-v6mr1600973wmg.12.1528839321575;
        Tue, 12 Jun 2018 14:35:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s3-v6sm631810wrp.76.2018.06.12.14.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:35:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Merland Romain <merlorom@yahoo.fr>,
        Git Users <git@vger.kernel.org>,
        Eric Scouten <eric@scouten.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Subject: Re: [PATCHv2 0/6] git-p4: some small fixes updated
References: <20180608203248.16311-1-luke@diamand.org>
        <xmqqo9gg9bi3.fsf@gitster-ct.c.googlers.com>
        <CAE5ih7_ZDzg9h8BEGDWyg_jBG1rj=_eW1Kg7JO7oKiF6Q2+37w@mail.gmail.com>
Date:   Tue, 12 Jun 2018 14:35:19 -0700
In-Reply-To: <CAE5ih7_ZDzg9h8BEGDWyg_jBG1rj=_eW1Kg7JO7oKiF6Q2+37w@mail.gmail.com>
        (Luke Diamand's message of "Tue, 12 Jun 2018 22:24:38 +0100")
Message-ID: <xmqq7en38z8o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> On 12 June 2018 at 18:10, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>> This is an updated version of the set of changes I posted recently,
>>> following comments on the list:
>>>
>>> disable automatic sync after git-p4 submit:
>>>     https://marc.info/?l=git&m=152818734814838&w=2
>>>
>>> better handling of being logged out by Perforce:
>>>    https://marc.info/?l=git&m=152818893815326&w=2
>>>
>>> adapt the block size automatically on git-p4 submit:
>>>    https://marc.info/?l=git&m=152819004315688&w=2
>>>
>>> - Spelling corrections (Eric)
>>> - Improved comments (Eric)
>>> - Exception class hierarchy fix (Merland)
>>> - test simplification (Eric)
>>>
>>
>> That reminds me of one thing.
>>
>> This 6-patch series depends on the rm/p4-submit-with-commit-option
>> that came without and still waiting for a sign-off by the original
>> author.  Also I do not think the original patch reached the public
>> list, so I'm attaching the patch to make sure people know which
>> patch I am talking about.
>>
>> Romain, can we get your sign-off on the patch you sent earlier?
>
> Wasn't it already sent in this message:
>
> https://marc.info/?l=git&m=152783923418317&w=2
>
> Luke


Thanks for a pointer.  Will replace and requeue.

