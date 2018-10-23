Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE891F453
	for <e@80x24.org>; Tue, 23 Oct 2018 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJXC2s (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 22:28:48 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:57528 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbeJXC2r (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Oct 2018 22:28:47 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 22:28:47 EDT
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-03v.sys.comcast.net with ESMTP
        id EyGfgjF2nnFVDF0uag1fNE; Tue, 23 Oct 2018 17:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1540317372;
        bh=4FNfwuq9SIuXNU8tIwex0Wp9cY/rjqXiQhl9d3PFJaU=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=V8GEdHPT591yYQOsHsKnwUidIXw8HIVvz9el+TFBwMMDF9uJr7KgJ9NllCzEfZh0o
         nkD8bT4VNY3EPlZCQbZgyNLeLPH3zxu3d7+CaRJ9pDceiSKj3ZNRc0P9IedJXre5Xf
         Nj2J1lnTx7xSAV9Yc+oO4gIKOniVPZBT7nEXibeFkRgjI7IsCIXkh099jz5CBPNQE0
         xhkqEmNM0aztuMhnYC5pV9r9lk1pgyNllAnEQPQVyAXgjfSxyGLffSYLrnV9cHaEQh
         26CvzgtAYIDFJUVvXf0jnpjCuMMFG1YN04bechz6vwvhLnzWJoWBrWoDaEACVUxoL/
         ifKkNH9rXrKFQ==
Received: from [2620:0:100e:913:4957:471c:6cae:55cb] ([IPv6:2620:0:100e:913:4957:471c:6cae:55cb])
        by resomta-ch2-01v.sys.comcast.net with ESMTPSA
        id F0uDgf2My5r3BF0uIgPOsE; Tue, 23 Oct 2018 17:56:10 +0000
Date:   Tue, 23 Oct 2018 10:55:49 -0700 (PDT)
From:   Matthew DeVore <matvore@comcast.net>
X-X-Sender: matvore@matvore-linux.svl.corp.google.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
In-Reply-To: <xmqqin1ts11h.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.21.1810231053550.56374@matvore-linux.svl.corp.google.com>
References: <cover.1540256910.git.matvore@google.com> <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com> <xmqqin1ts11h.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfNY8ItGniR2en4P5uTJfnrIYX371r2HaJ89zfs+CJEbppyQIrR/oyCDBe126+h1j5oovBLyV+3ObfpGI66n7ClBIh6aAh2iKLxeSwpmnZhdDdceEl9nO
 0ACLA6RbzbVXUZZPFuMTINMZXve7Ru5HIO61LvM7xGD4yEu9gqqIbjwYBe7V1VjmJEFAwKv7HHk7Vo6OOQJDd2h9PrIuW2MwBSV+ub5bT0xcCzgPE3UuvECT
 5d/O8Zxd5940AzkU2hBvMd2WYAXqQy+Z632ehJ99fdlCGKl5KwB7lZ0ntfrrFPVtICyZAHNWaeYoKZdsWx0wgj8aiKdel/k8ccITZ2hON5jBWZNiuPtbdwHs
 XXNau9khiDS+OhwwlrvI66CE8slKvT0GFGnNIHN8N6ZSSq4N8xAhm1eZk02ymPO7k2oc+eBlXmpQ1aJLjmPJAC0TIbyddg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, 23 Oct 2018, Junio C Hamano wrote:

> Not really.  We were already doing a controlled failure via die(),
> so these two tests would not have caught the problem in the code
> before the fix in this patch.
>

BUG is apparently considered a "wrong" failure and not a controlled one
by test_must_fail. I just double-checked that the tests fail without
this patch.

not ok 119 - --exclude-promisor-objects does not BUG-crash
# 
#		test_must_fail git blame --exclude-promisor-objects one
# 
# failed 1 among 119 test(s)
1..119
