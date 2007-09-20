From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Yet another builtin-fetch round
Date: Wed, 19 Sep 2007 22:40:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709192233360.21941@iabervon.org>
References: <20070919044923.GP3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 04:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYBy1-0004jt-5Z
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 04:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbXITCkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 22:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbXITCkc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 22:40:32 -0400
Received: from iabervon.org ([66.92.72.58]:40312 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbXITCkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 22:40:31 -0400
Received: (qmail 16918 invoked by uid 1000); 20 Sep 2007 02:40:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Sep 2007 02:40:30 -0000
In-Reply-To: <20070919044923.GP3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58748>

On Wed, 19 Sep 2007, Shawn O. Pearce wrote:

> Another short series for db/fetch-pack, still in pu.  Aside from
> optimizing the pipeline on the native transport (so we only invoke
> the remote process we need once vs. twice) I'm actually now quite
> comfortable with this whole series and think it is ready for next.

While it's still in pu, should these series of corrections be amended into 
the original series (for the ones that correct new code)? Most of the 
before-fixing states aren't worth saving as project history.

> I'm certainly running it in production, and will be until it is
> merged.  The performance difference is too big for me (and at least
> some of my coworkers) to not be doing so.  If there are any specific
> reasons why this topic is not ready for next or is unsuitable for
> merging please let me know so I can take the time to correct it.

Good to hear that it's working for you. It's been working for me since 
July, for my usage patterns, but they're not very extensive, and I was 
mostly relying on the tests.

> 1/5  Rename remote.uri to remote.url within remote handling internals
> 2/5  Refactor struct transport_ops inlined into struct transport
> 3/5  Always obtain fetch-pack arguments from struct fetch_pack_args
> 
>   These three are basic code cleanups for small issues that
>   bothered me about the original implementation of builtin-fetch.
>   Now is just as good of a time as any to cleanup the code and make
>   it more maintainable.  I think the overall total line count is
>   reduced by these three patches.

All of these look right.

> * Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
> * Fix memory leaks when disconnecting transport instances
> 
>   Fixes two known (but minor) outstanding bugs.  At this point
>   I do not know of any other bugs in builtin-fetch so I would
>   really appreciate testing reports from other people, especially
>   those whose uses cases might stray outside of my workflow.  Hah,
>   I did not tell you my workflow.  ;-)

Looks good, but I didn't really check over them.

	-Daniel
*This .sig left intentionally blank*
