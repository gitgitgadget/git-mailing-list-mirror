Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9486A207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979538AbdDYA4x (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:56:53 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35543 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756369AbdDYA4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:56:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id v14so15595946pfd.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2xnzpzboFXm0vgF0hOsdYdRQejTxELILuiKT3xxSZqk=;
        b=EGaEHwgW/pPyoyJXns9lpM3CwGlghNpWeV5Yccxus1+OxzZtqybsGaLL+lDUW8z1vp
         IVlhN3eT5FXTBtcInAaEQz0praq05WYmvEmoD3HlgrCDgAI/oRZvZDCoEnwRmaRn6yvq
         tQdzeAFyOYyIf3w1yXoEQrq6cbnjmMlw+ePS0UUPvADz3OLp3vzH2PT+pOqjbKpQ5/oF
         j5aTvxmrEawhKExnW9EMzhFrZCVV7faDLDQ51G1iNF1rttsBNku8uZ6x5mKSbbNzrdk0
         SmlGaRWd5HUMZf4aj9yQzVfJY+uW+Kzcy+rSEs87TVf9gQ8n65pAKeqYU4zJwkM1CmuA
         FVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2xnzpzboFXm0vgF0hOsdYdRQejTxELILuiKT3xxSZqk=;
        b=oCYNnxlWG2fuHD3dQjBGFl3ral6gJAfebXBBdacipWwrr182e0KrlGqo77apR4/IOa
         4RUvhofT90BDfUiwT75WrYJGHcCzpWvsjdKtwIuBTOKvHT+CQgRv+V+0YKBjXSDwTpaR
         LljFdXp3bgnpfRNadPQIAc7cMTh+1UQz+Dj5NYZpyOQQa9jarXcITRUGcGYcP9ChN83G
         M3j5I5lhCEHEiA5MaURTt9LxScYcUQgjhtV4aohSkTQ9O07pGlKyvpmK+KxTZuNHHnLt
         ZJCeSNeh30dIWHiw3vvf9vJXnA7jlXx/Up7yy2V17yPTjXHVvIz4BfdXrfmD71nWnMTW
         hjLA==
X-Gm-Message-State: AN3rC/5QUtLwwtUf8mdFOwCiw9vuk+DSFewYInkjRNHw0OrkcVrbdsp0
        QZtNEOZGE6FPJQ==
X-Received: by 10.84.231.136 with SMTP id g8mr27849843plk.12.1493081810867;
        Mon, 24 Apr 2017 17:56:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id p16sm32865754pgc.4.2017.04.24.17.56.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 17:56:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
        <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704211135430.3480@virtualbox>
        <xmqqfugy4pnx.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241609300.3480@virtualbox>
        <CACBZZX7AmzFw-jVC_hd1t+qjK5jD485XD8g6U72p4RLoRD_kJA@mail.gmail.com>
Date:   Mon, 24 Apr 2017 17:56:49 -0700
In-Reply-To: <CACBZZX7AmzFw-jVC_hd1t+qjK5jD485XD8g6U72p4RLoRD_kJA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 24 Apr
 2017 17:18:57
        +0200")
Message-ID: <xmqqbmrlz4mm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Is getting the results of these builds time-critical? If not perhaps
> an acceptable solution would be to use a source repo that's
> time-delayed, e.g. 24hrs behind on average from Junio's git.git, and
> where commits are pushed in at some configurable trickle.

Because the tip of 'pu' is updated every day, but the tips of
individual topics are not, the tip of the more stable side of
integration branches are less often updated, I would think that an
automated procedure (whether it is Travis or Dscho's Windows thing)
that is most efficient for us would:

 - treat updates to 'maint', 'master' and 'next' as they do right
   now;

 - use update to 'pu' as a mere "trigger" and not test 'pu' as an
   aggregate as it is not very interesting (merges near the tip may
   be merging known-broken topics, like yesterday's pushout).

And arrange 'pu' update to trigger a procedure like this:

 - Grab the list of merge commits beyond what matches 'next':

   $ git rev-list --first-parent '^pu^{/^### match next}' pu

 - For each of these merges:

   - If its second parent (i.e. the tip of a topic) was already
     tested with the current 'master', do not bother testing it
     again;

   - Otherwise, call its second parent "it" in the below:

     - Create a merge of it (and nothing else) on top of 'master',
       and test it.  Each topic is intended to be able to graduate
       without other topics in 'pu', so this will catch potential
       breakage early and help blocking a broken topic from getting
       merged to 'master'.

     - When the above fails, test it in isolation to see if it
       itself is broken.  If this succeeds, we may have discovered
       unintended interactions between the topic and other topics
       already in 'master'.  Or the topic itself may already been
       broken.

     - In either case, record the test result so that the same tip
       of the topic would not have to be tested again, merely
       because the tip of 'pu' got updated next day due to updates
       in other topics.

We can s/master/next/ in the above description (I am undecided on
pros-and-cons between using 'master' and 'next').
