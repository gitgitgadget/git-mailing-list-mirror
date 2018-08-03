Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682351F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeHCUxk (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:53:40 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38469 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCUxk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:53:40 -0400
Received: by mail-wr1-f53.google.com with SMTP id v14-v6so6305187wro.5
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IO8vUmrM8z9A1pJXdSSzMT4ThD4V2Nu+9xdjij65r60=;
        b=pcIRo2UEn4DbZvn6HMZEDgUWvwPXncOUCP45CugBBi/qLXc64nqwvRnxi0mXW7/oLU
         LtT7ukQXAhsnsyC0deoiN1dTOglMi5RKG8aJPoHRTvHfh6P7fAnfXOwDTx00dn4M5ZWr
         X4+uAgV4MDWz8J44js6SrP8K6yLgHE1t/vgwotJErPaQVQMsTb+cTxMy3iBmQIDk4AmO
         cP4ZWAUi/ovRp6sVyHbpcbIliOSXCeOQGr278KDdYGTeeqIn4xpKC75Xcoh3IhjjL68b
         7XBkbSoMu9QJ4rjYzamIg1ZLx5xLbTNrwvD5KnaE9S4kJpjvFnRNrlnzkQMPnClLc1qD
         mOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IO8vUmrM8z9A1pJXdSSzMT4ThD4V2Nu+9xdjij65r60=;
        b=fKowX32ytZDehzwjIc3DoXSlNqvt0uKVqV+alb2C8Kos/1LGgMEqQCKxP1FbMCtpe0
         rP0bodM5Pvcx9Cnaq7GCJD5tyYznplLHx0pF6cNXWNuQtJT6+nBZYzrKCKmTpCN7MbPx
         7mLstJi0hyTfa5HRkF9mgV10uNz1Rfb6Dxa51XkMB36xsf5kLnenVhs5eUt4fdBlt7qY
         IgOHtZRml/1TPKPieB9u/FuVnlFh5QNZwWBHB9lnsMOl9Qlm6QSBXOd2Ffbve76wP3MF
         ALr1B7dNt8Rr7qpoIpPzk51g+1hM3iE7xB0sReryaMxghylE6UwOl88Rwkc8Neti7EFR
         n+ZQ==
X-Gm-Message-State: AOUpUlFjyer1uvUGFKXdTvzy9uv8YPJijIh5lWVQIyrMULcw7n3Cj8sp
        c0OQiM0OJw2BgJbE6JeVbTe5reP4
X-Google-Smtp-Source: AAOMgpd/N8l743jtVeH1R6iMHfMp9thnooF+/S9dT+wNN8a7YDCyFwt/AH7ih12D6kkdWa8SeaapMw==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr3237802wro.279.1533322567909;
        Fri, 03 Aug 2018 11:56:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f23-v6sm52081wmc.42.2018.08.03.11.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 11:56:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
        <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
        <20180803184508.GE106068@genre.crustytoothpaste.net>
        <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 03 Aug 2018 11:56:06 -0700
In-Reply-To: <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 03 Aug 2018 11:51:02 -0700")
Message-ID: <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On Fri, Aug 03, 2018 at 11:40:08AM -0700, Junio C Hamano wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>> 
>>> > On Thu, Aug 02, 2018 at 04:02:36PM -0700, Junio C Hamano wrote:
>>> >> --------------------------------------------------
>>> >> [New Topics]
>>> >
>>> > I had expected to see
>>> > <20180729192803.1047050-1-sandals@crustytoothpaste.net> (the refspec @
>>> > handling) in this list, but I don't.  Were you expecting changes or
>>> > additional feedback before picking it up?
>>> 
>>> Neither.  I just am not all that interested in seeing @ used for
>>> HEAD in the first place, as I find it quite confusing.
>>
>> Okay.  Is that just in this case, or in general?  If nobody but me wants
>> this feature, I'm fine dropping it.
>
> That's the typical case of me saying something in a deliberatly
> outrageous way so that we can hopefully see people from both sides.

I guess that makes the answer to the original question "the latter"
;-)
