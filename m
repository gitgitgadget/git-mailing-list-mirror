Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DF91FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 01:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbdBHBDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 20:03:14 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:56910 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753568AbdBHBDN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2017 20:03:13 -0500
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id A475726206A;
        Tue,  7 Feb 2017 17:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=9ac03
        CpblQ1taXGtY4Qlafg4524=; b=FLmL3+ML++00Sp1r9L2yHKqbHf7TvpjIqPhwi
        pU/tgl7xs9Y8IxrRxvx8E4P1bIsCvfwIq8d9foQ+AgdO18HvwrpAiO1ERSRQ/zng
        Iw89CSYF9TZp/1H+FlYFd2MMFCPGWGjvPwjAi6mtzANIgh5TsHSAEQwtqfE0Pbte
        vXERZA=
Received: from [172.31.11.72] (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 2814E262065;
        Tue,  7 Feb 2017 17:03:12 -0800 (PST)
Message-ID: <1486515795.1938.45.camel@novalis.org>
Subject: Re: "disabling bitmap writing, as some objects are not being
 packed"?
From:   David Turner <novalis@novalis.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Date:   Tue, 07 Feb 2017 20:03:15 -0500
In-Reply-To: <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
References: <1481922331.28176.11.camel@frank>
         <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
         <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2016-12-17 at 14:50 +0700, Duy Nguyen wrote:
> And we can't grep for fatal errors anyway. The problem that led to
> 329e6e8794 was this line
> 
>     warning: There are too many unreachable loose objects; run 'git
> prune' to remove them.
> 
> which is not fatal.

So, speaking of that message, I noticed that our git servers were
getting slow again and found that message in gc.log.

I propose to make auto gc not write that message either. Any objections?


