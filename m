From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 12:35:51 -0400
Message-ID: <20050628163551.GA29410@kvack.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org> <7vekamvmxj.fsf@assigned-by-dhcp.cox.net> <20050628110625.GC21533@64m.dyndns.org> <20050628145256.GA1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Li <git@chrisli.org>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 18:27:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnIvr-0006D1-HV
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 18:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVF1Qei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 12:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVF1Qei
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 12:34:38 -0400
Received: from kanga.kvack.org ([66.96.29.28]:10189 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262105AbVF1Qee (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 12:34:34 -0400
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26546AbVF1Qfv>;
	Tue, 28 Jun 2005 12:35:51 -0400
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050628145256.GA1275@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 04:52:56PM +0200, Petr Baudis wrote:
> I think the git-*-pull tools are actually just fine. You will only need
> to have some server-side CGI gadget to frontend the file, but we need
> that anyway to make the pull reasonably effective.

Not really -- the use of rsync for the objects fails horribly on slow 
links when the project scales in the number of commits.  The rsync 
protocol has to transfer the names of each file and some information 
about it, and that information isn't delta compressed.  This is where 
kernel.org is falling over, as well as what makes the kernel tree very 
painful to use over a dialup modem link.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
