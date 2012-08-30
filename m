From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: GC of alternate object store
Date: Thu, 30 Aug 2012 11:53:14 +0200
Message-ID: <20120830095314.GA29038@troll08.europe.nokia.com>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org>
 <hbf.20120828vnfp@bombur.uio.no>
 <20120829074249.GA14408@ugly.local>
 <7v3935y9tw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 11:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T71RC-0006Hk-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 11:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab2H3JxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 05:53:17 -0400
Received: from byte.kde.org ([212.110.188.12]:37345 "EHLO
	byte1.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab2H3JxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 05:53:16 -0400
Received: from localhost ([127.0.0.1] helo=troll08)
	by byte1.vm.bytemark.co.uk with esmtp (Exim 4.72)
	(envelope-from <ossi@kde.org>)
	id 1T71R4-0006z1-Lm; Thu, 30 Aug 2012 10:53:14 +0100
Received: by troll08 (masqmail 0.3.4, from userid 1002)
	id 1T71R4-7sI-00; Thu, 30 Aug 2012 11:53:14 +0200
Content-Disposition: inline
In-Reply-To: <7v3935y9tw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+52 (3a30d398fbbb) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204530>

On Wed, Aug 29, 2012 at 08:52:27AM -0700, Junio C Hamano wrote:
> (I won't comment on the other parts in this discussion).
> 
which is kinda unfortunate. ;)

> Oswald Buddenhagen <ossi@kde.org> writes:
> > i did exacty that. the tags are *still* not populated - git just tries
> > very hard to treat them specially.
> 
> Doesn't
> 
> 	git push $over_there 'refs/*:refs/remotes/mine/*'
> 
> push your tag v1.0 to refs/remotes/mine/v1.0 over there?  The
> version of git I ship seems to do this just fine.
> 
as i wrote before, i'm pulling, not pushing, so any differences could be
blamed on that (or git version 1.7.12.23.g948900e).
anyway, it seems this new version does fetch the tags under the remotes'
namespaces, after all - but it still imports them into the global tag
namespace as well, which of course makes a mess with the duplicated
tags.

and for many repos i'm getting something like this (this is kinda new):

Fetching qtbase
remote: Counting objects: 62375, done.
remote: Compressing objects: 100% (28049/28049), done.
remote: Total 55704 (delta 45280), reused 36646 (delta 27368)
Receiving objects: 100% (55704/55704), 16.76 MiB | 4.94 MiB/s, done.
Resolving deltas: 100% (45280/45280), completed with 3017 local objects.
fatal: bad object 90f0f499ec5953d60d616a2ff541ecaf8b0c31a2
error: ../qt5/qtbase did not send all necessary objects

both the aggregator and the fetched repos run cleanly through fsck.

regards
