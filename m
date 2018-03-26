Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DAB1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeCZVWZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:22:25 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34497 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeCZVWW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:22:22 -0400
Received: by mail-wr0-f175.google.com with SMTP id o8so20317945wra.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cIdlhrq1UGeU/7c8Yw2neUwZIBTFz78xf4PRllSRGX4=;
        b=LiYxfkklvmP0u3U0k8s+djEgblvX5+vRuNoUVj2YdPLpv2i7Oo2DwQ0WciL9I0K/Yn
         252td6egr70bcK0PZpsTrBSau9R5T573EYGhLuIIqLWg2DFBItDr1W3u+dEX01vlB/5p
         6M4tfnmvbtr16pVscFbADFwzrQByoDMmNYqiaJgrJgGcR28+spmX98L0rlhtGu79PWSe
         YYl1EBIDbnBuY23Wj5n9KlHYpMSRwvsw2RV5ZRYkq/pz4VUSuGOx47Kasbm99cQ5O72i
         +rB0zjsztDj/M0dQcL0tUSgAqkgpqwQHLYAS+jVopyn/TuJp8XijeCqCpHwOW8iKty+7
         H1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cIdlhrq1UGeU/7c8Yw2neUwZIBTFz78xf4PRllSRGX4=;
        b=oS+8TPIUU4PNTplKm262lAtz66jVAj1yvmMP1NovOsd/biFWXPpEDmqHnKgSnaG8zo
         EYbPpvxvITiCrCwD1dZyrt5ublPjSUbkK5MSLXeo7ZWag0YKfrZxed1X+DMZ46bMGKjA
         gBj2JFjG6jAmhB6FFi+mjDNSNfN67g9TvsVc8g4XHlnugSrfZQHeW/e4/Lv83SyDW+Ju
         Ky8B8kSZ6UvBloJppNp2ooYfa6a120ndrIXyDcEAp5SIfkaU1KqLWiOfksWylJwY6hEz
         U8eJroDJXoBwHULsHYiwysYoeyEV6xV5aAnCQxMXp3OJ41f39Z2UyhAMPHCKjyekw0S2
         dvrg==
X-Gm-Message-State: AElRT7FotCeWUBNlz/a7W5+imzKIU46bWX61GJAW61omoMB2YxRlJN/p
        riw+v+TsjP8UvlU0UO7JjkI=
X-Google-Smtp-Source: AG47ELvxdx4VmbztMhC9pZlNP16lSi0EXhvHspSSjrq72QtHAtuljYsB/MyTWo69gC/WDUCWu9VQUw==
X-Received: by 10.223.143.86 with SMTP id p80mr34920666wrb.31.1522099340691;
        Mon, 26 Mar 2018 14:22:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v23sm14141390wmh.30.2018.03.26.14.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 14:22:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Per-object encryption (Re: Git Merge contributor summit notes)
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux> <874ll3yd75.fsf@evledraar.gmail.com> <20180326205349.GA21735@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180326205349.GA21735@aiede.svl.corp.google.com>
Date:   Mon, 26 Mar 2018 23:22:18 +0200
Message-ID: <87y3iewn05.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 26 2018, Jonathan Nieder wrote:

> Hi Ævar,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> It occurred to me recently that once we have such a layer it could be
>> (ab)used with some relatively minor changes to do any arbitrary
>> local-to-remote object content translation, unless I've missed something
>> (but I just re-read hash-function-transition.txt now...).
>>
>> E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
>> remote server so that you upload a GPG encrypted version of all your
>> blobs, and have your trees reference those blobs.
>
> Interesting!
>
> To be clear, this would only work with deterministic encryption.
> Normal GPG encryption would not have the round-tripping properties
> required by the design.

Right, sorry. I was being lazy. For simplicity let's say rot13 or some
other deterministic algorithm.

> If I understand correctly, it also requires both sides of the
> connection to have access to the encryption key.  Otherwise they
> cannot perform ordinary operations like revision walks.  So I'm not
> seeing a huge advantage over ordinary transport-layer encryption.
>
> That said, it's an interesting idea --- thanks for that.  I'm changing
> the subject line since otherwise there's no way I'll find this again. :)

In this specific implementation I have in mind only one side would have
the key, we'd encrypt just up to the point where the repository would
still pass fsck. But of course once we had that facility we could do any
arbitrary translation .

I.e. consider the latest commit in git.git:

    commit 90bbd502d54fe920356fa9278055dc9c9bfe9a56
    tree 5539308dc384fd11055be9d6a0cc1cce7d495150
    parent 085f5f95a2723e8f9f4d037c01db5b786355ba49
    parent d32eb83c1db7d0a8bb54fe743c6d1dd674d372c5
    author Junio C Hamano <gitster@pobox.com> 1521754611 -0700
    committer Junio C Hamano <gitster@pobox.com> 1521754611 -0700

        Sync with Git 2.16.3

With rot13 "encryption" it would be:

    commit <different hash>
    tree <different hash>
    parent <different hash>
    parent <different hash>
    author Whavb P Unznab <tvgfgre@cbobk.pbz> 1521754611 -0700
    committer Whavb P Unznab <tvgfgre@cbobk.pbz> 1521754611 -0700

        Flap jvgu Tvg 2.16.3

And an ls-tree on that tree hash would instead of README.md give you:

    100644 blob <different hash> ERNQZR.zq

And inspecting that blob would give you:

    # Rot13'd "Hello, World!"
    Uryyb, Jbeyq!

So obviously for the encryption use-case such a repo would leak a lot of
info compared to just uploading the fast-export version of it
periodically as one big encrypted blob to store somewhere, but the
advantage would be:

 * It's better than existing "just munge the blobs" encryption solutions
   bolted on top of git, because at least you encrypt the commit
   message, author names & filenames.

 * Since it would be a valid repo even without the key, you could use
   git hosting solutions for it, similar to checking in encrypted blobs
   in existing git repos.

 * As noted, it could be a permanent stress test on the SHA-1<->NewHash
   codepath.

   I can't think of a reason for why once we have that we couldn't add
   the equivalent of clean/smudge filters.

   We need to unpack & repack & re-hash all the stuff we send over the
   wire anyway, so we can munge it as it goes in/out as long as the same
   input values always yield the same output values.
