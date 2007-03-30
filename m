From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (resend)] gitweb: Support comparing blobs (files) with different names
Date: Fri, 30 Mar 2007 15:56:09 -0700
Message-ID: <7virciz6gm.fsf@assigned-by-dhcp.cox.net>
References: <200703302341.27225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXQ18-0004PL-D7
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 00:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXC3W4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 18:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXC3W4M
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 18:56:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:34115 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470AbXC3W4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 18:56:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070330225611.JWTG28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 30 Mar 2007 18:56:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hAw91W00X1kojtg0000000; Fri, 30 Mar 2007 18:56:10 -0400
In-Reply-To: <200703302341.27225.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 30 Mar 2007 23:41:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43506>

Jakub Narebski <jnareb@gmail.com> writes:

> Fix the bug that caused "blobdiff" view called with new style URI
> for a rename with change diff to be show as new (added) file diff.
>
> New style URI for "blobdiff" for rename means with $hash_base ('hb') and
> $hash_parent_base ('hpb') paramaters denoting tree-ish (usually commit)
> of a blobs being compared, together with both $file_name ('f') and
> $file_parent ('fp') parameters.
>
> It is done by adding $file_parent ('fp') to the path limiter, meaning
> that diff command becomes:
>
> 	git diff-tree [options] hpb hb -- fp f
>
> Other option would be finding hash of a blob using git_get_hash_by_path
> subroutine and comparing blobs using git-diff, or using extended SHA-1
> syntax and compare blobs using git-diff:
>
> 	git diff [options] hpb:fp hp:f
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Junio, could you apply this? It looks like it was lost in the noise.

I was waiting for dust to settle.  Ack's from people involved in
the discussion would be nice.
