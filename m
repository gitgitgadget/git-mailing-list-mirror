From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 21:53:19 -0700
Message-ID: <7vhdgismo0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
	<Pine.LNX.4.58.0505301801520.1876@ppc970.osdl.org>
	<7vu0kiu8pm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505311923240.19864@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:51:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdLBq-0004Hj-9d
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 06:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFAExZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFAExZ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 00:53:25 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33990 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261250AbVFAExV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 00:53:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601045320.GCQE26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 00:53:20 -0400
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0505311923240.19864@qynat.qvtvafvgr.pbz> (David
 Lang's message of "Tue, 31 May 2005 19:25:15 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DL" == David Lang <david.lang@digitalinsight.com> writes:

DL> Hmm, thinking out loud. would it help to look at the deltify scripts
DL> and let them find the major chunks and then look in detail only when
DL> that fails?

It's unclear to me which part you are trying to help with
deltify algorithm [*1*].

Internally, git-diff-cache -B -C is used which does use the
deltify to locate complete rewrites, renames and copies (that's
why the script is so slow).  For passing on and assigning blames
line by line, parsing "diff --unified=0" output was a lot easier
for this script and that was what I did in this quick-and-dirty
version.


[Footnotes]

*1* David says "deltify" and Nico calls it "deltafy".  I am not
a native speaker so I cannot tell, but which one is correct?

