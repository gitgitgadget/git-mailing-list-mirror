Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E1220437
	for <e@80x24.org>; Tue, 10 Oct 2017 21:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbdJJVcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 17:32:32 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43009 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756530AbdJJVcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 17:32:31 -0400
Received: by mail-qt0-f182.google.com with SMTP id a43so49738439qta.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K30lUhF+OSaHXjidrSKJVFwrCq23VMTaUzLbLlZUQY8=;
        b=Jdh+p0pYLZWCj9+p4OlTIJZx5nN+wM672v7M6EkNMmUBgNEHB4lA4OD9u823K53gA6
         8wrHEm3P0iAmu9FmDdrzjR23SCsL3pVgXj2/aNwvIOU9/AmUqyH6O1ukk0rNysaZ8TvK
         sLSPdJHU4wO7qxs7uOdVW9n5Zeu4Ql1dZNheHFDXoho97yOwREUNcn7EgnFs4NrBLnad
         Bd7HfOcqL9nGJlsyV20PAiDhTbIGWNigtdqIUPO0WlPquhi8sbIH4VDAxYt7fDVYQ9t1
         MqnCLsNE5VayXYPnKR5bik8zn/urfwQA/RKD3WtAP4VwzE8sZUVpA6AqUvIUZ6m9VihM
         0Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K30lUhF+OSaHXjidrSKJVFwrCq23VMTaUzLbLlZUQY8=;
        b=Vsp6FbP7fewN6GpqD70GF5bTpLxJ1c+BvS20EGJ5ybIwh6JWoW/XRphcD78PSqjlf9
         jQLScmn6zAI4UaNIIsoTE1MphDSdnlpxTz8vnlDrgDpYnpBCT/0v319YOeTWq1l178Bm
         KwtuyjKJZSB0tgrhj20nbQGSQ51lwviBEY86t7oHuAooZXZDIP1mgdodLwtNGHujSicK
         rqk0+Xr6gwjd9ImdX0wElzmJ5VHTuP1hMiBqGLRXfxkL3gT41x1fzMU7VgutGu2UEsS3
         zwYimviSmJkG1iSfpE0uk3LL8DOdKNoCql3iNhZXY7NHxxkoQ/Lt7GNEoDx1IVN/4yJO
         9qaA==
X-Gm-Message-State: AMCzsaXQDWT/DAft4xRB4jFVLCtTStFSzlmFfs/8cPg+KD+G00bgcq7V
        s38YjBhdP3AZRdpxRh3L9WoDa4uBP7hqA3Wkut6SBg==
X-Google-Smtp-Source: AOwi7QBmKaySqXFEjkiEmCKgWrrKe5yUT5g5dUh9MLHXGB8rtPcpGOZXiDt1cOfNMXKxqLGODpgNeSAvLCaYe94+gjE=
X-Received: by 10.200.8.53 with SMTP id u50mr22503072qth.260.1507671150572;
 Tue, 10 Oct 2017 14:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 10 Oct 2017 14:32:29 -0700 (PDT)
In-Reply-To: <20171010211755.GY19555@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com> <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <20171010210049.GA77383@google.com> <20171010211755.GY19555@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Oct 2017 14:32:29 -0700
Message-ID: <CAGZ79kawV+GZ22D_nCr676iMqFR5-aFE6LNpAVm9yDghudkuhg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git Mailing List <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 2:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Brandon Williams wrote:
>
>> Given some of this discussion though, maybe we want to change the
>> semantics of 'protocol.version' so that both servers and clients respect
>> it.

I have no preference for this, but I agree with Jonathans reasoning.


>> As of right now, these patches have the server always allow
>> protocol v0 and v1?  Though that doesn't do much right now since v1 is
>> the same as v0.

I would strongly prefer if the user configures "v0 and v1", being explicit,
if the client wants to talk either of them.

(v0 is not any more special than any future protocol after all -- from the
users perspective, configuring protocol.version)

On the wire transfer we may want to omit the v0, but for simplicity we could
just dump the clients config of "v0 and v1" onto the wire, and the server
would either ignore the "v0 and" part (when speaking v1), or ignore it
completely (old server, speaking v0).

Given this model, we have
* a strict whitelist clientside,
* the ordering decision can be deferred until later,
  when we have an actual v2.

>> One other considerations that I should probably handle is that a client
>> doesn't do any verification right now to ensure that the protocol
>> version the server selects was indeed the protocol that the client
>> requested.  Is that something you think we need to check for?

Yes, we would want to see if the protocol version matches the configured
white list. ("Once we have a v2, I would no longer want a server talking
v0,v1 to me, because I consider v0 insecure[1], and I personally want
to rather have no communication than a v0 protocol. After all I configured
'protocol.version = v2' only")

[1] e.g. https://public-inbox.org/git/1477690790.2904.22.camel@mattmccutchen.net/

> Do you mean in tests, or are you referring to something else?

A test would be lovely.

Thanks,
Stefan
