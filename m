From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Some documentation...
Date: Wed, 20 Apr 2005 18:35:13 +0100
Message-ID: <426692D1.20304@dgreaves.com>
References: <42668C8D.3000209@dgreaves.com> <Pine.LNX.4.61.0504201321380.2630@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:33:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOJ42-00065Y-1q
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVDTRgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVDTRfl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:35:41 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:31709 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261689AbVDTRfP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:35:15 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 04546E6D5D; Wed, 20 Apr 2005 18:33:30 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16158-14; Wed, 20 Apr 2005 18:33:29 +0100 (BST)
Received: from oak.dgreaves.com (modem-1977.baboon.dialup.pol.co.uk [81.78.23.185])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 42E07E6A88; Wed, 20 Apr 2005 18:33:29 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOJ6X-0000fa-Cu; Wed, 20 Apr 2005 18:35:13 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504201321380.2630@cag.csail.mit.edu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

C. Scott Ananian wrote:
> On Wed, 20 Apr 2005, David Greaves wrote:
> 
>> In doing this I noticed a couple of points:
>> * update-cache won't accept ./file or fred/./file
> 
> 
> The comment in update-cache.c reads:
> /*
>  * We fundamentally don't like some paths: we don't want
>  * dot or dot-dot anywhere, and in fact, we don't even want
>  * any other dot-files (.git or anything else). They
>  * are hidden, for chist sake.
>  *
>  * Also, we don't want double slashes or slashes at the
>  * end that can make pathnames ambiguous.
>  */
> 
> It could be argued that './' is a special case... but at the moment this 
> is definitely a designed 'feature' not a 'bug'.

Indeed - I've been reading the code to document it as correctly as possible.

But I actually found this by running:

   find . -type f | xargs git add

for a new project - so I'd class it as user unfriendly...
Yes, I know how to get round it :)

I have ensured that my next perl version of gitadd.pl (that I submitted 
to Petr) doesn't allow these files to be added - and it could even 
cleanse leading ./ and any /./ constructs.

So maybe it's left as documented behaviour and higher level tools must 
manage the data they feed to it...

I hope it's useful to raise these niggles now before changing them is 
too hard.

David

-- 
