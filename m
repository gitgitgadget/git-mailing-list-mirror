Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E66320248
	for <e@80x24.org>; Wed, 17 Apr 2019 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfDQFii (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 01:38:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42974 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQFih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 01:38:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so30118953wrx.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ub6yAY4OSbgbiUhzIb93AnonCzjSqQSn5qb+Psu8WEU=;
        b=B2ev7Aua99ughmyYhoc6uE2OqVmkSW3sd5Qwwm3UqD9v7MIdsG2BKQcVPAkxaapIhU
         2LV7ZpsLkktI5DGvFU/AxytCsPvu2Fxr/GgItHVbTK+Mpp9M2CbzzjhPq0R5xDy7Egzx
         +uRhmRiLZA2GKKbRl/ZntgVJ8FY/S3T30k5X+HJXpXL5sy/2xstCw2iti/RiprYO0TQ4
         vg0mhjjVs/qzjNWl6WhUcFh//TkaAri/ldjPRcsd2X37fZ/XtAkqVNGLAVvgV8pWjE38
         sZprcc2sO5B65jyQ4IWxoKfG+gk0E3vMwtaz8Rrja0yTesDjB0ovk8KJ1V2eT9ZY7fqL
         9vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ub6yAY4OSbgbiUhzIb93AnonCzjSqQSn5qb+Psu8WEU=;
        b=Nn7fIJYsPECxWPTtXsyTLr7Ae+7+00X4Kjp4KNGbffd6PoAJkab3pWUoJAwsRkczFv
         4bmyS6mgvVN7frJ/OxOqhdfMfIJCLo81ndtYwTfVcpM7GZR2Ais08c0dSTeLkZHHZdlD
         OhqDdBo3BEq3gK9oIqKgRfupHO6wX8g9kmUTssXCd5KGXb2Me6vik6nWztTwOGBPO6Hr
         03cD73CJ7vFj6xXcyjUcSXPQRZlVM+4enGkMTdoCq5IN5um0JXrT+cYKxAEOcmoVwVP1
         c9PJdsIrNGNF3nncwHyF8V88zypN/bruL+KAvzSEUHu1DUDQl628G1QbVMzE4ywHieJu
         TMzQ==
X-Gm-Message-State: APjAAAVlCo6e+Dl4egv7o+PrSWxvfyIkWmq1d1FBlOqaUcBAff/hDksP
        9Cl7MFLFEsn7JXrix2HN5BwuDLhhxmU=
X-Google-Smtp-Source: APXvYqxb6PW3s28JvDWJd3WLEMZpFefNcP5mTM0e4AyrMPY/baX2mxxDpDep+RdCo0nc+s0lURqIxQ==
X-Received: by 2002:adf:b68d:: with SMTP id j13mr57557173wre.50.1555479515947;
        Tue, 16 Apr 2019 22:38:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g13sm1226556wmh.11.2019.04.16.22.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:38:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net>
Date:   Wed, 17 Apr 2019 14:38:34 +0900
In-Reply-To: <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net> (Taylor
        Blau's message of "Tue, 16 Apr 2019 19:37:06 -0700")
Message-ID: <xmqq7ebtkx7p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Hi Junio,
>
> On Tue, Apr 16, 2019 at 10:19:45PM +0900, Junio C Hamano wrote:
>> * tb/unexpected (2019-04-10) 7 commits
>> ...
>>  Code tightening against a "wrong" object appearing where an object
>>  of a different type is expected, instead of blindly assuming that
>>  the connection between objects are correctly made.
>
> I sent a re-roll of this series in [1], which should be ready for
> 'next' if you feel comfortable queueing it.
>
> [1]: https://public-inbox.org/git/cover.1554861974.git.me@ttaylorr.com/

That's this one

    Date: Tue, 9 Apr 2019 19:13:06 -0700 (1 week, 3 hours, 23 minutes ago)
    Subject: [PATCH v2 0/7] harden unexpected object types checks

which I think is what has been queued and what is listed in the
message you are responding to.

Do you mean you have even newer ones?

Thanks.

