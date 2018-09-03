Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3B51F404
	for <e@80x24.org>; Mon,  3 Sep 2018 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbeICRii (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 13:38:38 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46312 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeICRii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 13:38:38 -0400
Received: by mail-wr1-f49.google.com with SMTP id a108-v6so598937wrc.13
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kNvVpXeBMm0S9VFpP2JIbJaYb9lQHOuY2rK+N35YQ2E=;
        b=YLaryGa2V7P6m7R6J9oh/5RcDvUY7ZLS4Uwp4S9SNsQocsD2xCKBPIvMj1X18tSvLM
         jsTwRsgRDonjVoyNoSQEQJgPAE99o+3UcurF1XgnPtCpcnk1xcROYDd5c7NiadHF/bP3
         lMLdtg3SGHDPYuY23fV2jXvXL/xJ/X0rv6DHFHoI/O2fTfQ9/coDGZQd+7WJFxe0LxG/
         CwcwePFWAe/A+ujgqTo538vXkdBdmyWpCF6QAubJ049OHT3fXrfJgbW4YHGB1DDH5qYv
         SH+aB81KuIp/AqoPwrEy+CYpcC7kq0MC/rnpARJHVKLser0fA43zkwKeuA4M1z+zqOdj
         c7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kNvVpXeBMm0S9VFpP2JIbJaYb9lQHOuY2rK+N35YQ2E=;
        b=KfJx7RBaunh5uGPxD5Xn+9Gku62XWhGMsQvGPYl8caGxWqnm8BX3IMuVZqg+jTtb7W
         aq9hDLhTjWy/Mp3Wj72SPBZEODNz9etcC/FNhA872gJR2ja+itE4lku4t4ON7Z/W7fMH
         pz9iPHc68HSxkCWx1/V+AQ3MlqXIaOh5Uv+UGU75/wYdpqiDrz7Uo79tFyggxA1Pqg5A
         pmsRHkCMRNogdPKpQDDll9qwIFY0DuFo0VbF9ySXzTHn1i+P1jVbmNjjiK3U6qZnivqs
         0sA2IXAXR/n25gdAx9bGnX/1S2D9WTfJQPrV3QzvBn/MstwCKtTFenO65pcaAc35vLak
         RnwQ==
X-Gm-Message-State: APzg51CIFPrxJDETrahPkIpvZyRC+3Cl/1vK8KF8kvswfY02Clp0GZkx
        AIchOz3BvxHu0YY5ohwmXH5ziFnr
X-Google-Smtp-Source: ANB0VdZHWN6g12dRygRXJwfiODrhazycyWjxcNiaA9wTtMFe3PhHpCGfMZlO2Lt9GlAzp+1Agt1iLQ==
X-Received: by 2002:adf:9503:: with SMTP id 3-v6mr18551250wrs.251.1535980709431;
        Mon, 03 Sep 2018 06:18:29 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id k34-v6sm32452644wre.18.2018.09.03.06.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 06:18:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should accept --author
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
        <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet>
        <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
        <87r2igca0s.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1808301607030.71@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1808301607030.71@tvgsbejvaqbjf.bet>
Date:   Mon, 03 Sep 2018 15:18:27 +0200
Message-ID: <87o9debty4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Thu, 30 Aug 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Thu, Aug 30 2018, Johannes Schindelin wrote:
>>
>> > On Wed, 29 Aug 2018, Junio C Hamano wrote:
>> >
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >>
>> >> > The `stash` command only incidentally requires that the author is set, as
>> >> > it calls `git commit` internally (which records the author). As stashes
>> >> > are intended to be local only, that author information was never meant to
>> >> > be a vital part of the `stash`.
>> >> >
>> >> > I could imagine that an even better enhancement request would ask for `git
>> >> > stash` to work even if `user.name` is not configured.
>> >>
>> >> This would make a good bite-sized microproject, worth marking it as
>> >> #leftoverbits unless somebody is already working on it ;-)
>> >
>> > Right.
>> >
>> > What is our currently-favored approach to this, again? Do we have a
>> > favorite wiki page to list those, or do we have a bug tracker for such
>> > mini-projects?
>> >
>> > Once I know, I will add this, with enough information to get anybody
>> > interested started.
>>
>> I believe the "official" way, such as it is, is you just put
>> #leftoverbits in your E-Mail, then search the list archives,
>> e.g. https://public-inbox.org/git/?q=%23leftoverbits
>>
>> So e.g. I've taken to putting this in my own E-Mails where I spot
>> something I'd like to note as a TODO that I (or someone else) could work
>> on later:
>> https://public-inbox.org/git/?q=%23leftoverbits+f%3Aavarab%40gmail.com
>
> That is a poor way to list the current micro-projects, as it is totally
> non-obvious to the casual interested person which projects are still
> relevant, and which ones have been addressed already.

I don't think this is ideal. To be clear and in reply to both yours and
Junio's E-Mail. I meant "official" in scare quotes in the least official
way possible.

I.e. that you need to search the mailing list archive if you want to see
what these #leftoverbits are, because the full set is stored nowhere
else.

> In a bug tracker, you can at least add a comment stating that something
> has been addressed, or made a lot easier by another topic.

Yeah, a bunch of things suck about it, although I will say at least for
notes I'm leaving for myself I'm using it in a way that I wouldn't
bother to use a bugtracker, so in many cases it's the difference between
offhandendly saying "oh b.t.w. we should fix xyz in way abc
#leftoverbits" and not having a bug at all, because filing a bug /
curating a tracker etc. is a lot more work.

> In a mailing list archive, those mails are immutable, and you cannot
> update squat.

In a lot of bugtrackers you can't update existing comments either, you
make a new one noting some new status. Similarly you can send a new mail
with the correct In-Reply-To.

That doesn't solve all the issues, but helps in many cases.
