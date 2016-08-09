Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A033F1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 08:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbcHIILj (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 04:11:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58033 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751277AbcHIILe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 04:11:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C0B6B2071E;
	Tue,  9 Aug 2016 04:11:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 09 Aug 2016 04:11:33 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=/Lz3t9FsipijI3VwEFIv3Qyra/k=; b=VgyJTV
	bG5smhL7Vm6TU/AcQP9tzLlnOVarkVcjxJWxFa85pWy0s+IcVHy1B3vRXZeK9ujg
	2dGIPEKkVWGAEh7zH84cWJOfOeuZlz9ulZoHnDMJ4NT5+F9mBvpvOJj2dA8UDaGw
	gQYG+Too5zzKbuX68bHJ51vhlg5uNUQ45gRGI=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/Lz3t9FsipijI3V
	wEFIv3Qyra/k=; b=NfWYgessgdwgz3vcLWc2XDK0DEnVl2Zq1kf4OitzmYJuSpG
	P6uzZaaQHYEO8ro4brZTZTH4DpVfbCN6YaTEjrq7uU39Y5gVy1XCPs74qTDKE48s
	D8+kDB47AGACUVnN38EUUsH3ETN1HZWGMPsxVZA5fvNS6oW8Tp07H+H7gUxA=
X-Sasl-enc: ml5Kbg7FWfW7nRNLT81Z00eZrCAf7O37Ks+X5hn21d5u 1470730292
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id E1DA6CCE66;
	Tue,  9 Aug 2016 04:11:30 -0400 (EDT)
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de>
 <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <6adc480d-15e3-c0ac-0e05-eb10c767a8ab@drmicha.warpmail.net>
Date:	Tue, 9 Aug 2016 10:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty venit, vidit, dixit 09.08.2016 01:20:
> Given that I work for GitHub, I'm uncomfortable doing any more advocacy
> here. If people have concrete questions, I'd be happy to answer them, on
> the list or in private.

You're doing a great job differentiating between your roles as a member
of the Git devel community and as a GitHub employee, so please keep the
discussion here.

Maybe two more points of input for the discussion:

off-line capabilities
=====================

The current workflow here seems to work best when you are subscribed to
the git-ml and have your own (local, maybe selective) copy of git-ml in
your (text-based) MUA (mutt, (al)pine, emacs, ...) that can jump right
into git-am and such directly. I'm not sure how important the "off-line"
aspect of that is for some of us, and how that could be replicated on
GitHub - while PRs and such may be Git based behind the scenes there
seems to be no way to clone that info and work from a local clone.
(Don't know if GitLab is more open.)

My own setup
============

My usual MUA is Thunderbird because of its integration with calendars
and address books. I usually read and post to mailing lists via
nntp/gmane, that works best for me for several reasons (e.g. archive
available when I need it).

For git-ml, I had to learn early on to answer by e-mail to git-ml rather
than by nntp-reply because proper nntp-replies somehow didn't meet the
expectations of the e-mail users (double copies because of the cc-policy
or such, I don't remember).

I use git sendemail even for small throw-in patches because the git-ml
does not allow attachments but wants patches (files) as in-line text,
and Thunderbird possibly reformats text (because it's text, you know).

When I want to try out a proposed patch I have to "save message" and run
git-am because patches don't come as file attachments on the git-ml
(can't use "save/open attachment"+ git-apply) nor a PR (can't use git
fetch nor view in browser). If it's a series, I have to do that for each
invididual patch, which usually means I simply don't (or rely on Junio
doing it and fetch his xy/topic branch).

And more often than not, patches from series do not appear in sequence,
not threaded on top of the cover letter (in the gmane nntp version of
git-ml), and it usually happens for the same people again and again,
which tells me it's a git sendemail config issue and not gmane.

So really, everytime I interact with the git-ml I think about switching
to mutt or such just for git-ml, even though over time I have gotten
used to the number of hoops that I have to jump through if I want to
interact with git-ml.

Suggestion
==========

Maybe the current gmane woes are a good reason to try out something
different for a month or two, with copies to the git-ml, and with the
default being to revert back to git-ml after that and discuss what we've
learned. As a result we may improve our workflow here, get GitHub to
improve, and maybe switch or not. Either way we could profit from that.

Michael
