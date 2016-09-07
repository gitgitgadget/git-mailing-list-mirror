Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC191F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbcIGRHu (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:07:50 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35775 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcIGRHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:07:49 -0400
Received: by mail-wm0-f42.google.com with SMTP id i204so97103566wma.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v0anzeEoHI4dqUMBE4ADcRZgy49AA9GJ+MvlxvPcw74=;
        b=NgzTBGzYtaUy2RkyyvpPI7/i1WTWRo7KXwqJW8SwVQyD6Xd876SP61Q55UHESnRBqG
         Y86/U63vcM6Kud1eVSk8c8XYeY7gQloBZJoUlLwKzAVV6c3/jG9SmtlO5wQd2nACnlWX
         OxvkBzsm3TxyI5nkPArMB3rtOSQm0Hwn9lRw/UZF5TS8KAxjT8PgP1C094oGT2Gxtv2v
         wQKD4IJW48AkQhp63VHnRcR4qBVMGW6zonRxdqH0x8L3Hr4vKMqUdxnaNDUwUFsl2ZFm
         OdX9fZ9m0qo1enmYdET1iAgyD6PExXTytMFhmoXx8eIC+r/Ll458IhXlp2eos3EG7ZtU
         0+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v0anzeEoHI4dqUMBE4ADcRZgy49AA9GJ+MvlxvPcw74=;
        b=KActvGiMsvmzZZ5wDpwH55KVnJW56duUW8WJkZWvg70rovhVdnie5aPNINeY+FxnpS
         okWRAzz63gP9fDmoIQEeBU6D8z7jfgbxvX9dkra5+E0lm5Ct1prSf2P9J47wMwxFq8Bp
         eWRoc4LOLDNKQG5BKuJX1HiPrFsNlOiRxuQK460aThG6y+N1Mwz7pXTi6s6FZFqysPct
         vK0yvfj1O4E1w53FTgxLUDAqf+3Q8iBwM22Sh3pHnb1XWo/vwh3QYgIajsq3+42TLilX
         qnqLbs4JPP4zN4jsf5x1b0QDJ/TK+ew/m5Zp4zL84HQ42d70QIQnLvpEyHfsdlqgbnDT
         AzHA==
X-Gm-Message-State: AE9vXwOIbUgSdA/QmIiDYNIxz+YA9nevNZS2PwoyGPtqe2+oGh7h+lG6WEub2zkBn/XKtOKMxfV3McfQLUaBlQ==
X-Received: by 10.194.235.166 with SMTP id un6mr41283373wjc.169.1473268067790;
 Wed, 07 Sep 2016 10:07:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.234.212 with HTTP; Wed, 7 Sep 2016 10:07:47 -0700 (PDT)
In-Reply-To: <1473240491.20551.1.camel@kaarsemaker.net>
References: <20160906180838.865-1-ralf.thielow@gmail.com> <20160906185918.21286-1-ralf.thielow@gmail.com>
 <1473240491.20551.1.camel@kaarsemaker.net>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Wed, 7 Sep 2016 19:07:47 +0200
Message-ID: <CAN0XMO+diDLXUrxjNGnUi6oUEwkcGavEX8vyGWy2+Wju-N4WJQ@mail.gmail.com>
Subject: Re: [PATCH v2] rebase -i: improve advice on bad instruction lines
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-09-07 11:28 GMT+02:00 Dennis Kaarsemaker <dennis@kaarsemaker.net>:
> Hi Ralf,
>
> There are quite a few patch series in flight these days around
> interactive rebase. Have you checked for conflicts with those?
>

Thanks. I did not check against 'pu' when I created this patch but I'm able
to apply without any conflicts.
