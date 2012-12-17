From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 11:40:58 +0100
Organization: Bertin Technologies
Message-ID: <20121217114058.449cbc3c@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkY8J-0000Zr-Jz
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 11:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab2LQKk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 05:40:58 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:44995 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab2LQKk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 05:40:57 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7D871A0F63
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 11:40:56 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 55BFFA0F61
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 11:40:56 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF600FV08C7TV60@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 17 Dec 2012 11:40:56 +0100 (CET)
In-reply-to: <877goht6eu.fsf@pctrast.inf.ethz.ch>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19456.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211672>

On Mon, 17 Dec 2012 09:43:53 +0100
Thomas Rast <trast@student.ethz.ch> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Yann Dirson <dirson@bertin.fr> writes:
> >
> >> ....  In this respect, they seem to be
> >> lacking a few features, when compared to "replace" refs, but they have different
> >> uses, ...
> >
> > Not reallyl; grafts were old hack whose use is still supported with
> > its original limitations; replace is meant to replace all uses of
> > grafts while removing grafts' largest warts.
> 
> I suppose there's the additional issue that grafts are much easier to
> use than replacements if you really only want to replace some parent
> lists.  With replace you need to handcraft the replacement commits, and
> git-replace(1) unhelpfully does not say this, much less gives an example
> how to do it.
> 

Right, replace refs can surely be made easier to use.  The requirement to craft a
new commit manually is a major step back in ease of use.

Maybe something like "git replace -p <orig-commit> <parent>..." to just provide a simple
API to the exact graft functionnality would be good.  But it would be commit-specific, whereas
replace refs are indeed more generic, and, one could want to rewrite any other part of the commit,
so we could prefer a more general mechanism.

Something that could be useful in this respect, would be an --amend like option to git-commit, like
"git commit --replace".  But unfortunately it does not allow to change parents, and it has the
drawback of requiring that HEAD points to the commit to be replaced.

So maybe, if there are no other idea, a simple "git graft" command that would wrap "git replace",
would fill the gap.

-- 
Yann Dirson - Bertin Technologies
