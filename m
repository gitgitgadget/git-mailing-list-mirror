X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 12:33:20 -0800
Message-ID: <20061124203320.GA21654@soma>
References: <loom.20061124T143148-286@post.gmane.org> <20061124191609.GA32506@localdomain> <loom.20061124T202153-512@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 20:33:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20061124T202153-512@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32236>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnhjl-0003NK-Ti for gcvg-git@gmane.org; Fri, 24 Nov
 2006 21:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935048AbWKXUdX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 15:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935050AbWKXUdX
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 15:33:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:64728 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935048AbWKXUdW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 15:33:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 917D37DC098; Fri, 24 Nov 2006 12:33:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 12:33:20 -0800
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> wrote:
> Eric Wong <normalperson <at> yhbt.net> writes:
> 
> > git-svn transfers full files, and not deltas.  I'll hopefully have a
> > chance to look into improving the situation for slow links this weekend.
> 
> Yes, but why would that make fetching the first revision slower? In this
> situation, both svn and git-svn would have to fetch full files. Maybe git-svn
> isn't using gzip compression or http pipelining?

Even for the initial transfer, the tree is bundled into one big delta
(at least over https).

-- 
