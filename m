From: John Keeping <john@keeping.me.uk>
Subject: Re: offtopic: ppg design decisions - encapsulation
Date: Mon, 6 May 2013 16:53:53 +0100
Message-ID: <20130506155353.GF25912@serenity.lan>
References: <CACPiFCL+cd1vmqj6JEj84L5rDvHGxDgo+zGw5__ard6-sumipA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 17:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNjp-0003q7-28
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab3EFPyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:54:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52896 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab3EFPx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:53:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3CBA2CDA5A9;
	Mon,  6 May 2013 16:53:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVgM++pGhV5W; Mon,  6 May 2013 16:53:59 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2CAB4CDA596;
	Mon,  6 May 2013 16:53:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACPiFCL+cd1vmqj6JEj84L5rDvHGxDgo+zGw5__ard6-sumipA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223465>

On Mon, May 06, 2013 at 11:34:28AM -0400, Martin Langhoff wrote:
> [ Unashamedly offtopic... asking here because I like git design and
> coding style, and ppg is drawing plenty of inspiration from the old
> git shell scripts. Please kindly flame me privately... ]
> 
> ppg is a wrapper around git to maintain and distribute Puppet configs,
> adding a few niceties.
> 
> Now, ppg will actuall manage two git repositories -- one for the
> puppet configs, the second one for ferrying back the puppet run
> results to the originating repo (were they get loaded in a puppet
> dashboard server for cute webbased reporting). The puppet config repo
> is a normally-behaved git repo. The "reports" repo is a bit of a hack
> -- never used directly by the user, it will follow a store-and-forward
> scheme, where I should trim old history or just use something other
> than git.

I'm not sure I fully understand what the reports are, but it sounds like
they are closely related to original configuration commits.  If that is
the case, have you considered using Git notes instead of a separate
repository?
