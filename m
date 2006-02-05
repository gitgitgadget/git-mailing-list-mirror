From: Amos Waterland <apw@us.ibm.com>
Subject: Re: [PATCH] do not open editor in dumb terminal
Date: Sat, 4 Feb 2006 19:37:41 -0500
Message-ID: <20060205003741.GB29021@kvasir.watson.ibm.com>
References: <20060203114133.GA11499@kvasir.watson.ibm.com> <7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Sun Feb 05 01:38:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Xun-0007A5-SP
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 01:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWBEAht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWBEAht
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 19:37:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:59332 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750800AbWBEAht
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 19:37:49 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k150biLb013873
	for <git@vger.kernel.org>; Sat, 4 Feb 2006 19:37:44 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k150ZhoA210984
	for <git@vger.kernel.org>; Sat, 4 Feb 2006 17:35:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k150bhQ6004659
	for <git@vger.kernel.org>; Sat, 4 Feb 2006 17:37:43 -0700
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k150bh0l004648;
	Sat, 4 Feb 2006 17:37:43 -0700
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1F5XuQ-0007Zb-3m; Sat, 04 Feb 2006 19:37:42 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0bgdxmh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15613>

On Fri, Feb 03, 2006 at 11:56:54AM -0800, Junio C Hamano wrote:
> Amos Waterland <apw@us.ibm.com> writes:
> > Many people run git from a shell in emacs (obtained by M-x shell).  When
> > they try to do a commit without specifying a log message on the command
> > line with -m, git opens vi inside emacs, with unpleasant results.  I
> > think the right answer is to just refuse to open an editor in any dumb
> > terminal.
> 
> No, please don't.
> 
> I run 'git commit' from M-x shell or M-x compile.  My EDITOR is
> set to 'emacsclient' while inside Emacs.

If your TERM is set to `emacs' then that is fine.  If it is set to
`dumb' however, that seems a bit strange.  A dumb terminal is usually
understood to be one that does not have the ability to interpret control
sequences.

The reason I sent the patch is that people get a rather unpleasant
introduction to git when vi splatters control characters all over their
emacs session when they do their first commit.  I agree that people
probably should have their EDITOR set to emacsclient though, so if you
want to just leave the code as is that's cool with me.
