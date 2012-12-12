From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 12 Dec 2012 11:54:23 +0100
Organization: Bertin Technologies
Message-ID: <20121212115423.3db6bb4d@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tijxg-00056X-Va
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 11:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2LLKyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 05:54:31 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:49435 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab2LLKyb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 05:54:31 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7BF6AA0F8D
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 11:54:21 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 3985CA0F7E
	for <git@vger.kernel.org>; Wed, 12 Dec 2012 11:54:21 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MEW00C0TZMKL380@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 12 Dec 2012 11:54:21 +0100 (CET)
In-reply-to: <20121212094432.6e1e48c8@chalon.bertin.fr>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19442.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211335>

On Wed, 12 Dec 2012 09:44:32 +0100 Yann Dirson <dirson@bertin.fr> wrote:
> In fact, I even looked for a way to specify an alternate (or supplementary)
> grafts file for this drafting work, so only well-controlled git invocations
> would see them, whereas the others would just ignore them, and could not find
> any - nor could I identify an existing way of disabling the use of grafts by
> other means than moving it out of the way.  In this respect, they seem to be
> lacking a few features, when compared to "replace" refs, but they have different
> uses, and just using the latter as a drafting area is just not adequate.
> 
> I thought about adding support for a GIT_GRAFTS_FILE envvar, which would
> default to $GITDIR/info/grafts, or maybe with a more general addition of a
> GIT_EXTRA_GRAFT_FILES envvar, but I'm not sure the latter would be that useful.

My bad on this point: there *is* a GIT_GRAFT_FILE envvar, it is just undocumented.
In fact it is not the only one:

git.git$ for v in $(git grep define.*_ENVIRONMENT master -- cache.h | cut -d'"' -f2|grep ^GIT_); do git grep -q $v master -- Documentation || echo "missing $v"; done
missing GIT_GRAFT_FILE
missing GIT_CONFIG_PARAMETERS


-- 
Yann Dirson - Bertin Technologies
