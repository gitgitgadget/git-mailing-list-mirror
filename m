From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to squash a few commits in the past
Date: Mon, 03 May 2010 12:09:27 +0200
Message-ID: <4BDEA0D7.9090201@drmicha.warpmail.net>
References: <loom.20100503T112508-677@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 12:09:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8sao-0001zW-0q
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 12:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0ECKJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 06:09:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60045 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754051Ab0ECKJa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 06:09:30 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B235CF2381;
	Mon,  3 May 2010 06:09:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 03 May 2010 06:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kKCY/98eBkqo5x48jbszPLcJQ/w=; b=THGtIoWV6mBD0qFuhUg+YBcn7GkbomSjosnTwFCRNDZi3VXvplMPKIoQXsLkCqPDpCcyP5KjcBVczZG+p9N859t4lIavGVnEtHbAGLVW6pjBevRjCJHqeXsH9rvUJe/ocjKDA6yclyKAJy2lTIrki22C9yVwAgzaCLeYmv6VX+k=
X-Sasl-enc: uGv6fhvNyQteCU082Q454O6SLELTzp2j2gtITepdPJcH 1272881369
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A4044D445E;
	Mon,  3 May 2010 06:09:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <loom.20100503T112508-677@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146226>

Gelonida venit, vidit, dixit 03.05.2010 11:33:
> Hi,
> 
> 
> 
> I posted already a similiar question about how to squash the all the commit
> hostory older than a certain commit into one commit.
> 
> 
> This question is slightly different.
> 
> 
> I'm having a git repository.
> 
> Suddenly I noticed, that git pull became rather slow.
> 
> The reason:
> One of the team members accidentally commited a very huge file together with
> some useful sources.
> a few commits later he noticed his error and removed the huge file.
> 
> 
> 
> The plan would be:
> - create a new git repository without the huge file
> - let everybody clone the new repository and continue working.
> 
> 
> I thought, that I could squash the commit adding the file, removing the file and
> the commits in between into one commit.

You don't need to squash the commits in between. Use git rebase -i A^ if
A is the commit introducing the large file. Then, either edit that first
commit (to not add the file) or reorder so that the removal commit is
squashed into A.

If everything looks fine people can pull and rebase. Note that in the
source repository, there will still be a large "blob" until you prune
and repack.

Michael
