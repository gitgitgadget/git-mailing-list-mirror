From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Thu, 26 Jul 2007 15:31:46 -0700
Message-ID: <7vfy3a7q5p.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
	<20070726220949.GA4420@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 00:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEBse-0000Tv-Va
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 00:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934204AbXGZWbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 18:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934179AbXGZWbs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 18:31:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39680 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933310AbXGZWbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 18:31:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726223147.STHK1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Jul 2007 18:31:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UNXm1X00g1kojtg0000000; Thu, 26 Jul 2007 18:31:47 -0400
In-Reply-To: <20070726220949.GA4420@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 27 Jul 2007 00:09:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53873>

Matthias Lederhofer <matled@gmx.net> writes:

> I try to take a closer look at your changes tomorrow evening.  Here
> are just two short things I saw while taking a short look at the
> patch.
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> +const char *get_git_work_tree(void)
>> +{
>> +	static int initialized = 0;
>> +	if (!initialized) {
>> +		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
>> +		if (!work_tree) {
>> +			work_tree = git_work_tree_cfg;
>> +			if (work_tree && !is_absolute_path(work_tree))
>> +			work_tree = git_path(work_tree);
>
> A tab is missing here.

I think xstrdup() is missing here, too.
