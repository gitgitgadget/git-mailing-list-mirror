From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Wed, 23 Jun 2010 09:38:28 +0200
Message-ID: <20100623073828.GA13602@pvv.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006210106.07758.johan@herland.net> <7vk4pttfo3.fsf@alter.siamese.dyndns.org> <201006211219.02911.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 09:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORKXg-00055X-DQ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 09:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab0FWHie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 03:38:34 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:33909 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab0FWHid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 03:38:33 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1ORKXU-0000n1-7N; Wed, 23 Jun 2010 09:38:28 +0200
Content-Disposition: inline
In-Reply-To: <201006211219.02911.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149498>

On Mon, Jun 21, 2010 at 12:19:02PM +0200, Johan Herland wrote:
> 
> Ah, so Git should automatically _eliminate_ other alternatives based on the 
> fact that they are not compatible with the purpose of the superproject 
> merge. Still, that requires Git to know the purpose of the superproject 
> merge. Which it doesn't, AFAICS.

This appears to be a good time to resuscitate an idea we had a while ago:

Why not make merging recursive wrt submodules?

I have been trying for some time to figure out how to use git for some
huge projects that consist of hundreds of more or less tightly coupled
modules. Some of these modules are used for multiple projects, and
taken together they are too large to fit well into a single repository.

I wouuld like to be able to use submodules to achieve several things:

1. Partial clones/checkouts - clone only the modules you need
2. Make git behave for projects that are too large for a single repo
3. Bonus: share some modules between muptiple projects

Now - for each superproject I would like this to behave as closely as
possible to working with a single repo, so for merging this would mean
that any merge from toplevel would automatically do the merge in all
affected submodules as well. Just merge the sha1's directly, don't try
to be clever - merge as if it was a subdirectory.

- Finn Arne
