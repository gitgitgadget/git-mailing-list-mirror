X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Tue, 28 Nov 2006 14:24:42 -0800
Message-ID: <20061128222442.GC1369@localdomain>
References: <20061128220605.GA1253@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 22:25:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061128220605.GA1253@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32597>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBNg-0007oz-Ls for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757795AbWK1WYp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757796AbWK1WYp
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:24:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:53376 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757734AbWK1WYo (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:24:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 65C802DC035; Tue, 28 Nov 2006 14:24:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 14:24:42 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> finish_report does seem to return a useful value indicating success
> or failure, so we'll just set a flag when close_edit is called
> (it is not called on failures, nor is abort_edit) and check
> the flag before proceeding.

Also, this only affects the delta fetcher.  When using the non-delta
fetch: the SVN libraries will just segfault :)

-- 
