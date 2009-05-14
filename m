From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 04:13:32 +0200
Message-ID: <op.utwdsutn1e62zd@merlin.emma.line.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 04:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4QUo-0007FB-1w
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 04:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbZENCNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 22:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZENCNf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 22:13:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:47367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751093AbZENCNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 22:13:34 -0400
Received: (qmail invoked by alias); 14 May 2009 02:13:34 -0000
Received: from g225203118.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.225.203.118]
  by mail.gmx.net (mp049) with SMTP; 14 May 2009 04:13:34 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/7pUdbBb37HWN7BrHGSOAaIZSCGYhvT7G3ftuQRN
	t/urHKdnXidP8k
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 8171594459
	for <git@vger.kernel.org>; Thu, 14 May 2009 04:13:33 +0200 (CEST)
In-Reply-To: <op.utv93sdo1e62zd@merlin.emma.line.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119124>

Am 14.05.2009, 02:53 Uhr, schrieb Matthias Andree <matthias.andree@gmx.de>:


> 2. how do I trash the accidentally created 2nd "baz" tag object, i. e.  
> remove it from the (packed) object database? Of course, I can hack some  
> script (or use a text editor) to grind this git-fast-export into shape  
> and re-importing it...

OK, that worked: I traced (with git cat-file) the tree through all tagged  
tag until the first tagged commit, and hack packed-refs (or refs/tags/foo)  
to point to the commit object, and afterwards prune the dangling tag.

However, the other questions remain. I'd think git tag should dereference  
its 2nd non-option argument to a commit before laying down the tag...

-- 
Matthias Andree
