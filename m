Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B09C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8901A20771
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RN+r4nSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgFWMq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:46:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:59703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgFWMqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592916381;
        bh=uVn45f/Zz7/MxTWU3jPKqzeHyTRnSqywu9BWOODszlU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RN+r4nSdO9VwttpXdtSwSWEkme/phN8ajLB60Ev3xw9xnyIEf6HeQkMQp8yuHMEoq
         e/EVeiZFrr/c+GK+rkbPOskx0dbOO+aCuhqJ3OEujoKdBXpDX6/PYMzKBFBhB7jWvP
         n4tb39GpnEfZTCIppNVmEhWqYEU5TeXUdIS7cbzM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.214.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1jRd5Z2NOq-00M2hB; Tue, 23
 Jun 2020 14:46:21 +0200
Date:   Tue, 23 Jun 2020 14:46:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #04; Mon, 22)
In-Reply-To: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006231445190.54@tvgsbejvaqbjf.bet>
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ErJu+nqm9YFrGqp8G5Khd+aZCPycYsECmyL4QhChJHMCxqWbJYj
 LN85OLjg+/MvHxXdNMuC14Yd8N6wDZ8T2YVvKjVYiaJqDvFoRB9+yoFlKz6qNXku71sWan3
 42qtyxPFKgYMEALiq+qN1106Dlu/ivsYIRbUIKdSQkCJDstNaMzkBS05XyclXQBrWJ8uJvj
 e6s2t2jkU3KKPF2FKjIlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xG6VQMg7xN0=:p5k8YCk5JmwsC2gxeIO/Wp
 fbluRuXNEz0B1nVXwOf5virw+TL/zkKOvBWHuWanneNWL7MF1mx4T52vWbdJTn3swAA0ZTtER
 50Ma2HtG0nIbrz+KKb1sYLa5J8FTb2CquIceAlGTnJi80Qa6t4gU/l1ZIQUHb8PvjqNXb5r2N
 95ikn9U4tvCvXvv8Fpj5/qUaccj2TCdnP3W06d51Un/3I6Hzio+LHK8B5eCeo6xt/tc/GG2cp
 4BjHt2ayhdQpAPdB2besGEhCfqCO/0PD7diIbjvYcPW1IckaH0NO6UjMmYptueiG4izrR52g+
 HxA/s9j/jsX45iafvPhHXsWIUkIoA+jw2AKSsum7ar/8AgV3S2mOAOeVxj4a7WlOu/0pJxbQh
 Sh0TPTfnR+dhHGlJQHbEa4Xs4nh/qngsU8fullxlQfMOTz4kI0LMhTwq2tbi3+SgEEJOws9Rx
 vhrJL8QTQQg4pnCHvi03fp9mVN6Cjr1hIlFhaGC3OV32hlOo7Q3GLCt4Bfo2nLZiGgARKC2kL
 8lpq11ZaGrbU+kN60O59mc6uFBwL8MGh0kFfAfV9BUCecSk5v5kQPT1VHK9mI8WltYyZ9FVh7
 k4lYcATvSZCl2h0JGV3/8M73V7ZBkoq7QCaXDSpRY61FMYM/67Th3utqhU1Jd/Rfk6drWEsaE
 4hKY8TNr5vF2KHqJySFP7c/f3lKwHE0EeFKq7+MKdKRzykkFYZLIHKptI8vRLms76GL2kAvRY
 T7BecA6QukD+i5lqUY6H/N0o95ouV9V6sG7Fsdr/ph56MnXbMg3Y4elcQLXe8JCfK+CJUecr0
 YrwafFZ5pNyZhuOrWM+doG3XYgdFtgxkH4sDIJYut9RFkZevajdJzxSHkXlbSV2WqMJal11HE
 +RAOOQsL3vEu9T5sRoIx9yLTOn2GX1OJKs7Wl2Cnuc36aFDUJ+DhVCDjBORZaBmTUqB4ZvTRd
 BaKZib+CqXELWfsAUz6wJ/SgT/6dREaK3L0HFOex8/tjfuLpUpkV9sH4+78S93TOPOD5ahf+6
 pYJCTEhs0xXAwZh1Mh+RfdoD4Ja2uNdWMJjSq7ng/hza/yvQ1Clv+b8nAWQCtsida8slhD69b
 f0tkvzpFByLzKVo6kmKpY8lRtZigIheOhixIwbX8yQpGYIi9UAg0F8cmJTCJQaRqE4GnG4FYX
 ElbfPDP69I43kNi7TEs5AxCFB3DG4ikpYOVE5iP30YkAkpnsA++Drey2n9wcIuyaiAcALbzIp
 iJ0qW6KlALM6wAS5y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Jun 2020, Junio C Hamano wrote:

> The 'pu' (proposed updates) branch has been renamed to 'seen' to use
> a more meaningful name (after all, the purpose of it is not to
> contain all proposals, but to merely serve as a place to park what
> the maintainer happened to have seen) and more importantly, to make
> room for topics from those contributors whose two-letter name
> abbreviation needs to be 'pu' under 'pu/$topicName'.

Very nice!

I apologize in advance for taking a while to get GitGitGadget back on
track after this rename, as I had originally planned to work on other
things this week.

Thank you,
Dscho
