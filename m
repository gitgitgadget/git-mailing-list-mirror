Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD861F403
	for <e@80x24.org>; Fri,  8 Jun 2018 21:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeFHV6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 17:58:03 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38156 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeFHV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 17:58:02 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so9108849vkb.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRGUCwgWXt5G/cyZVz2vf2cstViJd8w10vzUqWKXvKw=;
        b=l1+kmMUJAZsgQSlMhZLEoFXcXf44cN+rqdggdjYIBFg6LNgNaQxzLAFhl9hza6D/tw
         NuzUCyTK+BV0pZ9XlOUE7w9CzxC5TWsw/DNhRskttgVb8uirmwiMhmJVAONR9/leknhU
         sPxaJFWtZ/aLnX9zUiywRZpXW8FjMzEg7WBSzteeykCg4mmoLOQXzRvFq1kMr7vu1YEd
         R8ie1V43jKbUpBNPotNiTHXHprblNNjwzTpGN2LouXoeKHMgDm9uZ4D5PjMgY6s8RdBn
         J+aXSLs0AcQxpkvot5KrWRh7Xv+CJT7TWSKC3ORa9YP+/cg9qp1zEFa6pJVa7f2zWKkz
         gcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRGUCwgWXt5G/cyZVz2vf2cstViJd8w10vzUqWKXvKw=;
        b=DWpyspKO8MTySGlVDpiyj/4wfcPO6RV5kS+c0wcl+rQLTr2plxvW3AFvxd43Tx3usr
         arIl3otD7IZ2LJai8l/ya3Ryx5GwGsCcrT8lNW76Z1EYOYA5Aj/RQLqpL1VJL4V4hvP9
         JWney6ncUpuxC5RXvp5EQeWmlruZGOfmGi5TZPlg5rx8ZoFbheaKZ/CcVit96COwDYg0
         GEtSQODN8g2fhDEmCj3bc/qaJrqaG4ZZlNgrHkptPotK4m0Lqgr8ahUtz2Afj+8AGh6g
         n8GhX232qB51IqiKgUUh5A7wtzgH6nVndcWzgy1dkUXyKgvOTnPO3zaTD1OFwCJL/STE
         +w0g==
X-Gm-Message-State: APt69E3TjqO91rLmtH0lHgMM7lhDvzcaMquAHl9u7xZ7dgwy37T83D4/
        JDxR1jsec5K9/6JqyzNRICKZlRDEILloFKoIIsk=
X-Google-Smtp-Source: ADUXVKLISfYpBY+GcfR3KZW6U9rqQItrY5vLy7b78x06UoEXtMJ/iEOtp6E1yHu/l7aYBxD3bmj40i2Joawh7oND/w8=
X-Received: by 2002:a1f:2282:: with SMTP id i124-v6mr5275770vki.48.1528495082171;
 Fri, 08 Jun 2018 14:58:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 14:58:01 -0700 (PDT)
In-Reply-To: <20180608215207.GB42503@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com> <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180608212348.GA42503@aiede.svl.corp.google.com> <CAM0VKjkWkUmU9LGyKKFyvkOCFh1s+JJK4aZLPfoOJj26OkNQVg@mail.gmail.com>
 <20180608215207.GB42503@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 8 Jun 2018 23:58:01 +0200
Message-ID: <CAM0VKjnJbHA8BXC_prSAj1QoNC2fDRX4WKmse028g9J1XZX+Qg@mail.gmail.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 8, 2018 at 11:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> SZEDER G=C3=A1bor wrote:
>> On Fri, Jun 8, 2018 at 11:23 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>
>>>> +   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then
>>>
>>> Needs a - before the } to avoid errors in a shell where the user has
>>> chosen to use "set -u".  See v1.7.4-rc0~159 (completion: fix zsh check
>>> under bash with 'set -u', 2010-10-27) for more details.
>>
>> Right...  I did remember that, but by the time I finished typing out
>> that long variable name I forgot about it... :)
>>
>> However, I'm not sure it's worth caring about, because the
>> bash-competion scripts don't work with 'set -u' anyway...
>
> I'd be happy to see these '-'s go away (it would make the code both
> easier to read and easier to maintain), but as a post-2.18 topic,
> please.

Of course.

> Alternatively, if there's a real need for them, I'd be happy to see
> the completion tests start using 'set -u'.

Our test harness doesn't work with 'set -u' at all...
