Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD43201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934787AbdBQUFl (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:05:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34068 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934613AbdBQUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:05:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so5695893pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Faezp5FAW147DKWgNbk35C5gdfj3MRG516GpENQe4aw=;
        b=pjQLwlNERzckK8+aN7whTfmDBpyrTK8OJaT5bv+UlIhr4yTTMDCYf2Og/xt0qk6Vqi
         L0F0dMesh72ruE1ZllWBkbLdOOd6voF5Cw490iViK6fvXQ7Z2Ia8TQRdfael1zxyC2I0
         5olv5WoIcf8ihBCaND7XcN4SZ185uGNkBap0zr789Y9b6LY8uIJ8eLQdvUpdGQq0AzT2
         CGF4FKg1MuZOeS8iCfvXCjSJZHUNloKEp6wvlVVjN+Z9dytTfZYnSgcPoc5i8xPN5D1v
         oBK/zNKr7Z0XqEpvcBpV7qrl9aNeR35e6+mde/6adYTsAr18vdXP2v3wPnud3S7tbO9G
         Rosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Faezp5FAW147DKWgNbk35C5gdfj3MRG516GpENQe4aw=;
        b=NuOeJRwlYofNkv5LRx1Thbymi95J+SX4HbdX9GI+a1V4xM7FvvUMNkW6g1sbqqzMC/
         4pRiiSPzHKHXjIQLbU77MHYAccnTgMpy3ejqz8/JFiQi7P3oXx6bKlJXFQ8VrCGVahCO
         4ZTxdfhlP1s2FliMan8I/Z21cmJCDyxQAOGCN/vYjj/ltTZR11OUAVPcDiKsud750nbv
         Ml3j+lqdGvQVKJ0PiVWVJ3e5ui96OWPK/Fti9O+xU3adFwd5jUQGhSHKLrlYzTHU8RFt
         sW0qRglKEH97FvuexvhoNP7EH5Bvcm2EkP06mj+ujFNhF9Ub7sWY6sJc7h/RqjiZa8fk
         38WA==
X-Gm-Message-State: AMke39ltk+5IMNn4pgK0tjI6Y5IOUdaIlacjyQJrn6Bvj94ItXBo9NxS/WZkRaitLhK05A==
X-Received: by 10.99.139.68 with SMTP id j65mr12357423pge.64.1487361939470;
        Fri, 17 Feb 2017 12:05:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 191sm21232874pgd.40.2017.02.17.12.05.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 12:05:38 -0800 (PST)
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
Date:   Fri, 17 Feb 2017 12:05:38 -0800
In-Reply-To: <vpq7f4owtbi.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
        17 Feb 2017 19:44:33 +0100")
Message-ID: <xmqqd1egshv1.fsf@gitster.mtv.corp.google.com>
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
>> Johan Hovold <johan@kernel.org> writes:
>>
>>> That's precisely what the patch I posted earlier in the thread did.
>>
>> That's good.  I didn't see any patch yet 
>
> It's here:
>
> http://public-inbox.org/git/20170217110642.GD2625@localhost/
>
> but as I explained, this removes a feature suported since several major
> releases and we have no idea how many users may use the "mupliple emails
> in one field". The approach I proposed does not suffer from this.

OK, so you are aiming higher to please both parties, i.e. those who
place a single address but cruft at the end would get the cruft
stripped when we grab a usable address from the field, and those who
write two or more addresses would get all of these addresses?

That approach may still constrain what those in the former camp can
write in the "cruft" part, like they cannot write comma or semicolon
as part of the "cruft", no?  If that does not pose a practical problem,
then I can imagine it would work well for people in both camps.

