Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380B01F406
	for <e@80x24.org>; Tue, 12 Dec 2017 21:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbdLLVGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 16:06:30 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46974 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdLLVG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:06:28 -0500
Received: by mail-qt0-f195.google.com with SMTP id r39so584386qtr.13
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wR8Ykyuln2u0h569fLaxzSOM4rDlJiyXvDLyzm4EWUo=;
        b=nwV7FS+nTs1ffTFDHzmOimzVbGFp57DpQsze5gtuZ+5kaGgNEzlUurSuqdxcXzEiX0
         j07p4MCMmsRTNc+B11nmqW8qyd235bSjxwLzKrRzVHpb03BYlwnwPO/hdeJFb286TQkQ
         yEMLfXUs+JTlT1bWMYt46Vnspnzoi/f/lV/urzSWSJmHarhf1B03UezsLo77S/E9Xm54
         NxnM999bLoa3BQibY7O6e39ymOLmRLARve7uzOuV2QBhtSUNmDacUJ1vDT7/kWNKGJrw
         QzXIbDvPnYmN2ftyn/+FBPqD56PhBa+NJ9CvDEj2AgoShPg0gnBiWtEsBvivI2sGWiKR
         tl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wR8Ykyuln2u0h569fLaxzSOM4rDlJiyXvDLyzm4EWUo=;
        b=GZH0XPdZJg0SkykVMv0xMYD/aAZIz0qslRVh2sJbFcokJWtehQ4cM+9TSDQTrRrEzD
         05YrFfYFvKd+I0pSjDYQR06a8AiSiO/PXHBgPYRLkTMFm+qyPJPTqnIcMxjJ/LustL9W
         cFXcGPPccgJ4gHQl/aBTNDnl1uFXOU5SExyESe0+iw6BLIFhtQV5TXvA9JVhPAfAc6dt
         bsU7zeHySNoFASmTHhhb1g+pl+rXIbfF55yBNOZ37tyxstY6vxnfmOhUclwfknejCGQg
         P9fg66MnnD4yvojZkmcTA1IYrpTTovNzQg2W+dQUHlE9lsXYsZnWUaXCHRJT/hy7h45a
         tJ9g==
X-Gm-Message-State: AKGB3mJ7az0OJGREJl+Gp7X3i1C3qgMuZzFQ9ylv0Az6FDPQAvzXRt6A
        DCeb39FU9b1mQd9BdosEE9Y=
X-Google-Smtp-Source: ACJfBouD3WoXw2Jw5CKlcwBKYzFPF5VVR17OoiMbwXK/w6cKZUEZfyhscv/hfKfkvNxeFgIUiPlpYg==
X-Received: by 10.237.62.202 with SMTP id o10mr7924653qtf.241.1513112787581;
        Tue, 12 Dec 2017 13:06:27 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id j1sm67141qkc.5.2017.12.12.13.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 13:06:26 -0800 (PST)
Date:   Tue, 12 Dec 2017 16:06:23 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, dnj@google.com, git@vger.kernel.org,
        judge.packham@gmail.com, kostix+git@007spb.ru,
        manschwetus@cs-software-gmbh.de, max@max630.net, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH] t/helper: ignore everything but sources
Message-ID: <20171212210623.GV3693@zaya.teonanacatl.net>
References: <xmqqbmj31zve.fsf@gitster.mtv.corp.google.com>
 <20171212205606.75581-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212205606.75581-1-sbeller@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Stefan Beller wrote:
>> If we ignore everything but resurrect *.[ch] with negative exclude
>> rules, can we do the same without moving things around?
> 
> Yes, there is also one lonely shell script in there, which also needs
> exclusion.

There aren't currently any .h files, but I suppose it doesn't hurt to
include that pattern to be safer for the future.

> +*
> +!.sh
> +!.[ch]

The ! patterns are missing a '*'.  I think it should be:

*
!*.[ch]
!*.sh

Does it make sense to also include !.gitignore as well?
It's already committed, so it's not ignored.  But perhaps
having it listed will save someone from getting their repo
into a state where local changes to .gitignore aren't picked
up (I know that's a bit of a stretch).

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
How much does it cost to entice a dope-smoking UNIX system guru to
Dayton?
    -- Brian Boyle, UNIX/WORLD's First Annual Salary Survey

