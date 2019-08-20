Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6D11F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfHTPOy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:14:54 -0400
Received: from m12-16.163.com ([220.181.12.16]:47720 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730190AbfHTPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RY0oXp4GNylIb05VoE
        DO9auhzCpFcV7Ie8bRD3S5Evk=; b=VOvhemtp2dVHDaPY9VJPkMeP4zHYoeKg+t
        HZ3DgX2CfgXM8J+rYp6S9SjtIqu6CuITl96NNUP7ipoAaD5z0wOkqETjrZls3gTs
        pjCLgKhHVxeZ2oo3c8WtmYkGhGYbStkZcEQ8FBNcH9G+UtaTg3C57b1gp+o3TN//
        8xSjGmUGg=
Received: from localhost.localdomain (unknown [115.205.5.95])
        by smtp12 (Coremail) with SMTP id EMCowADnxqpMDlxdnGt7Aw--.18194S3;
        Tue, 20 Aug 2019 23:14:21 +0800 (CST)
From:   16657101987@163.com
To:     gitster@pobox.com
Cc:     16657101987@163.com, git@vger.kernel.org, mhagger@alum.mit.edu,
        peff@peff.net, sunchao9@huawei.com, worldhello.net@gmail.com
Subject: Re: Re: [PATCH v2 0/1] pack-refs: always refreshing after take the lock file
Date:   Tue, 20 Aug 2019 23:14:08 +0800
Message-Id: <20190820151408.12700-1-16657101987@163.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <xmqqr25hxdk6.fsf@gitster-ct.c.googlers.com>
References: <xmqqr25hxdk6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr25hxdk6.fsf@gitster-ct.c.googlers.com>
References: <xmqqr25hxdk6.fsf@gitster-ct.c.googlers.com>
X-CM-TRANSID: EMCowADnxqpMDlxdnGt7Aw--.18194S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xXrWUAFyfWFyrKr13CFg_yoW8Xr4rpa
        y2ga4DtF18Ar1Ikw4DJ3yIg34Svrs7Cay5Jr15GrW7ZasxWFyqqrZaqa9Y9F97Cw4vqw4Y
        q3yj934Iy3s5ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRxWrZUUUUU=
X-Originating-IP: [115.205.5.95]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiPg0XglxBdZXrwgAAsy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

---

Jeff King <peff@peff.net> writes:

> I'm undecided on this. I think reftables are still a while off, and even
> once they are here, many people will still be using the older format. So
> it makes sense to still apply fixes to the old code.

Got it, thanks for explainning.

> What I wonder, though, is whether always refreshing will cause a
> noticeable performance impact (and that's why I was so slow in
> responding -- I had hoped to try to come up with some numbers, but I
> just hadn't gotten around to it).
>
> My gut says it's _probably_ not an issue, but it would be nice to have
> some data to back it up.

Sorry for responding after 4 days because I have been away on official
business.

Tody I have tryied some tools like trace logs, time, and strace, tring
to figure out if there are some noticeable numbers. I tried different
repositories with different ref numbers and blob numbers, I also can
not recognize how much the refreshing impact the performance, perhaps
I need to find a better computer for benchmark testing.

---

Junio C Hamano <gitster@pobox.com> writes:

> I am tempted to let correctness (and ease-of-reasoning about the
> code) take precedence over potential and unknown performance issue,
> at least for now.  A single liner is rather simple to revert (or in
> the worst case we could add "allow pack-refs to efficiently lose a
> ref to a race" configuration option) anyway.

Thanks a lot :)

-- 
2.17.2 (Apple Git-113)


