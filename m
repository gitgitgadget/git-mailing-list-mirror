Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0531F404
	for <e@80x24.org>; Wed, 29 Aug 2018 09:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeH2NJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 09:09:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32790 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeH2NJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 09:09:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9-v6so3394613edr.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/i1w8rO2P4Q9GrTRjPCaylQ5V6U2h25rwscCxz4YYXA=;
        b=Gbk8A/Kt07YiD3bOqcx9RMAz6yI42AJDcmVojAtSKcT/WkkH3Y0AOyS+UM9FNIplhn
         EAdXRuhBOW8Gw3Fh9FpcQpWPVFLwdMg1ZQlYV/m1FhHsRUqJZTMhn+gABTEjY3YAqlEK
         BQiNmWA2Qo5DzcdjsK/2hmK9RBSWE7O0tUiTI7vDVEu2FNoky5Mm37Mxp2aYlAKkeopj
         MDkxoKv59Pog7BrkSxQtO6zsWLjAQxdJznne12Hh+3Ch2+fB6VGjLBEC2yWt2/w4/wWH
         a/qQSEmGgl/o5deEUGTTw9LQcPSgEksyHUNhFWRcWET5OK83uftpMV7JN0dWP33fj7fI
         ppFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/i1w8rO2P4Q9GrTRjPCaylQ5V6U2h25rwscCxz4YYXA=;
        b=cm1O6XvAFvtXVlgN4tgerWFDeFpbXUXHjuclaN/fMy16h4iPkDTzhQDPx8BWEe3oUy
         35cWj38XYHepo53RFHWlBW3KpS6rOVKjXH1B9RBT1JJsyxcFEXBMUbHvkQGC+pUIe06I
         xnJ/HyFcDGytIhGehDmPbgLKeeVzrwyQOMF3ESku7g2JQUNN/yPcIQih0rA2UMveZ0Ng
         ctJxfrQswyKJrhe3b5XQ7BJHqnzTianWvA7JyRhi7GhExHky5hOa7PgoVoBhr6y4ww5p
         YsY29fX0nFyVbmNLA3H17dito8YIQsQvtpndeMPSIA7xTL4YCV3JVgjkYU7MGBTwnwto
         fLtA==
X-Gm-Message-State: APzg51AfndcthukR0CiDaBqPUrNro3PR4JrL7J4ZpdiHU3A+2Egsrfp9
        AlC//KbLmNEDZXf6nLArsfaagzW+Xr8=
X-Google-Smtp-Source: ANB0VdZM8HYbqMePqARrOyC6B6/p0+akO6zlV1xP+fuuQuxL9mHbUegYNKvi+8L4jKQoEzQscWDAkA==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr6622038edv.117.1535534007897;
        Wed, 29 Aug 2018 02:13:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1548543edi.26.2018.08.29.02.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 02:13:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: How is the ^{sha256} peel syntax supposed to work?
References: <878t4xfaes.fsf@evledraar.gmail.com> <20180824014703.GE99542@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180824014703.GE99542@aiede.svl.corp.google.com>
Date:   Wed, 29 Aug 2018 11:13:25 +0200
Message-ID: <877ek9edsa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>>> git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
>>
>> How is this going to interact with other peel syntax? I.e. now we have
>> <object>^{commit} <sha>^{tag} etc. It seems to me we'll need not ^{sha1}
>> but ^{sha1:<current_type>}, e.g. ^{sha1:commit} or ^{sha1:tag}, with
>> current ^{} being a synonym for ^{sha1:}.
>>
>> Or is this expected to be chained, as e.g. <object>^{tag}^{sha256} ?
>
> Great question.  The latter (well, <hexdigits>^{sha256}^{tag}, not the
> other way around).

Since nobody's chimed in with an answer, and I suspect many have an
adversion to that big thread I thought I'd spin out just this small
question into its own thread.

brian m. carlson did some prep work for this in his just-submitted
https://public-inbox.org/git/20180829005857.980820-2-sandals@crustytoothpaste.net/

I was going to work on some of the peel code soon (digging up the type
disambiguation patches I still need to re-submit), so could do this
while I'm at it, i.e. implement ^{sha1}.

But as noted above it's not clear how it should work. Jonathan's
chaining suggestion (<hexdigits>^{sha256}^{tag} not
<hexdigits>^{tag}^{sha256}) makes more sense than mine, but is that what
we're going for, or ^{sha256:tag}?
