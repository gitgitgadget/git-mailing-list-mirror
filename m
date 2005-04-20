From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
 performance problems)
Date: Wed, 20 Apr 2005 10:35:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201031350.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com>  <200504191708.23536.mason@suse.com>
  <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>  <200504192049.21947.mason@suse.com>
  <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>  <42660708.60109@zytor.com>
  <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc4032050420050655265d3a@mail.gmail.com>
 <Pine.LNX.4.58.0504200725110.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: jon@zeta.org.au, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGEW-0006ci-A5
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDTOf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDTOf2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:35:28 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:36489 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261624AbVDTOfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 10:35:24 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOGIK-0008Sp-00; Wed, 20 Apr 2005 10:35:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200725110.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Linus Torvalds wrote:

> - _keep_ the same compression format, but notice that we already have an
>   object by looking at the uncompressed one.

With a chunked file, you can also skip writing certain *subtrees* of the 
file as soon as you notice it's already present on disk.  I can code this 
up if you are interested.

Of course, the paranoid folks will give up any performance benefit you 
obtain if they keep their "yes the SHA1 matches, but is the file *really* 
the same" code.  But maybe they're willing to be slow -- and they can do 
an uncompress rather than a compress in order to do the comparison, which 
will give *some* performance improvement.
  --scott

LCPANGS Serbian MKSEARCH security KUCLUB LCPANES Saddam Hussein Secretary 
Delta Force AMLASH ESMERALDITE TPAJAX plutonium ESGAIN Ft. Meade India
                          ( http://cscott.net/ )
