Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDA7208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbdHYRHL (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:07:11 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33890 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754410AbdHYRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:07:10 -0400
Received: by mail-yw0-f177.google.com with SMTP id t188so2326512ywb.1
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GLDp5W8XC2UP5gfRWSfECECMTXhliKRmsF4ZtBdyC3k=;
        b=IcF9CG6YUI1LgPGjlxqEbH8pCt3fwtG5EaJDwfpfxUYAQX8ZQSXk/jKSdUwn30m47b
         zP0akOg/GX4OjNJCqA7+2QSADMiz3HH8yZFOYzyrtBZFpUcoIT/PZuxMo4ln6tyeJCUi
         KF1epGJDS3dQzx7dKUhxpLVJuezZZh89FRoptX6s1hrYZAf1hBBhlX/YdBQAPi1sfiZO
         I0tMMD916JmVZG0tD9/awNT9ioRY19FPn+DyZnTYj/MAl5Q6CBS9JfKifCbr7YihVRXW
         WHr2rL+EtN9vd+FOPwpngq1DPXhndgS5AX7Va1W5cVDWXE/YNH5TZ1LUE7+QNVoy1jEe
         AdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GLDp5W8XC2UP5gfRWSfECECMTXhliKRmsF4ZtBdyC3k=;
        b=oDI1ot/66dPSkftTrcRz/2HPA1Bf+pXq6yekVGT3C2BBJ99Ztx5clyoOx8XlM6HFZL
         aC7oGBO5nHVnASXY0X8vSvJ7cVIywgHzVPZsL43/TCb8YtJ2+MNVOGctG0HRzlHAqx4Y
         rv7r7N/usXxvUFwdTN08J7G+uLjyHnk4JZk7JaCfG/yujy7TC9pvEUMNUNml0j3rcnmZ
         zQdznzWOpdW+CmTchXOKxrtCbBcpCNAsdXIfeFQdWlHoGGzy7VCN//dVxrY0zEOeU5ZL
         wiyboQMqKPc5vugzaqg396Rox3gucleVEZxBlcxTG9VncAsMk0ZXDqTmQFNyhFMbJDZr
         5DJA==
X-Gm-Message-State: AHYfb5hrD6Lb/31JLEFgmt6oAH4eyfkkdTfJZjptdFc7swFHgVWOSOlq
        xeLfqsQqIJbH9dbejn52fxuyg7idz5lk
X-Google-Smtp-Source: ADKCNb6RBZx8qWZwRcxqhHy6H1rZdJBDiMTul6PeZPHRim31/lZJCNf80Bu2xgp9ThsfVgLRoC8bh3sWhp/Lff1lCc8=
X-Received: by 10.13.229.3 with SMTP id o3mr8389456ywe.137.1503680829292; Fri,
 25 Aug 2017 10:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Fri, 25 Aug 2017 10:07:08 -0700 (PDT)
In-Reply-To: <xmqq7exsv3yu.fsf@gitster.mtv.corp.google.com>
References: <20170824225328.8174-1-bmwill@google.com> <xmqq7exsv3yu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Aug 2017 10:07:08 -0700
Message-ID: <CAGZ79kZ3NDsAQ4zVrUN8Ab3=f5RT63G16a_gCPm3Poe47BCMvg@mail.gmail.com>
Subject: Re: [RFC 0/7] transitioning to protocol v2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 6:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> The best way to preserve functionality with old servers and clients would be to
>> communicate using the same end point but have the client send a bit of extra
>> information with its initial request.  This extra information would need to be
>> sent in such a way that old servers ignore it and operate normally (using
>> protocol v1).  The client would then need to be able to look at a server's
>> response to determine whether the server understands and is speaking v2 or has
>> ignored the clients request to use a newer protocol and is speaking v1.
>
> Good. I think the idle talk last round was for the server to tell
> the v1 client "we are still doing the slow ls-remote comes first
> protocol with this exchange, but just for future reference, you can
> use the v2 endpoint with me", which was way less desirable (even
> though it may be safer).

The idea that this RFC series tries to show case is safer IMO.

>> Patches 1-5 enable a client to unconditionally send this back-channel
>> information to a server.  This is done by sending a version number after a
>> second NUL byte in git://, in the envvar GIT_PROTOCOL in file:// and ssh://,
>> and in an http header in http://, https://.  Patches 6-7 teach a client and
>> upload-pack to send and recognize a request to use protocol v2.
>
> All sounds sensible.
>
>  - for git://, if you say you found a hole in the protocol to stuff
>    this information, I simply believe you ;-)  Good job.

The hole is incredible funny and sad IMHO, so I would expect that
this series (specifically the review once it leaves RFC state) focusses
on how to allow future protocols with no such hacks. So AFAICT
the core idea of this series is that we can have an exchange

client through poked hole>  "We can speak version 4,3, and 1 as fallback"
server > "Ok, 3 it is"
[ protocol v3 is executed, I don't know what it looks like. ]

Alternatively when the server is old:

client >  "We can speak version 4,3, and 1 as fallback"
server > lists refs
client continues v1 as usual, because the version announcements
are so different from the first ref in the refs advertisement of v1,
such that the client knows for sure which version is talked. (despite
never getting an explicit "it is v1")

Or if the client is old:

client > (nothing)
server > lists refs, current v1 style.


>  - http:// and https:// should be a no-brainer as the HTTP headers
>    give ample room to send information from the initiator side.
>
>  - For ssh://, I do not think it is sane to assume that we can
>    convince server operators to allow passing any random environment
>    variable.  If the use of this specific variable turns out to be
>    popular enough, however, and its benefit outweighs administrative
>    burden, perhaps it is not impossible to convince them to allow
>    AcceptEnv on this single variable.

Once the next generation protocol demonstrates it is far superior
than the current protocol admins will switch happily. (Some ideas:
(a) refstable instead packed-refs format, yielding better compression for
ref advertisement, (b) refs-in-want to cut down ref advertisement to
just the needs, (c) negotiation to draw from the remote reflog)

For now I would suggest we put a protocol v2 in place that is
the current protocol + a version number coming through the
poked hole at the beginning; the goal and review of this series
ought to focus on getting the version handshake right (and future
proof for an eventual v3 if needed in another 10 years)

Regarding the patches itself:

 patches 1,2 seem ok, no further comment
 patches 3-5 are the client stating that it can understand v2.
 which means that patch 6 ("actually understand a v2, that
 looks surprisingly similar to v1") should come before 3-5.

 patch 7 can be either before or after 6, the server side
 seems independent of the client side for the sake of
 this patch series.

Thanks,
Stefan

>
> Thanks.
