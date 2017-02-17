Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547BA20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbdBQS26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:28:58 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32824 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934224AbdBQS25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:28:57 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so4577694pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cDseCtFasTf40H2z0+J4NpyrEP+vedBHXmfabF23Lss=;
        b=b02LSSLO0rKoE8wIb3TpixI5Hh1ozLWjWZTBZIKHnk5Mzv6PfTXXthky40vyh5d9eB
         ODz8iAcSDtz4d8KefIadE4KpkQhO9gUgbIiyj374TYPIXzN4b9r71SkfcHS1BvGC62br
         7nKiXkNyjxtCTux2HPTrBWyWY24Z8BnoaNm6ayp26sHHuWgndV5wL2HM3NVzyzQ2Ovj7
         +GFWK9yZEotEILld0qsPXdVVD3eN1dZzTPVuo7UEN8HzXj6LqtpJOEx7f1ZFe2pooZMT
         I9AhlyKHH+EcIi+9ytVI4bjuaX7x2Zokoqgtqic83UAx6fXQFOqlinZxWjTJChaOhXmq
         5J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cDseCtFasTf40H2z0+J4NpyrEP+vedBHXmfabF23Lss=;
        b=VO3eCnH2wVj1Ncm3UXTk8c98I+m2vvA6pJxsgApKwrU0/2RNUxsjqCg5gYAcgPAeGK
         I1kmNxbZtlMODLWd/G5Z9yAEVrU0xGIXNzq57+NctxEdUbf6VS/5ZmsYlKRycCkxLfv+
         //VfZx5zPL49pWRYbXfwhSipZn/zHCa5Kx5R6lEBchnqfInE156SaIkO/l3sMaGpAWNl
         EYIc2MYneihyGCMHREeCJ+xrgoqBaiERH+O7aHNc62E7QCVRgkU9x9k/Icd+g3LltyyW
         6/wewjgAoBWjMWRoW4S8KpDf6Tlj+F5QjKlwely4oE/hyP8v4j5tpLHAZDsgMT4t/OmY
         vETA==
X-Gm-Message-State: AMke39mPkbfJV1eD7feT81i/uagXJhKbdWX8Cag+9hV0dTian2yOD/uF8LzU/Spe5Geztw==
X-Received: by 10.84.148.134 with SMTP id k6mr13272993pla.142.1487356136523;
        Fri, 17 Feb 2017 10:28:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 129sm20934129pgj.59.2017.02.17.10.28.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 10:28:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost> <vpq4lzs7o0s.fsf@anie.imag.fr>
        <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
        <20170217182326.GA479@localhost>
Date:   Fri, 17 Feb 2017 10:28:55 -0800
In-Reply-To: <20170217182326.GA479@localhost> (Johan Hovold's message of "Fri,
        17 Feb 2017 19:23:26 +0100")
Message-ID: <xmqq4lzsu0wo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> That's precisely what the patch I posted earlier in the thread did.

That's good.  I didn't see any patch yet but the message you are
responding to is a response to Matthieu's message asking if you are
planning to work on it, so I'd assume you are and and look forward
to seeing a patch (or a series?) we can queue.

Thanks.
