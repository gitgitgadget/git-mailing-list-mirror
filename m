From: Erik de Castro Lopo <mle+tools@mega-nerd.com>
Subject: Re: Retrieving a file at a before a specified commit
Date: Thu, 30 May 2013 13:19:03 +1000
Organization: Erik Conspiracy Secret Labs
Message-ID: <20130530131903.d699bee16aa406790ea96a12@mega-nerd.com>
References: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
	<20130529075811.GA7204@sigill.intra.peff.net>
	<20130530104932.d7ba4bfb426044ab9653057e@mega-nerd.com>
	<20130530023446.GA19860@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 05:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhtOQ-0007O6-G8
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 05:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967367Ab3E3DTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 23:19:07 -0400
Received: from hendrix.mega-nerd.net ([203.206.230.162]:39644 "EHLO
	hendrix.mega-nerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967340Ab3E3DTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 23:19:05 -0400
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
	by hendrix.mega-nerd.net (Postfix) with SMTP id 317CD106DF9
	for <git@vger.kernel.org>; Thu, 30 May 2013 13:19:03 +1000 (EST)
In-Reply-To: <20130530023446.GA19860@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225919>

Jeff King wrote:

> Yes, that is what I would expect git to do in such a situation. You can
> inspect it further, too:
> 
>   $ git rev-parse f51ac745^:pib/chkpib2.7
>   e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 
> That's the sha1 of the blob containing the content.  You can investigate
> information about that object like this:
> 
>   $ git cat-file -t e69de29b
>   blob
>   $ git cat-file -s e69de29b
>   0
>   $ git cat-file blob e69de29b
> 
> Of course since its size is 0, the last one is not that interesting. :)
> 
> You could also just look at the tree, which gives similar information:
> 
>   $ git ls-tree -lr f51ac745^ | grep pib/chkpib2.7
>   100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0 pib/chkpib2.7
> 
> Hope that helps.

Yes it does. Thanks!

Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
