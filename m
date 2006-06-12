From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 07:59:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120754460.5498@g5.osdl.org>
References: <11500407193506-git-send-email-octo@verplant.org>
 <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
 <20060612082448.GA11857@verplant.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 17:00:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpntO-0006j3-6x
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 16:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWFLO7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWFLO7r
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 10:59:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752020AbWFLO7q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 10:59:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CExegt013977
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 07:59:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CExdMb023645;
	Mon, 12 Jun 2006 07:59:39 -0700
To: Florian Forster <octo@verplant.org>
In-Reply-To: <20060612082448.GA11857@verplant.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21704>



On Mon, 12 Jun 2006, Florian Forster wrote:
> 
> Would it help to cache `git-annotate's output, e.g. using one of the
> `Cache::Cache' modules? Or is browsing of blobs too sparse for this to
> result in a performance gain? I'm sure the modules could be integrated
> as a weak precondition.

The apache setup at least on kernel.org is already set up to do caching, 
as long as the generated headers for the page allow it in the first place.

So caching inside gitweb is generally pointless, at least when it's at the 
level of one result page. At a higher level, if the internal caching might 
improve performance of _other_ pages because it caches the result of some 
intermediate important thing, it might be a different issue.

		Linus
