Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0615201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbdBVRo7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:44:59 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35471 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbdBVRo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:44:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so1351603pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jg6BO2vAZQoQTK9sgJrSY2whvOk3u1cZFYBne0PBC9E=;
        b=uD1McFwAcmCt5PpQ7WruIPxzq3O/MmB8vS/Ln87MWKNkZGEMIRXCt+ibn45mhhBt2J
         ATjkApVT0OZX4ads0KC/4zWvCxbaOlb4TfzbIar0Gj9X3SYT0W0cgfBFYUWhYQ6MGcGo
         WG/bUuetzuAbfvz3PaOWwIhxUz2TElHdkRqyGAK/ijFM5G63WLA6VS6RmDKGtKyS3zVh
         CfLtuxigUIuh2iJyLq8Nnu9r7wcDVXSK8r0wq7ToUgzFRPjG2aHtu9dKU33qUeJdBE0n
         XVE2N/RcTGbWzh3uwGVeRWbJ+gYVUDYpv0gPylI2Vmr9SHRBtT1WMNsPSRYbJYS732PF
         VpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jg6BO2vAZQoQTK9sgJrSY2whvOk3u1cZFYBne0PBC9E=;
        b=Pd9B36mKPvtbjR5fYardeKXRdfmZY7hebvILUixgih7QkyQ4Q0RG6a0+jQrn/gMB6s
         kwjYdAfau2vyMouwz9X/e8AjOtaZ4gyMQlmxdec+N1ibSOmUkxmpJtwniv60BAaGQskB
         ZgAqu3suQZGAm4O/QTdVKqjZtFJeWZRNX+zNYcGHjwfni4P2nIuJ+zTVSs7vNlxMIa6S
         vyoY7adQwUC4olT4egTG6obbhzx7uIPmpIMzPoGhn5EfHcCIFjKlI3sdO6L5IfUzB3cn
         iD3UwCSdK3Tel2qRDGYAu20XDa2X9Tw5JpK8fJwrVjKRakJ+jrVMZm7zWav8S1fBZ/hl
         AfVA==
X-Gm-Message-State: AMke39mGA4r9wCoNJrCTYA6/yUZasB0WvwZ7EnwnKkIaPDkucdckEvM9WZuFxKEwY+zv9w==
X-Received: by 10.98.102.129 with SMTP id s1mr24934973pfj.26.1487784973745;
        Wed, 22 Feb 2017 09:36:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id f78sm4837786pfe.116.2017.02.22.09.36.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:36:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jon Loeliger <jdl@jdl.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Toolforger <toolforger@durchholz.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: url.<base>.insteadOf vs. submodules
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
        <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
        <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
        <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
        <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
        <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
        <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
        <20170221230029.cs36tjwpsw2opuwp@sigill.intra.peff.net>
        <CAGZ79kby-UhUqci9Mgdhw+wvS5Y39=Q7AmCrWaTMWbcZPNT6Dw@mail.gmail.com>
        <xmqqo9xvdsji.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka2S=V1x2fSQq+E-yE0Ao36-4tuTvnD6uXpPXJPLFN3JA@mail.gmail.com>
        <xmqqbmtvdj7p.fsf@gitster.mtv.corp.google.com>
        <E1cgXSe-0007jp-QI@mylo.jdl.com>
Date:   Wed, 22 Feb 2017 09:36:12 -0800
In-Reply-To: <E1cgXSe-0007jp-QI@mylo.jdl.com> (Jon Loeliger's message of "Wed,
        22 Feb 2017 08:00:04 -0600")
Message-ID: <xmqqh93mcelv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jon Loeliger <jdl@jdl.com> writes:

> So, like, Junio C Hamano said:
>> Stefan Beller <sbeller@google.com> writes:
>> 
>> > Do we want to invent a special value for url.*.insteadOf to mean
>> >   "look up in superproject, so I don't have to keep
>> >   a copy that may get stale" ?
>> 
>> My gut feeling is that we should do the selective/filtered include
>> Peff mentioned when a repository is known to be used as a submodule
>> of somebody else.
>
> Does the management of these submodue-related config values
> become easier if, instead of placing them in .config, we
> place them in a git/.context file?

Do you mean that Git users that use submodules adopt a convention
where a separate file in $GIT_DIR of the toplevel superproject holds
pieces of configuration that are meant to be shared between the
superproject and across all its submodules, and the $GIT_DIR/config
file in submodules and the superproject all include that shared one
via include.path mechanism?

That may allow us to do without being responsible for sifting of
configuration variables into safe and unsafe bins.

I dunno.
