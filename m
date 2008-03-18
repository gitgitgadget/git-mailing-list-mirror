From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: auto gc again
Date: Tue, 18 Mar 2008 11:33:45 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803181130240.3020@woody.linux-foundation.org>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <20080318182421.GI17940@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc412-0006jn-Fb
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbYCST0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbYCST0w
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:26:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44594 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753914AbYCST0u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 15:26:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2IIZ0NX005675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Mar 2008 11:35:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2IIXj53010760;
	Tue, 18 Mar 2008 11:33:46 -0700
In-Reply-To: <20080318182421.GI17940@kernel.dk>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.325 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77507>



On Tue, 18 Mar 2008, Jens Axboe wrote:
> 
> axboe@carl:~/git/linux-2.6-block> git count-objects
> 901 objects, 6448 kilobytes

The default auto-gc threshold is 6700 objects. You should *not* be even 
close to hitting it.

But there's a 20-pack pack-limit. Do you have lots of pack-files? But you 
can disable that one with

	[gc]
		autopacklimit = 0

and I do think the default might be a bit low.

		Linus
