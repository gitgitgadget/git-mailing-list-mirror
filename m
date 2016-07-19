Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783281FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbcGSSwp (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:52:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35326 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcGSSwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:52:43 -0400
Received: by mail-io0-f194.google.com with SMTP id q83so2002788iod.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 11:52:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=c97GikTvyfTh1lekRdleU1XqcJ27DjkkDCJBAnfW5Kw=;
        b=0lEaptRvdVjYpkO+Wdc/r0Gl5NkO1ofrLteQMpAYfOWF7Zz+hPyS/r/hTUU4kVrVVO
         2o+l61XthqPhGk58nQIuJdvSHkl4vIjx4UHW33HlcuWnC4CH6a4hjBLRbujbyBj2c/e7
         rCqnBqlvt2gRtKWxbvNTzdjIvD0PDRogIFaL5M7y3n0VtJBdGMzekI5/wWs4xFst/ZfD
         +UNuTN6hB12dj27KNhXf5ei1bisrjCi10NoTzosUg9XThSR6nOLKNbvEDJ5gjSdJ9940
         IcFgYXtn4Z26c9ibKxyn3tXteK7xB69IhVbjOJ39d3i7Gk5p3A8puRf+fwcmX1hxltog
         zKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=c97GikTvyfTh1lekRdleU1XqcJ27DjkkDCJBAnfW5Kw=;
        b=mLa7gtdsYkNu8pswqpuWpd4RWTBZCeWcQZAvFS5/eY++ZIxhnl5Ohcmm7hjcaiXBw5
         yHVdYHp8UrY02oXt0pZW7XzhbXQy3qoXwkEw7K8/jswJSiIjOMvFkhvhFamAH4AUDqvW
         bdHIm0YSdqORXQno4VjJl/dZgSht9fYIj8Qp5UCdLIFHcV/oFKX0vl/j8ZZs8JBw2b6b
         4UMx598o8t4ehP/d+BtvPwItevXX5zwefuK6LdqATlIN68Y+LwGdt/XI3UqPpsrA/xLc
         qDK7zqsreXX3tmWJeyJaMyFTu12aJG0sFCh13NT4c43gLEuzpc7Jv848tF5lKnam5/O0
         67sg==
X-Gm-Message-State: ALyK8tJvo31eRZGgqB4v60nrZmTK9ciyZNIFeIWK1f1G8fpf8CfNiiCdXo5BM39cOp1dY6Skm69dy1u6+LSV5g==
X-Received: by 10.107.25.14 with SMTP id 14mr39715421ioz.168.1468954362945;
 Tue, 19 Jul 2016 11:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Tue, 19 Jul 2016 11:52:42 -0700 (PDT)
In-Reply-To: <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
References: <20160719144701.571-1-antoine.tenart@ack.tf> <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 19 Jul 2016 14:52:42 -0400
X-Google-Sender-Auth: 7XJIuvt_-ejwsQ8aqpilGWeKTls
Message-ID: <CAPig+cQ5eGoNFa90__ay+Y7AMP5Zd1VUDXWFCfU1-XX3oEYAkg@mail.gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Tenart <antoine.tenart@ack.tf> writes:
>> Adds a --name option allowing to specify the name of a worktree when
>> creating it. This allows to have multiple worktrees in directories
>> having the same name (e.g. project0/foo, project1/foo etc...). This
>> commit keeps the previous behaviour by making it the default value, i.e.
>> by using $(basename <path>) as the worktree name when the --name option
>> isn't used.
>
> Hmm, is this related to an earlier discussion
>
>     https://public-inbox.org/git/20160625051548.95564-1-barret%40brennie.ca/
>
> in any way, or is it an independent invention?
>
> The conclusion of that discussion thread was roughly "users
> shouldn't even _care_ about the name, and if they have to use name
> to identify the worktrees to do certain things right now, reducing
> the need for such 'certain things', not making it easy to give a
> user-defined name to a worktree, is the way to go", IIRC.

Yes, that's correct. The discussion wandered a bit before starting to
converge at [1] and concluding at [2].

[1]: https://public-inbox.org/git/CAPig%2BcRNUZZBw%3DF-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ%40mail.gmail.com/
[2]: https://public-inbox.org/git/CAPig%2BcSEwib1iFyWE5h8-qTbsAC%2BzsaSDSYQnv6otWoOOjWAeA%40mail.gmail.com/
