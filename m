Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F29201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 05:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdKNFP1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 00:15:27 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:55438 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdKNFPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 00:15:25 -0500
Received: by mail-qk0-f170.google.com with SMTP id d125so8155271qkc.12
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 21:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c85eBMtxJ4jVSRgFGtjJRplQvHDMbJG9KWEJt2MAP+s=;
        b=nJDBm9KJeU7S4/6ZyLNYKQztf0k2xaMNE28XZypEWcQj4BIFyB7nDf1Y9HN9pteujA
         dMQAKL+U+hAj9iXjf4Co0gxVV7wgtoB3EhSmwphiFwjRvhfqU8j7K5KgKuhvemcu+PF/
         J/4HyDORLmM6joLpqRFaYEaw4FOcRVvRljZg8+GfrPgmHGk5GnysUDAbK8eFUeJLcnF5
         SjXzULDOpiy0s+Shvm+VzAEAFGJqKuA/JJhB9PPn4eYmRlnG+dOLydt7KxDyeIEBwnr4
         iFNYZIRcpsxfiy0W7Gx4D/JmifvTgu5krENm+wbxS+DGiQ6DxLLBx/gG2scnw4B6gLF0
         an6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c85eBMtxJ4jVSRgFGtjJRplQvHDMbJG9KWEJt2MAP+s=;
        b=GjopfOivapZUi8dECoNf42oOqIzZdA6Avx7+1tgdLv75131c7UE5npkcYlvjMTIqvK
         178I8VT/a+NWLgvBf13pRgZobhPRMR8jYc8ZNeh4xNBTI0tWHX5NcQF0RR8zMkrhrlOP
         uc8y8jwbWAgQUdsakyH6HxhsZs4iVc4BJWPJFBtErCOQoqc6m06kEjbjhjHBJ3z0aE9S
         UYuR6DUnXw1GwS8dNRFb15Ip6aTIZ31n3t15qCPKtD/UJf8lSTg9A/VN25kQMkisjN7T
         5VRoiCXaWrxXQuhgZ3GP0Q88kYRbRYjOeRq063K6VpK5rYuwnxkDMRAz8d3xLpDK2of0
         2L6w==
X-Gm-Message-State: AJaThX5xnIooySHhq7k23nBhBFofZShK7rL5QzheVZoBP9bL0p9yhdUT
        sSp2qPXWcuPIlxUFykRrN6M=
X-Google-Smtp-Source: AGs4zMYn66Q8/x6X5dBPz0SdtOKbafu8YPuVhoISYrYXZXDLgK+w9/WHRPegdeCbbZVbT9agfsDnFw==
X-Received: by 10.55.166.82 with SMTP id p79mr10244337qke.302.1510636524480;
        Mon, 13 Nov 2017 21:15:24 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id l207sm11725914qke.97.2017.11.13.21.15.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Nov 2017 21:15:23 -0800 (PST)
Date:   Tue, 14 Nov 2017 00:15:20 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>, git@vger.kernel.org,
        Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171114051520.GU5144@zaya.teonanacatl.net>
References: <20171113210745.24638-1-tmz@pobox.com>
 <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
 <20171114030351.GS5144@zaya.teonanacatl.net>
 <xmqqshdh5ygy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqshdh5ygy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> The message goes to the standard output stream since it was 
> introduced in 809f38c8 ("git notes merge: Manual conflict 
> resolution, part 1/2", 2010-11-09) and 6abb3655 ("git notes merge:
> Manual conflict resolution, part 2/2", 2010-11-09).  I do think it 
> makes more sense to send it to the standard error stream, but just 
> in case if the original author thinks of a reason why it shouldn't, 
> let's summon Johan and ask his input.

Sounds like a good plan.  If the message does move to stderr, there 
are also a few tests in 3310 that need adjusted.  They presume an 
error message from `git notes merge`, but they only redirect stdout to 
the output file.

While I was bored, I prepared a commit with these changes and 
confirmed the test suite passes, in case we get an ACK from Johan.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It is impossible to enjoy idling thoroughly unless one has plenty of
work to do.
    -- Jerome K. Jerome

