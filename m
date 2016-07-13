Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE1F2019E
	for <e@80x24.org>; Wed, 13 Jul 2016 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbcGMRzM (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:55:12 -0400
Received: from latitanza.investici.org ([82.94.249.234]:29214 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbcGMRzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 13:55:09 -0400
X-Greylist: delayed 1690 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jul 2016 13:55:09 EDT
Received: from sabotaggio.investici.org (sabotaggio-vpn.investici.org [172.16.1.3])
	by latitanza.investici.org (Postfix) with ESMTP id 7210C1200ED
	for <git@vger.kernel.org>; Wed, 13 Jul 2016 17:26:27 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptolab.net;
	s=stigmate; t=1468430787;
	bh=3EbJ5KHZjacc7AIkhYuPUdPBxDIOWk1vw9d2Yzy2wr4=;
	h=Date:From:To:Subject;
	b=BP//kp8TRJbprD9C96VzYGDgaeA47g34Ei60/pwQ8hO6C/tzDS6wSNW+Hju0DbfSU
	 rwn/sH5MEmL7WvyjzAPOJQ7Gb87XJXJuk9TyLBypCH+QyCH/0h9aorEiyqwrPY9HIH
	 7cyT/O+OLtc/7zmBo/H7WDTvWGsbLprWMmjHMO6U=
Received: from [91.121.170.222] (sabotaggio [91.121.170.222]) (Authenticated sender: ervion@cryptolab.net) by localhost (Postfix) with ESMTPA id 5396A28009D
	for <git@vger.kernel.org>; Wed, 13 Jul 2016 17:26:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:	Wed, 13 Jul 2016 20:26:27 +0300
From:	ervion <ervion@cryptolab.net>
To:	git@vger.kernel.org
Subject: Https password present in git output
Message-ID: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
X-Sender: ervion@cryptolab.net
User-Agent: Roundcube Webmail
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Sometimes using ssh is not possible and saving https password in plain 
text to disk may be desireable
(in case of encrypted disk it would be equivalent security with caching 
password in memory).

One possibility for this in git is to save remote in the 
https://username:password@domain.com/repo.git format.
However, in this case every time you push or pull, the remote address, 
including the plain text password.
That would introduce additional security issiues and is unreasonable?

Wouldn't it make sense to scrabble the password part in remote's url 
before printing it to output?
