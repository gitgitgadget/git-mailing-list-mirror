From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/5] full integration of rev-cache into git's revision
 walker, completed test suite
Date: Fri, 07 Aug 2009 15:22:19 +1200
Message-ID: <4A7B9DEB.1060002@vilain.net>
References: <op.ux8i7ceotdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZG2b-0004RN-NC
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 05:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbZHGDWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 23:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbZHGDWl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 23:22:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:37074 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756986AbZHGDWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 23:22:40 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id C4BD121C4AC; Fri,  7 Aug 2009 15:22:24 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id BEDC821C44B;
	Fri,  7 Aug 2009 15:22:19 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <op.ux8i7ceotdk399@sirnot.private>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125168>

Nick Edelen wrote:
> This last patch provides a working integration of rev-cache into the revision 
> walker, along with some touch-ups:
>   

"This last patch" is redundant.  You can just write "Integrate rev-cache
into the revision walker;"

>  - integration into revision walker and list-objects
>  - addition of 'unique' field to commit objects, optionally initialized in 
>    rev-cache with the objects introduced in that commit
>  - tweak of object generation to take advantage of the 'unique' field
>  - more fluid handling of damaged cache slices
>  - numerous tests for both features from the previous patch, and the 
> integration's integrity
>   

Does it make sense to split this integration up or stage it somehow?

> 'Integration' is rather broad -- a more detailed description follows for each 
> aspect:
>  - rev-cache
> the traversal mechanism is updated to handle many of the non-prune options 
> rev-list does (date limiting, slop-handling, etc.), and is adjusted to allow 
> for non-fatal cache-traversal failures.
>
>  - revision walker
> both limited and unlimited traversal attempt to use the cache when possible, 
> smoothly falling back if it's not.
>
>  - list-objects
> object listing does not recurse into cached trees, and has been adjusted to 
> guarantee commit-tag-tree-blob ordering.
>   

Especially given the length of this part of the commit message.

Sam
