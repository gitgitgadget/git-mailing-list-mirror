Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7731F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbeHBUcZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:32:25 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34927 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeHBUcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:32:25 -0400
Received: by mail-wr1-f47.google.com with SMTP id a3-v6so3114044wrt.2
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=07sp9//03+xrxGmBAJ2C4l+2+JKg1Z7XuvOU7abk7nI=;
        b=idXXyQygdkAFUDPvFNooaYxugu93/1d5xH7w0v2jRq8Mi2O5ps9RhtsDLBYqxPb5JZ
         /Zb1s+jEU2YDVo6DUaId46VvkXggwM2rxqShUBkp77cxKtbBncQTwqh+zs28V6bXki+6
         NYjCiAFj4l8r4Bwk3T3+EEvUOR5ILIook/GK4An++FpBavGerOdb6IbggORM6zry6pih
         cK3JuQNki2q/wmWtIz6CJfDdhlyrXveevukfoCzFUO1otHKIgrRWwsuL++8aEYCSke2u
         2qI+biHQJopV3ulbJAGM4MOfqWTNFmAmSHA1kxklpe2irHupWfmM7pvgAXwr7OE3rP+F
         fFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=07sp9//03+xrxGmBAJ2C4l+2+JKg1Z7XuvOU7abk7nI=;
        b=aIFTJDzc22ignCO2pMULytUp7E/9sq2sYhrQpo+jINQ3RGvEOJT5R51Dy9WXi+2W52
         4NlEqFa9sTV0Am/t93kZywPguZjQRkCQ6dp+pbgkrxanOXerVDZt821U73JwmZD3Q0uo
         TV4gsQSW1+XvnhXW/N8jcPLtFYnsCGL9Iw8sYH2+ieXrTmZSxFx6Va4qBPdUipCb1b5J
         5pDZesxwfrfw2N4H0HHho3/E0/J6LnrC/2t1EUukCkB85JxgnDZ0Enso8x3GgidKQ7fg
         ndethApSd3GnB7euQ0zvLXevufkAVqIAB0hfiNX30ZvqP64iFc+WyWrchp9DDX1zNFTM
         iFsQ==
X-Gm-Message-State: AOUpUlGmJoKsHPnNx7CKtj3OHiQAt4xHf3Hp6Sv43+eOTpI1vC29BqlE
        7k/TvNRMpuvrFRbAt7GGSIA=
X-Google-Smtp-Source: AAOMgpfLoJplV710zly+HlqCqakqFdlpLMb+rpm+9DamqjdGq6FwcKt2ugKmaAHJe9ndI2BVzEu4mg==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr385837wrs.171.1533235203911;
        Thu, 02 Aug 2018 11:40:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm1888871wrt.40.2018.08.02.11.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:40:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAL21BmkmxmjVmi3JUaW7vK5yGyzzZDxeMGNSSYV0nzEzWKcs+A@mail.gmail.com>
        <xmqqpnzaq6jf.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0yWYvrbgtKjUs8oVks36Rp4qpfGAj3tambixSeC+-_1w@mail.gmail.com>
Date:   Thu, 02 Aug 2018 11:40:02 -0700
In-Reply-To: <CAP8UFD0yWYvrbgtKjUs8oVks36Rp4qpfGAj3tambixSeC+-_1w@mail.gmail.com>
        (Christian Couder's message of "Thu, 2 Aug 2018 14:41:40 +0200")
Message-ID: <xmqqlg9o1ukd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Looking at the code of the patches again, I can't see any simple way
> to improve on the way it is done.

Thanks.
