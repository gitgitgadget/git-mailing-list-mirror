X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method  HTTP/1.x  proxying
Date: Fri, 24 Nov 2006 09:57:01 -0500
Message-ID: <20061124145700.GA13947@coredump.intra.peff.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu> <7v64d5keke.fsf@assigned-by-dhcp.cox.net> <67mz6h6xmb.fsf@poseidon.eteo.mondragon.edu> <7vfyc9cjci.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 14:57:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vfyc9cjci.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32219>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncUH-0007mk-AJ for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934633AbWKXO5F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934635AbWKXO5F
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:57:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:6373 "HELO
 peff.net") by vger.kernel.org with SMTP id S934633AbWKXO5F (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:57:05 -0500
Received: (qmail 2631 invoked from network); 24 Nov 2006 09:57:08 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 24 Nov 2006 09:57:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Nov
 2006 09:57:01 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Nov 24, 2006 at 12:57:49AM -0800, Junio C Hamano wrote:

> +			# Skip up to the empty line of the proxy server output
> +			# including the response headers.
> +			while ($rep = <$s>) {
> +				last if (!defined $rep ||
> +					 $rep eq "\n" ||
> +					 $rep eq "\r\n");
> +			}

Nit: checking defined($rep) inside the loop is redundant.

