From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to	git://
Date: Thu, 14 Aug 2008 11:51:37 +0200
Message-ID: <20080814095137.GF9680@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org> <20080814001029.GA14939@cuci.nl> <20080814005723.GM3782@spearce.org> <48A3F7AA.8070001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 14 11:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZVa-0004mX-U5
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 11:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbYHNJvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYHNJvj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 05:51:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47568 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYHNJvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 05:51:38 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B5C8E5465; Thu, 14 Aug 2008 11:51:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A3F7AA.8070001@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92340>

Andreas Ericsson wrote:
>I'd do it like this instead:

>daemon: auth_user = dlsym(dlopen("auth-module.so", RTLD_NOW), 
>"authenticat");

>This approach has several nifty benefits:
>* The otherwise duplicated code (for different auth schemes) is
> done only once (in the git daemon).

I'd prefer that to be in a separate program, instead of git-daemon
proper.

>* If the git daemon has no authentication module loaded, we might
> as well not bother sending any challenge and just pretend we do
> not know about the authentication scheme.

Loading modules is highly fragile across different OSes, so it's not
really recommended at all.

>* Modules is a great way for newcomers to get started contributing to
> git so it's a nice way of getting more contributors/sub-maintainers.

If by "modules" you mean dynamically loaded libraries, then I
wholeheartedly disagree.
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
