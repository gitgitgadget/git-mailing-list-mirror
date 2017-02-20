Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BD6201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 01:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdBTBPX (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 20:15:23 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34914 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdBTBPW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 20:15:22 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so3507768pgz.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 17:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oioq8NqGwQaWKJz5xgh+lTMeqfEG451heXNAdUM6s+Q=;
        b=GfJyFqs7bMsbQfsute2VXdwOWEFZ6j0898uN6vro1EXK003sJRFRYwxDTAnBN3ZQml
         JfmarPi5LZ3hQG56WNTOPdCXuranj5oZQMUXuJRapz/FI9CYKh3POZYzI9Qgat7yKUhS
         615RPVh6A5GXrE0VaxEzJzf21YkjijOubXu6vDyO4hAyDrieJ4ZPtS4iJ+czBIF1g+11
         CfXyIzTq98RUv88vAHeZKvqx+4sxJ6i7DV3zD1qjs8u6oGdEos/2bqS+wZoFCRW/GdiB
         Q51yffGP0bK+yVDrVeh6Ipquriyk46jzuACC/EyMgQv+GqNhIxlmQA0B7eILtGU9HJ1Q
         FCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oioq8NqGwQaWKJz5xgh+lTMeqfEG451heXNAdUM6s+Q=;
        b=KjHHmNYQe6tjPsfG+0+QtQi6TODmLTWbu3W4R/VkzxpKrSPl+yfZONNvWR4eme84MW
         dUc0ECEbh513pUKZgS0CMPPNH8fprKjlacZCp/utRdAKbioLbiKjFIDeZA3AU4x6Gejc
         SbVlPrht2L4gyf8fWyZapsVedGrJL4EqiRFZPAR+q5eNpXWnVOm4SceVzOCW1ILQBgGY
         lxukpoJZ5wYzZQg2uzaA6Ijqv3j7jl6Oj1j2U9ybT13XZdEvBM06fRR5NQaoiM2acVoK
         L6b9HrQWXkA3XPNlmVuGU0piSDIv2GDImxstL9Spym70vUJcIz/3cKEObg5lCwm/wrCj
         NySQ==
X-Gm-Message-State: AMke39kKInuorT3je0jeZoN8jEeAxb6bsBWY1N90wyUgoTJ1mIs7PJTs9q30qINlSXAyJg==
X-Received: by 10.99.143.13 with SMTP id n13mr23854379pgd.10.1487553321220;
        Sun, 19 Feb 2017 17:15:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id w75sm2895654pfi.50.2017.02.19.17.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Feb 2017 17:15:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
        <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
        <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
        <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
        <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
        <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
        <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
        <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
Date:   Sun, 19 Feb 2017 17:15:17 -0800
In-Reply-To: <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 19 Feb 2017 19:46:48 -0500")
Message-ID: <xmqqr32tll22.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think there are two potential patches:
>
>   1. Add a custom-format placeholder for the --source value.
>      This is an obvious improvement that doesn't hurt anyone.
>
>   2. Switch --decorate to the end by default, but _not_ --source.
>
>      This use case _could_ be served already by using a custom format
>      with "%d". So it's really just a matter of having better-looking
>      default.

Yes, and I agree it is a better default to have "--decorate" at the
end.

I do not mind having to use a custom format myself, but I suspect
that the default for "--source" is more useful to have it at the
beginning, because "--source" annotates each and every commit, as
opposed to "--decorate" that adds annotation few and far between.


