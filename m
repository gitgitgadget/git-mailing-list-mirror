Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2461F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeADAId (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:08:33 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:41428 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeADAIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:08:32 -0500
Received: by mail-wm0-f48.google.com with SMTP id g75so618536wme.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RLZIVVzygHQ2bGwVpeygXbK92Hart4BgJNZC5pNZTRU=;
        b=DDZO0fDFma3XjiQ/AbVdFHhpT6WY59wiADRc00MEWPLOnDbdUm0kUNLgd6kAU4I7Ws
         YMnthaN513e5UE1OjpDOw5SyE2V2i1bD1NL591EGZL+O3BveKM9dNQyEnZnkb7I1F7/F
         nQ7/IcaqpnTmjPFm396Dzm0CfZ5ZInf9W9I8ig5rkJ7MiB8XIMIfvco2kurJuCQX0Bmt
         zsxf34i2U15JCnpX14KhY1YBNr4X2QUIRp1RzvDn1VOZl1tiNOJfxIqCm5ksBeKNzaMR
         Qne//FCLq3y3k1v6MqbJrfH+Y4FtnITHjfQp7exkYcKWO8fYNXjv955Kq+mzNWsuF5SD
         DpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RLZIVVzygHQ2bGwVpeygXbK92Hart4BgJNZC5pNZTRU=;
        b=b2NlKCSJzm3vA5uC9pOOc+K3FBD2WBsjycl3ODrI+6bcBRg6GuFpZUjoon7d6UiGV0
         MhKba4OzZufFe9Qa7o2EFxg+sFxBWScOS0+dXP5xvlxN6zdTPlIdJt45M8nrSlymEox9
         C8g7BANFYA9eO8uq/9B45kqy87fFQTYn8Tzc0SyoezGPi33xM6ioqk55jbku9Fp4IHBI
         N6bW3xctV3792BQnAKFyMz8t0sb+KWpzv2zzoGkpjqlu2mYoVv5HH0l9ekjlFfpISief
         fIAYrvCws6UMv8JHlCouCTMueCbJ1HiH4NWO9qto91Ywy6hulS2f0ELZP8Z6LyMods7Q
         fZDw==
X-Gm-Message-State: AKGB3mLjeW4o153+k3zxRhYfkJQbFsdnWXSWeQyTY1GsSEvuBPavZ4nm
        6ThZ0liNy1Lo+Vivn5anmLFvtR4T
X-Google-Smtp-Source: ACJfBotN44vPiM0gqopjNYDj34Xe+XmnwNF8kqD6ZMDQo5oymEEG1RXMtoehlM91onbBE2DtsD4fww==
X-Received: by 10.80.163.7 with SMTP id 7mr4792023edn.100.1515024511180;
        Wed, 03 Jan 2018 16:08:31 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p37sm1089470eda.96.2018.01.03.16.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 16:08:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
References: <20180103102840.27897-1-avarab@gmail.com> <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 04 Jan 2018 01:08:28 +0100
Message-ID: <87bmiacwoz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 03 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This is useful for talking to systems such as Github or Gitlab that
>> identify user accounts (or deploy keys) by ssh keys. Normally, ssh
>> could do this itself by supplying multiple keys via -i, but that trick
>> doesn't work on these systems as the connection will have already been
>> accepted when the "wrong" key gets rejected.
>
> You need to explain this a lot better than the above.
>
> I am sure systems such as Github have more than dozens of users who
> push over ssh and these users identify themselves by which key to
> use when establishing connection just fine (presumably by using a
> "Host" entry for the github URL in ~/.ssh/config), and presumably we
> are not sending "wrong" keys over there.  So there needs to be a lot
> more clear description of the problem you are trying to solve in the
> first place.

Hopefully this is clearer, and depending on how the rest of the
discussion goes I'll submit v2 with something like this in the commit
message:

SSH keys A and B are known to the remote service, and used to identify
two different users.

A can only push to repository X, and B can only fetch from repository Y.

Thus, if you have a script that does:

    GIT_SSH_COMMAND="ssh -i A -i B" git ...

It'll always fail for pulling from X, and pushing to Y. Supply:

    GIT_SSH_COMMAND="ssh -i B -i A" git ...

And now pulling will work, but pushing won't.

If you were to do, where C is a completly unknown key:

    GIT_SSH_COMMAND="ssh -i C -i A" git push X ...

It would work, since ssh wouldn't get far enough in the key negotiation
to drop you into a shell. This is the case you had in mind, but is
unrelated to the problem I'm trying to address.

I tested this on a Gitlab instance, but as far as I know this property
is going to be intrinsic to anything that uses ssh in this way,
i.e. once you get past the step where the server says "this key is OK"
and drops you into a shell, it's not going to retry the whole
negotiation with another key just because the command you ran exited
with non-zero.

So now I just have a GIT_SSH_COMMAND that dispatches to different keys
depending on the operation, as noted in the commit message, and I can
assure you that without that logic it doesn't work.

I thought that use-case might be useful enough to be natively supported,
since right now you either need to hack it up like that, or perform
similar hacks with url/pushurl and ssh host aliases in your config.
