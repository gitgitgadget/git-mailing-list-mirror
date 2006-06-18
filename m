From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] Remove ranges from switch statements.
Date: Sun, 18 Jun 2006 14:07:32 -0700
Message-ID: <7vveqyyxyj.fsf@assigned-by-dhcp.cox.net>
References: <11506438892865-git-send-email-octo@verplant.org>
	<1150643889264-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 18 23:07:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs4Ua-00058g-Kx
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 23:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWFRVHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 17:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWFRVHd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 17:07:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61383 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932087AbWFRVHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 17:07:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618210733.DKOG5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 17:07:33 -0400
To: git@vger.kernel.org
In-Reply-To: <1150643889264-git-send-email-octo@verplant.org> (Florian
	Forster's message of "Sun, 18 Jun 2006 17:18:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22102>

Florian Forster <octo@verplant.org> writes:

> -	switch (ch) {
> -	case '/': case '-': case '.':
> -	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
> +	if (((ch >= 'A') && (ch <= 'Z'))
> +			|| ((ch >= 'a') && (ch <= 'z'))
> +			|| ((ch >= '0') && (ch <= '9'))
> + ...

Sorry for bringing up an old topic again, but wouldn't people
agree that this is easier to read if it were written this way ;-)?
 
	if (	   (('A' <= ch) && (ch <= 'Z'))
        	|| (('a' <= ch) && (ch <= 'z'))
		|| (('0' <= ch) && (ch <= '9'))
	...
