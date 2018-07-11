Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7521F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeGKGVX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:21:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34110 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeGKGVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:21:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so47208042ois.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jvJ98vBG2QQW6j0+ne7rE+KnrqUFrMgtagCUY282ugk=;
        b=N/hMpt1zXah0QAEO5uhntw+pRkhT76Lx8jjiuJrtn1AyzNFxc3XD5wSC7hgYLCR9Ya
         JlETknLBkeyKOOI90+CwvGpi1Cham8CnXHHL32WtsMWDJe7yECPCf8UwxG1Npv+sOxwL
         awutZkQ2Rt9kSzxvq7XqBoHt2Y0Ggq2f1uOLszAjMbRrJqJd0rxVFM9d9/EGStTTajbb
         uyhcodQSVuZPBa/3lJ+NZ6cWBajkO460tDxsSPTuTQT7gG1TygW8x2x1/nPyChY2yi6C
         PpME6ZUVE6jICATF0rsZOthbi+ij6025HtwKcPG4YJ+giMbwLuYyveOAmm7+TJoakf7u
         +dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jvJ98vBG2QQW6j0+ne7rE+KnrqUFrMgtagCUY282ugk=;
        b=fpEZpzfb+24QghJ7whtqXErUOZrNQSYUdCVUH/3z6hYrwR+HAMLVb6GQanUlLv9H/b
         QY8KVjNl4OYlQzE7zQeod8DErbDkXcH9q0m9BUiOzcCltbzQXsbxUzKWhOFBFnHIKYC2
         lNBDaXxd9/+2dd/+UBmE6NFYi0jLrdz2IsB3F38Jir2WajU9CwVA1ngdbymyNgVK5z3B
         f9HPgukTQKmupYJJIysxWM/tKOdI0hDSmYdBZi2hEW+qtq0BtncYELwtAOEvVZn9kG9Q
         pDmu+jAtmw5UNdprdGfNizNyJOG4x2peV7/GsJX3xu3KgvaDRKMnzTBf1CDsjZik2IIH
         g7rw==
X-Gm-Message-State: APt69E3jXsxnrvfuJdynG0f/ljqxIW26V87POfVz6aIuOv8TwQkkiL3L
        hCMfuJ4DscYy50LQggH0pvSG06vHesmL47ndnbY=
X-Google-Smtp-Source: AAOMgpcG8VG2gscntT2fWCAcwoZs8kbAz3j78yoCKVNKFmbnU96Cay880IgW2GJaffrxKsqDobgYWWMAD9moH/V/iiU=
X-Received: by 2002:aca:e185:: with SMTP id y127-v6mr33300646oig.245.1531289922927;
 Tue, 10 Jul 2018 23:18:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 23:18:22
 -0700 (PDT)
In-Reply-To: <xmqqwou26hcv.fsf@gitster-ct.c.googlers.com>
References: <20180710154106.5356-1-wchargin@gmail.com> <xmqqwou26hcv.fsf@gitster-ct.c.googlers.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Tue, 10 Jul 2018 23:18:22 -0700
Message-ID: <CAFW+GMAP6hwU1frm-FUVqx4pokpSQajWz7N6mGtMC-EO+01m2Q@mail.gmail.com>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> we care about reachability only from the detached HEAD here, so this
> must _not_ use test_commit, which creates an extra tag.

Right. I can add a comment to that effect.

> Please avoid unnecessary reflowing of earlier lines of the paragrpah
> when the only change is to insert "or from HEAD" in the middle of its
> fourth line.

Sure: I'll make that change. (My intent was to incrementally clean up an
area already under change, but I'm happy to instead make only the
minimal change.)

> Also, I am not sure if "or from HEAD" is even needed when we say
> "from ANY ref" already, as we count things like HEAD as part of the
> ref namespace.

My two cents: with the docs as is, I wasn't sure whether HEAD was
intended to count as a ref for this purpose. The gitglossary man page
defines a ref as a "name that begins with refs/" (seemingly excluding
HEAD), though it later says that HEAD is a "special-purpose ref". In my
opinion, the change adds clarity without any particular downside---but
I'm happy to revert it if you'd prefer. I'd also be happy to change the
wording to something like "any ref, including HEAD" if we want to
emphasize that HEAD really is a ref.

> We are interested in seeing that ":/string" is understood as a valid
> object name, and this is not limited to "log" at all.

Indeed. I was a bit surprised for the same reason (I expected the tests
to be using `rev-parse`), but I agree that it's probably best to keep
the existing structure to minimize churn.

---

After reaching consensus on the change to the docs, should I send in a
[PATCH v2] In-Reply-To this thread? Peff, should I add your
Signed-off-by to the commit message, or is that not how things are done?

Best,
WC
