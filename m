Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B67202A7
	for <e@80x24.org>; Tue,  4 Jul 2017 08:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdGDIYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 04:24:35 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35637 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdGDIYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 04:24:33 -0400
Received: by mail-wr0-f169.google.com with SMTP id k67so244463430wrc.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4JPoSpXYAQ+oSw3/sijlbRIbeXFTA3xphdU0N+wvJdI=;
        b=TwKLMXK18Bmf3peXh8SIRXGpGMkC1yUrvwcTn0QmQ7aXF5WZA8aWOM/42voNw/vxZa
         8Aj83b2ufiVNBdLeXpr6EtCWzGEcsVm9pWEHepLCwp2eOGgA+wjrW176ul4fWUSNXtyk
         ONgdIr9/jE2+MEkw2sZotmzF2ofr6cYAuarI9r1YbZDckpZldwDfkM386NFh56VbGo7G
         d1Ye02UMPeFDMcayonATtI5FDQxUHQrCDrlnV3R4+KCntDeucpkSuHVEa5jjHcQmcz85
         k3uFQsDLb0W6JePseYtFYKXRBFHeRhYnfAs4BK6BvjP9mXhdWFbQPQmYqU+qLF/OI+rU
         IAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4JPoSpXYAQ+oSw3/sijlbRIbeXFTA3xphdU0N+wvJdI=;
        b=keAGQu4FmWhxbN1rxB9zmxkP2MUapQZ15fSExLCTdT+SICA4ChIWdKJJ3lf6b+ldMe
         MHQMV9oc/ORupiDPNrh6Gmz3vYYUImZud9h/4qcQuhD4jYCeN/VT4wXY3ODulpIZl0I5
         yTgNAAr59/TFDgAyVueFVFsKaho9yEnvqDR95//9TdIaQE0ExrSjXk1T98xg9ieGaxC/
         m8tA0UTi4UDsuvE9WEVaNo3dt4qz24JhIQTbW1OedhWy3BqoKhoGPiwLexQBCywX4/mq
         IqH+MTEKMX28YmYNA+lFZ7Hdo32JPPg/Eq0XiJwcNxglllEqzp8jZvx7v2ZJ0SOo8VuZ
         +/Yg==
X-Gm-Message-State: AKS2vOx5ghRQgV8ymrJrn2C2u3OkpG21TQ+Ubz8d4HSJPQSMZ7JkaENf
        frYng8GD5bL3rg==
X-Received: by 10.223.151.51 with SMTP id r48mr35971482wrb.189.1499156672452;
        Tue, 04 Jul 2017 01:24:32 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id o6sm16106821wrc.48.2017.07.04.01.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 01:24:31 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSJ8I-0003dD-LF; Tue, 04 Jul 2017 10:24:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170704071909.phs4bf5ybdord2lv@tigra>
Date:   Tue, 04 Jul 2017 10:24:30 +0200
Message-ID: <87van8boe9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 04 2017, Konstantin Khomoutov jotted:

> On Tue, Jul 04, 2017 at 12:00:49AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> I don't have a OSX box, but was helping a co-worker over Jabber the
>> other day, and he pasted something like:
>>
>>     $ git merge-base github/master head
>>
>> Which didn't work for me, and I thought he had a local "head" branch
>> until realizing that of course we were just resolving HEAD on the FS.
>>
>> Has this come up before? I think it makes sense to warn/error about
>> these magic /HEAD/ revisions if they're not upper-case.
>>
>> This is likely unintentional and purely some emergent effect of how it's
>> implemented, and leads to unportable git invocations.
>
> JFTR this is one common case of confusion on Windows as well.
> To the point that I saw people purposedly using "head" on StackOverflow
> questions.  That is, they appear to think (for some reason) that
> branches in Git have case-insensitive names and prefer to spell "head"
> since it (supposedly) easier to type.
>
> I don't know what to do about it.
> Ideally we'd just have a way to perform a final check on the file into
> which a ref name was resolved to see its "real" name but I don't know
> whether all popular filesystems are case preserving (HFS+ and NTFS are,
> IIRC) and even if they are, whether the appropriate platform-specific
> APIs exists to perform such a check.

I think there's no easy way do this in the general case with the current
ref backend, because we rely on the FS to store the refs.

But I'm thinking of the more specific case where you specify
{HEAD,FETCH_HEAD,ORIG_HEAD,MERGE_HEAD,CHERRY_PICK_HEAD} as non-upper
case, and we resolve it from .git/$NAME.

So the detection would not be checking whether the file on-disk has the
same casing, but knowing that if we resolve anything from .git/$NAME
then the string provided on the command-line must be upper-case.

Although there is this:

    $ git rev-parse HEAD
    051ee1e7dd2c7b8bdc20f237eea3c7d5b1314280
    $ git rev-parse WHATEVER
    WHATEVER
    fatal: ambiguous argument 'WHATEVER': unknown revision or path not in the working tree.
    $ cp .git/{HEAD,WHATEVER}
    $ git rev-parse WHATEVER
    051ee1e7dd2c7b8bdc20f237eea3c7d5b1314280

I.e. we allow any arbitrary ref sitting in .git/, but presumably we
could just record the original string the user provided so that this
dies on OSX/Windows too:

    $ cp .git/{HEAD,Whatever}
    $ git rev-parse wHATEVER
    wHATEVER
    fatal: ambiguous argument 'wHATEVER': unknown revision or path not in the working tree.

But this may be a much deeper rabbit hole than I initially thought, I
was fishing to see if someone knew of a place in the code or WIP patch
that dealt with these special refs, but between the low-level machinery
& sha1_name.c (and others) there may be no easy one place to do this...
