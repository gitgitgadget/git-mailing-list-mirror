Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B42A2027C
	for <e@80x24.org>; Sat, 15 Jul 2017 10:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdGOKp4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 06:45:56 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36515 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdGOKpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 06:45:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id 62so39182677wmw.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2017 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=O6d7/kjcj3fbiM/V3HnCJcXJrb7c1tqS8MRQ3wyGggw=;
        b=N9f7IsdB7PsytWTn5+urZ7t430s0bfhq4Z6VTWTUu9BhQK3IrWQv8zHSl1fuTF9NxK
         BVI0ocgH3u9CvADBL7Aj40cfQbc0+11WSPzXOs4OdVj+eLCZxmyyOAy4kiNfyy5gnwRQ
         /Uc9NtFrDbBiG1ETWEXPtiZrdCAgeP/rfYSlUoR5e3aRWQrTpvIEz7yflYdAmyeDmCtT
         iDCLh+Jz80YdRNjIlmjy0MwcABZrgzJvzb1Ua1A9CC/nrXxjU5HOZLFi/OoZK/5ftvsX
         HMiQl6LNjC2PrTI1GBCsl781xnPx19SjZFwR5LxYiLp99neQl922lXzvqhmD4NAc67J3
         XLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=O6d7/kjcj3fbiM/V3HnCJcXJrb7c1tqS8MRQ3wyGggw=;
        b=qOJmEsykJNZRXuT02moci/b3PjR1lMqcOlaugQM0UD9onKuFTTMr1E2pBXDZ3xyxME
         wFQJFTfU5GxK8JLZQrEZrIYApYvBE5n2gec4rvOp0t+BC7GUwAlqpdr/NZQ4cpVvE9Nn
         YwEFhT89nXDAh/aUmt+/TGaEhDe/G3sMOoqmjV9CxWtt4Yqe51m3mZyi13M2EdZUuDkK
         W8wLrR9i+3tCCMlCg3UFM/fXUKjBESnA9s0udZ8KAbe14RCTS50qcZaOqDm2z4budkJS
         KOZVj/kF4Zy8Iz+MpbD+Nbi8ngeY3UKiqMR8qm9bYwOo9smfOyYRqkHg6kys5+1O6GmH
         V67A==
X-Gm-Message-State: AIVw112tE1ddBwWTrgNEKkZb6kPwKPDoo0Hw82U36+Fule77o/FVQM3b
        N7QWhTfwjUu/PA==
X-Received: by 10.80.175.36 with SMTP id g33mr10030029edd.183.1500115553607;
        Sat, 15 Jul 2017 03:45:53 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id c56sm5284507ede.21.2017.07.15.03.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jul 2017 03:45:52 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dWKa7-0001rS-6P; Sat, 15 Jul 2017 12:45:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
References: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com> <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de> <8760f4bmig.fsf@gmail.com> <xmqqlgo0cm7f.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqlgo0cm7f.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 15 Jul 2017 12:45:51 +0200
Message-ID: <87k23a2d28.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 07 2017, Junio C. Hamano jotted:

[Re-flowing & re-quoting some of this for clarity]

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Which is why I think we should take Francesco's patch (with fixes from
>> feedback), instead of Junio's.
>
> The patch in this discussion is not meant as a replacement for the
> one from Francesco.  It was meant as a companion patch.

Okey, so per the table I laid out in 8760f4bmig.fsf@gmail.com:

>> The concern I have with Junio's patch above (but I like Francesco
>> Mazzoli's approach better) is that the safety of the various --force
>> options, from least safe to most safe, is:
>>
>>  1. --force: You blow away the remote history, no idea what's there, or
>>     if your local ref mirrors what you just wiped.
>>
>>  2. --force-with-lease: Even if you have a `git fetch` in the
>>      background, at least if you wipe a remote ref you have a copy in a
>>      local reflog to restore it.

So with your patch you won't get #2 at all unless you set
push.allowLazyForceWithLease=true.

Once Francesco's patch is also applied (or some version thereof) you can
then set push.AlwaysForceWithElease to make --force mean
--force-with-lease, which is disabled by default.

I think this is really crappy UX design. Now in some future version of
Git I need to set a config option *and* type a longer option name to get
behavior that's an improvement over --force.

To get the --force-with-lease behavior by default on --force I'll need
to set two options, one to alias it, one to allow the option it'll be
aliased to.

> As I view the form of the option that relies on the stability of
> remote-tracking branches strictly worse than the honest "--force"
> that loudly advertises itself as dangerous (as opposed to being
> advertised as a safer option, when it isn't), I consider the change
> to require users to opt into relying on remote-tracking branches as
> a prerequisite before we can recommend the form as a safer version
> of "--force".

How is it being advertised as strictly safer without explaining the
caveats after my f17d642d3b ("push: document & test --force-with-lease
with multiple remotes", 2017-04-19)?  I think we now do a very good job
of describing the caveats involved, but maybe I missed something.

If you think the documentation is now over-promising can you point out
what parts, so I can fix them.

I think we're really losing the forest for the trees here.

I've had to help a lot of people (mainly inexperienced people @ work)
after they --force pushed something.

It would be a *huge* improvement if git shipped with a default such that
I *knew* that whatever they just wiped away could be found in their
local reflog, right now you need to ssh to the git server and dig around
there to see what they wiped away.

Most of these people are not running some auto-fetch editor thingy the
presence of which is is your motivation for removing the lazy
--force-with-lease, and even if they were these people would also
benefit from being able to run e.g. `git reflog
refs/remotes/origin/topic` to see what they just nuked once someone more
experienced shows up and tries to recover from their mistake.

So I wish we could make --force eventually mean --force-with-lease, but
it sounds as though you'd like to hide that behind two config options.
