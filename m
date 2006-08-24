From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Thu, 24 Aug 2006 11:45:41 -0700
Message-ID: <7vzmdu7z1m.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net> <eck1em$p8b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 20:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGKCz-0007UN-6M
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 20:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWHXSpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 14:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWHXSpi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 14:45:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5885 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030450AbWHXSph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 14:45:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824184537.VABC29796.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 14:45:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Dulc1V00M4Noztg0000000
	Thu, 24 Aug 2006 14:45:36 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eck1em$p8b$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	24 Aug 2006 13:10:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25971>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Converting "blobdiff" and "blobdiff_plain" format would be much easier
>>> if git-diff-tree and friends had -L <label>/--label=<label> option,
>>> like GNU diff has.
>> 
>> I am not sure how that would be useful, given that you would
>> disect the header line-by-line to colorize anyway.
>
> gitweb could output patch directly (slurp-print) in blobdiff_plain,
> if there were -L <label>/--label=<label> option to git-diff. As it is now
> git_blobdiff_plain (or git_blobdiff('plain')) would have to process diff
> header, replacing hashes by file names.

I do not think gitweb does diff between two arbitrary blobs; in
other words, you only need "diff-tree treeA treeB -- path".

I think feeding object names _is_ what's causing you trouble.
