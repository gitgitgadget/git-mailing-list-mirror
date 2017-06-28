Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC8120285
	for <e@80x24.org>; Wed, 28 Jun 2017 22:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbdF1WCH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:02:07 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36487 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF1WCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:02:05 -0400
Received: by mail-pf0-f178.google.com with SMTP id q86so39843984pfl.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZMLS+vQsCpy5rtwimoUVQHliVXJMKS09a1AcIZkbGik=;
        b=L1cDOtPQ49KcZHon4de1K6MqbMssvZxR2p1OAokSnKA7Jrv3pHnEbW6QsWFQVEJbcl
         y67mGdLwCV4U7O6U63P5DOFeY+W1L3DgppJmUdg0MFLo1qg2lIfM+NdU7qxyY3r6I8oN
         LwUPRsbdYFwdFy1MUNglM8Y+GvsDFliHqdwEvcBDZ8AQ//dYcTvXGYGLCDjrCo9587x3
         fgM7gZMIddn7hZUzj7AjYfYJNoouw1swR9rPEcTumofGSU5C47y5azogo4pTwsmrjGtd
         1QH6xm+sosDmdmRlLwXqZnvomajiiIvaAwVXH2wkitshc1Nzh/b/H7/GaBVlWARl1JK/
         /wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZMLS+vQsCpy5rtwimoUVQHliVXJMKS09a1AcIZkbGik=;
        b=DEC5PxTcP3nt5VZn6zZ+aQBSON6u91Ud8MYlbMsbWjL8PZjNwn5m0sCVf8NVIZLIbO
         tz0ly0dVmNQVXqvC3EEU3U61IH5qTpoUqi2T41g+unwX0GnGHNqPywuVPMoxD31nohzR
         LgK9t6nKrgzG1zeA+Ygnbh/vDkFT4CqSlyoMQ6rtq+NFQmiwqy8YKvjCLY9b06PUR2UX
         ZPD8TYM5BL0LOY9gQKhmequ8R0PG5lE0Ovq+6BMLA8fz/YGP50tWlOFXEuSk8iNrD64V
         xDMhcCGAhfBkWb6hOUlnBGiINftjdSnvhczNxuf7yy0FoxChsVhSNf5JnSGoz3zRK5v2
         fVbA==
X-Gm-Message-State: AKS2vOx/jrs6ob3CfJMqwzeZ/F4/wb9MJQakgX9+ACwb9t5yUdOeikVj
        zE1MpQRVe93MGA==
X-Received: by 10.101.75.199 with SMTP id p7mr12499736pgr.164.1498687324608;
        Wed, 28 Jun 2017 15:02:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id r129sm7005235pfr.112.2017.06.28.15.02.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 15:02:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        SODA Noriyuki <soda@NetBSD.org>
Subject: Re: [PATCH v2 0/3] update sha1dc from PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <20170627203348.19827-1-avarab@gmail.com>
        <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
        <87h8yzkcv5.fsf@gmail.com>
Date:   Wed, 28 Jun 2017 15:02:03 -0700
In-Reply-To: <87h8yzkcv5.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Wed, 28 Jun 2017 23:42:54 +0200")
Message-ID: <xmqqh8yzvkis.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 27 2017, Junio C. Hamano jotted:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> A v2 addressing comments to the v1, tbdiff below. Just fixes the
>>> subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
>>> for Solaris, we can just use __sparc (and indeed we did before this).
>>
>> Thanks.  Let's have this tested by minority platform folks to help
>> the upstream digest your pull request.  The change since the last
>> round makes perfect sense to me.
>
> Just a brief update. This has been found not to work on some BSDs (with
> older GCC), but there's a patch being discussed at
> https://github.com/cr-marcstevens/sha1collisiondetection/pull/34
>
> The discussion is sorted out, just waiting on n-soda to submit a patch
> (or to tell me he'd like me to), then the known issues will be fixed &
> it should be merged quickly, then I'll submit a v3.

Thanks.  

It's good that I learned to pretend that I didn't hear anything like

    I'm pretty sure this un-breaks everything & doesn't regress on cases
    where we fixed things earlier.

from anybody, and instead wait a bit longer ;-)
