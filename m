From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote: fix missing .uploadpack usage for show command
Date: Thu, 25 Jun 2009 14:48:48 -0700
Message-ID: <7vd48s2ddr.fsf@alter.siamese.dyndns.org>
References: <20090625090036.GA32650@foursquare.net>
	<7vmy7wcgge.fsf@alter.siamese.dyndns.org>
	<20090625212135.GA28935@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJwoT-00005H-5e
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZFYVsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbZFYVsq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 17:48:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61014 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZFYVsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 17:48:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625214849.CYBA20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 25 Jun 2009 17:48:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8Moo1c0074aMwMQ04Mooi3; Thu, 25 Jun 2009 17:48:48 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=Oep6SgxtURYA:10 a=xp1XZONDAAAA:8
 a=utBi5mjCxnCvtdFYpAMA:9 a=wjHv4HnWT9HMj3G1xvtlCaEheVIA:4 a=kMKJStmIQngA:10
X-CM-Score: 0.00
In-Reply-To: <20090625212135.GA28935@foursquare.net> (Chris Frey's message of "Thu\, 25 Jun 2009 17\:21\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122246>

Chris Frey <cdfrey@foursquare.net> writes:

> For users pulling from machines with self compiled git installs,
> in non-PATH locations, they can set the config option
> remote.<name>.uploadpack to set the location of git-upload-pack.
>
> When using 'git remote show <name>', the remote HEAD check
> did not use the uploadpack configuration setting, and would
> not use the configured program.
>
> In builtin-remote.c, the config setting is already loaded
> with the call to remote_get(), so this patch passes that remote
> along to transport_get().
>
> Signed-off-by: Chris Frey <cdfrey@foursquare.net>
> ---
>
> A possibly clearer description...

Thanks, much clearer.  Will queue, aiming to eventually merge to 'maint'.

Do you have tests to protect this fix from getting broken in the future by
other people?
