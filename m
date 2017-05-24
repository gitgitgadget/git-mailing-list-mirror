Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFF120285
	for <e@80x24.org>; Wed, 24 May 2017 07:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031378AbdEXHIj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 03:08:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36293 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938513AbdEXHIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 03:08:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so16075661pge.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ey16MfDOt0se0hIU9Bk9Hzz7p9hQyMN3Zzmj/7NqQdw=;
        b=l8XCEL/AD0LOoHZ8J3u7g2b5zlgeAu3IsYBuf5p3EwbVBRI92Ye+kN0kHLhy58UKsU
         1XW3IZUWVjwFXxirYlAjxnYEIP2ibzBaS9x5/4p6sFUBVgMJIRl5hb4SrRdAKmQ3ZJVN
         GaFlQH39KCMtYxOh5yzC1vhIj1zpxhV75b8bkAAjOuHRC25oSyI4c/OsifivFKPT9RiN
         ovs1B1/Q5HKJd97oLVjDhILXBlfqdpTM5h1h4liVz9OKw7BF5qsBPUzdtvnsVl5cZKoz
         Oa0vwB/1mvl0PAhIOX+k91bEHFCcEMMmZ2wEOSs6SolqfVMrrPTZ4p5nNCwELLSEM8VX
         LOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ey16MfDOt0se0hIU9Bk9Hzz7p9hQyMN3Zzmj/7NqQdw=;
        b=KTIiLTHZNFH457iXBgzNVpz/pFlY24J0rHCXmF+cISmAxblXWvLhbkDOo0bly5M93N
         7acz5AGBfDz2DNkRX2ibN/YbTRNT+EBkjZwtVHMSVt8cPRCxFROdFf/XOT8j31dY6NNM
         F4KTfvNXEu9otEiVd3nQX9Xxdg27ObR8Sdqv24Be4mSjrayWJSo41hrC3m6tJkMgW9qP
         fcAo/yX5oXNLas5wRG7Oe/qWMFV01O/T35T/1g4cBwSeIXaUcMpfXYchkpJrAKDcxb9h
         7FLzCvQ1iuowKkYsaWP1ecJkuuRzlDZg9mfEzwZxxKxAtv9LbaKEB5tFt4UEe7o6Bx+2
         +lKg==
X-Gm-Message-State: AODbwcCeljRkZJQLh0wxHdTQvuEZMiET+lBHEB8zCZE9xfBjFB1MVD+/
        1mMZsnMx3rV0Lw==
X-Received: by 10.98.101.6 with SMTP id z6mr36446072pfb.221.1495609717831;
        Wed, 24 May 2017 00:08:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id m8sm6879765pga.34.2017.05.24.00.08.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 00:08:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 00/29] Add blame to libgit
References: <20170524051537.29978-1-whydoubt@gmail.com>
Date:   Wed, 24 May 2017 16:08:36 +0900
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com> (Jeff Smith's message
        of "Wed, 24 May 2017 00:15:08 -0500")
Message-ID: <xmqq1srehguj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't had a chance to take a deeper look, but what I saw in
merge conflicts with the rest of the system made all sense to me ;-)
Will take a deeper look tomorrow.

Thanks.
