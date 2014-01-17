From: John Keeping <john@keeping.me.uk>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such
 ref: ''" for branches without an upstream
Date: Fri, 17 Jan 2014 08:40:10 +0000
Message-ID: <20140117084010.GL7608@serenity.lan>
References: <52D8827E.3060007@fb.com>
 <20140117022152.GB12444@sigill.intra.peff.net>
 <52D899CA.5050409@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 09:40:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W44yV-0002Ks-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 09:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbaAQIkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 03:40:20 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:60278 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaAQIkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 03:40:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B8BD76065C5;
	Fri, 17 Jan 2014 08:40:17 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vW6F7VwSzkPH; Fri, 17 Jan 2014 08:40:17 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 5A9AD60659A;
	Fri, 17 Jan 2014 08:40:17 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4F7FE161E21B;
	Fri, 17 Jan 2014 08:40:17 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dLDzwhPlSAl; Fri, 17 Jan 2014 08:40:16 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A58EF161E44A;
	Fri, 17 Jan 2014 08:40:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <52D899CA.5050409@fb.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240578>

On Thu, Jan 16, 2014 at 06:47:38PM -0800, Siddharth Agarwal wrote:
> On 01/16/2014 06:21 PM, Jeff King wrote:
> > On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:
> >
> >> With git-next, where git pull --rebase can print out "fatal: No such
> >> ref: ''" if git pull --rebase is run on branches without an upstream.
> > This is already fixed in bb3f458 (rebase: fix fork-point with zero
> > arguments, 2014-01-09), I think.
> 
> If I'm reading the patch correctly, that only fixes it for git rebase, 
> not for git pull --rebase. git-pull.sh contains a separate invocation of 
> git merge-base --fork-point.

I'm pretty sure the invocation in git-pull.sh is OK.  The error then
comes out of git-rebase.sh when git-pull invokes it.

Are you running a version of git-next that includes bb3f458?
