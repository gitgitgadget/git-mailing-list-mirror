From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach diff -B about colours
Date: Tue, 20 Feb 2007 10:22:43 -0800
Message-ID: <7vodnovgcs.fsf@assigned-by-dhcp.cox.net>
References: <20070220100846.GA7928@moooo.ath.cx>
	<Pine.LNX.4.63.0702201506551.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 19:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZdY-0001Dp-P1
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXBTSWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXBTSWp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:22:45 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61515 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbXBTSWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:22:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220182243.OJDX21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 13:22:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RuNj1W00E1kojtg0000000; Tue, 20 Feb 2007 13:22:44 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40251>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Matthias Lederhofer noticed that `diff -B` did not pick up on diff 
> colournig.

sp.?

> -static void copy_file(int prefix, const char *data, int size)
> +static void copy_file(int prefix, const char *data, int size,
> +		const char *set, const char *reset)
> ...
>  	if (!nl_just_seen)
> -		printf("\n\\ No newline at end of file\n");
> +		printf("%s\n\\ No newline at end of file\n", reset);
>  }

Are you sure about this one?  If preimage lacked terminating LF and
the postimage has it, then don't you want to see "\ No..." as an
addition?
