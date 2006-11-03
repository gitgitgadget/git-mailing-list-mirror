X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: multiple branches or  multiple repositories
Date: Fri, 3 Nov 2006 11:01:16 -0500
Message-ID: <20061103160115.GA27895@coredump.intra.peff.net>
References: <eie7ae$ib6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 16:02:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eie7ae$ib6$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30860>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg1Tv-0002Ct-Fg for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752526AbWKCQBT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbWKCQBT
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:01:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:21205
 "HELO peff.net") by vger.kernel.org with SMTP id S1752526AbWKCQBT (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:01:19 -0500
Received: (qmail 10889 invoked from network); 3 Nov 2006 11:00:20 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 3 Nov 2006 11:00:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov
 2006 11:01:16 -0500
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Fri, Nov 03, 2006 at 02:51:30AM +0100, Han-Wen Nienhuys wrote:

>  - for each module, create a separate git repository.  Inside the 
> repository, each subproject has its own branching
> 
>  - put each module as a separate branch in a shared repository.
> 
> I think the first option is the most natural one, but are there any 
> issues, besides namespace pollution to the second option?

I don't believe there is currently an option to git-clone to grab only a
single branch, so cloners in the second case would end up having to get
_all_ modules (though such an option would probably not be hard to
implement).

The plus side is that a single 'fetch' would grab updates for all
modules (with only a single connection to the server).

