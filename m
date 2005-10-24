From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-fetch: Fixed missing $COGITO_LIB path
Date: Mon, 24 Oct 2005 14:11:47 -0700
Message-ID: <7vacgymxgs.fsf@assigned-by-dhcp.cox.net>
References: <11301869531376-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 23:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU9br-0008OR-FM
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVJXVLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJXVLu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 17:11:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57318 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751297AbVJXVLt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 17:11:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024211108.JIUM24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 17:11:08 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11301869531376-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Tue, 25 Oct 2005 09:49:13 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10561>

Martin Langhoff <martin@catalyst.net.nz> writes:

>  fetch_progress()
>  {
> -	exec cg-Xfetchprogress "$_git_objects"
> +	exec ${COGITO_LIB}cg-Xfetchprogress "$_git_objects"
>  }

I think somebody recently sent a patch to quote the variable so
that you can have whitespace in it.  So probably:

	exec "${COGITO_LIB}"cg-Xfetchprogress "$_git_objects"

or even "${COGITO_LIB}/"cg-...
