Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBB020357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbdGJQSA (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:18:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33554 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbdGJQR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:17:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so15150631pfh.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AaIVzrl/gCDq+OsM2JIIFUP1IZ9VEc+f+7WIPgGfDZ0=;
        b=GYsXBLU6gbLuDr8oC8zOGhzuaxbLm1NYwAyh/iYHujeDinXX4oYawxw/TpTiQ+rQTm
         foGWAxAkK0zMqrDpZyur8la5h66YhSPPTwD70Rb8HkbvjZn32P83dDO3NGhaHB8m17LK
         wbb9dY7D1mvWyvLMinMaen3l0B2ji3F25q4mXaGc4PKQVNircuty7oMNK2dL9m0s/Dbf
         3YNxP51Wu/dW9unXHgMHBLuda4xWoYbseQftryjVYFC1wf/5rYobCxh+AyzyXF26GfRe
         ZW1tCI164LXLvOtr4YfebUgL7j0xU4TA6KE/RgChsj/Uc2HyODIjsyxj23l6xMkEGXp3
         HMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AaIVzrl/gCDq+OsM2JIIFUP1IZ9VEc+f+7WIPgGfDZ0=;
        b=I0WaRdXQo4We4nc53FjAu3ohc//Xtc6vNe2oY2cZHseZGwEgtNQYaIhnXgICP0qItD
         6o9rtHZ27PiMTlKPAbgk5POMHwhsSrGbK/xf6niAVqfQHValbctoMilUix6budDSe3ci
         O4Ig3qab/5WsR3r5pIN7yg/YOEpFOMlzbmxeLdj3kacuErdmS0eIB1/Ga1yptMHk11/y
         EMHoAT7kg+AdQoe2/UcNiWLt/I+G59tQUGBC2Eqms7fxaHxLycPVbTxt1slaFcc1F3dd
         lDq9Dfv32u/7XY+6t55+REjtANIvuZs1u4VFFqafbC55ESqe7/QPIOYYhpQJfsKimchC
         A5nA==
X-Gm-Message-State: AIVw111PtVnyUddoGUQUmT+lhkGAz+BwtWdyEgwM1dEA3PIfcAANk9O6
        TOKGT8Vt4OXmAg==
X-Received: by 10.98.63.220 with SMTP id z89mr44836824pfj.84.1499703478634;
        Mon, 10 Jul 2017 09:17:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id y1sm27424980pff.13.2017.07.10.09.17.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 09:17:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     astian <astian@eclipso.at>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Doc/config.txt: explain repeated sections
References: <20170708203413.16442-1-astian@eclipso.at>
        <20170708203413.16442-2-astian@eclipso.at>
        <xmqqfue6a5va.fsf@gitster.mtv.corp.google.com>
        <xmqq7ezi9h64.fsf@gitster.mtv.corp.google.com>
        <20170710073229.mwf7zufx3xmszkde@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 09:17:56 -0700
In-Reply-To: <20170710073229.mwf7zufx3xmszkde@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 03:32:29 -0400")
Message-ID: <xmqqzicc6zbf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> FWIW, the use of "multivalued" here tickled my spider sense, too. I
> think when talking on the list we generally reserve "multivalued" for
> true "we expect this to be a list" variables. But the only mention of
> "multivalued" in the config documentation seems to be:
>
>   Some variables may appear multiple times; we say then that the
>   variable is multivalued.
>
> I think the proposed use is consistent with that (and that line is only
> 2 paragraphs above the proposed paragraph).

Thanks for careful reading.

