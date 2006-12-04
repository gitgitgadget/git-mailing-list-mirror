X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Mon, 4 Dec 2006 01:05:49 -0800
Message-ID: <20061204090549.GB30316@hand.yhbt.net>
References: <20061128220605.GA1253@localdomain> <871wnget3b.fsf@mid.deneb.enyo.de> <20061204085253.GA31047@soma> <87zma4yr71.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 09:06:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87zma4yr71.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33175>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr9lp-0007Ro-VJ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 10:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759783AbWLDJFu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759792AbWLDJFu
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 04:05:50 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9121 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1759783AbWLDJFu (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 04:05:50 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id 747C92DC034; Mon,  4
 Dec 2006 01:05:49 -0800 (PST)
To: Florian Weimer <fw@deneb.enyo.de>
Sender: git-owner@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
> * Eric Wong:
> 
> > Does the following patch help?
> 
> Don't think so.  The issue is not timing-related.  I've seen a failure
> every 1000 requests, which suggests to me that it's hitting the
> MaxKeepAliveRequests limit configured on the server.

Actually, that's exactly what this patch should fix.  git-svn restarts a
child every 1000 revisions to avoid memory usage from going through the
roof.

-- 
