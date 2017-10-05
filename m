Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298892036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdJEJnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:43:23 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:47538 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdJEJnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:43:22 -0400
Received: by mail-vk0-f54.google.com with SMTP id h63so7748972vka.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CNGgrwLaoMPWq8U3CwzH4K6+v8StxKAb8IbUqbmRmEw=;
        b=hhf57P+Skc3qGuCHJ4/K5/zMgan+PZCfNcuqTKw/kG+usU44Rbvmg1Zu0BSO6UXpHY
         39mDh6onSxOkoDRsFlN0VR7UOvSMJTvZ45jBcp6960qivbETMtN0WPXvoE9BpDXmIOzn
         qbeWgBSi7+Zxbx5bU+0a1IF/nWqlnuKyx9tr146i79u/r0GfON1eWbudECZALu7x/ddc
         SZX/wVns8pvKx3U4Ns5bsHV6X1JJL8HsPSSHhraIu9p+4TqGy5Ys3yDW60UFZbmgX9da
         oJ2b/NTDFPPG/KhrEzBTJsfIYOnZmrEukjFSN+s+SaXhqFxlXy2XKIDlHaeUigQybDH3
         kjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CNGgrwLaoMPWq8U3CwzH4K6+v8StxKAb8IbUqbmRmEw=;
        b=OV1+Ip5vzCQ3dA4DKMO3Db0BvBR/fzJi6sK9bItpkqfLohXJsKP4Ah17gC07JtUukH
         2pFu074hZR1zrlp63i2iIKsef0PJ+m7KcEFGC2VDZ2ePiiGBLiKwa/t0tQiS6PvaeJz5
         uubn/8+vyWoEXt262rJkLBEZLUiq7nu9sHfbpcwXhPjZUj/huGckgONM2ozvw0DxUz5w
         IyWD0QpzrwALh2zELJ7tSaaBrIsrPIwC1EuVJcrN4+uDwV2m0a02S9/RH73GYq/AtkNc
         MmaOji/SHd0hrPNZY8J2PQ+t2Dp4/X32jtX0+mpH0yh0vT/2N37RjocKDJxoXzYXkds6
         Wn+A==
X-Gm-Message-State: AHPjjUiYFvXBr3Gi4tvnBjy6sfo/GTBKCftsgdk5SpKleMUX6XRFmEOs
        QFvzoX+O5sLHysxvv8IzkNfTlV+u1X/skMI1uQQ=
X-Google-Smtp-Source: AOwi7QCzYhBpFWqxhfMuNMBNt2gC7sjsRNEyNHaMWUx+yL0GYxqXifHHE6OhUb7avl9PwvmyOor6P2x45+m0h2fyK+Y=
X-Received: by 10.31.214.71 with SMTP id n68mr13771119vkg.31.1507196601811;
 Thu, 05 Oct 2017 02:43:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.157 with HTTP; Thu, 5 Oct 2017 02:43:01 -0700 (PDT)
In-Reply-To: <20171005093052.3uefgby6a57udoqy@sigill.intra.peff.net>
References: <165c9648-e7f0-66de-b3b9-023c48c49d95@free.fr> <20171005093052.3uefgby6a57udoqy@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 5 Oct 2017 18:43:01 +0900
X-Google-Sender-Auth: nQNVq6ZuWHkOAFJXhLKE9_ICXUM
Message-ID: <CAPc5daX+N_Z6v-NxOb5cHh1V3Ctu7uQ+QFHzN9ATTQ22pVAfQw@mail.gmail.com>
Subject: Re: Quoted-printable support in git am
To:     Jeff King <peff@peff.net>
Cc:     Mason <slash.tmp@free.fr>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 6:30 PM, Jeff King <peff@peff.net> wrote:
>
>> The patch header contains:
>>
>> Content-Type: text/plain; charset=UTF-8; format=flowed
>> Content-Transfer-Encoding: quoted-printable
>
> That looks right. Though I wouldn't be surprised if whatever generated
> the "flowed" also screwed up patch whitespace.
> ...
> If it does have the qp bits decoded, then I'd suspect that maybe there's
> whitespace damage caused by the MUA.

I would be surprised if MUA that says format=flawed did _not_ mangle the patch.
