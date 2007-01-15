From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:13:34 +0100
Message-ID: <1168856014.16129.35.camel@localhost.localdomain>
References: <200701151000.58609.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 15 19:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi3-0006cV-Pg
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:27 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9X-0003eK-J4
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXAOKNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbXAOKNv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:13:51 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:56226 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXAOKNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:13:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 3D67362C088;
	Mon, 15 Jan 2007 11:13:46 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26745-05; Mon, 15 Jan 2007 11:13:39 +0100 (CET)
Received: from [129.132.210.134] (vpn-global-dhcp3-134.ethz.ch [129.132.210.134])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 7504562C083;
	Mon, 15 Jan 2007 11:13:39 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
In-Reply-To: <200701151000.58609.andyparkins@gmail.com>
X-Mailer: Evolution 2.8.2 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36809>

On Mon, 2007-01-15 at 10:00 +0000, Andy Parkins wrote:
> Hello,
> 
> I was just talking to another developer in my office about version control.  
> He's working with Windows so has chosen Monotone for a version control 
> system.  I didn't have any huge objections, as I'm sure monotone can be 
> migrated to git without much trouble (they look to support the same features 
> from my brief reading).

The decision to use SHA1 hashes for all objects comes from Monotone, so
the design has to be somewhat similar.

> Of course my favourite is git, but we were talking about the certificates 
> needed by monotone for each developer.  I assume that monotone therefore 
> signs every commit.  It obviously crossed my mind as to how one would do that 
> with git?  We obviously already have the ability to sign a tag, but is there 
> a way in which one could sign every commit.

You'd need to automatically generate a signed tag for every commit (for
example in a post-commit hook? Or use a wrapper script for git-commit
which runs git-tag -s afterwards)

> 
> The more I think about it, the more it could be a reasonable question.  In my 
> own repository I can obviously create whatever commits i like, claiming them 
> to be from whomever I like just by altering a few config settings.  If I put 
> a few of those in my own repository and then managed to persuade Junio to 
> pull from me - wouldn't I have faked commits from another developer?  
> However, I wouldn't be able to fake a gpg signature.

You just explained why no one should pull from people he does not trust.

I think it would be overkill to sign every single commit, signed tags
are enough to sign the whole history (as everyone should know by now).


Matthias
