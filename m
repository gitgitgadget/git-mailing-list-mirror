From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 10:47:42 +0100
Message-ID: <4280833E.2020300@dgreaves.com>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <20050510083609.GF11221@kiste.smurf.noris.de> <20050510085626.GC8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 11:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVREC-0000zY-6w
	for gcvg-git@gmane.org; Tue, 10 May 2005 11:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEJJr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 05:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVEJJr5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 05:47:57 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38308 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261598AbVEJJrz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 05:47:55 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5CB1CE6DD0; Tue, 10 May 2005 10:46:47 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09906-04; Tue, 10 May 2005 10:46:47 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.133.19])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 985BBE6DAA; Tue, 10 May 2005 10:46:46 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVRL5-0000SM-1I; Tue, 10 May 2005 10:47:43 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050510085626.GC8176@lug-owl.de>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan-Benedict Glaw wrote:

>On Tue, 2005-05-10 10:36:09 +0200, Matthias Urlichs <smurf@smurf.noris.de> wrote:
>  
>
>>Jan-Benedict Glaw:
>>    
>>
>>>>	find * \( -type f -o tyle l \) -print0 | ...
>>>>        
>>>>
>>>Btw, this won't find dot files, so using "." as the path list (instead
>>>of "*") might be wise...
>>>
>>>      
>>>
>>git doesn't want to handle dot files anyway.
>>    
>>
>
>...which I actually consider to be a bug. Why should git care about the
>filename, as long as it doesn't clash with ".git"?  After all, it's just
>a plumbing mechanism designed to locate file contents by SHA-1 hashes.
>It shouldn't deal with file names at all, really:-)
>  
>
I tend to agree that a generic 'content tracking system' shouldn't
impose this kind of rule.
Requiring well formed filenames (eg no //, no trailing /s) is fine - but
dot-file-discrimination?

When I first saw it, I expected this kind of rule to (eventually) be
lifted from the plumbing to the porcelain. The minor problem is that
Linus seems to like getting his hands dirty and keeps using the plumbing ;)
(eek - these analogies...)

David

-- 

