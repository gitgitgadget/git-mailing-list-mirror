Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8881F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 18:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeDZSqA (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 14:46:00 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35215 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeDZSp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 14:45:58 -0400
Received: by mail-lf0-f46.google.com with SMTP id r125-v6so32235629lfe.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SdSQ5g8wWg6u3EcOCjvSYJ4KzIwe+BJnjgzcHUPADOA=;
        b=O0+WsOQBYkrpXnjblUMJ+y7L7jFQnLq/lWuaCI/ZVr7w7+qSfpNdLkEvGjN0wCSyk7
         5CocQbkVeePWMF7bzJxxz/gDChyACTY7SjBbnP4Qpp4tfPvD/6WqRZeDmodzKTaer+Dn
         N2q8deZ9SEF9ESKkhYUsUIYhyycHEQG+vmAJ6ZKIl3Mz2KSEbV6R/8QuyYgmwsTu952+
         QWrNq6d1yEm/A1KLz73ex0nD7v07DjbVeclkniidp6acbG3oJVz6PFFhFruBcF+Vr5pZ
         FZ727aKK13yP+CbsL288meFfDdrYkNRrbQbr6YvRN7AOysSc2aTz9/HzCwI5am3b+PdB
         0QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SdSQ5g8wWg6u3EcOCjvSYJ4KzIwe+BJnjgzcHUPADOA=;
        b=tPkiRXgc4v1m2GhSDdCGV/r463cjIgF0atRbb0LtnyfmoaFazyKvZ0DvVsn9t7KXKJ
         yLRf/AH45dCMsO/itvEJS4QBA7J66btjTt14+9FjR2A/o1Z8BK2H3MEX9OWLOldAegrs
         Bp5VzblNaIGkN9TmOfUMr3c8MjzlO+EMM44+U7vSRuQsKnq9bJWzG7AfSgVJNFHsLAFH
         3KMzuGM/AsglEIqRotHquJXL254wOPd0rWsuKNch7/zSctRS1mP+1jKT62dFMN1eOt/t
         baRNfZxnm8C0IQPKg0lZwlAefXmIPJuLRYN+2WNcvZXpW+QSOKzanQe+EE9UhRRozEE+
         np+Q==
X-Gm-Message-State: ALQs6tCBdE4/9ck8W50Ej8OoyW11uH0TIQAZcqsqSN/SEkxlcVHrAvGu
        kuXFXFmvx22h6MvPZViQZeB9Yw==
X-Google-Smtp-Source: AB8JxZrp81Xa45jvHtubiUDtxUh7IRKjAHuQ5KuFFMYoeTXKMw9506+/IH/ugMQbDsTfBFKdNSBLoQ==
X-Received: by 10.46.27.82 with SMTP id b79mr5297366ljb.134.1524768356972;
        Thu, 26 Apr 2018 11:45:56 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v3sm1411653ljj.71.2018.04.26.11.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 11:45:56 -0700 (PDT)
Date:   Thu, 26 Apr 2018 20:45:54 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <20180426184553.GB6844@duynguyen.home>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <871sf3el01.fsf@evledraar.gmail.com>
 <20180426171540.GA2037@duynguyen.home>
 <20180426175358.15495-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180426175358.15495-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 07:53:58PM +0200, SZEDER Gábor wrote:
> BTW, wouldn't running
> 
>   git clone --template=/path/to/template/dir/with/hooks/
> 
> invoke the post-checkout hook in there?
> 

Yes but it's cumbersome, preparing a template just for one extra
hook. I never like this template thing to be honest.
--
Duy
