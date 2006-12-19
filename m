X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Tue, 19 Dec 2006 11:35:57 +1100
Message-ID: <20061219003557.GA17799@gondor.apana.org.au>
References: <20061218080941.GA3857@coredump.intra.peff.net> <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net> <20061218224505.GB13034@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 01:25:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2922 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 20:24:46 EST
Content-Disposition: inline
In-Reply-To: <20061218224505.GB13034@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34782>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTiu-0000uy-R7 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932622AbWLSBYr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWLSBYr
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:24:47 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:4515 "EHLO
 arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S932622AbWLSBYq (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 20:24:46 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6]) by arnor.apana.org.au
 with esmtp (Exim 4.50 #1 (Debian)) id 1GwSxa-0004YL-D5; Tue, 19 Dec 2006
 11:35:58 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1
 (Debian)) id 1GwSxZ-0004dQ-00; Tue, 19 Dec 2006 11:35:57 +1100
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Mon, Dec 18, 2006 at 05:45:05PM -0500, Jeff King wrote:
> 
> but doing it inside an interpolated string doesn't:
> 
> $ foo=bar}
> $ echo "${foo%'}'}"
> bar}'}

Yes it's a bug in dash.  Both quote marks (" and ') are represented
by the same char internally before processing which is where the
mix-up occurs.

I'll work on a fix.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
