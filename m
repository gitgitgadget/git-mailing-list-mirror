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
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DD41F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 10:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJHRrW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 13:47:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45384 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHRrW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 13:47:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so20208778wrw.12
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hYkedkdOdrASPhKmUeu3lNxpR6MbiqDjOWENk5MGyBs=;
        b=KKT5hqmpoLXRt24u5ccBSAoFYU87lA+zDUdHlLF1Ml6WbJLPZy+8oNRiHdXc2uHg5C
         xEdjMe8VLiP7vb7d63WwBxLI2PLzVhwp0loGURV/L83+FsWSLtjAd8or9AqTtD3X4Ra5
         mUQRRZVwEptTEJEPJXZa0j1W+9aL1iejn/QZizFgoY5YkFPL1Ek90AHuMtPTCJ9dL5lM
         ygtfZB3WxdJz0BtcLkvh+10tD/ph+6HUAVXQUKWTzKaaINunPRuV5XXH3dLle3I97+Y3
         n7uk1xSaotiR5w8HshOZHgcW0V1bpne3VBhOt+BCNi9ukDrb6DxCPDapCIrFR/deIdg1
         K/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hYkedkdOdrASPhKmUeu3lNxpR6MbiqDjOWENk5MGyBs=;
        b=fTRPpYjEr46jVL7ICnNi0rWjYtW5bewIKJChcZSTh6wcxgUvTznB5laEGaClebXhYp
         lOi57pLlkQKiiRCietxlcCaqYUrV7Jyo+DlCYnBE6wcBAD3UuFNePXJwB3Mh/6zYLOe8
         KtBFH4DpbeUlRfAASV1KdTNRGsRJa4j8MuW8sxBLaeYu1N54oJtRzDDdOu29eZNL/Y0Q
         SfvRYV5ERZK1zz+QtTYiuNAYV3OU82KYgnWo7AalF2GM78AZ3k7f/fC3oeN8hAHsV/xW
         xhFx/nf2p6jU7Pka51rPJZqrMgY6MYL3E1jvVM6FLTyb2tVZfhelgUw1OglQF0fsEiNq
         4DhA==
X-Gm-Message-State: ABuFfohnRFqpNIDowvkXX+v9JCWUL7ooDJGsOm3Wg7xTA+3wZKi93d98
        sWCxIpK1VKTwyd5eSKEfFU0=
X-Google-Smtp-Source: ACcGV608QAOw52xmBYdm1LqQPbV38jA8eafQDPg+EJUCpeF267uf/dkqqV6RBCIllU17Tlp/3uwOZg==
X-Received: by 2002:a5d:6748:: with SMTP id l8-v6mr14766373wrw.197.1538994977945;
        Mon, 08 Oct 2018 03:36:17 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id w11-v6sm14274538wrn.65.2018.10.08.03.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 03:36:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
        Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Oct 2018 12:36:16 +0200
Message-ID: <87h8hwafof.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 07 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> 1. We still have this check of objects/17/ in builtin/gc.c today. Why
>>    objects/17/ and not e.g. objects/00/ to go with other 000* magic such
>>    as the 0000000000000000000000000000000000000000 SHA-1?d  Statistically
>>    it doesn't matter, but 17 seems like an odd thing to pick at random
>>    out of 00..ff, does it have any significance?
>
> There is no "other 000* magic such as ...". There is only one 0{40}
> magic and that one must be memorable and explainable.

Depending on how we're counting there's at least two. We also use
0000000000000000000000000000000000000000 as a placeholder for "couldn't
read a ref" in addition or "this is a placeholder for an invalid ref" in
addition to how it's used to signify creation/deletion to the in the
likes of the pre-receive hook:

    $ echo hello > .git/refs/something
    $ git fsck
    [...]
    error: refs/something: invalid sha1 pointer 0000000000000000000000000000000000000000
    $ > .git/refs/something
    $ git fsck
    [...]
    error: refs/something: invalid sha1 pointer 0000000000000000000000000000000000000000

This is because the refs backend will memzero the oid struct, and if we
fail to read things it'll still be zero'd out.

This manifests e.g. in this confusing fsck output, due to a bug where
GitLab will write empty refs/keep-around/* refs sometimes:
https://gitlab.com/gitlab-org/gitlab-ce/issues/44431

> The 1/256 sample can be any one among 256.  Just like the date
> string on the first line of the output to be used as the /etc/magic
> signature by format-patch, it was an arbitrary choice, rather than a
> random choice, and unlike 0{40} this does not have to be memorable
> by general public and I do not have to explain the choice to the
> general public ;-)

I wanted to elaborate on the explanation for "gc.auto" in
git-config. Now we just say "approximately 6700". Since this behavior
has been really stable for a long time we could say we sample 1/256 of
the .git/objects/?? dirs, and this explains any perceived discrepancies
between the 6700 number and $(find .git/objects/?? -type f | wc -l).

>> 2. It seems overly paranoid to be checking that the files in
>>   .git/objects/17/ look like a SHA-1.
>
> There is no other reason than futureproofing.  We were paying cost
> to open and scan the directory anyway, and checking that we only
> count the loose object files was (and still is) a sensible thing to
> do to allow us not even worry about the other kind of things we
> might end up creating there.

Makes sense. Just wanted to ask if it was that or some workaround for
historical files being there.
