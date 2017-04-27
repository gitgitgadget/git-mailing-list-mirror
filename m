Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0702207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbdD0Ahl (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:37:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34048 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753678AbdD0Ahj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:37:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so4044242pfj.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SSAbmr4HCt2oZyOX6T393x/ZN1xiw+3h/m0t2xr69pc=;
        b=soMzM19dhzfRityRp7QBo6wllgP9/cVVhXFKSBTjEC08eYovSaofl593g5vWwY85UW
         EU659bSxe0Wgrwzj5GpM03ZTFXuMXqPGtX14RGOpBYgQxyQzThZfBD+8QoFhWZ2oKKzj
         48Guq60UrebLLHf2seTPeosIaIf29oEw9x5MypmmmesO1/JWtB+XuHR/XZdZPmCaMK6R
         iUfqYBQGglHIx9WC1kFiNSsl9Ujk8v9AYIgH2jFP7Q+wzAce0Ij87Ixj33JIxSJ4BX9R
         I6t8S18EsLH/71qgpR5BMxT9gq2mxx6aC4LEFk8VG9JmgKrXpxkdvjNC6bKrtZGI8aBo
         9N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SSAbmr4HCt2oZyOX6T393x/ZN1xiw+3h/m0t2xr69pc=;
        b=VcSzYZgvpEHGvLUt09Sd+Y89Bx++qmWES7JsTzn4J//T3l0VoCihLtf4FM11B8myVY
         SSYbSXwvK3gsKiGLdcRy49amm7+JaKYWyYeuN9Z2WWV815BuYVurVeFtwhF/Wv1MsKV6
         1kbj5sqLlwx7gMqh+tIq34CeV9dpnQyQWUjckgJhzxUztqDb7E+2Lx9t5+CI8kURGKud
         gIGzrzuzCMXI0eXaAy3oljroadEmdOlksFYDBzZxAIJFhZ0WiRTidovDr5wug7tBizWd
         M/IPvOhFzg/qrAeCf+yTYcrayT21L0EIvhaEeGtcS/NxpsN4Yindcyhl8iD8chAeojtT
         5Jwg==
X-Gm-Message-State: AN3rC/4xjwbkCp/xcbYvgRffq1y43H1YGj2e99IVOpEMV+IXOmXYS1ah
        UoeJzeOH10XhHQ==
X-Received: by 10.84.233.136 with SMTP id l8mr3423663plk.49.1493253459160;
        Wed, 26 Apr 2017 17:37:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id a77sm751839pfe.33.2017.04.26.17.37.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:37:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, liam Beguin <liambeguin@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425044320.17840-1-liambeguin@gmail.com>
        <alpine.DEB.2.20.1704252148400.3480@virtualbox>
        <1493165607.29673.31.camel@gmail.com>
        <20170426014704.blyczgmbuqd5amys@sigill.intra.peff.net>
        <xmqqpofzstsf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704261124250.3480@virtualbox>
Date:   Wed, 26 Apr 2017 17:37:37 -0700
In-Reply-To: <alpine.DEB.2.20.1704261124250.3480@virtualbox> (Johannes
        Schindelin's message of "Wed, 26 Apr 2017 11:25:25 +0200 (CEST)")
Message-ID: <xmqqa872r8ha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 25 Apr 2017, Junio C Hamano wrote:
>
>> Running
>> 
>> $ git grep -i -e 'instruction [ls]' -e 'todo l'
>> 
>> lets us count how we call them, and we can see there is only one
>> instance of 'instruction list'.
>> 
>> Running the above in v1.7.3 tree shows that it was originally called
>> 'todo list', and we can see that an enhancement of cherry-pick in
>> cd4093b6 ("Merge branch 'rr/revert-cherry-pick-continue'",
>> 2011-10-05)) started calling this instruction sheet around v1.7.8.
>> 
>> A follow-on patch to unify all three would be nice, indeed.
>
> But we cannot unify them, as the config option's name uses "instruction"
> and to keep backwards-compatibility, we are simply unable to resolve the
> confusion.

We can correct historical mistakes by introducing preferred synonym
to misnamed configuration variables, clearly document why we prefer
it over the misnamed one that is now deprecated, and then eventually
dropping it at a major version boundary.
