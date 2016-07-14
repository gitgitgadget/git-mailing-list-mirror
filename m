Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16D520196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbcGNSu3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:50:29 -0400
Received: from lixid.tarent.de ([193.107.123.118]:42072 "EHLO mail.lixid.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbcGNSu2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 14:50:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.lixid.net (MTA) with ESMTP id 5CAA51402C8;
	Thu, 14 Jul 2016 20:50:25 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
	by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
	id 1q5zI3x3pdJi; Thu, 14 Jul 2016 20:50:25 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.lixid.net (MTA) with ESMTPS id 1F775140134;
	Thu, 14 Jul 2016 20:50:25 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id CD268221C7A; Thu, 14 Jul 2016 20:50:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tglase.lan.tarent.de (Postfix) with ESMTP id ACA7B220943;
	Thu, 14 Jul 2016 20:50:24 +0200 (CEST)
Date:	Thu, 14 Jul 2016 20:50:24 +0200 (CEST)
From:	Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: Server-side preventing some files from being overwritten
In-Reply-To: <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607142049240.25238@tglase.lan.tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de> <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com> <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de> <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 14 Jul 2016, Junio C Hamano wrote:

> Can't this become simpler, e.g.
> 
> 	if ! git diff-tree --quiet "$old" "$new" -- "$subdir"

Thought about diff-tree, but additions are permitted,
and diffing the actual file content has overhead too.

Just counting the number of object hashes removed from
the old tree (recursed) works out just fine.

bye,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
