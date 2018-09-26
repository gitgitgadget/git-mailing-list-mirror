Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C711F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeI0DhP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:37:15 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:39097 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0DhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:37:15 -0400
Received: by mail-yw1-f49.google.com with SMTP id v1-v6so201445ywv.6
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0W65y/Cu/U1kRHwG0qmJ6PAiFkCq2ooow/3JrmdvLU=;
        b=QP/E17FSVCJZmH3AWJdZjqdud3AYLBQfLxoz0Y+MRkwEh676eFBXGjoIHuskOt+1yE
         MV3izYIVO3N10dCSYPF/j2NcYrI1kzS87+nCbWSEPaebI3XVqi7Arw8mAd08zMC9zS68
         W5qeJJrLN2AQk5oJeaX826pYq2cDJvi0omVxMFQBSfW5d1a/O5uB481vzjuADJ5BiDpx
         PETco8HgYL3Biq/Gthv3PzKdcoNwMIjN7QcE30yQLh1QgrPNJrS1Q4kFEUOU+2ZDe05L
         13QUUjjW3ljkbKzrRFsj1s9zlGQ4c68JsOGyr99MbUzp/RbFYty6Ye80De/GY+AZCNT7
         Pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0W65y/Cu/U1kRHwG0qmJ6PAiFkCq2ooow/3JrmdvLU=;
        b=rWc0hxZnTgG/JrPkThSgi7E3slAWBBxGYLcLK0R2icWUvm1pPrSlqIw0Kk2srAqkQL
         8isJ5Aqi6jZWzGYPVNEQnE/PnC58NEX5geO2JrLRqlLa8/vrgBM+EIAa1u1Qjy6tFQGU
         U/wIIvBSC4+HdwuqAngoYIlQ5v95oyiqR90DXrKODFQMRkDahuRJqR6UfAcGjQZAN+ih
         CmpKZHN/kt/Yq2qeEg2H/LPv+tNc0C8MRcrVRJwHMCeP5p9qkHCq29jcXbgcbZKWIkwv
         lU6Zv0CwbQFlSemQ+lFEz1LU+SVp7o4/0Z1AwKRFichvVd6Z+T1IqGSTglE1PIcd3eLf
         jsOQ==
X-Gm-Message-State: ABuFfojOG693qRSvbPmAYZ5AfxxwgEXwu5YxeeSMk4+OA/5YH2bKOZxE
        P+JRdGxbb/7lakwN0LjCgtkpuwRRK5NWqlceZjY2jg==
X-Google-Smtp-Source: ACcGV60yuPZAButCo3xyrs29SYjwiwIDaIJyO4DtesRxeD+uocSLdn1dQ7K9qkM8j7M7X25tTGch1n4uL+WwaKWu5bU=
X-Received: by 2002:a81:b64c:: with SMTP id h12-v6mr4265606ywk.119.1537996941641;
 Wed, 26 Sep 2018 14:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com> <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net> <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com> <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com> <20180926185812.GD30680@sigill.intra.peff.net>
 <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com> <CAGZ79kbeQvLuH1nGPkf8hHbs49SmuPeme_XBdz7ek5fU5AZ9Zg@mail.gmail.com>
 <xmqqpnx0j9kn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnx0j9kn.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Sep 2018 14:22:10 -0700
Message-ID: <CAGZ79kauPS58UpryN+cfAzoiDo+Ee98_RLOnHPJhTUXv5OQM0w@mail.gmail.com>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > (I am not seriously proposing unbalanced comments, but for
> > longer documenting comments we may want to consider,
> > omitting the asterisk?)
>
> If this is not a serious proposal, then I'll stop wasting
> everybody's time.

I proposed two things, one of which I was not serious about.

The other has downsides as both you and Peff point out.
So living with comments may not be the worst after all.

I'll read&reply to Aevars proposal now.
