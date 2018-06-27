Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220E11F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965987AbeF0Svb (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:51:31 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41283 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965779AbeF0Sva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:51:30 -0400
Received: by mail-lj1-f177.google.com with SMTP id v12-v6so2444416ljj.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R4xmHhLRb9vG+fw9lObtKJfPTETkMjRo4o0QHo/q18E=;
        b=wF915fXoSWYWyWY1X43DhXn4XrLTdlH4yWmOuN2Ez86AL9Q3JwqGV95LC3pMTIeFjQ
         7boh1dpJgscKDDKj+8W0+wbIH/AUvPuK9hmM0m+PTJ0e3prpB7ZnZu4OqG+iHmn8zT9F
         Yuk7BS47q3Uy7vOL38jOwKgOcUQty134cG2VQ/RknQ8zmW5vmE1v6S6rak2zey7Sl9Cq
         Za1OAKv47XQaSqKf7gcTZnAFIZeVLH3gMvhjZB9UScZGi8pjX4oGMVig7Do4jJUZ3UJ6
         IKVJhWo9DYZ+1aSkKAJhlaV2OzNkqk5PQrqG0k43o7LWNjpStVukAtVQvJoGNDWIeIYa
         Rgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R4xmHhLRb9vG+fw9lObtKJfPTETkMjRo4o0QHo/q18E=;
        b=Vs5kvytCwXReq8ANTrd7i3Eg16pgt0UR+j6b+hW62pV4U4v/IW1wKuzc87nvK6fFEp
         49+yP9Cy304nb4Kw0Gz4KqUsu72SHJnxBfPS5iiwdohhHO8tbc4zMLRQlU2NK6mrnZGy
         zw1sUoXbPrCNVddNyhbiCb2YPom7zZJy5CRm3ZyQ/IBpGpruXg1nuY+2Sv8+tJaBB5Xe
         PVlhzP2cO77TjBBAf9+T9xXM5Jp2zSlb+Wol5WVLzyJJPpwHS8UzVLnmLF13Vm8ZvgCe
         Wu8QEM7T9rchZRq09JhnWmYKmG4JM/FqLoXIT0BEXVSwvPJ0o9ihlAV+nLT3704WX9bL
         BGhQ==
X-Gm-Message-State: APt69E0FNs1JwJMv+z+tBFtFX3M+F7Mq5blhIIiT2zGwsWJ7MAuqzT8G
        DLhXwwCu2sdtaJatDnbEIOAph4rfyO0x1P3lQc9LjA==
X-Google-Smtp-Source: AAOMgpeXk1q309VU6uLxyFqibKIMUitoHCe9vIepH8y3z9rmq00DhMTPlIfdWS/WZenKt5AANLyUkwLgW/QuCMGRlU0=
X-Received: by 2002:a2e:2bc9:: with SMTP id r70-v6mr489948ljr.133.1530125488776;
 Wed, 27 Jun 2018 11:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:c801:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:51:08
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806271251130.21419@tvgsbejvaqbjf.bet>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is> <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1806262343410.21419@tvgsbejvaqbjf.bet>
 <D5941A31-B9B3-4EB1-9D55-D5E86A541D2C@dana.is> <nycvar.QRO.7.76.6.1806271251130.21419@tvgsbejvaqbjf.bet>
From:   Wink Saville <wink@saville.com>
Date:   Wed, 27 Jun 2018 11:51:08 -0700
Message-ID: <CAKk8ispLOsfe+t9yMaLdWd9tzN+zBfrXBmt3j-PjF1dYYJbfLg@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: Fix white space in comments
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     dana <dana@dana.is>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Sorry for the whitespace bug, it looks like everything is under
control one way or the other.
