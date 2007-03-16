From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch, git-parse-remote: Cleanup implementation of '.'
Date: Fri, 16 Mar 2007 02:32:19 -0700
Message-ID: <7vps79v8ik.fsf@assigned-by-dhcp.cox.net>
References: <etavpn$ma0$1@sea.gmane.org>
	<7vr6rqyr60.fsf@assigned-by-dhcp.cox.net>
	<45FA5771.1040200@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Fri Mar 16 10:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS8nw-0002yW-37
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 10:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbXCPJcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 05:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933142AbXCPJcd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 05:32:33 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46134 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932932AbXCPJcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 05:32:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316093221.HFTY18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 05:32:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bMYK1W00h1kojtg0000000; Fri, 16 Mar 2007 05:32:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42338>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> 	The patch is a cleanup of the one you posted, and it was
> 	appropriately tested with no regression.
>
> 	I can see now what you meant by the split between fetch and
> 	merge logic making my patch more complicated than necessary.

Thanks.  I'll squash the two and apply.

> +	builtin)
> +	        canon_refs_list_for_fetch -d "$1" \
> +			$(git-show-ref | sed -n 's,.*[      ]\(refs/.*\),\1:,p') ;;

I may not be really thinking straight tonight (no I am not
drunk, but just a tad sick), but I wonder if this is sufficient?

	$(git-for-each-ref --format='%(refname):')

Shorter and one less process and pipe.
