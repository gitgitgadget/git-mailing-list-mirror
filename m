From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: pull into dirty working tree
Date: Fri, 15 Jun 2007 20:26:58 +0200
Message-ID: <200706152026.58609.robin.rosenberg.lists@dewire.com>
References: <18031.64456.948230.375333@lisa.zopyra.com> <alpine.LFD.0.98.0706141801030.14121@woody.linux-foundation.org> <46a038f90706142033p1b7f5b49uc5b4af72b0419c8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzGUy-0005mZ-QP
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXFOS0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 14:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbXFOS0P
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 14:26:15 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23491 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbXFOS0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 14:26:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C0308AE5230;
	Fri, 15 Jun 2007 20:19:33 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30779-02; Fri, 15 Jun 2007 20:19:33 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 7475E8030D0;
	Fri, 15 Jun 2007 20:19:33 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46a038f90706142033p1b7f5b49uc5b4af72b0419c8e@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50274>

fredag 15 juni 2007 skrev Martin Langhoff:
> On 6/15/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > But yeah, if you can check in stage 1 (_without_ changing the working
> > tree) whether the merge will work, then everything is fine.
> 
> Aha- so at phase 1 we know
>  - what paths are dirty in the checkout
>  - what paths of the merge need an actuall diff3 merge
> 
> perhaps we can do those diff3 merges elsewhere (tempfiles). If they
> are trivial diff3 merges, then we can complete the merge operation
> without touching the checkout. After this is complete, we can then
> update the checkout...

Can't you treat this like git-am or git-rabase. Save the diff to .dottest. Then
peform the pull just like you do normally involving the user if necessary. After
that either automatically or after a --continue/--abort you apply the diff with it's own
conflicts.

-- robin
