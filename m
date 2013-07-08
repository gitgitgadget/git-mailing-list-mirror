From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] fetch: make --prune configurable
Date: Mon, 8 Jul 2013 20:01:25 +0100
Message-ID: <20130708190125.GX9161@serenity.lan>
References: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 21:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwGgr-0005uw-9m
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 21:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab3GHTBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 15:01:33 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:37812 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3GHTBd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 15:01:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 433F522B61;
	Mon,  8 Jul 2013 20:01:32 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4RwrFEDcNhRH; Mon,  8 Jul 2013 20:01:30 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 0250C23A98;
	Mon,  8 Jul 2013 20:01:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1373288217-20580-1-git-send-email-mschub@elegosoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229886>

On Mon, Jul 08, 2013 at 02:56:57PM +0200, Michael Schubert wrote:
> $gmane/201715 brought up the idea to fetch --prune by default.
> Since --prune is a "potentially destructive operation" (Git doesn't
> keep reflogs for deleted references yet), we don't want to prune
> without users consent.
> 
> To accommodate users who want to either prune always or when fetching
> from a particular remote, add two new configuration variables
> "fetch.prune" and "remote.<name>.prune":
> 
>  - "fetch.prune" allows to enable prune for all fetch operations.
> 
>  - "remote.<name>.prune" allows to change the behaviour per remote.

Should this be "remote.<name>.pruneFetch"?  I'd quite like to be able to
configure --prune for git-push as well (I just haven't got around to
actually doing anything about it yet...) and it might be better to be
explicit in the remote.<name> section from the start.

I'm not sure it's necessary since we already have "remote" and
"pushremote" so we could have "prune" and "pushprune" but perhaps it's
worth considering.
