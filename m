Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA07F1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756902AbcJTVxj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:53:39 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34564 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756011AbcJTVxi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:53:38 -0400
Received: by mail-qt0-f171.google.com with SMTP id q7so70906583qtq.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Y5ZzGy7CS+wOsqyya+nDm2INCL2vZVhcR8V+vROSKM=;
        b=PBgTcijYTAx+VBp9CN6rwzgZnAQn+6syaSQZ3Nikd1xDUq/VgIGwCQzdpThVPdOyXE
         GDR/xsTP3D3JPSmfBnAs29KD6Ki5jina1je7DV/UAmN2ftBUDnYKnlNcv443GwW9aHAI
         N4KqrEhhVYLTxmHAzB2Pje8wXVVJZ4uq/Bh7p5OH3pcCjaRSKFusyOZjw0SDqDxd6EMW
         jh5GuL8qim6g4xjcZ/dkd2hYKZs+XocmXOSzFdKEX2lYt/FvCvsfiBBA55hNYUv990lU
         HxUJHiZs89RuQFeDQz9u6JMZhe76RRCPG+9k+ErkK9MdlxtB6WErGyJ93ElkJwx5n4uB
         uw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Y5ZzGy7CS+wOsqyya+nDm2INCL2vZVhcR8V+vROSKM=;
        b=bj4GtOQ4/oIS/XNfmtQPlyKtpvep4vkTc+8ZLDTElxt75c2OTZob/HgAY/JS4ggMtt
         12n/6rWhAFbBgMjnkWwmRoU5aBxGuLrQs27/JLH3/4hbmclUhufNJpXGOcmOPs8dmtk/
         p7Vu5nnifyGmvSlLifEDPNo817Vj9oqaGmyCgxQbYrPMwqImbBq9OxWUppOnkMnOePAP
         ckm2MOo63I4uULpW+c0eA3QtzooKYWexPsjBfAKkSoGnnW0WtcfEazMvhRPZQ1nvfUfH
         HhRT2hz6C09N8f9pibr6vL9+GoFFbuCR6aqT/cao8er0aUmFn56fBk/+sKHx4wscSuHw
         Mvcg==
X-Gm-Message-State: ABUngvdHCgy64X3/yxeFltsgSTrsYJTpy1Ya/PSgvQ76uXzhQe0sq042Tn+YrzPcNUqxOOu7jxLRaQad3e8O2A7k
X-Received: by 10.200.34.145 with SMTP id f17mr2710708qta.149.1477000417531;
 Thu, 20 Oct 2016 14:53:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 14:53:36 -0700 (PDT)
In-Reply-To: <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com> <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox> <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
 <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 14:53:36 -0700
Message-ID: <CAGZ79kZkSwbiYD=G_nSZW8_qeb2q+AOsqYipmEigTN1aNYPiEw@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 2:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 20, 2016 at 12:54:32PM -0700, Stefan Beller wrote:
>
>> Maybe we should stop introducing un-optimized tests.
>> [...]
>> * heavy use of the "git -C <dir>" pattern. When applying that
>>   thouroughly we'd save spanning the subshells.
>
> Yeah, I imagine with some style changes we could drop quite a few
> subshells. The problem is that the conversion work is manual and
> tedious. I'd look first for spots where we can eliminate thousands of
> calls with a single change.
>
>> That said I really like the idea of having a helper that would eliminate the cat
>> for you, e.g. :
>>
>> git_test_helper_equal_stdin_or_diff_and_die -C super_repo status
>> --porcelain=v2 --branch --untracked-files=all <<-EOF
>> 1 A. N... 000000 100644 100644 $_z40 $HMOD .gitmodules
>> 1 AM S.M. 000000 160000 160000 $_z40 $HSUP sub1
>> EOF
>
> I think that helper still ends up using "cat" and "diff" under the hood,

I assumed that helper being a C program, that only needs to fork once
for the actual git call and then it sits idle to compare the exact output
from stdout to its stdin.

If there is a difference it will do the extra work (i.e. put stdin and stout to
a file and call diff on it)
