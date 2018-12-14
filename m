Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FDB20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 11:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeLNLIG (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 06:08:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41166 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeLNLIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 06:08:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so4605807edi.8
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=toDOwBOWCF0PA9tZ9jrH4b+0VJxl0FNqq2R/c7jvgcY=;
        b=nB8c9QV/H5rxD4MoZCDWFgWpBaBuhAZENmDpPyxuZf1K6LphUmbXr6ufLDJnc3eiRp
         uyXF9sJm6hz/Yn/G8b1CRbGWoLOQA4zf7paiENbNFhiwiUYjTmavjimcQwBmGBczdeoH
         avcVgcR/G350FRA816+iB/it/oMr0MXXe8eYJlvQgwlDzfxcpEShfATzUdI8lh2d6/xX
         a6MwEd3gcn4S5/NcNbsJXEwpdGXy5jT/4URTfs6uxy2yIwudgVcpiLNim/X6LNWvo4KS
         Q/3bkrWr3M1A2GTrFKrqF+n0tNxHI6bqcNqaJTGUVQJ/E6F/wcKezH/SQVMligdxQieg
         0R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=toDOwBOWCF0PA9tZ9jrH4b+0VJxl0FNqq2R/c7jvgcY=;
        b=RtFh6u1irmHMwqu9JfBh8mk+Ns427gi+i20Y0MFe3UtqnOrdmnZHDw9aJbamK4K5zl
         1Rny0dyqeJKD7xLV1jOa3iSY1MC1ysd+eH+R30sncVzu1xuSu3t+EEZ55OGyBLuyAonG
         Yr7rTIh3oeB/VsMHHwDOAuG18EEVs54hbSjq89GMNL8FV5eW4qbZiPhibOsg6y+OU217
         bs/eTeA+FvFgOOogSVtItLRQXPOBNVm5gHX63q5cwJryJ0n2JtA/IhOrinnaOg0maqaX
         phmAnGHnOe8GrMneexmVZ2MRpBiy0lX5czp5/lFl4PvlXlBZ1/MslFRQZFGSuLDHeKnx
         8MDQ==
X-Gm-Message-State: AA+aEWbMKTlgsCrvq5UEuIr0uplxQoZKDxaFc9QG0jwIaUz2N/EBtg+U
        1fNpovTcsg6nukQTaS4MmsQ=
X-Google-Smtp-Source: AFSGD/UJNrzBTlpYJH4fS/wWQqObhS221v9iTYSZ9q3kPNZJ9Kulqzk8u4I7O+urRjpZzQm5wQ4rJw==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr2583708edc.5.1544785683864;
        Fri, 14 Dec 2018 03:08:03 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id 97sm1424166edq.45.2018.12.14.03.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 03:08:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com> <20181213155817.27666-9-avarab@gmail.com> <87pnu51kac.fsf@evledraar.gmail.com> <20181214101232.GC13465@sigill.intra.peff.net> <87o99o1iot.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87o99o1iot.fsf@evledraar.gmail.com>
Date:   Fri, 14 Dec 2018 12:08:02 +0100
Message-ID: <87mup81i3x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Dec 14 2018, Jeff King wrote:
>
>> On Thu, Dec 13, 2018 at 05:08:43PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>>> Now that we have this maybe we should discuss why these tests show
>>> different things:
>>>
>>> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
>>> > index 086f2c40f6..8b1217ea26 100755
>>> > --- a/t/t5500-fetch-pack.sh
>>> > +++ b/t/t5500-fetch-pack.sh
>>> > @@ -628,7 +628,10 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
>>> >  	test_commit -C server 6 &&
>>> >
>>> >  	git init client &&
>>> > -	test_must_fail git -C client fetch-pack ../server \
>>> > +
>>> > +	# Other protocol versions (e.g. 2) allow fetching an unadvertised
>>> > +	# object, so run this test with the default protocol version (0).
>>> > +	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
>>> >  		$(git -C server rev-parse refs/heads/master^) 2>err &&
>>>
>>> What? So the equivalent of uploadpack.allowAnySHA1InWant=true is on for
>>> v2 all the time?
>>
>> Yeah, I actually didn't realize it until working on the earlier series,
>> but this is the documented behavior:
>>
>>   $ git grep -hC3 'want <oid>' Documentation/technical/protocol-v2.txt
>>
>>   A `fetch` request can take the following arguments:
>>
>>       want <oid>
>>   	Indicates to the server an object which the client wants to
>>   	retrieve.  Wants can be anything and are not limited to
>>   	advertised objects.
>>
>> An interesting implication of this at GitHub (and possibly other
>> hosters) is that it exposes objects from shared storage via unexpected
>> repos. If I fork torvalds/linux to peff/linux and push up object X, a v0
>> fetch will (by default) refuse to serve it to me. But v2 will happily
>> hand it over, which may confuse people into thinking that the object is
>> (or at least at some point was) in Linus's repository.
>
> More importantly this bypasses the security guarantee we've had with the
> default of uploadpack.allowAnySHA1InWant=false.
>
> If I push a id_rsa to a topic branch on $githost and immediately realize
> my mistake and delete it, someone with access to a log of SHA-1s
> (e.g. an IRC bot spewing out from/to commits) won't be able to pull it
> down. This is why we have that as a setting in the first place
> (f8edeaa05d ("upload-pack: optionally allow fetching any sha1",
> 2016-11-11)).
>
> Of course this is:
>
>  a) Subject to the "SECURITY" section of git-fetch, i.e. maybe this
>     doesn't even work in the face of a determined attacker.
>
>  b) Hosting sites like GitHub, GitLab, Gitweb etc. aren't doing
>     reachability checks when you view /commit/<id>. If I delete my topic
>     branch it'll be viewable until the next GC kicks in (which would
>     also be the case with uploadpack.allowAnySHA1InWant=true).
>
> So I wonder how much we need to care about this in practice, but for
> some configurations protocol v2 definitely breaks a security promise
> we've been making, now whether that promise was always BS due to "a)"
> above is another matter.
>
> I'm inclined to say that in the face of that "SECURITY" section we
> should just:
>
>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
>    with "this won't work, see SECURITY...".
>
>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
>    default, and will be much faster, since it'll just degrade to
>    uploadpack.allowReachableSHA1InWant=true and we won't need any
>    reachability check. We'll also warn saying that setting it is
>    useless.
>
> Otherwise what's th point of these settings given what we're talking
> about in that "SECURITY" section? It seems to just lure users into a
> false sense of security. Better to not make promises we're not confident
> we can keep, and say that if you push your id_rsa you need to run a
> gc/prune on the server.

I sent that too fast. What I meant is that there's 3
settings. uploadpack.{allowTipSHA1InWant,allowReachableSHA1InWant,allowAnySHA1InWant}. Those
are, respectively, cheap/expensive/cheap to serve up.

We could make them cheap/cheap/cheap by just making the first two a
synonym for the 3rd (allowAnySHA1InWant), because as noted above

Also, parts of the v2 code, e.g. this in 685fbd3291 ("fetch-pack:
perform a fetch using v2", 2018-03-15):

	/* v2 supports these by default */
	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;

Seem to have intended to turn on allowReachableSHA1InWant, not
allowAnySHA1InWant, but apparently that's what we're doing?

In any case, regardless of what v2 intended there anything except having
allowAnySHA1InWant on by default seems irresponsible given x) us
documenting in "SECURITY" that it doesn't really work y) even if it did,
there being a *tiny* minority of people who'd in some way care about
this feature who don't also run some sort of web UI on the git server
that'll be bypassing this setting no matter if it worked as intended for
the wire protocol.
