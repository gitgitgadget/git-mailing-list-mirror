Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E621F453
	for <e@80x24.org>; Thu, 25 Apr 2019 14:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDYOgT (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 10:36:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfDYOgS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 10:36:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so17975pfo.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xaVUyOlMKOolNKKv3loCVrP2X5TfjIHGNPO6U067vJA=;
        b=PqX7+wv7GjMAXofUmXxd/BgGTZ+Eahqoovn3MD/RsQKQUxmR4JF0QhjlizLNAOEasO
         6Q2NZ115+aQ+8aA5rdZeL/JtApVPbyTJ8sqok+VzKkBob2pu0L6UxTAevug1ab+KT/fg
         KK7twXzFKHdpiYrVmD2bFfHSkmAIEBG1VV2GGn+BwZ/9ORHfFCZ5mqnu8Ar9hUucuRg1
         kKzLMtaVU/su9kRDCeVLHi5QE2RErUVm+KV28SeEwaqvH+PSTXSrFoNGEuyKc9igmY1F
         kcmW7e/9Z66vA1q9RcsYye4ri5DpRubEplHpWkM5hKRM/xwgL1h2+9EC+3tTSiofN3IT
         VjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xaVUyOlMKOolNKKv3loCVrP2X5TfjIHGNPO6U067vJA=;
        b=d5wLtsmPJGl8fn9kYJbggyuy05Sys/FxX/2sg4zCQiTASXD6PlbPojI9BQvYrGiEtF
         V/oV1D6JDIhQD27BNtfYizEJMzB47BpvzUN8D18lvv0gy0QVAzj0l9j5o23VPSJXh8qF
         XaoimX9Ccqc7ZVRTJxSntH8kw7WL31NB8BTEMa+pmpDtS0IyGH69wOlAO9caB89im2O0
         x5wiFXraXzDFvxkrLGt12K2uoTDdoqUXxHbQePYKAQm6/HErDVk+BhRInBdmX/u8YCDW
         EoPHGqGuuTc9d0LxRI9lFFEQxNVtvMelK889GPnN/oyYMji678xKqwqcWHm8ZW1nZUFr
         oShA==
X-Gm-Message-State: APjAAAWVuceuGS7+VQdkVs9U6LNHt5FsnH+tk8qkuMeqSi0ZcP+fpC36
        sswPCZ20UUrfoEZTZtOx9Rk=
X-Google-Smtp-Source: APXvYqw33D7pwcGVmom5ruRB0W3mXGMtZUANgvjl0dlO2WiowleigGtWuJaz9poTfqcGeFj8K2U4kQ==
X-Received: by 2002:a62:6a81:: with SMTP id f123mr41398009pfc.40.1556202977365;
        Thu, 25 Apr 2019 07:36:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id h15sm24888605pfr.146.2019.04.25.07.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 07:36:16 -0700 (PDT)
Date:   Thu, 25 Apr 2019 07:36:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
Message-ID: <20190425143614.GA91608@google.com>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1fis8gq.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Because we don't have some general config facility for this it keeps
> coming up, and various existing/proposed options have their own little
> custom hacks for doing it, e.g. this for Barret Rhoden's proposed "blame
> skip commits" feature
> https://public-inbox.org/git/878swhfzxb.fsf@evledraar.gmail.com/
> (b.t.w. I *meant* /dev/null in that E-Mail, but due to PEBCAK wrote
> /dev/zero).

I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
That is, I thought the intended behavior is always

 1. For single-valued options, last value wins.
 2. For multi-valued options, empty clears the list.
 3. When there is a special behavior triggered by not supplying the
    option at all, offer an explicit value like "default" that triggers
    the same behavior, too.

and that any instance of a command that isn't following that is a bug.

Which of course leaves room for improvement in documentation and how
we organize the implementation (as Peff discussed in [1]), but isn't
it nice to already have something in place that doesn't require
inventing a new syntax?

Thanks,
Jonahtan

[1] https://public-inbox.org/git/20180406175044.GA32228@sigill.intra.peff.net/
