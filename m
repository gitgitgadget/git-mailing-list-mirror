From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 11:30:36 +0100
Organization: Bertin Technologies
Message-ID: <20121217113036.7745f956@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <20121217085242.02a77243@chalon.bertin.fr>
 <7vfw35m509.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:30:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkXyJ-00031Y-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 11:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab2LQKai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 05:30:38 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:44181 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab2LQKah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 05:30:37 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 2890AA0F60
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 11:30:34 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 03960A0F5D
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 11:30:33 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF600FLW7UXTV60@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 17 Dec 2012 11:30:33 +0100 (CET)
In-reply-to: <7vfw35m509.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19456.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211671>

On Mon, 17 Dec 2012 00:56:06 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > And we may still want the bug fixed, or would we just list it as a known bug ?
> > At least it does not seem to occur with "replace" refs:
> 
> The "replace" was designed to "fix" known limitation of grafts,
> which is _inherent_ to it; the graft information was designed _not_
> to be shared across repositories.  The fix was done by by using a
> different mechanism to allow propagating the information across
> repositories.

I see.  But from what I observed (without looking at the source), it looks like
when determining which commits are to be pushed, the grafts file is not "neutralized"
as it should.

> So there is nothing further to fix, except that there is a documentation
> bug you can fix if you didn't find it documented.

Will do.

> Thanks.
> 
> >
> > git-test$ rm .git/info/grafts 
> > git-test$ echo "fake merge" | git commit-tree master^{tree} -p master^ -p maint
> > b821b2aa00973a47936d7cd25c9a5978b1c839c6
> > git-test$ git replace master b821b2aa00973a47936d7cd25c9a5978b1c839c6
> > git-test$ git push origin maint
> > ...
> >    50b03b0..79211fe  maint -> maint


-- 
Yann Dirson - Bertin Technologies
