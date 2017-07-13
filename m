Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE6C2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdGMVYR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:24:17 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32838 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGMVYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:24:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id k14so35598690pgr.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uye/99EEs5RZZU+HRbUDAfwG4Q3n7E+TwAHN9uJFIGs=;
        b=g8auDE8ibfdLnC/u9gzRYtWq4/OJaemt6Mu1Ii/kn7QJzppLYHEUs0A8ABHNoUzDhY
         P8dSDCPx5dx5v9tHMgm1UtMSA2EKXHludFd9CkXOvPWaV2ZOBS+DWqbgPC+knAASRwqr
         LAavb9q1eJH5zSd+XIYC0UJin0DtWgkTY0xb1RgxS0DzEBC/D8lLafmVGexktQ9wzd7r
         n5rSD91n86NmWyErcrmXVDKcFQ1L5Wwor7W1JujRzq0v2ZWn2ANVYXuG/uBdOFtnfeNY
         BUkjLsSFszDeLS4ShD4EpCXhQMnlAt8J3ZxcoQDudxLyi5m1tjbWepdFvzVWsIsYN/Lb
         3nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uye/99EEs5RZZU+HRbUDAfwG4Q3n7E+TwAHN9uJFIGs=;
        b=NOaZ5oIAmudYFwrfisBsfOuRc3Iu/hXR6tUGPjpR5RxT+Y1k/5r+Cqxb4B+F+TyRAO
         p6Qf9ioqBebzynIQg5dFZ47oj3zhxjXSIvDaocrindToevmBN/dRi1qJKNJJuQItDWDa
         nRI1QHxudHPiGCBj4iDWhVd2n2hcbDn4Jxz1Uz9RY91Eo55UO8QdGQ4/wKVfksn+K+8k
         FhqWoTVCsgNlk+rQ5XR5rWpmK1rzBHsBYNr1Lc8kKVrqsQcBoH3fXuuzXyjm9SZdy7xD
         glCbZ+9UldZhr0FtAgMd5z9yHbrCV+OoV/BwlUszmYmzE3c1Hd0RuIFOrFAf3A/c7F9W
         ibQA==
X-Gm-Message-State: AIVw113YObmERBtKYh5rhaz71UJoUXEizI9fKcOWXOsUdPhkrJTT0nls
        lCfxgTeNFf+tGQ==
X-Received: by 10.99.114.19 with SMTP id n19mr11164762pgc.81.1499981055534;
        Thu, 13 Jul 2017 14:24:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id o6sm11668404pgs.43.2017.07.13.14.24.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 14:24:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
        <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
        <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
        <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
        <20170713181350.tb6gndxc66ewpggj@sigill.intra.peff.net>
        <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com>
        <20170713204946.wfshkwpqoiwqgkft@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 14:24:14 -0700
In-Reply-To: <20170713204946.wfshkwpqoiwqgkft@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 16:49:46 -0400")
Message-ID: <xmqqr2xkt4ht.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sorry, I mean the case where you do a merge from the other side, but
> then you end up rewinding the history in some way, taking into account
> that merge and everything they did. For example:
>
>   $ git pull
>   $ git rebase  ;# this will flatten the merge
>   $ git push --force-with-lease
>
> There was never a moment where the other side's tip ref was in your
> local branch, but you did incorporate it via the merge.

Ah, OK, now it is clear what you meant.

Thanks.
