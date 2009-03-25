From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Tue, 24 Mar 2009 19:26:17 -0500
Message-ID: <sL3rt6iQWyznVMwP2SukD7BiuS1AVuqwVkMR4XSwA5SnK9TLmqyqAg@cipher.nrlssc.navy.mil>
References: <200903250105.05808.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGzy-0003SM-Td
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbZCYA1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZCYA1j
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:27:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47381 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665AbZCYA00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:26:26 -0400
Received: by mail.nrlssc.navy.mil id n2P0QIdn017825; Tue, 24 Mar 2009 19:26:18 -0500
In-Reply-To: <200903250105.05808.johan@herland.net>
X-OriginalArrivalTime: 25 Mar 2009 00:26:17.0729 (UTC) FILETIME=[5056D710:01C9ACE0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114524>

Johan Herland wrote:
> Hi,
> 
> Some colleagues of mine are working on a "secret" project, and they want to 
> create a central/server/integration repo that should be group-writable, but 
> not at all accessible to anybody outside the group (i.e. files should be 
> 0660 ("-rw-rw----"), dirs should be 0770 ("drwxrws---")).
> 
> I started setting this up for them in the following manner:
> 
>   mkdir foo.git
>   cd foo.git
>   git init --bare --shared=group
>   cd ..
>   chgrp -R groupname foo.git
>   chmod -R o-rwx foo.git
> 
> ...and everything looks good, initially...
> 
> However, when I start pushing into this repo, the newly created files are 
> readable to everybody (files are 0664 ("-rw-rw-r--"), dirs are 0775 
> ("drwxrwsr-x")).

But nobody has access to anything under foo.git since you did
'chmod o-rwx foo.git' above.

Unless I'm missing something, I think you already have what you want.

-brandon
