Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8FA21F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935829AbeCSTNz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:13:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43482 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935827AbeCSTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:13:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id o1so19739450wro.10
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3DSzTFBo+loSUV+D3jMW6FqMa+TQYAzahvrRTUkpDH8=;
        b=vKtQD8HwoJC45arWvClBQcs19Zb5u0YeeaK7dvLMyFjOQqiuxn8C0xOlTULqFW+BH2
         WNIClrI7r6pWIP5jMOhOTXaD0wEksgdkGCV3kLPW2ZcYXmFwx9EWhIUgMGY6JsW1LPux
         8BSR2nk7uKrSBqi3mxxT2qe/sUNn0aQjLWRKKoDBFy4JDb5USymBNQf6O50XWRQ9oj/D
         I0c5xDSOz8RjQO460AJ1aZE3tB+StJT5luRfuXBkID0OaKLJIk3GH8SrlHNlIRlCVfZ0
         piqc4/wthAEusZoUWBWJVDjg4AZwVYmRht9QaGxHTLqrCVNVtiv7o+CJhGzEtKBQmwqo
         PdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3DSzTFBo+loSUV+D3jMW6FqMa+TQYAzahvrRTUkpDH8=;
        b=WwyNJifkrROzsu+dlhqT2v6ek5e2Z1LjE65chJZWq0g3whHPG7RwR4odHDoV/c4q9L
         MAWZtRwHVcGhjv45tRTnqHMwhvy1soux260FV+qLp7Rig9kZajn5cVHCBVqbnmfC/tZ2
         wqeIKQ2Y/P4clu8v/N3zbUHXwMFde7nY5FiS32UQgcowtewNl3hHNEsCTmDtFgaBWxsg
         XsuLsbANfsJjwU2NWkR29RmR+PH/cYuuRAtkSoAx7Qpd1sbxEsmqMz5Dp9P2zFnkXT+f
         DCYgv53vPja1NKojYyiyIt4ekWVr4yhmx8PKWT8ELW6mU6N6sKysv4olqHiN/Qx0dB7N
         yN/A==
X-Gm-Message-State: AElRT7EyCTa7Y73wC1h0RLZbWTAnvjTTFySXKm74euOo3Y4s9PnxrGmu
        8A4aR91gcRbFx2pINyScRhg=
X-Google-Smtp-Source: AG47ELt+FyW491/oiY2zF8zL8WV9uiD9bAgg+nYNLElS/10cj+qdHc5B2YIZEEAauTJ/ydQdZTH2EQ==
X-Received: by 10.223.157.3 with SMTP id k3mr11212184wre.179.1521486830821;
        Mon, 19 Mar 2018 12:13:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b8sm843502wrf.29.2018.03.19.12.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:13:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/36] Promisor remotes and external ODB support
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Date:   Mon, 19 Mar 2018 12:13:49 -0700
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 19 Mar 2018 14:31:11 +0100")
Message-ID: <xmqqh8pbvpxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> A lot of things are different because the jh/fsck-promisors and
> jh/partial-clone have been merged into master since the v1. So the
> integration is much more complete now (though not fully complete), and
> this integration happens quite early in the patch series.
>
> This integration makes it possible to have many promisor and partial
> clone remotes (instead of just one) with possibly different partial
> clone filters, though that is not tested yet.
>
> I am not sure that the "external odb" name is still the best, as the
> promisor remotes are not quite external. So I am open to suggestions
> about a new name.

So,... so far we have a way to make an incomplete clone of a project
from a remote that promises that objects (deliberately) missing from
the resulting repository are available later by an on-demand request.

We do not yet have code to actually make an on-demand request, and
the other side of the request to fulfill the promise.  

And that is what these patches want to do?

That sounds like a "lazy backfill" mechanism; I know others are
better in naming things than me, though ;-)

On the other hand, if the code updated with these patches do not
cooperate with the promise mechansim (e.g. request is made to any
missing objects, instead of "this object was promised by that
remote, so let's go there and ask" and "this object is simply
missing, without promise by anybody, so let's not bother the
promisor remote"), then it is not even "back"-filling, but is a
mechanism to access remote object database over a protocol, so
a minimum s/ext/remote/ would clarify what it is.

I guess "lazy backfill" would be more preferrable than a pile of
independent, competing and uncooperative features ;-)

>   - Patches 13/36 and 14/36:
>
> These patches move over the promisor objects and partial clone code to
> use the external odb mechanism. The result of 13/36 is that instead of
> the "extensions.partialclone" config variable, a
> "odb.<name>.promisorRemote" config variable is now used. The result of
> 14/36 is that instead of the "core.partialclonefilter" config
> variable, a "odb.<name>.partialclonefilter" config variable is now
> used.

The use of "extensions" was to protect the repository from versions
of Git that are unaware of the "promise" mechanism to even attempt
touching it.  Will we keep the same degree of safety with these
changes, I wonder?

