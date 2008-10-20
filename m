From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: Is XDL_MERGE_ZEALOUS too zealous (or maybe not zealous enough)?
Date: Sun, 19 Oct 2008 23:42:00 -0400
Message-ID: <1224474120.19785.3.camel@mattlaptop2.local>
References: <1224377652.19061.12.camel@mattlaptop2.local>
	 <7vhc785izq.fsf@gitster.siamese.dyndns.org>
	 <7v3ais5hb3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 08:51:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krlfq-0005Jl-Vr
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 05:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbYJTDmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYJTDmF
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 23:42:05 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:44175 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751496AbYJTDmF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2008 23:42:05 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id 454EB98682;
	Sun, 19 Oct 2008 20:42:03 -0700 (PDT)
In-Reply-To: <7v3ais5hb3.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98621>

On Sun, 2008-10-19 at 15:52 -0700, Junio C Hamano wrote:
> However, the usual simplified merge shows this (run "git checkout --merge
> builtin-checkout.c" if you have done the above):
> 
> <<<<<<< ours
> 	/* --track without -b should DWIM */
> 	if (0 < opts.track && !opts.new_branch) {
> 		const char *argv0 = argv[0];
> 	...
> 		opts.new_branch = argv0 + 1;
> 	}
> 
> 	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
> 		opts.track = git_branch_track;
> =======
> 	if (conflict_style) {
> 		opts.merge = 1; /* implied */
> 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> 	}
> 
> 	if (!opts.new_branch && (opts.track != git_branch_track))
> 		die("git checkout: --track and --no-track require -b");
> >>>>>>> theirs
> 
> Removing the two lines from the simplified "theirs" is not what I would
> suggest (it would be actively wrong), but I wonder if we can do something
> clever to help users with a merge like this.

IMHO, the solution is just to use diff3 style.  I never understood how I
was supposed to intuit the correct result of a merge from the two sides
without seeing the common ancestor, so I am glad to have the diff3 style
working now.

Matt
