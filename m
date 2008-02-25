From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Instituting feature and infrastructure enhancement proposal
 window?
Date: Sun, 24 Feb 2008 22:25:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802242055330.19024@iabervon.org>
References: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:26:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTzC-00076V-0a
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYBYDZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYBYDZj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:25:39 -0500
Received: from iabervon.org ([66.92.72.58]:41415 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbYBYDZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:25:38 -0500
Received: (qmail 28849 invoked by uid 1000); 25 Feb 2008 03:25:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 03:25:37 -0000
In-Reply-To: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74988>

On Sun, 24 Feb 2008, Junio C Hamano wrote:

> If this proposal is accepted favorably by the list and is
> implemented, a release cycle will look like this:
> 
>  * A release from 'master' is made (e.g. v1.5.4 gets released on
>    Feb 1st).
> 
>  * The release is merged to 'maint'.
> 
>  * Fix-ups to v1.5.4 start flowing and get applied to 'maint',
>    and merged to 'master'.  At some point, the first maintenance
>    release is made (e.g. v1.5.4.1 was released on Feb 10th).
> 
>  * The topics that have been cooking in 'next' may be rebased to
>    v1.5.4, and 'next' is rebuilt on top of 'master' with them
>    (e.g. this happened on Feb 17th for this cycle).

I'd actually like to have topics that don't make a release reverted in 
'next' and reapplied in 'pu'. That way, from the release to the rebuild of 
'next', 'next' and 'master' have identical trees, and it's therefore 
trivial to rebase off of 'next'. Topics that were moved out to 'pu' in 
this period would presumably be merged back into the rebased 'next' early.

Or maybe, when 'next' closes, anything not in 'master' moves out to 'pu' 
until the rebuild.

>  * New topics start appearing in 'next', cook and graduate to
>    'master' as before.
> 
>  * The window closes.  We pick what topics we should have in the
>    new release.
> 
>  * We continue as before, but with the understanding that some
>    topics in 'next' won't graduate before the new release.
> 
>  * Tag -rc1.  'next' really closes and we go into feature
>    freeze.
> 
>  * RC cycle continues.  Perhaps one or two RCs every week, as before.
> 
>  * The new release is made (hopefully within 3 months since the
>    beginning of the cycle).

So what would be the 'pu' policy through this? I think one of the reasons 
that the kernel manages to do well with a short cycle is that stuff sits 
in -mm for some time, in general, before hitting mainline. This both means 
that people can get their code exposure without hurrying it into the merge 
window and that code can cook as long as necessary before starting to 
impact end users.

In any case, I like the short cycle idea.

	-Daniel
*This .sig left intentionally blank*
