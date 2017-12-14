Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84981F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdLNV0N (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:26:13 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:42994 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbdLNV0N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:26:13 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so14818804itb.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9GiPQftk4MOs5maUJCqUyxNQxMrEP4jfORXLe3wXgaU=;
        b=kwbecy4WN5r4cFwcOjEneMe1pIHJTgh9kuiVtmPM9Gz28dPp+5367Hl89jz+LO5NER
         iJpaICNjtMY2eZGMYtWqVNZmnY5L6hSNMJM3p9lIl/ios8oyYjeyuuxO4T/7kkQx1+3X
         djzPhqNUdKXWFQmXuJeRQs4lJSG+ucEewMFdrUviCVNQ8OJzgPNwve6ZhNezFG359eUR
         9gzhrrTXPVARWX+n4z7R4t2HXDME7gWChmRrUILSKDqeNTLYPCN60wK4WwnFic6JF/w6
         wgpNvG5+BxpBuJ8lqYWi7n6muJmL4a4KnezxWLlNO5URUNUYZCQlw3GrLqAYY1mHQiEG
         Znyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GiPQftk4MOs5maUJCqUyxNQxMrEP4jfORXLe3wXgaU=;
        b=uj9qhclmI+CzFOFfFkcRQ1GrKq7QqHWHZBJRgNOvJbIlYF6+WQmAFCtd6CfWMqlzq4
         EDDr/2IMUowkJ+e4NXWZIZ3qWE9TL6enPT7WpDAEs9a7wXMCJUBo59HdD1SDLzw4FDf0
         1Q3JmgL4YMCEfUDzvPymmBR/AnW2zUrpOXRLq06o3MrmlAxKt7wXqktTtn/NCAgJLhu0
         cTyFv7vPhL8ljBKN6MqTyosEjkpa1oBNjDJ97nVghOHU5zcnU6gxTqi768rKuOwIEQuh
         /rlTyPy3Jox8RpPnlziXzovBs1OgngJKXxu/cZJbGzZeCFWmDRStafmWxQT4J2evsK5N
         2B5w==
X-Gm-Message-State: AKGB3mLDgLhRNrFWXo0PlY/mNbQ1CvZFlApmZHPT1uZhC5c83DguggP5
        Eh0ZfbNvz3gM3aurAXfFZms=
X-Google-Smtp-Source: ACJfBot/EiL7pK20pVuc8qftpcoeZDrgDnC1sgjD1x+lrP+gbi9YGbkHWxUkirnMmo35NjiesgZ2zA==
X-Received: by 10.36.190.199 with SMTP id i190mr4971802itf.84.1513286772279;
        Thu, 14 Dec 2017 13:26:12 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z74sm1639149iod.61.2017.12.14.13.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 13:26:11 -0800 (PST)
Date:   Thu, 14 Dec 2017 13:26:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
Message-ID: <20171214212609.GD32842@aiede.mtv.corp.google.com>
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
 <20171214210453.GB32842@aiede.mtv.corp.google.com>
 <xmqq6099t3xi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq6099t3xi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> * sb/diff-blobfind (2017-12-12) 1 commit
>>>   (merged to 'next' on 2017-12-13 at 9a27a20c5f)
>>>  + diffcore: add a filter to find a specific blob
>>>
>>>  "git diff" family of commands learned --blobfind=<object-name> that
>>>  allows you to limit the output only to a change that involves the
>>>  named blob object (either changing the contents from or to it).
>>>
>>>  Will merge to 'master'.
>>
>> Sorry, I should have replied about this a long time ago: I love this
>> option but I am not sure that --blobfind is the right name for it.
>
> Sorry.  I should have updated the description when the option name
> was updated in the latest round.

Sure.  My worry still applies:
https://public-inbox.org/git/20171214212234.GC32842@aiede.mtv.corp.google.com/

But as I said, if nothing comes of it within a few days then I'm happy
to conclude that we did our best.

Thanks,
Jonathan
