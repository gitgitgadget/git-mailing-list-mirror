Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EAA1F428
	for <e@80x24.org>; Tue, 28 Aug 2018 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH1XiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:38:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47141 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbeH1XiF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 19:38:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B70520F12;
        Tue, 28 Aug 2018 15:44:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 Aug 2018 15:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=r9H8dqI1djqgsoB/Jg6zG6JhyMr9t
        shnBjKSLcyHUgw=; b=B3MNcWo6DSWlEDyaWHiUo1/WR9P8pDDhP8HkoRwHD9q6k
        kPHz1T26aK9ps3Jq6kJcCURiqCjpvI+Vmz7R/QttxzEgoguMl9ANdQ3aKZ5UXaUP
        J92IZ2gHJCeooceVlKOezH563ZBCuquJLO3UC5OlsnQ31upXXbMkY3AlfaIVIGej
        skhC6XNsnp8YxLMi36fdloZo9pgPl93p5JIO4t6PHI99jsxXCRcikrGvcsPYZGtr
        grCTPCqjrln6RzHYEbcgIT6HmS8mW+vk1L+CSEhvBsU0CgCu2mq95SlFiv6gBzjt
        Dl0idwxVh9qHJ7/Nuqc7HsTrOrUBkfoK5cyIT5DGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r9H8dq
        I1djqgsoB/Jg6zG6JhyMr9tshnBjKSLcyHUgw=; b=wLZF7TM8KbBykgPGrIS9eQ
        L0gBde3pGmhQYl6NF2J5pAwh5hzGjABggI9mzksoy/YwozixcIkKMd4rFqVW5zV4
        TdJiXoI97VjAf+fGjJg988QAsQnKMuzySpE1Qr+FArCE1PaFqoO7f5iET74CE1Ms
        z30WufMtDvo9CBM+c9zziPYW4XCwxkFMKkZTrDfasl1gOxebK1AsKnSMftAX2l/g
        j7yh0nu94NknOCRceBmDMsjqV6Wp9WtEDNiGg6JphVb4f/lJEzljQQcnKwCTaQZS
        1INt3GUao4BDcmmUKfG2ypGGTiKNy5uOKRKhcLW2yirBfe/7Ax7e/f2JhK0k8AIA
        ==
X-ME-Proxy: <xmx:N6aFWyOyO99x--wnYiXEcj03Nm1gTn8ImeOc0X1HOpjt7THdXwNJkA>
    <xmx:N6aFW24jZ09WwFmxlqIBe0l2lP0P2ks9fMd6fzqKY5DR7YJjKih8jQ>
    <xmx:N6aFW26ix7XH3f_CWFLaiuR710sykphOKNhjrgzs2FhcCpQxipkbEw>
    <xmx:N6aFWxg37Z5-D401qJXULCCLFmszWL2VYfjtoBqh1W1m2WRWAuGDnA>
    <xmx:N6aFW7BrIxqm-uyAHsJnwC9oXTfoICUWMNIuRcy8bIa3-1F-q9zlsA>
    <xmx:N6aFWy8xFHRXLkW83E6EXstRcsGGS_foacTmHWXdQHicbM3uYxvPNw>
X-ME-Sender: <xms:N6aFW-VvvAYttVmHX9ndwk0s_-HnlxIS5rrQMKJIwVT7pRHr3wsVnA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0728E4686;
        Tue, 28 Aug 2018 15:44:54 -0400 (EDT)
Subject: Re: GIT_TRACE doesn't show content filter files it's operating on
From:   Stas Bekman <stas@stason.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
 <20180827235321.GB11663@sigill.intra.peff.net>
 <28045b26-4822-b00c-30f3-1076d2e49d1f@stason.org>
 <20180828005810.GA18659@sigill.intra.peff.net>
 <9fc6cdcf-2e72-8eb1-9bcd-f513babd9c6f@stason.org>
Organization: Hope, Humanized
Message-ID: <a3a1e935-8eb7-0894-4474-74f79dade11e@stason.org>
Date:   Tue, 28 Aug 2018 12:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9fc6cdcf-2e72-8eb1-9bcd-f513babd9c6f@stason.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-27 06:13 PM, Stas Bekman wrote:
[...]
> I now know how get the filenames for "clean/smudge" filters. Can you
> please help with the same for "textconv". %f doesn't work - it gets
> stuck there waiting for stdin, the following seems to pass, but I'm not
> sure it's correct:

On a closer look this is not needed for "textconv" as it already logs
the filename in the GIT_TRACE=1 trace.

I have no more remaining questions, Thank you for your help, Jeff.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
