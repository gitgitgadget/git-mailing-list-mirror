Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2470B209A9
	for <e@80x24.org>; Mon, 26 Sep 2016 22:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934510AbcIZWSJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:18:09 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33151 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbcIZWSI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:18:08 -0400
Received: by mail-pf0-f171.google.com with SMTP id 21so70019147pfy.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asSbE6ue/rXV5JELdjum7twenbbZR1mAkyxgq58K5hA=;
        b=PFJKpjpiATBwDG+2KoP0LpiIkndl45oPdeUoDuMp48PIAkL+GJDU4B3yL9IGAmDOlq
         CVAzJUdqI9HDuJDiDmb6mLWr7U2DG3REcJtvzddpQjj9bYRVdgB1Juqkvt3EEmCWuUDp
         Ew5k5FsI5/tHAtS18jfuM+fE8Yqq9obyHRdk5JtJTeYY9FTDPdDwoqXvgjxO6MDWFw3k
         Ze1ZBYC7GN4zAKxnL4P7gsbiIiABWAadP7Jj7t4bDTbzOkz0zfsiNJBqPExF6XEmyckT
         WATpENKj8GvdrDtLyeA5T7uIUhdtLMKohaJ2JGArURX+2npMvUtibCZZ6uXF2Ck1hS5K
         7/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asSbE6ue/rXV5JELdjum7twenbbZR1mAkyxgq58K5hA=;
        b=JyNq2dgfetaQ1IcpSyKZ5e31ej/70+8HXf+pU8bSTD5+/sqbylmq6wEA90704OFtkv
         HNX7QMrk4DUyI0Iti/Z8OiMdpBr5s2XiL6dJO5ZQtQmH8LLwEY5B0mm4TzudVtjz8X8y
         mMkrJbDLQXwhue3GiFynOjGBS7jqdK9NGh9gU2rGqdnu4ZSc/inhK8ovchdXsz8GYowc
         PGIQXEETolj1RIeUIlRm7P77zqjcrlVvvwfYu87fXXCRyXw66y/TPHpgWhaINh+eKO4n
         JghkjUHq3mO2YD7lqRX7HCowvM/nvAkBWsxsb1nZd28vw3gDa4KMJXu16S9sGQCFapbB
         yeKQ==
X-Gm-Message-State: AE9vXwO4DSoncGZWAXqMys3aPk574wgKQISqZuIAfs2CpfPOTcwMiD0XyCzOxi9TZk4NuaRK
X-Received: by 10.98.83.130 with SMTP id h124mr41581150pfb.154.1474928287455;
        Mon, 26 Sep 2016 15:18:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:68f5:3ae7:a09a:2077])
        by smtp.gmail.com with ESMTPSA id b125sm33312320pfg.36.2016.09.26.15.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:18:06 -0700 (PDT)
Date:   Mon, 26 Sep 2016 15:18:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Documentation/fetch-options: emit recurse-submodules,
 jobs unconditionally
Message-ID: <20160926221803.GA10222@google.com>
References: <20160926193553.32631-1-sbeller@google.com>
 <xmqq7f9yqu9w.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbeq+Wznm=ChWO0tU5A_haPQ6DvKNHbK+8Y3es5OVcRag@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > By the way, 7dce19d3 is interesting in another way and worth
> > studying in that it adds --submodule-prefix ;-) It may be something
> > we want to consider consolidating with what Brandon has been working
> > on.
> 
> That's why Brandon is cc'd now. :)

Interesting.  Once we get something we agree on for adding the
--submodule-prefix option to the top level we'll definitely have to
update this section of code with the change.

-- 
Brandon Williams
