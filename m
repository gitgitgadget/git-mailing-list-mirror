Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3D7202A5
	for <e@80x24.org>; Wed, 20 Sep 2017 20:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbdITUsZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:48:25 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:45657 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbdITUsW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:48:22 -0400
Received: by mail-pg0-f45.google.com with SMTP id 188so2338645pgb.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xa95zCZt/WDHxx+TbcQGYZ42mm9Ox4+Nb305puFatK0=;
        b=msWJxnTpMn+kCUhPgsWHJeLOtHYiGsMtozH4KLOzn5PKvHL8lAYqUICosAbyObAYit
         PPyVBfQdG5FxNbRSlpqjAIK5eu82t+kQPpZhfCoptPdKQn5JpvW9D2NmnaE+Hqy0UkJK
         Hj6ObR2hNFma7IcIQBtM0LP/K/mlhP0I36+mRX17BZIBffhWIz4bX9BBFjmMLNYOhVcM
         KWg7/UXcXkdF13u0aiT63rgAcvd2I+tUAzhYPVv4Qhtg20NktHjvFRVAUY+NRbjIQu9z
         JNZ/8hbBTxVp7AXa5GabDcCK2eZCHvN3BtfR44Ok+F9JD1vwwtr5rOuP7k37h2UjkELr
         y3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xa95zCZt/WDHxx+TbcQGYZ42mm9Ox4+Nb305puFatK0=;
        b=HGmpcZ8npYgbeHqmTvMcZ/s1qALVE0qxJycSR3eWtE6FvmyEb0metJoaHQ5NNGyYP4
         4DgDmmm/XETYJrQJIpIt827osGwH1ObwrLa2MKizxxhyMbO9VgQFAz1J1lrQxuOI1O4F
         +76nR2tMgHEdCkU/4YH4+dzSTsxBrAQPAJc45WTiIUQUW9dUmFDFyRYdvA12njvKz+uN
         Fv68BOB+U2n0P/aNRgPOzMBS8wycRpYa7zRH82lmTyrU7/Y0rmKmMOrIuHaFAhkngQUx
         QSYpwB0xKdRhgAsY9P32m7MFGvqlk5MQigy7ExHR5nkY2R8FovhwPTtZJpqBGFgzmHIP
         uw7w==
X-Gm-Message-State: AHPjjUgjtFQqgvlBcw/mEKGvkiVDRmWLiksJhXfekC2a8EtqgUFt0Q32
        hz8TMsJF3JhS079h+0hhmKQ=
X-Google-Smtp-Source: AOwi7QC99Qp+o+35gqtG7o/z0v6hKx750RmyqkEo1jWd1Oy99+TWUFX3l7gak3cUkaCBzYKLidgRaQ==
X-Received: by 10.84.129.226 with SMTP id b89mr3278952plb.0.1505940501653;
        Wed, 20 Sep 2017 13:48:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id b22sm9351331pfh.175.2017.09.20.13.48.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 13:48:20 -0700 (PDT)
Date:   Wed, 20 Sep 2017 13:48:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        gitster@pobox.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1.5/8] connect: die when a capability line comes after a
 ref
Message-ID: <20170920204818.GE27425@aiede.mtv.corp.google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170920184832.146564-1-bmwill@google.com>
 <20170920191431.emornzhse6f7s5mg@sigill.intra.peff.net>
 <20170920200627.GA82704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920200627.GA82704@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 09/20, Jeff King wrote:

>> (For that matter, could we just be checking whether *list is NULL?)
>
> True, that would probably be the better way to do this.

Nice idea, thank you.

That doesn't capture a few other cases of pkts that aren't supposed to
come before the capabilities^{} line:

 * shallow
 * .have
 * capabilities^{}
 * invalid refnames

Perhaps it should check all of those:

	if ((shallow_points && shallow_points->nr) ||
	    (extra_have && extra_have->nr) ||
	    got_dummy_ref_with_capabilities_declaration ||
	    got_invalid_ref ||
	    *list)

What happens when another type of pkt gets introduced?  This feels
pretty error-prone.  The underlying problem is that we are emulating a
state machine that is not a simple for loop using a simple for loop,
by piling up variables that keep track of the current state.  That
suggests one of the following approaches:

 A. Replace saw_response with an enum describing the state.
    Immediately after reading the first packet, update the state to
    EXPECTING_FIRST_REF.  Immediately after reading the first ref,
    update the state to EXPECTING_SHALLOW.

 B. Use instruction flow to encode the state machine.  Have separate
    loops for processing refs and shallow lines.

By the way, there are some other ways the current code is less strict
than described in pack-protocol.txt:

 - allowing an empty list-of-refs.  (This is deliberate ---
   pack-protocol.txt's lack of documentation of this case is a bug.)

 - allowing multiple capability-lists

 - allowing capabilities^{} combined with other refs

 - allowing refs, shallow, and .have to be interleaved

Tightening those would likely be good for the ecosystem (so that
buggy servers get noticed quickly), but that's a separate topic from
this change.

[...]
> I wasn't sure either, which is why I added the comment to prod
> discussion.  I agree that is is orthogonal to this series so I'll most
> likely drop it, as it doesn't help with the protocol transition
> discussion.

I'd be happy to write a separate patch adding the NEEDSWORK comment
(or even a patch doing what the NEEDSWORK comment suggests) to avoid
derailing this one. :)

Thanks,
Jonathan
