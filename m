From: Ingo Oeser <ioe-git@rameria.de>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 19:23:07 +0200
Message-ID: <200906171923.08034.ioe-git@rameria.de>
References: <200906160111.47325.ioe-git@rameria.de> <alpine.LNX.2.00.0906161332080.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ingo Oeser <ioe-git@rameria.de>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyoc-0000VS-By
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbZFQRUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 13:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbZFQRUg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 13:20:36 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:36082 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZFQRUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 13:20:35 -0400
Received: from [91.62.59.75] (helo=axel.localnet)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ioe-git@rameria.de>)
	id 1MGyoO-0002Wx-5i; Wed, 17 Jun 2009 19:20:36 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; x86_64; ; )
In-Reply-To: <alpine.LNX.2.00.0906161332080.2147@iabervon.org>
Content-Disposition: inline
X-Df-Sender: 849595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121762>

Hi Daniel,

On Tuesday 16 June 2009, Daniel Barkalow wrote:
> You should be able to have the slave repositories store tags for tree 
> objects (instead of commit objects), and have the webservers fetch those. 
> You'll still have the object database, but it will only contain stuff 
> that's been deployed to that webserver, not intermediate versions or 
> historical versions.

Ah, that sound like a great solution. I'll try that.

> You'll still have to store both the repo and the checked out data 
> (but git stores the content delta-compressed against each 
> other in one big file, normally, so there really aren't files to hard link 
> to.

Ok. That was under the assumption, that the core of git is basically a 
content addressable file system. But that seems to be history :-)

> Of course, the other possibility is to check out versions on the slaves, 
> and rsync that to the webservers, which is probably the optimal method if 
> you're not in a situation where you benefit from anything git does in 
> transit.

I would benefit from noticing local changes. But simple rsync is what is tried now.
Problem is, we get no de-duplication from rsync, which git could do.

Many thanks for your suggestions!


Best Regards 

Ingo Oeser
