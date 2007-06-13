From: Junio C Hamano <gitster@pobox.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 10:17:55 -0700
Message-ID: <7v8xanepto.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	<Pine.LNX.4.64.0706131553390.4059@racer.site>
	<200706131827.08163.Josef.Weidendorfer@gmx.de>
	<200706131854.59605.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyWYu-00075u-9X
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925AbXFMRR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758938AbXFMRR5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:17:57 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59138 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758870AbXFMRR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 13:17:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613171757.GKXN3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 13:17:57 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B5Hv1X00K1kojtg0000000; Wed, 13 Jun 2007 13:17:56 -0400
In-Reply-To: <200706131854.59605.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Wed, 13 Jun 2007 18:54:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50103>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Wednesday 13 June 2007, Josef Weidendorfer wrote:
>> While without "-z", log_tree_diff immediatly returns
>> because "opt->diff" is 0, in the case of "-z",
>> the tree differences are fully done even not used at all ?!
>
> I wished git-gui and gitk would be better integrated for
> history/blame browsing; I also missed a text search functionality
> in the blame view of git-gui.
>
> Neverless...
>
> opt->diff is set to 1 in setup_revisions() whenever
> diff_opt_parse() parses an option. And "-z" is
> parsed in diff_opt_parse().
>
> In cd2bdc, Linus write in the commit log
>
>  - make setup_revision set a flag (revs->diff) if the diff-related
>    arguments were used. This allows "git log" to decide whether it wants
>    to show diffs or not.
>
> So why is "-z" regarded as tree-diff related, leading to calculating diffs?

Because of the thinko in that commit.  He obviously meant
things like --stat, -p and its friends.
