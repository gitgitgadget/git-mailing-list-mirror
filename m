Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8840B211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 17:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLDRhZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 12:37:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34983 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLDRhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 12:37:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so16896906wrb.2
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BH7iqN3/V/6wfI9SX+/Fyvmgyrfn/hkM6bH8J/hkAas=;
        b=d1W/4DtlFDZbyk3r12pleTLXyiAC21DBu9Bz0+C3JvbMClDOXmzfj1SXRnJ9yOeT/J
         eowjXOT/Oqz9zs+y2EeBruc2Q1gA9nQkhxkJ7qylFQKH3Yh1LMP2WqJhcoNghBnCGOpc
         pWMJdsYUYKF3CJAKM5dyPuRSB3yDkEUerXNlcFHUqk74BtHuwGiPZrmXPwLNEa6pLB7m
         h1LEXJqsEi9+jNHOo4vOt/4fvZYRkAvIVAcwZ7gt3lSVXZNwpLhQEbcZW4UQsPOYd/fy
         +WIRXgdtqfLGGJ1QzXuH6AYRyURAmKPkeBLV2I2LRMB4r2oz8J+4ZSGbyTagYvGte6Fq
         0/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BH7iqN3/V/6wfI9SX+/Fyvmgyrfn/hkM6bH8J/hkAas=;
        b=gh8ryQLtnbU2ovxlwzQa8emfS5pdgQlQMaEEmohUqi+8Q9ziCzIusaVBqtT19JAfft
         vxBhDlap++pIYw9wldICSPg60d1YVIOVFs88LfrxFrRY2IKrH3QVG9Qq/mkj3POF4rwB
         5qlj9EsPb75M1GYZREHsBjdEg4ppskakDNoMh0hzi/ZLjUf60zowoEZHIaMqBAf7A+Kk
         gxxo/yhZGvn2dw7v1jWr66UdNrrJzeLT2/2oXB6LWp7tHOcZqwPHZ3MTXnEYx+7XdHWa
         8UOczwfRPn0xSojzNOMgYZCcjo5cyqxdglMHTfQoD5GGoKqnklEmyecMwuqoL191LcQ6
         Jwrw==
X-Gm-Message-State: AA+aEWbcTMfvnryxuxtTSBLDYLjm48Pl4ny9tRTC8mfdWgLP324vGjav
        Nlt/T2zsmoqf6aBRntSdL2s=
X-Google-Smtp-Source: AFSGD/VXc/3F28Dy4DhpG/1we4OQgdfVAbAuNpSKYJn3mCgQuX87aq1VQ3RCwbBCuNeuOFmrmRWc7A==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr2616611wrn.11.1543945044178;
        Tue, 04 Dec 2018 09:37:24 -0800 (PST)
Received: from szeder.dev (x4db19e3e.dyn.telefonica.de. [77.177.158.62])
        by smtp.gmail.com with ESMTPSA id i192sm10254970wmg.7.2018.12.04.09.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:37:23 -0800 (PST)
Date:   Tue, 4 Dec 2018 18:37:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181204173721.GI30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <87o9a1z0j5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9a1z0j5.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 06:04:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 04 2018, SZEDER Gábor wrote:
> 
> > The number of parallel invocations is determined by, in order of
> > precedence: the number specified as '--stress=<N>', or the value of
> > the GIT_TEST_STRESS_LOAD environment variable, or twice the number of
> > available processors in '/proc/cpuinfo', or 8.
> 
> With this series we have at least 3 ways to get this number. First
> online_cpus() in the C code, then Peff's recent `getconf
> _NPROCESSORS_ONLN` in doc-diff, and now this /proc/cpuinfo parsing.
> 
> Perhaps it makes sense to split online_cpus() into a helper to use from
> the shellscripts instead?

I don't think so, but I will update this patch to use 'getconf'
instead.

