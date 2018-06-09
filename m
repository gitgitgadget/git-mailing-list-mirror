Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC1C1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeFIGcD (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:32:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39543 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeFIGcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:32:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so7283191wmc.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l9CaD+yjvOtJg2vajmvAm+cOksuDf2IsBeC8LH+o/5w=;
        b=a1Ned3BAisOEiDA5LMt3RcNQo3jmRgz6vmG4jlKkLQHaQrTRwtxvyJ07xJozhsaVX3
         6xVTPmLMXh3BVlk0ZeXmZtU6m57ynV4/nQ2lBWMLuOu2iGt4E8cpH1pL/NRn6nC+b7oH
         SjFHBE6z/WC12dX91wL/PlafVt3RcE9Cyss2yZkQ6jYYGlSdFSO8ELIXweaX2CQpOe2H
         vLb/hhPMF9lVkqXoCvEDsFSFyYO9lwPiLCsYDsec/JT/hDgGXM4wE99HnniSf8ThI8pS
         0gvlLM+BOihix3Rgzxka2rCVxuwp7w0pFCbUjiUq8SfjwhnVH1WVBwC6uh7iLyTrRVy3
         5NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=l9CaD+yjvOtJg2vajmvAm+cOksuDf2IsBeC8LH+o/5w=;
        b=SoA10IV+aeFfiLjJgXYHBlGh/DoTRimXHF6+16zlpIe5J8XiQuauhdPNMaGcrdlV7D
         vGuI+OAyy1QN//agYQxrSakP38IFESgiB7SCmj+6eS9EMLsHRdb7HFfWNFDEzwHwI5Zi
         HItkCPVl/QDqcWS095yqogQ2/4kiZh+/NfPow2CSrE5ZKYtWm0De2EVpaWAt22uw+E8c
         VI0RsY5069pJXNNDPmOoFuYbDieNaXdTridVxuB/DsURV+41H5N3sEfZ+KVDpje4SzP7
         dwr1Ng4vdOvTodu5Km+kJel02j4BfkDd8rGTfGACSCDhQw328I2cAkVcoyePOjUf4b3+
         j8JQ==
X-Gm-Message-State: APt69E0RZFWZLV+4c51AlSHGpWReHnAVjSDEmwyPfOXWI01rdSva26sc
        rLHt93dkTfGSEmg8jbvj+qsM7KJt
X-Google-Smtp-Source: ADUXVKKheGZnF8TUFw9IOUdI1rqRZXmK4dGDXY/wRabff/Gfn9HL4L3jUC7cVjT6ou8703RA6w5tWw==
X-Received: by 2002:a50:abe5:: with SMTP id u92-v6mr10146473edc.43.1528525920846;
        Fri, 08 Jun 2018 23:32:00 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id k29-v6sm12738252ede.96.2018.06.08.23.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 23:31:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
References: <20180607145313.25015-1-git@jeffhostetler.com>
        <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
        <20180608090758.GA15112@sigill.intra.peff.net>
        <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
        <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
        <87fu1w53af.fsf@evledraar.gmail.com>
        <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
Date:   Sat, 09 Jun 2018 08:31:58 +0200
Message-ID: <87bmck4gip.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 09 2018, Duy Nguyen wrote:

> On Sat, Jun 9, 2018 at 12:22 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Fri, Jun 08 2018, Johannes Sixt wrote:
>>
>> > Am 08.06.2018 um 18:00 schrieb Thomas Braun:
>> >> I for my part would much rather prefer that to be a compile time
>> >> option so that I don't need to check on every git update on windows
>> >> if  this is now enabled or not.
>> >
>> > This exactly my concern, too! A compile-time option may make it a good
>> > deal less worrisome.
>>
>> Can you elaborate on how someone who can maintain inject malicious code
>> into your git package + config would be thwarted by this being some
>> compile-time option, wouldn't they just compile it in?
>
>
> Look at this from a different angle. This is driven by the needs to
> collect telemetry in _controlled_ environment (mostly server side, I
> guess) and it should be no problem to make custom builds there for
> you.

Let's say you're in a corporate environment with Linux, OSX and Windows
boxes, but all of whom have some shared mounts provisioned & ability to
ship an /etc/gitconfig (wherever that lives on Windows).

It's much easier to just do that than figure out how to build a custom
Git on all three platforms.

I guess you might make the argument that "that's good", because in
practice that'll mean that it's such a hassle that fewer administrators
will turn this on.

But I think that would be a loss, because that's taking the default view
that people with the rights (i.e. managed config access) to turn on
something like this by default have nefarious motives, and we should do
what we can to stop them.

I don't think that's true, e.g. what I intend to use this for is:

 a) Getting aggregate data on what commands/switches are used, for
    purposes of training and prioritizing my upstream contributions.

 b) Aggregate performance data to figure out what hotspots to tackle in
    the code.

That's things that'll both benefit the users I'm responsible for, and
the wider git community.

> Not making it a compile-time option could force [1] linux distro
> to carry this function to everybody even if they don't use it (and
> it's kinda dangerous to misuse if you don't anonymize the data
> properly). I also prefer this a compile time option.

Setting GIT_TRACE to a filename that you published is also similarly
dangerous, so would setting up a trivial 4-line shell alias to wrap
"git" and log what it's doing.

> [1] Of course many distros can choose to patch it out. But it's the
> same argument as bringing this option in in the first place: you guys
> already have that code in private and now want to put it in stock git
> to reduce maintenance cost, why add extra cost on linux distro
> maintenance?

Because:

1) I really don't see the basis for this argument that they'd need to
   patch it out, they're not patching out e.g. GIT_TRACE now, which has
   all the same sort of concerns, it's just a format that's more of a
   hassle to parse than this proposed format.

2) I think you and Johannes are just seeing the "telemetry" part of
   this, but if you look past that all this *really* is is "GIT_TRACE
   facility that doesn't suck to parse".

   There's a lot of use-cases for that which have nothing to do with
   what this facility is originally written for, for example, a novice
   git user could turn it on and have it log in ~ somewhere, and then
   run some contrib script which analyzes his git usage and spews out
   suggestions ("you use this command/option, but not this related
   useful command/option").

   Users asking for help on the #git IRC channel or on this mailing list
   could turn this on if they have a problem, and paste it into some
   tool they could show to others to see exactly what they're doing /
   where it went wrong.
