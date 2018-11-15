Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CAA1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 00:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOKYu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 05:24:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeKOKYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 05:24:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so8735132pfn.8
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdSByLAa0QR7W9Y70Tx3V9XaDkRNZigU+pxIf09zeFk=;
        b=Deh6JtNub895VAgVwdHX2a3v/k569Yl1ebbr/kGGUOrtjFB8QhvIipncF6Nhk9f3Yo
         nftgX/Q4r6GYJ5snHaj/FlMJ23eNQ0I7JBZskc5AvQCPURYbN5X/WxQs8DMGxAPGt3IW
         Nbu9+baiFORlvV4eBTZ6xnYtG+5gOUoNw9fySl/pH/rfeGWSDeHLZELbcX3t10fXotbh
         vOCu4tXrHk/PPlgb3hrZ4GV9ntdfshsuF/SkLGf7S7h+jB9PJaL1J3PPBkf0sQQvtoS7
         0mMOQJEq9uDFWC0dv7tbtyrZeWOjZXA+1WA8xN86pyhWwimijYbx6dfPfD1jdQRp4X2k
         IKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdSByLAa0QR7W9Y70Tx3V9XaDkRNZigU+pxIf09zeFk=;
        b=o75uFwpDwog1Gyk08y1jMTTwx4bl5oNB3OUu39ySodb+OjpjIEPld0ZnEd66omEJLp
         uV61Wq1uaowNI0Jo+fb2NOkVnZxpEHnjQ1LnOwrWJtmB4T+UJB3yenlyEAowEt+B0ZZu
         HaLbOGTrhJmzEm9Tl6ffHqeV5bTJ1ntMDUWeG9UdXnnoBYNG04hJ63KPZ5ruwbt4vTrY
         S41z7N31XSmnLTGHy9APW4f0NqW22+tKFazf9VhDJgptzORT+69s/9aURejqXA3elEYW
         bAvmKenNSOAihpYciFXYVU1W6MqAP3y91YKoZCyd7V7CBSxWLFE+vSDlOyEwtrbzz4V7
         tq2A==
X-Gm-Message-State: AGRZ1gLboza900HaON2pj4dR23yWtvfpG6ZELccZtSuzGyG2IeZXxJ2u
        oiQb37Z+p7GQurseMylZtD0=
X-Google-Smtp-Source: AJdET5e1lInlBdWoqUtanue7RPXwvPshja6pJi5gDl+VaMip1959LT0E1yb6VxgBCUR4WhOex4jc/Q==
X-Received: by 2002:a62:9f98:: with SMTP id v24-v6mr4033105pfk.163.1542241157604;
        Wed, 14 Nov 2018 16:19:17 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id s37sm22419691pgm.19.2018.11.14.16.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 16:19:16 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:19:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 1/3] eoie: default to not writing EOIE section
Message-ID: <20181115001915.GB92137@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003911.GB170017@google.com>
 <xmqqtvklzszv.fsf@gitster-ct.c.googlers.com>
 <5fae19dc-2e77-1211-0086-e7aa9d30562f@gmail.com>
 <20181113182502.GC68106@google.com>
 <xmqqzhuctp72.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhuctp72.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  1. Using multiple versions of Git on a single machine.  For example,
>>     some IDEs bundle a particular version of Git, which can be a
>>     different version from the system copy, or on a Mac, /usr/bin/git
>>     quickly goes out of sync with the Homebrew git in
>>     /usr/local/bin/git.
>
> Exactly this, especially the latter, is the answer to your
> question in an earlier message:
>
>>> Am I understanding correctly?  Can you give an example of when a user
>>> would *want* to see this message and what they would do in response?
>
> The user may not be even aware of using another version of Git that
> does not know how to take advantage of the version of Git you have
> used in the repository, and it can be a mistake the user may want to
> fix (e.g. by futzing with PATH).

Ah, thanks much.  I'll add a hint along those lines (e.g.

 warning: ignoring optional IEOT index extension
 hint: This is likely due to the file having been written by a newer
 hint: version of Git than is reading it.  You can upgrade Git to
 hint: take advantage of performance improvements from the updated
 hint: file format.
 hint:
 hint: You can run "git config advice.unknownIndexExtension true" to
 hint: suppress this message.

I am still vaguely uncomfortable with this since it seems analogous to
warning that the server is advertising an unrecognized capability, but
I can live with it. :)

Patch coming in a few moments.

Jonathan
