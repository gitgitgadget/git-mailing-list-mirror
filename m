Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D0E21006
	for <e@80x24.org>; Mon,  4 Jul 2016 00:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbcGDABn (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 20:01:43 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46756 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249AbcGDABm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 20:01:42 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bJrKS-0002T7-1m; Mon, 04 Jul 2016 09:01:36 +0900
Date:	Mon, 4 Jul 2016 09:01:36 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, spearce@spearce.org, jrnieder@gmail.com
Subject: Re: [PATCH/RFC] fast-import: Keep a fake pack window on the recently
 written data
Message-ID: <20160704000135.GA9467@glandium.org>
References: <20160703234439.8889-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160703234439.8889-1-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 04, 2016 at 08:44:39AM +0900, Mike Hommey wrote:
> +		/* Ensure a pack window on the data before that, otherwise,
> +		 * use_pack() may try to create a window that overlaps with
> +		 * this one, and that won't work because it won't be complete. */

In fact, there is still a possibility of this happening after that pack
window in closed when opening windows on other packs.

Mike
