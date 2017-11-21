Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F29E2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdKUXAK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:00:10 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36316 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdKUXAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:00:09 -0500
Received: by mail-qk0-f169.google.com with SMTP id o6so14358594qkh.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XqfwsqvnnISi2SSgJCkDRFzUVP0WmIRVZdo1vGbHBM0=;
        b=c2vattqx1DnZCuckXfWj3t2jyHmkOS2sRIYs2RJysV1VXvUYjPaxGvTpOoW0q5G2md
         eZ5voe819L3zJD8ttNNjxC4S1jPhsIFjvSqNyhP4zZdulUQmhSnqDvz2x0Y6ewqZRY6z
         JS6IK4bGHeoqkbjG3EBOQlHWIpUEPDdtvWcZsPXiYVZ/C2gAJBqJGJFMb9FdUOYDtDjZ
         sRjuTLiJbEnm24zLvPoOCEifj8ffK/nhkCsJANN4U1ibDvOqbHwQfosXnfRraMQb5XQ2
         XVchYoRWAnvKDcTT44GvFXBxka5RTBqhTq5GovLvZhyibmolBMEiLClQc8d4+AeKuRTq
         LfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XqfwsqvnnISi2SSgJCkDRFzUVP0WmIRVZdo1vGbHBM0=;
        b=V03/tz1kW/cmu7fCAAQ8YY3D2/zIYtreOpUhOSccotDsvIHi7liyo/XB7894wBISds
         m9Qk5NGDs75fMi7uEo4SZoks+51f8Pf93H1ETV6FbSRNPQoZcQEAlLaCgorDs2MmALo/
         w4pJ9ZBpMMghFAR2slrSTTpLlrWKCQecQPT/0U+CRJK8hoQgDPfQNGYxOcWqgJHWyxXL
         Dn+0D1/f2O7MpXOjRHyOa00HNL2Cj/VsDi/EV++80eW3rev321iGfO4tFn0mEJkRYmb2
         l6Q7PYp1ZmAp2WTi7VZ14+5JRmqDMvzCpofyXRFsPGsnYGzRtYxLwN0ZiCIeU9jfoU5+
         nCgA==
X-Gm-Message-State: AJaThX5aXJ4w7yGzuyuP+gmxXKrv1F0d9aCdqamJzK9ZXbMgdcYEF+FS
        Z/wFHcd/BGHLaz8TEMhCoH30nVFzn5x6RpvCe3f5ng==
X-Google-Smtp-Source: AGs4zMa0F8WwAyh5Pb9HHqEaM79tu9JUH5iWBjglvbnNcKDqPSHNfsjKUfYKeBpnxFFJNhM4D6VNNONk6QtU+D038WU=
X-Received: by 10.55.203.156 with SMTP id u28mr30062429qkl.353.1511305208773;
 Tue, 21 Nov 2017 15:00:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 15:00:08 -0800 (PST)
In-Reply-To: <20171121224709.GJ3429@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com> <20170724180312.GE13924@aiede.mtv.corp.google.com>
 <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com> <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
 <20171121223449.GI3429@aiede.mtv.corp.google.com> <CAGZ79kZxD4r0J+uZCuBStkZq1mqPSTaOdkpyOmPXjdLLr6rkOQ@mail.gmail.com>
 <20171121224709.GJ3429@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 15:00:08 -0800
Message-ID: <CAGZ79kbNwV5dg2raUu4SZRWsocpXr7xtgDuyyQ+gVcPFQWfKjg@mail.gmail.com>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 2:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>> On Tue, Nov 21, 2017 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> Stefan, do you know what thread I should look at to find the current
>>> state of this patch?  I've had it applied locally for a long time.
>>
>> It was "Undecided" for some time, then Junio kicked it back to pu, expecting a
>> reroll[1]. The "send out a plan" that was referenced is found in [2]
>> describing 6 plans for the future of submodules. The approach in [3]
>> which is different on the implementation level, but very similar on
>> the UX level sounds best currently.  I'll coordinate with JTan to
>> come up with patches for that.
>>
>> [1] https://public-inbox.org/git/CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com/
>> [2] https://public-inbox.org/git/20171109001007.11894-1-sbeller@google.com/
>> [3] https://public-inbox.org/git/20171108172945.33c42a0e91b4ac494217b788@google.com/
>
> Thanks.  That thread appears to be about a long-term plan; what is the
> short-term plan?
>
> E.g. is there any additional documentation that should be added to the
> patch that detaches?

The second patch in that series has a tiny bit of information, see
"Documentation/checkout: clarify submodule HEADs to be detached".

I would think that this is sufficient for the short term to get into a
safe state.

> Or should it go in as-is?

That is what I would prefer and then we'll build on top of this once we
figured out the direction of the long term solution.

Thanks,
Stefan
