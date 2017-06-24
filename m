Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875F1207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 00:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbdFXA1d (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 20:27:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36818 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbdFXA1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 20:27:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id e187so7889913pgc.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 17:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NZe0PAb5nRzzVNiwoNryv67ovHJ9XQ12jtOcqvV+46w=;
        b=Xcf7jyYF3+0IuwFDNQ1X2nwbTD8W6hxPbXIAYrZvi7qnIh+rKPZTUSbS1T32fq/5cz
         CwntyguwC33+otOjpw56o3TKaIvDEvnNp39TASF5f3DFzhdv/gnxyEVdT4gA3dIfupvp
         X1iFvpQfXVX7VBB+hc2TIsYybciVtx8VPuQenl1iip23YXW7eQo+E4K/oEP/OzFYkvkV
         XFZdvbjZn2bIzlVRNQRznsTGkisfbbVBRPX4YLGEEnC0R3Q7IaCwhfqjLpB5fXDsHyNM
         0GN9vjluKjeTcwUPsysWH5Gfo61p9aeg47nlGvTv5j2ZYwSyMBfmB610zO1Bk224S8qV
         ww6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NZe0PAb5nRzzVNiwoNryv67ovHJ9XQ12jtOcqvV+46w=;
        b=BY2mRuX/A4cu/3a/0qBOkcMc9wvpJI4SGzP+X5MdSfceyWec3GlT1oOUgJ3HTuH1Gi
         I45PdnUTq/wEn9C0o/AEmGQcOLj7cTuYQUdSWAGLSwaDjPI7DnFO3ItzDUm3qX4kzPLA
         BsP3HF7kRUMFv2IMtaRV6WArgY+7Hz8Jyq58lkiHYywsYEDKDa8t1pgf3lUydfYEtVDA
         I3nghFW71e6UZt7LI2n2zoPTxz+TOwwPKfpiVUKytShhjGiBXPtoFwZYJnWpl78rdAyQ
         zA9yspOWQLaT7/5NRgR6i5SFYmmzWUZmecC7p7zDo/kvTmAl/3cHkCxNETCTILzQHxVS
         hjOA==
X-Gm-Message-State: AKS2vOzcgqtRCqQXiVVIWGhQMgYs1KnJ6hpgjh6THGNcXc5YEAgiELNf
        lfHHJCXBKOQEpw==
X-Received: by 10.98.32.200 with SMTP id m69mr7750284pfj.5.1498264051556;
        Fri, 23 Jun 2017 17:27:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id b13sm455145pfj.126.2017.06.23.17.27.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 17:27:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
        <877f03k4tp.fsf@gmail.com>
        <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 17:27:30 -0700
In-Reply-To: <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Jun 2017 22:28:07 -0700")
Message-ID: <xmqqefuab571.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> * ab/sha1dc (2017-06-07) 2 commits
>>> ...
>>>  Will keep in 'pu'.
>>>  Impact to the various build and release infrastructure of using
>>>  submodule is not yet fully known, but this lets us dip our toes.
>> ...
>> But it's been 1 month kicking around in pu now. What are we gaining from
>> keeping it there even longer at this point?
>
> I am sort of waiting for a success from Windows box at Travis.  It
> hasn't passed for other reasons for a while, though.

https://travis-ci.org/git/git/jobs/246371006#L480 shows that on
Linux, we are taking the code from the submodule and the compilation
is happy.

https://travis-ci.org/git/git/jobs/246371008#L25 shows that we do
init and update the submodule but it does not appear that neither
the bundled sha1dc/ nor the submodule gets used on MacOS.  Probably
we are using the hash from the platform?

https://travis-ci.org/git/git/jobs/246371011#L724 shows that the
bundled sha1dc/ is used on Windows, not from the submodule, for
whatever reason.  I trust what Dscho does for Windows platform well
enough that I do not feel unconfortable for not knowing why the
build there triggered by Travis does not use the submodule one.
Whatever configuration he chooses would be the best for the
platform.

So the only nit I may have is that we may possibly want to turn this
on in .travis.yml on MacOS before we move it forward (otherwise we'd
be shipping bundled one and submodule one without doing any build on
that platform)?  Other than that, the topic seems ready to be merged
down.

Thanks.

