Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80331F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbfHBQ7Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:59:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45780 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfHBQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:59:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so36323252pfq.12
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1enicwWr49syDCdzz1BNioIr0eIU2st2vbcuFMbMq4=;
        b=jhKssXU0DGDi7ekjFtxJhANTodRYBMpTV74jQX27lr9efAjqs8Nm44QutLA+Gq+DWu
         KJQyUJR8o0xX0YkySoO6Bt4hZ/12+sFIQoQ3KlBmzXfG4Y39lnxCZSlhJxd/wuDoHrrD
         A1+X46Js4d0FbBHk4KzqY2PPBnP7XDedWBOUW2lwZtrHQSLM91A2WrzvAjlXUTPlofcN
         rlVAjIhUuGHZEtELrNgrIuRUt9wki2o95lAOhSMXQnImb+GboMUcy4Q1DItSACkHZnDn
         vFMKgIMH95dxwHywGRPfHYeiXpyiEC6wBj9rwNco+HYvbaRNcC+XYVFYCcpqcELxPanu
         cv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1enicwWr49syDCdzz1BNioIr0eIU2st2vbcuFMbMq4=;
        b=V9EIreMFrgrC1CCNy3ej9J+Czwya/cRX2gS9tnHKKvtwJK0zKaFVDvmYD213wNr3LZ
         cyCS+Hye91NQyxNHSD94dTV6OvMH+7ty5Jladen2m/MLyjvp3Q/anQuiRlVByeEPFiJZ
         6M1KYysPJ6UJ89KfT0fgI1GSg2HU6IeZA0ohRnKPHamvSt2BUJ3rgEhelyeex4i4SJaW
         Aj9a9ehbG1GrmlQBRMyKqJER94XDobxmS8g0KQpz8lfy9So+woF8uicRGfDnbnb7AV9f
         K/aeYUi1CDr8mJQYzQYnNpcsCejGG1Ix5MBH3cub5PqpKGvT7QLrWxyP7lNgL8TS8qpt
         Zh1w==
X-Gm-Message-State: APjAAAWzlZ5VpvMwUal8sb7sdGucM6eeQ0WB26T6YuixYbx0b7vtdzv2
        h2+wDcwrLMSFnuya3ua3yqk=
X-Google-Smtp-Source: APXvYqw9rIPBoBhMNiwNXvacDJ8V+H7iDJ+6NA1Xx2g3BQhZz0s3I9H6d7cgjsXrjjLG34xqLrSONA==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr5014842pjc.3.1564765155782;
        Fri, 02 Aug 2019 09:59:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s5sm58500642pfm.97.2019.08.02.09.59.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:59:14 -0700 (PDT)
Date:   Fri, 2 Aug 2019 09:59:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Steadmon <steadmon@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
Message-ID: <20190802165913.GA109863@google.com>
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1564009259.git.steadmon@google.com>
 <20190725234229.GM20404@szeder.dev>
 <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet>
 <20190726220348.GF43313@google.com>
 <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com>
 <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Thu, 1 Aug 2019, Jonathan Nieder wrote:

>> What do you think of making the validation disabled by default and
>> using a parameter (see "Running tests with special setups" in
>> t/README) to turn it on?  That way, it should be okay for it to take
>> 10 minutes because this would only affect such specialized workers as
>> choose to set that parameter, instead of all of them.
[...]
> So how about adding a separate test script that activates Trace2, then
> runs a _few_ selected, very specific commands, starting with a set that
> Josh thinks representative, validate the generated JSON, and then only
> add new invocations if we *ever* see violations of the schema, to verify
> that we don't regress on that front again?
>
> Such a script can't take more than a couple of seconds to run, I am
> sure. And it would totally strike a sensible balance between benefit and
> time spent.

I think this suggestion has been covered a little upthread, but
apologies for not paying it the fuller attention that it deserves.

Such a test would check that

* the validation code still works, the schema is well formed, etc
* traces produced by common commands fit the schema

That makes it very likely the right thing to do.  This is a test that's
cheap to run, so we can make it happen automatically as part of a normal
test suite run for any developer that has ajv installed (including
various CI jobs).  And it unblocks getting patches 1 and 2 from this
series in.  So, basically, you're right. :)

That said, it still leaves an unmet need that is important to us.

We cannot trust the JSON output and rely on it without a more
exhaustive test that the schema is accurate.  It is very easy to add a
new field or event type that only shows up in a specialized code path,
without remembering to update the schema or docs, because of the
nature of how the trace2 API works.

In this thread, you can already see some of the fruit of this more
exhaustive approach:

- it identifies the tests that write invalid UTF-8 to the traces,
  illustrating an issue with the format (i.e., a real bug) that we
  can now be more aware of

- it identified a field that had been renamed in code where we had
  forgotten to update the documentation

The exhaustive approach really helps.  Arguing against it kind of
feels like saying "leak checkers are great, but why run one on the
full test suite instead of a dedicated tool that exercises the code
paths where you expect to find leaks?"

In the short term, we can run tests internally to check that Git keeps
following the schema.  Let's not block patches 1 and 2 by this ---
instead, the simple basic functionality test you're describing seems
like a good way to make progress for the moment.

We can upstream it later.

Thanks,
Jonathan
