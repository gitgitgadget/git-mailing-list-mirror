Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52855201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdELF3t (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:29:49 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34594 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdELF3s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:29:48 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so25025022pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6JjEW+ORvMDgvb0Q8rIGxDENnSu5VoZjXkB/5ps5s1s=;
        b=Blbrbg3WhUsHpHAYkEnvrKrHCDpUgq3PG16V84r5O7XkpZHJFW4vbcDdIrSPx6gyKa
         5pYn5yEHszvY2JqUBrCiUq5LSrsTq+6Oh4l1stWP4x1NI+cA5dWFShj/oc/PPvczdZxd
         3nYseBs21AqiTNQtGs77XtVFVeJ9XTQSH/I3Fe1WUAQA688pW2tnWoh6h/r1nSJIEF/7
         JTBPW9CHTDYLdDlAOemVmCLBAKQfWwV1QZYDdbmkE2hXfJCqiEvyOS0Peh3ZB+s4yYKv
         UPlAQNd32shgVoDqv9bip7k+GB9mTm6Fl0v9RjdPHLJRSu4MJkrDa9WjoSFTzSv39eWC
         j7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6JjEW+ORvMDgvb0Q8rIGxDENnSu5VoZjXkB/5ps5s1s=;
        b=Hy7F20GsPZ1IHWF21jCYviVq0YY1mgKUeBZ6jCgvKB9GboBJImSIYGlOI2WxwWLodW
         njV2LozU6iaXOg096C4j/QnXplw73V9F7t8b/MhcXSerXkfHmwkTFfT1ekF17/zkHEJg
         Oc+svXuRqK7RWVZnrCyIwiDmL1DIBhAF9oAuOAuCnZMki+1yWPrK4/Um6i24f3HSneEx
         aDe/FKsu9liNF6CBiy+YNbmnwB+2UV2fALAvKE2AwUEGb50vptNUas2XffppnNfCfrbU
         5tbCVuJm4cP1TdS32ov7IDOLP2prKUSs7+2J4D5HVEgQaQjWgCEwjF/eFRvwu2CaVhvp
         6UHg==
X-Gm-Message-State: AODbwcDOzUBWnYyCcZZcjHiYk6FPzij5WNRwMhunS/NmZtWnhRYt+fTd
        rC6AmQCp5cOleQ==
X-Received: by 10.84.164.199 with SMTP id l7mr3288040plg.11.1494566987682;
        Thu, 11 May 2017 22:29:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id g5sm2573210pfe.34.2017.05.11.22.29.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:29:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705111506030.146734@virtualbox>
Date:   Fri, 12 May 2017 14:29:46 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705111506030.146734@virtualbox> (Johannes
        Schindelin's message of "Thu, 11 May 2017 15:08:35 +0200 (CEST)")
Message-ID: <xmqqd1be7id1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 10 May 2017, Junio C Hamano wrote:
>
>> * jc/bundle (2016-03-03) 6 commits
>>  - index-pack: --clone-bundle option
>>  - Merge branch 'jc/index-pack' into jc/bundle
>>  - bundle v3: the beginning
>>  - bundle: keep a copy of bundle file name in the in-core bundle header
>>  - bundle: plug resource leak
>>  - bundle doc: 'verify' is not about verifying the bundle
>> 
>>  The beginning of "split bundle", which could be one of the
>>  ingredients to allow "git clone" traffic off of the core server
>>  network to CDN.
>> 
>>  This was surrected from a "to be discarded" pile, as from time to
>>  time people wonder about resumable clone that can be primed without
>>  bothering Git servers with dynamic packfile creation, and some
>>  people seem to think that the topic could serve as a useful
>>  building block for that goal.  But nothing seem to have happend.
>>  Unless people really want it, I am inclined to discard this topic.
>>  Opinions?
>
> The primary concern that wants to be solved by these patches is the
> resumable clone, right?
>
> If so, I think that we may want to rethink that approach. If your
> bandwidth is flakey and your repository is large, the upcoming work to
> support fetching objects incrementally (there are three competing
> proposals about this IIUC, hopefully they will settle into a single
> approach soon) may actually be the better way forward.

In short, these won't help, those who asked them to be kept a bit
longer in my tree were mistaken, and nobody will miss them if I just
discarded this topic?

I'm all for that ;-)  The smaller number of patches I need to carry
around, the better.

Thanks.
