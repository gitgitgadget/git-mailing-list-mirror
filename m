Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9989220A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdASV06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:26:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751514AbdASV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B35E5F8F6;
        Thu, 19 Jan 2017 16:22:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nXsnq7hOutcFo3bgxtKqc04cl/4=; b=ew30Wh
        Xjeg3+sduxYmE3p3iPhpwS8c0GJf25UWz9r8qA325+l9Q/nvSMPre7eafCh1LA4j
        MBAr0NYje/EltG256evfdu6cvjTG54iBUS087iHQ9a7B1MzK9GE9mt8hhH7j1aNu
        LlgjYBlBA55aOzErdM6wyH6rXHvzfe5nzmrkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SqetBCZo7/BmempkQFYeHCbZ+VecA0Js
        l1/2GmdUmEFttYtXm+Hy+1SqTdkWSs78boVla/6pxOCTNCsv6dwWNLZ8NPWXzxW8
        s1wWiKTAX+ulkkmRtFQP18OhnEVFGq7IG2mHVp8VZ45EH+AphQuecfMYhnikB34B
        D2Hj5W+du7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 509D05F8F4;
        Thu, 19 Jan 2017 16:22:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46CC05F8F2;
        Thu, 19 Jan 2017 16:22:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
References: <20170115183051.3565-1-wsa@the-dreams.de>
        <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
        <20170119204343.xtotmjddhbum2mvr@ninjato>
Date:   Thu, 19 Jan 2017 13:22:00 -0800
In-Reply-To: <20170119204343.xtotmjddhbum2mvr@ninjato> (Wolfram Sang's message
        of "Thu, 19 Jan 2017 21:43:45 +0100")
Message-ID: <xmqq7f5qzqx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 510F8B88-DE8D-11E6-A760-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> I didn't know about trailers before. As I undestand it, I could use
> "Tested-by" as the key, and the commit subject as the value. This list
> then could be parsed and brought into proper output shape. It would
> simplify the subject parsing, but most things my AWK script currently
> does would still need to stay or to be reimplemented (extracting names
> from tags, creating arrays of tags given by $name). Am I correct?

That is not exactly what I had in mind.  I was wondering if we can
do without any external script, implementing the logic you added
inside shortlog with an extra option that triggers the whole thing,
which may call into the same trailers API as used by the
interpret-trailers command to do the parsing and picking out parts.
