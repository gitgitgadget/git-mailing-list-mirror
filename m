Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56C0201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964776AbdBQWWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:22:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33289 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935044AbdBQWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:22:33 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so4887183pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pZj/y36ZC1Rpjr14xh3Uuw8XAWb52f+6OB/eC+FelkA=;
        b=AjYNngcoX826LlB/9Y8302tEndGvtng3fKVbdy7zjzr+HSNLTZzi7iS6n01m9nl/8X
         33f/oDvIKt3BssQIUObc8Yi9SFT/L2uyWpy75V2of9oYPMriKbf57VLOaS7S6OSs4pK7
         hQs6rWnzw9wqjc+nmcgHWjnnewqb5vO4yzBoBBUZpNkhJo61BXTql4XXkFYphmmV9xtQ
         0dCtTTwKOSX0ctUsZU9I3VlTljraUn9fg4vBlcX3kxAivsRD1pBlxerXmzP2nI2l8FRo
         b4pAGNOFr/Rx4uoS004XDmkTtdK06KrRq3Tq/I7Ub1w5aKsfsvWFFmDGED4UmfsO4ogt
         Ejiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pZj/y36ZC1Rpjr14xh3Uuw8XAWb52f+6OB/eC+FelkA=;
        b=pbg5kilDKDsUlz5yUlB4+NqECUZPqyGU/XuaySd48nQHrUvuqupj3sbqNSz789G8K2
         Dn0DzrZj+5FH9n9PSMu60Hy3qOx7/EAszpV3yPSmNUTig0rodaNU1eyDGKMySaKks51k
         z/LHdeNCe89XC65LWyizy+hEw3wp5X16e7arNTtuSu/WesYnzGVKlRKSfkgemljV3cf8
         pe9VIplnvGPhewdJZ3mEfHm0de+opZBWHfI2XUYyfIYhXNONwgIJYPMZMxeGsngOB2gP
         JwM7Gl+lC+W0xCw2+tkSgDKAQ+hemtsJEX2iOc5CBerG/TRr8B8q8Wo3IBQyj77xwybX
         rjnQ==
X-Gm-Message-State: AMke39lx0BRb36FPcmcwaIHTF22fAa+179+9LZckE1FZtTmJUD3teLe5mc/ku6ujnCh0fw==
X-Received: by 10.84.143.233 with SMTP id 96mr14397515plz.124.1487370152692;
        Fri, 17 Feb 2017 14:22:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id n87sm21281459pfi.122.2017.02.17.14.22.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:22:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost> <vpq4lzs7o0s.fsf@anie.imag.fr>
        <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
        <20170217182326.GA479@localhost>
        <xmqq4lzsu0wo.fsf@gitster.mtv.corp.google.com>
        <vpq7f4owtbi.fsf@anie.imag.fr>
        <xmqqd1egshv1.fsf@gitster.mtv.corp.google.com>
        <vpq1suwvab9.fsf@anie.imag.fr>
Date:   Fri, 17 Feb 2017 14:22:31 -0800
In-Reply-To: <vpq1suwvab9.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
        17 Feb 2017 21:20:26 +0100")
Message-ID: <xmqqbmu0qwyg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That approach may still constrain what those in the former camp can
>> write in the "cruft" part, like they cannot write comma or semicolon
>> as part of the "cruft", no?
>
> Right. Indeed, this may be a problem since the use of "#" for stable
> seem to include commit message, and they may contain commas.
>
> So, maybe Johan's patch is better indeed.

OK, so I'll queue that one with your Ack for now so that we won't
forget.  I guess we still want a few tests?

Thanks.
