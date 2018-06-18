Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4057D1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeFRPxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:53:31 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37691 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeFRPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:53:30 -0400
Received: by mail-wr0-f175.google.com with SMTP id d8-v6so17399079wro.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HV4m+ALcG0wwRR3c5ZSh9tCzhTW3JkMwt0tme+9gpZY=;
        b=HxMkriMJCvuz2urNa+wpnq1MtePANHTZJsIMSrJUbZdpvyr5w4mMqm7xeP1HpDzL8o
         A6/XwHHp+4cchoEDUAb9ZWiN5x+F/iwvQoUB4vif3NHKQqhQVFJ6WEMGmLsn8AsM2Tjr
         3HNYmVOkqL24I1u16oPo6pEVMEcdgHDB60amUNRJNjdx/vXJf/xiHvF4B/vUnRuaGplp
         7sQvTdjg52GyICEqxYesYL2PKZ0Qe2/sFhBIy/Mghyp+/Xe60fo0csnQNklRR9iYLKPj
         o8Y2Kzv1oTERGaxbKbMBlz8Qhu6dhLy0GvIJ9/WkUpPbfprHYhU+krK1gkLsBXp0bOb/
         zrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HV4m+ALcG0wwRR3c5ZSh9tCzhTW3JkMwt0tme+9gpZY=;
        b=Sj791oqD6SjpdYkgz2Mvv3VqBJTgWNYrI9Zmg4zXcVl7kfufqw8R/o90kNWtvvpwlw
         UKDkudFrK1CsyrL5W2RuJjW8WTKrsy3dHINdT/1G6M80Q7JN54rgHWNnLaUAX/+wEKQJ
         kJ2QRFAqpiAXv0fFmCfIoPEZuU6h+2oKKaefaEqaNP2mDsd6GoTDHZb4xWKoiz5HqnL7
         9OIwdFODvrwjYVeSz2uM6uuN5jIJUpDCfVYz88JMQBf5NEA5s9cDoiv58GWJNS6Iowxq
         DcThCYxcomoMWdOIx9+205kPc8QKDDlm6AXFq8ywhdcDprtOAdF8QgRiJeCRk/jgjL29
         cWPA==
X-Gm-Message-State: APt69E1CUXZvSinygou30P1H6471eoQanId2n9pmR+ePFkc5G3kDWgLu
        k0q0HhIzXOlZd2lCVjw33k8=
X-Google-Smtp-Source: ADUXVKLDT68e1lhqvIfdPXPY0y/axG1fb3P538v36nwtVyawYOFYWuarxj7kEB3vtkmui/1Ty3JXeg==
X-Received: by 2002:adf:fac6:: with SMTP id a6-v6mr10305366wrs.74.1529337208842;
        Mon, 18 Jun 2018 08:53:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o16-v6sm15613843wrp.8.2018.06.18.08.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 08:53:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
        <20180614101342.GO38834@genre.crustytoothpaste.net>
        <20180614151507.GA6933@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
        <20180618041713.GA31125@sigill.intra.peff.net>
Date:   Mon, 18 Jun 2018 08:53:27 -0700
In-Reply-To: <20180618041713.GA31125@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 18 Jun 2018 00:17:14 -0400")
Message-ID: <xmqqo9g8xf9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 17, 2018 at 01:37:24PM +0200, Johannes Schindelin wrote:
>
>> > If it's just a custom Authorization header, we should be able to support
>> > it with existing curl versions without _too_ much effort.
>> 
>> Indeed. Because it is already implemented:
>> 
>> 	git -c http.extraheader="Authorization: Bearer ..." ...
>> 
>> To make this a *little* safer, you can use http.<URL>.extraheader.
>
> Yeah, that will work for some cases. A few places it might not:
>
>  - some people may want to provide this only in response to a 401
>
>  - some tokens may need to be refreshed, which would require interacting
>    with a credential helper to do the rest of the oauth conversation
>
>  - there's no good way to hide your token in secure storage (versus
>    sticking it on the command-line or in a config file).

And all of these three are what you get for free by building on the
credential helper framework, after extending it a bit so that the
filled credential structure can tell the http code to show it to the
other side as a bearer token, not a password or password hash.  The
helper is asked to supply the auth material only after 401, which
covers both the first and the second points, and then keeping the
auth material in-core (e.g. cache--daemon) would be more secure
which covers the third point.  Am I following you correctly?

Thanks.

