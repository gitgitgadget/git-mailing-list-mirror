Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434771F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJQHE3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:04:29 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40031 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJQHE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:04:29 -0400
Received: by mail-wr1-f54.google.com with SMTP id d2-v6so27470165wro.7
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Thz5j993gUVJcim/5pH4/NS0kW42qiHR3b+sE0zqw4c=;
        b=rL4VFnuAo4j99YJh4tToj99mcYuVP7OG5/GVe3wZhk6sEwz4jt4V/xEDQEC9YyH8se
         We1u1DEI5UAyh22Yi7tXdJD5SFdBVg9FtzOlXTGRYYIuceobqITOnPgvC5uV7r+7kPff
         IJOpjlMF3ABCfGCDztqu92lva1rtQZh89vXIhfUyCyuyclBxE6CMAHbI3A0kBrnAVrrH
         uNP1dEIPWvgVw3S9sk7mAxlF+VkCrsOKLYFR4YjDEkF2T+TqKX6p+1LE6dTRnz5jneXS
         RX6A9RM7zFzU4h+rc1JngX7Lf402CZ81ZjTFyTQRa8yl3pXO0U4Lpt/0bFVVcO+fbDFr
         vOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Thz5j993gUVJcim/5pH4/NS0kW42qiHR3b+sE0zqw4c=;
        b=Ug16nCtSGvYqUXj8dg0NTwogh5kP8VgBQI1jzcznyNt4vib61j8T+pCouGyVqLiKyH
         IEFesR6/1U4gRiVo1iXleB8XR8Ln5/ZJiRo6hr+aKxrA+MNYwgq5gXy9G4liJIDVaANB
         nZ1O9S/YAM8IJMTRtkxIOaFktMeq8k1kl0hGZInGMUsWVjTVh8HhVvD2UmNkVEuL78/w
         QzXY/zNib+YdntHt/s4pQ3+yQzkZ2J5m3iPNCirZut5fKpD/D23ait0ag8da2DvkYarX
         OxNz9dFZjvWMo1EbTJKY9uC0yEhYbY9uEwi2TiDpBz0abjkZ+Oi1E9XzCaKhNj1sTz94
         3/nQ==
X-Gm-Message-State: ABuFfohposWlYtFiuYovS/q8bRA+2hZT/HmNW3J6TavV1eFIjhzn9VAY
        ObQy0PPJtP6GI6rw4Vk/x+Q=
X-Google-Smtp-Source: ACcGV61L78kIAGGv3oCqbtCKQJgIJGCgSDyuOmrWxgCEvkQ11Z3Kv2K4vUrWDWC46DoWtbOFjR5amA==
X-Received: by 2002:adf:94c2:: with SMTP id 60-v6mr20240364wrr.247.1539731507900;
        Tue, 16 Oct 2018 16:11:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n3-v6sm20510770wrr.62.2018.10.16.16.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:11:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com>
        <20181016212008.GA249669@google.com>
Date:   Wed, 17 Oct 2018 08:11:46 +0900
In-Reply-To: <20181016212008.GA249669@google.com> (Josh Steadmon's message of
        "Tue, 16 Oct 2018 14:20:08 -0700")
Message-ID: <xmqqftx5xz9p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> The first two patches (test cleanup and packet_reader refactor) are OK,
> but the latter two will break the archive command when an old client
> attempts to talk to a new server (due to the version advertisement
> problem noted in [1]). Sorry that I didn't catch that these had made it
> into next.

Thanks.  Will hld.
