Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9531F453
	for <e@80x24.org>; Fri, 26 Apr 2019 08:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfDZIdI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 04:33:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42875 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDZIdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 04:33:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so2430826eda.9
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pAuus4C+5v5lh0k1C0R9tSoj8rihbf1G06hSzKFwMk8=;
        b=Kbz0QGYN8/agHSjp/c4uBOPCw+xqYDZGmQgRUgBJlSPdl2PVX1RbK9JsnZQ0eSVCoR
         zhx52FdYFJrxySwDLet4iZpxFEoVGMrCuDgj3hvaY4Tb0CiJJ2hgYsaJ2xYRU1U/CLJY
         vAOhmMhrWzQ+I+tfZcnc3/XbjMX819bBi0tNMgKyF+IsEiIJxDj39pEFbEScJDu5fksb
         ljX14V97HSkeI1cA7cCTS1G4zuESBA+FW6RYXVT+TmtdsLOgnnJujC1U+71rJ0TOA53F
         b3ydGiIcm+1qr0ePWn7uC5oPDUvFAex8ZiDocS35WAsRQMbxLQspg9ZN6PaZlIc+1oUx
         O0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pAuus4C+5v5lh0k1C0R9tSoj8rihbf1G06hSzKFwMk8=;
        b=sha6C2qFNoS7YGIgKT7Oz+MDjY32BGQ+zG6O4u0zGNo7h2uUZqVlaT3YCPHGtvtmCa
         RO3M1KthsB7DWQP0xJt1ohb8XFL8JlkX+keBJU/jXIkkkk19fGDuPCF6VHD8Q4SwsKha
         M7FDkrrMSi5IG/yTVIDCVxfeec/PZ0rOl5cMJk4Sa6qLJZ1pbiR7YYTRqY8Ci+Dah76p
         JLK8vuMUShHLV8vd1BSuceI+xDA7Pj01/RzTNjBjmI/R7F6sUmtCte69mWFHry83M0qq
         cEYPyHXDhAP5LPtaiqIeGn0FEjl9ZQ5t/MYMhWFditnxJkIgN4jLeKXqE6pAJhOT+eSp
         ypQQ==
X-Gm-Message-State: APjAAAXUZ00NT4AmToA5RKoozCg7jfMlSXE1G5kuruyNS0BUSpai8/s1
        7KqhJ25DFPcFjRYwJZZSKtg=
X-Google-Smtp-Source: APXvYqzVpldY7ALILuXOJGmMSHjA0XnWMuTFnss5LNne/MkymvYGIKP3JZWfxZAshuaAbJy8fbiWLQ==
X-Received: by 2002:a50:9865:: with SMTP id h34mr4008121edb.9.1556267584939;
        Fri, 26 Apr 2019 01:33:04 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id f9sm4439316edd.45.2019.04.26.01.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 01:33:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com> <pull.112.v2.git.gitgitgadget@gmail.com> <87a7gdspo4.fsf@evledraar.gmail.com> <xmqqef5pwldc.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqef5pwldc.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Apr 2019 10:33:02 +0200
Message-ID: <878svxrwsh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 26 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Apr 24 2019, Derrick Stolee via GitGitGadget wrote:
>>
>>> NOTE: this series was rebased onto ab/commit-graph-fixes, as the confli=
cts
>>> were significant and subtle.
>>
>> Sorry, hopefully it helped more than it harmed :)
>>
>> A few unrelated things:
>
> Thanks always for your careful review and thoughtful comments, by
> the way.
>
>> Now as noted in my series we now on 'master' downgrade that to a warning
>> (along with the rest of the errors):
>>
>>     $ ~/g/git/git --exec-path=3D$PWD status
>>     error: commit-graph version 2 does not match version 1
>>     On branch master
>>     [...]
>>
>> ...and this series sets the default version for all new graphs to v2.
>
> The phrasing seems odd.  It is unclear, even to me who is vaguely
> familiar with the word "commit-graph" and is aware of the fact that
> the file format is being updated, what
>
>     "commit-graph version 2 does not match version 1"

Yeah it should really say:

    "commit-graph is of version 2, our maximum supported version is 1"

Hindsight is 20/20, but more generally I wonder if we should have these
format versions match that of the git version (unlikely to change it
twice in the same release...) which would allow us to say things like:

    "commit-graph needs v2.22.0 or later, we have the version written by v2=
.18.0..v2.21.0"

But of course dealing with those larger integers in the code/gaps is
also messy :)

> wants to say.  Do I have version #2 on disk and the running binary
> only understands version #1?  Or do I have version #1 on disk and
> the binary expected version #2?  How would I get out of this
> situation?  Is it sufficient to do "rm -f .git/info/commit-graph*"
> and is it safe?

Yeah. An rm of .git/info/commit-graph is safe, so is "-c
core.commitGraph=3Dfalse" as a workaround.

I'd say "let's improve the error", but that ship has sailed, and we can
do better than an error here, no matter how it's phrased...

>> I think this is *way* too aggressive of an upgrade path. If these
>> patches go into v2.22.0 then git clients on all older versions that grok
>> the commit graph (IIRC v2.18 and above) will have their git completely
>> broken if they're in a mixed-git-version environment.
>>


I should note that "all older versions..." here is those that have
core.commitGraph=3Dtrue set. More details in 43d3561805 ("commit-graph
write: don't die if the existing graph is corrupt", 2019-03-25).

>> Is it really so important to move to v2 right away that we need to risk
>> those breakages? I think even with my ab/commit-graph-fixes it's still
>> too annoying (I was mostly trying to fix other stuff...). If only we
>> could detect "we should make a new graph now" ....
>
> True.

Having slept on my earlier
https://public-inbox.org/git/87a7gdspo4.fsf@evledraar.gmail.com/ I think
I see a better way to deal with this than my earlier suggestion that we
perform some version flip-flop dance on the single "commit-graph" file:

How about just writing .git/objects/info/commit-graph-v2, and for the
upcoming plan when where they'll be split have some dir/prefix there
where we include the version?

That means that:

 1. If there's an existing v1 "commit-graph" file we don't write a v2 at
    that path in v2.22, although we might have some "write v1 (as well
    as v2?) for old client compat" config where we opt-in to do that.

 2. By default in v2.22 we read/write a "commit-graph-v2" file,
    preferring it over the v1 "commit-graph", falling back on earlier
    versions if it's not there (until gc --auto kicks in on v2.22 and
    makes a v2 graph).

 3. If you have concurrent v2.21 and v2.22 clients accessing the repo
    you might end up generating one commit-graph or the other depending
    on who happens to trigger "gc --auto".

    Hopefully that's a non-issue since an out-of-date graph isn't
    usually a big deal, and client versions mostly march forward. But
    v2.22 could also learn some "incremental gc" where it says "my v2 is
    older, v1 client must have refreshed it, I'll refresh mine/both".

 4. v2.22 and newer versions will have some code in git-gc where we'll
    eventually readdir() .git/objects/info and remove graphs that are
    too old per some new config (say
    "gc.pruneOlderCommitGraphVersions=3D180 days").

This means that:

 A. GOOD: Now and going forward we can fearlessly create new versions of
    the graph without worrying/testing how older clients deal with it.

 B. BAD: We are going to eat ~2x the disk space for commit-graphs while
    such transitions are underway. I think that's fine. They're
    relatively small compared to .git/objects, and we'll eventually "gc"
    the old ones.

 C. BAD: Different versions of git might perform wildly differently (new
    version slower) since their respective preferred graph versions
    might have a very different/up-to-date number of commits v.s. what's
    in the packs.

I think "A" outweighs "B" && "C" in this case. It's "just" a caching
data structure, and git works without it. So we can be a lot looser than
say updating the index/pack format.

Worst case things slow down but still work, and as noted in #3 above if
we care it can be mitigated (but I don't, I think we can safely assume
"client versions march forward").
