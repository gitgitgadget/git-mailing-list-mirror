From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: GC of alternate object store
Date: Fri, 31 Aug 2012 18:26:29 +0200
Message-ID: <20120831162629.GA18215@troll08.europe.nokia.com>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org>
 <hbf.20120828vnfp@bombur.uio.no>
 <20120829074249.GA14408@ugly.local>
 <7v3935y9tw.fsf@alter.siamese.dyndns.org>
 <20120830095314.GA29038@troll08.europe.nokia.com>
 <7vbohstlih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7U3M-0002UA-0k
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 18:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab2HaQ0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 12:26:33 -0400
Received: from byte.kde.org ([212.110.188.12]:36390 "EHLO
	byte1.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2HaQ0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 12:26:32 -0400
Received: from localhost ([127.0.0.1] helo=troll08)
	by byte1.vm.bytemark.co.uk with esmtp (Exim 4.72)
	(envelope-from <ossi@kde.org>)
	id 1T7U3C-0003f9-GV; Fri, 31 Aug 2012 17:26:30 +0100
Received: by troll08 (masqmail 0.3.4, from userid 1002)
	id 1T7U3B-4k5-00; Fri, 31 Aug 2012 18:26:29 +0200
Content-Disposition: inline
In-Reply-To: <7vbohstlih.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+52 (3a30d398fbbb) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204591>

On Thu, Aug 30, 2012 at 09:03:34AM -0700, Junio C Hamano wrote:
> Oswald Buddenhagen <ossi@kde.org> writes:
> 
> >> Doesn't
> >> 
> >> 	git push $over_there 'refs/*:refs/remotes/mine/*'
> >> 
> >> push your tag v1.0 to refs/remotes/mine/v1.0 over there?  The
> >> version of git I ship seems to do this just fine.
> >> 
> > as i wrote before, i'm pulling, not pushing,...
> 
> You would need to decline the automatic tag following with --no-tags
> (which in hindsight is misnamed; it really means "do not auto-follow
> tags"), like so:
> 
> 	cd $over_there &&
>         git fetch --no-tags $my_repository 'refs/*:refs/remotes/mine/*'
> 
> Otherwise, you will also get tags in refs/tags/.
> 
git seems to be happily ignoring that flag.
  git fetch --prune --all --no-tags
still re-populates the tags after i delete them manually.
