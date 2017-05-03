Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831F9207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbdECK2A (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:28:00 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35222 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbdECK16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:27:58 -0400
Received: by mail-oi0-f42.google.com with SMTP id l18so27624095oig.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2fzNPRGx5WAU2yDScMf8B0mEbjJSZR2FgKRGR8C3Ta8=;
        b=SN7Ki0VwK89KJa4ulhYo0bqK+z5hx/IZT7VLVFzk8JQPP3CATEVwcl5QJfTNZlnMuP
         ePc9CzS0x0pdQH4fd6O1wRhaMxOyPKH8VhrUSQBSAK3gVedj+R84D0idOc7fg4/IUxIn
         zbIGAzDv44kyqIQ46Vs1kzO0qfUcmkEWCN3PfAtccSloLu2uJfsQYXgt1dB+xvGO51Fc
         ZGh9BeU9ywyNuRKy3KLM9NgSJ6FmZJIUmjg64RoKO9+RcfeksZt5H9ldewThg/YUrqZh
         1kLWYDjVsIfTiOHnLSLYwJDvy/fzsRYloDN6RM4nKtS9S4kF2IA6tn4Ep/LB+nUrwuL0
         vbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2fzNPRGx5WAU2yDScMf8B0mEbjJSZR2FgKRGR8C3Ta8=;
        b=bMmNdGdAO/nb8XCugL3VC/E3wmNH5CLTZEpI0a0PkK8SD8MKlPAzA8mNcg46hckGOn
         0X3+qvtNtC1sVHou3mv7TGMyJb96xWDRcDEGbv6NnE4mw/sGI25k0leeZf9Ue9+lM4u3
         JlmdJAg2dpMWzO4iqXVAiMifJevPcHdG7QpQMN5q1DjSfgAlESsrWhPygttG/5cuqRG7
         rSYZVf+ixydBwG7CVLPY6kyXldJ0eO2toUJMNCqBhA7G0J5FxP0moAgS57uwWt6sYtdv
         Iht3KEmFCtRuWn82jDdC53mRHF1cJZIkmNYpiJrpGvLjh4DEyp2kAsSojekDMa14sYRf
         6Ibw==
X-Gm-Message-State: AN3rC/7Rk4ChysSGkWTlzjOz09v0S+krReFb55P9FyAjDXrce0b6rc7g
        v9RdhwDhnqKbndjd+RALLM95dzdMHw==
X-Received: by 10.157.12.253 with SMTP id o58mr13682028otd.122.1493807278032;
 Wed, 03 May 2017 03:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Wed, 3 May 2017 03:27:27 -0700 (PDT)
In-Reply-To: <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 May 2017 17:27:27 +0700
Message-ID: <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This applies to origin/master.
>>
>> For better readability and understandability for newcomers it is a good idea
>> to not offer 2 APIs doing the same thing with on being the #define of the other.
>>
>> In the long run we may want to drop the macros guarded by
>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>
> Why?

Well.. why did you add NO_THE_INDEX_COMP... in the first place? ;-) j/k

> Why should we keep typing &the_index, when most of the time we are given _the_ index and working on it?

I attempted the same thing once or twice in the past, had the same
impression and dropped it. But I think it's good to get rid of cache_*
macros, at least outside builtin/ directory. It makes it clearer about
the index dependency. Maybe one day we could libify sha1_file.c and
finally introduce "struct repository", where the_index, object db and
ref-store belong (hmm.. the index may belong to "struct worktree", not
the repo one...).

So yeah it may look a bit more verbose (and probably causes a lot more
conflicts on 'pu') but in my opinion it's a good direction. I wish
Stefan good luck. Brave soul :D
-- 
Duy
