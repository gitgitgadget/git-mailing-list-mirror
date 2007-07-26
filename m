From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Fri, 27 Jul 2007 00:09:49 +0200
Message-ID: <20070726220949.GA4420@moooo.ath.cx>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 00:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEBXy-0003GJ-3R
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 00:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764015AbXGZWJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935047AbXGZWJy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 18:09:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:33009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763763AbXGZWJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 18:09:53 -0400
Received: (qmail invoked by alias); 26 Jul 2007 22:09:51 -0000
Received: from pD9EB806C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.128.108]
  by mail.gmx.net (mp050) with SMTP; 27 Jul 2007 00:09:51 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19cdaJMmj5c0YE/2rIhiAzyD0bIxU2eCE50yYJGcs
	GYhVsMuRwv1SFK
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707260729150.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53871>

I try to take a closer look at your changes tomorrow evening.  Here
are just two short things I saw while taking a short look at the
patch.

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +const char *get_git_work_tree(void)
> +{
> +	static int initialized = 0;
> +	if (!initialized) {
> +		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
> +		if (!work_tree) {
> +			work_tree = git_work_tree_cfg;
> +			if (work_tree && !is_absolute_path(work_tree))
> +			work_tree = git_path(work_tree);

A tab is missing here.

> -				fprintf(stderr, "No directory given for --work-tree.\n" );
> +				error("No directory given for --work-tree.\n");

There should probably be no '\n' at the end when the 'error' function
is used.  There are two other calls to fprintf(stderr, <error message>)
next to the one you changed, why did you change this one but not the
other ones?
