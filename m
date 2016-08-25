Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996F81F859
	for <e@80x24.org>; Thu, 25 Aug 2016 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757207AbcHYVEB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 17:04:01 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36414 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbcHYVD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 17:03:56 -0400
Received: by mail-it0-f51.google.com with SMTP id e63so296327422ith.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PirFC6eLy+elIWwAJzpBla02v/mKlYxEJzK91mg6wQc=;
        b=NEx+Y/WMCoIEbOYZDGhoRSM1gnM/NFYOw7tBI5gM+vGThKCNC3axAAZpZBckCdNKh8
         hmiSvBWwM51LoTxSuUsRLPbD7aJD/Ahw6MUilgC35X6IvXx7TNyOjFYLEzkxgWeVzNte
         R5gjxxgEN1/M0fw6lxqwZ5b2GNJAmY8wngwj5s7CDYSasdCXqZ9Ts5EgzoFA6PNAGCui
         zBfU4taW4dRi1S7czC+SQgsUXcX2uSJmocUfmMPpNzfzL3zYJv1QvQz3BcTIqmMXztDf
         PKk7xyu6BW7f1lcx/UQdaEcgSQA/HzOaiAlMjYAF4bp088zaamWLrI9CjdhheP1C58iN
         14HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PirFC6eLy+elIWwAJzpBla02v/mKlYxEJzK91mg6wQc=;
        b=Acx5Gze1TiwiYpNo5h2h2xwmGUYsfqUYhDlqSWzQnU+IotNe8NUrMhlowuts+YXSoN
         PtUNCBcp2/926ziAffbF03cIpTa4jFDanIhrUkVjK2gVzr7M4+7wYa80lRb8iKchrDHv
         u74gORYY9O7Z0Um9XiVrA557fKmK3NLyttvDj3dabAtoL9S9j6Phm5R2KieC3LHrkRJD
         GsgsjpDpmltTkbU7M+/Qkwf4uJl+GKFJmUxVotVUZ50HX5BTaKXBbt24WJORa1frjtxW
         Aew3tyMZ+M97td3ZQ5nc2FbhSy9Y/faigoJwElOg6KK2OX8dT6N/LyKj0FA9mqBWh79Q
         X8XQ==
X-Gm-Message-State: AE9vXwNfiZUUO5M6m8nr7fI3SoihWIGCBVXcJJYl73Fi6hca4fCxWD3TGjeSEOLL2H3egKW7oyy2iqAVCKIuv0FB
X-Received: by 10.36.189.76 with SMTP id x73mr7020504ite.97.1472158560019;
 Thu, 25 Aug 2016 13:56:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 25 Aug 2016 13:55:59 -0700 (PDT)
In-Reply-To: <xmqqlgzklgiy.fsf@gitster.mtv.corp.google.com>
References: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
 <CAGZ79kbHfofmowHnwzFrumc1XJHE=ZMQEwNSeOSyF7YDG+aSjw@mail.gmail.com> <xmqqlgzklgiy.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Aug 2016 13:55:59 -0700
Message-ID: <CAGZ79ka60e2Y87k6oKtTN9e0ZexHx2GfJ7yfhvyQon_VgbUgNA@mail.gmail.com>
Subject: Re: Feature Request: Branch-Aware Submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hedges Alexander <ahedges@student.ethz.ch>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +cc Jacob and Lars who work with submodules as well.
>>
>> On Thu, Aug 25, 2016 at 2:00 AM, Hedges  Alexander
>> <ahedges@student.ethz.ch> wrote:
>>>
>>> Right now updating a submodule in a topic branch and merging it into master
>>> will not change the submodule index in master leading to at least two commit
>>> for the same change (one in any active branch). This happened to me quite a few
>>> times. To a newcomer this behavior is confusing and it leads to unnecessary
>>> commits.
>>
>> So you roughly do
>>
>>     git checkout -b new-topic
>>     # change the submodule to point at the latest upstream version:
>>     git submodule update --remote <submodule-path>
>>     git commit -a -m "update submodule"
>>     git checkout master
>>     git merge new-topic
>>     # here seems to be your point of critic?
>>     # now the submodule pointer would still point to the latest
>> upstream version?
>
> Isn't <submodule-path> subject to the usual 3-way merge when the
> last step (i.e. a merge of new-topic branch into master in the
> superproject) is made?  If 'master' hasn't changed <submodule-path>
> since 'new-topic' forked from it, because 'new-topic' updated the
> commit bound at <submodule-path>, doesn't "git merge new-topic" just
> take that change as the normal "One side updated, the other did not
> touch; take the update" merge?

Yes. I was unclear here.
By "latest upstream version" I meant the version you pulled in in the new-topic
branch via the "submodule update --remote" and that is preserved as is.
