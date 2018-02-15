Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE081F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755773AbeBOUbh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:31:37 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35187 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755769AbeBOUbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:31:36 -0500
Received: by mail-wm0-f47.google.com with SMTP id x21so3203464wmh.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y1m0b+OiRulJXs/a4I59hbF874fREV/rhN739cSlVks=;
        b=d3zd6zjehvsqRPt08jIW5FwlPK6ytsjCCg5oOQXjdGRRFM5h+n17eEPfLxrv8oGmri
         pPjEbd+k7nKaUx+PABN96bZUo1NFxg+G/B2qQSJorh6twbXh0d2Sfbfj0STwjRItEX8V
         jJlmlF6p3bwRc9DXNJABMre70DvF6T9twwRqgJnAjE290Wv7nH0oSOkkGd/5P9MtF/6f
         bCn6YBWO4XZvSwjMpEI8Dx+lbsmI4dZbz9Ud6wexQcSYLfFUs6C4/ec2olnJ1g7Af3Fr
         CCi1fHkMhbaImjD9UTY3GnFzi+Vb2DyutK2fsu6PeQik3CTNZUVsJdhrgz3XwItSnSGC
         lg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=y1m0b+OiRulJXs/a4I59hbF874fREV/rhN739cSlVks=;
        b=r7C6h/tNRT6V6S9sqhv9N4ND3sLiKMu9iUsiZl9waBT6TWYaEXegs18CoZRmm0v5I2
         We+1oY6BTpYz2XXlQkdxJIKfieLEZSr4i5w01LVOC35y7Q1iZ8cpWjjuU75D6gTkTbcA
         A5LEKgtKMzgFf9W4eOR4VkZTekRtrT3yCZ5iqeJI5EApGlt3IuP6NNRYKnAZ1GdP/5kK
         uGev3LzBmXXmeq+5JMoqz0vv/enWy+7Vg++NjmtpZrRhiKY0MSWdKQkwNjpxNDsa+Gzi
         Xe2UoQZ4P/X2dY+FSAL7pGugW6PPVEp6hBwcBKLCbiY/cUOE9x6Inf1X92JIoob3vCj8
         HlAQ==
X-Gm-Message-State: APf1xPB33JkuDW03Xm4L9yiroPU3/bJ2012CG0sf9RDAYk5BvJbySPpT
        avpvvn4v9TIfP8QPWwk0GtU=
X-Google-Smtp-Source: AH8x224flrHnnhILrSdMmeg5z+cFeTsW297qsDFOFbYW+QAtSDSFb36DLjx9nDxqLqMZPG1PUodHtw==
X-Received: by 10.28.235.6 with SMTP id j6mr2903482wmh.22.1518726694744;
        Thu, 15 Feb 2018 12:31:34 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id 137sm14186938wmm.46.2018.02.15.12.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:31:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 5/8] perl: update our copy of Mail::Address
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-6-avarab@gmail.com> <20180214234630.GE136185@aiede.svl.corp.google.com> <1227220836.729681.1518687134631.JavaMail.zimbra@matthieu-moy.fr>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <1227220836.729681.1518687134631.JavaMail.zimbra@matthieu-moy.fr>
Date:   Thu, 15 Feb 2018 21:31:29 +0100
Message-ID: <87tvuif10e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 15 2018, Matthieu Moy jotted:

> "Jonathan Nieder" <jrnieder@gmail.com> wrote:
>
>> Ævar Arnfjörð Bjarmason wrote:
>>
>> > Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
>> > 23, 2018). This should be a trivial update[1] but it seems the version
>> > Matthieu Moy imported in bd869f67b9 ("send-email: add and use a local
>> > copy of Mail::Address", 2018-01-05) doesn't correspond to any 2.19
>> > version found on the CPAN. From the comment at the top of the file it
>> > looks like some OS version with the POD stripped, and with different
>> > indentation.
>>
>> Were there changes other than the POD stripping?
>
> No.
>
> I should have mentionned it in the commit message, but the one I took was
> from:
>
>   http://cpansearch.perl.org/src/MARKOV/MailTools-2.19/lib/Mail/Address.pm
>
> i.e. following the "source" link from:
>
>   http://search.cpan.org/~markov/MailTools-2.19/lib/Mail/Address.pod
>
> The link name suggested it was the actual source code but indeed it's a
> pre-processed file with the POD stripped.
>
> It would make sense to indicate explicitly where this file is from in
> this commit's message to avoid having the same discussion next time someone
> upgrades the package.

I see that I'm being a complete idiot and added the *.pod file in the
distro instead of the *.pm file, I got it from metacpan and didn't check
it carefully enough (and only tested with system Error.pm removed, not
Mail::Address), sorry. So yours was the right version. Will fix in a
re-roll.
