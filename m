Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C471F404
	for <e@80x24.org>; Wed, 28 Mar 2018 21:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeC1Vhe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 17:37:34 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35863 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeC1Vhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 17:37:33 -0400
Received: by mail-yw0-f176.google.com with SMTP id y64so1308310ywa.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5X2Y/BsD3JVBSOkTAw+9WbtQHVOIT5vuIM4B+UIqo9Q=;
        b=QcnhON80JpflTEcrjbuSAJSQ5DleOgvOJIaIsfLREaGv9bxmIKBp2dgD+WUidDAwa8
         MYhAMxI080qRm1scTqlbUQOJOJy2UsK161d4gOUShbAfULtMKXoZU+7CWtmcNHphNVhh
         cR97NjGxyK9/ZYKIBH467fcoz6YqAf+xL9OpxyKqGcEVQrd62jkhmbFWoe/B03rubhTL
         xWAyZQV8pxYMz7r026DHTbwSL3hrtldSO/7qVcWGsdr+jqqCg68kU+GFYhX0hmKnJie0
         l4MWYUYMWUXZ1cjkYJEvgg6VDAE8gM7pN+3D3VnRUhFBXYrdBG3uLVrLY5/+kKRJYQ+u
         6itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5X2Y/BsD3JVBSOkTAw+9WbtQHVOIT5vuIM4B+UIqo9Q=;
        b=VJ2jrPqGkllWWt8QphNnGk1yWErTsbN56cQwf+RANU4t4wc0grLn2lF0+c05RjMLmQ
         plCfGcEVBWBHRyQTn6CT0bFdhzw+DcD2fr43ojraP17KRzsCjEeedZIQMrw0hfNZt25x
         Iw5HasSvg75pEaoeN1a8NMslCriNPXu8kTfaGsKWypNPhv4dz+ZwkZUWsv8YLe3Y0Ukd
         Z39uDKc9mpxK58TFRwKLGCABEIfXmEkgnNWeX1F23PgDBqxOetbISSdKZDSHHna1IoWL
         P8nAY/+MIfYC0DvafVXBGDUbNtuu+P1HeU0XbTvIS9rv2dP6BgS08U9WEDm3fiOVf2jo
         0a0Q==
X-Gm-Message-State: AElRT7HMl5HXIDqW5hY+qu7Bb+hP0hC7gLwr6uijBvGQOG+x44Vdtz/u
        Zc+2yR7TY/p1r69IzBY1HFoTG6EcRHWiJrAJY4gZW1XA1X8=
X-Google-Smtp-Source: AIpwx49T5P2TDE/v26No5E4/0NkeW1EPxwiPtEEbY8+PgM3CHOlvXYSQRPWactkh9J7ejm5u1+ITNCQHnlMkZMdR8fI=
X-Received: by 10.129.159.195 with SMTP id w186mr3415124ywg.414.1522273052369;
 Wed, 28 Mar 2018 14:37:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 14:37:31
 -0700 (PDT)
In-Reply-To: <38570708-e166-0004-878a-2d8442c12b65@web.de>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de> <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
 <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
 <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com> <38570708-e166-0004-878a-2d8442c12b65@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 14:37:31 -0700
Message-ID: <CAGZ79kYL55+=9UbW7H-c7OUg6CHbnzdkxs0ZMsFnEAaoVXRwLw@mail.gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This looks nicer here in the script, but doesn't test exactly what users
> type most of the time, I suppose.
>
> So how about this?

Looks good to me, though I had a nagging feeling at first that the
regex could be made more concise.
Why do we need the optional "[^ ]" inside \1 ?

> +       sed -e "s/^ \([^ ]* repo\) .*/-\1/" <actual >expect &&
