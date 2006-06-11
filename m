From: Geert Bosch <bosch@adacore.com>
Subject: Re: Redhat stateless Linux and git
Date: Sun, 11 Jun 2006 08:21:19 -0400
Message-ID: <D5AC73C4-5A2F-482E-9B45-71A72C62D670@adacore.com>
References: <9e4733910606091559m6a88e864m16f9d75a507ee684@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 11 14:21:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpOwX-00052n-Jf
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWFKMVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWFKMVM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:21:12 -0400
Received: from nile.gnat.com ([205.232.38.5]:62936 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751172AbWFKMVL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:21:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 0523E48CE59;
	Sun, 11 Jun 2006 08:21:10 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 12282-01-7; Sun, 11 Jun 2006 08:21:09 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 213A348CDD6;
	Sun, 11 Jun 2006 08:21:07 -0400 (EDT)
In-Reply-To: <9e4733910606091559m6a88e864m16f9d75a507ee684@mail.gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-Mailer: Apple Mail (2.750)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21652>


On Jun 9, 2006, at 18:59, Jon Smirl wrote:
> Redhat is looking for a scheme to sync the disk system of their
> stateless Linux client. They were using rsync and now they are looking
> at doing it with LVM.
>
> What about using git?

The data model is fine in principle, but git as-is isn't suitable
for general backup/sync-like schemes. Large (multi-GB) files
are not really supported yet. Still, I think the underlying
data model, with some modifications to split large files on
content-determined boundaries, would be really great for
distributed filesystems.

Many people using laptops these days connect to different
filesystems on their office networks, home networks,
digital cameras and even their PDA, cellphone and MP3-player.
What is commonly described as "synching", really is just a
merge between different branches. All arguments in favor
of using a distributed SCM hold here too.

Right now I'm using a hodge-podge of different manual and
semi-automated methods to keep my local filesystem with 1.5M
files totalling 90GB somewhat in synch with various
homedirectories on different remote systems and backup disks.
IMO, git is tantalizing close to be able to handle this, just
needs to get a bit more scalable. Probably you'd want to use
a different user interface as well, but all the underlying
data structures and merge strategies may be equally valid.

   -Geert
