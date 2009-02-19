From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 11:03:08 -0500
Message-ID: <499D82BC.7020500@xiplink.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com> <1235020471-59982-2-git-send-email-jaysoffian@gmail.com> <1235020471-59982-3-git-send-email-jaysoffian@gmail.com> <1235020471-59982-4-git-send-email-jaysoffian@gmail.com> <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:12:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBV6-00056z-H1
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbZBSQDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZBSQDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:03:16 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:52949 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZBSQDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:03:16 -0500
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id B2A5D7BC323;
	Thu, 19 Feb 2009 11:03:14 -0500 (EST)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 78ECA7BC2DB;
	Thu, 19 Feb 2009 11:03:14 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110712>

Jay, thanks a ton!  I'd been poking at this myself off and on over the last week -- I'm very glad to see you've done the work!

A couple of suggestions on the new format:

Jay Soffian wrote:
> 
> @@ -137,21 +137,18 @@ cat > test/expect << EOF
>  * remote origin
>    URL: $(pwd)/one
>    HEAD branch: master
> -  Remote branch merged with 'git pull' while on branch master
> -    master
> -  New remote branch (next fetch will store in remotes/origin)
> -    master
> -  Tracked remote branches
> -    master
> -    side
> -  Local branches pushed with 'git push'
> +  Remote branches:
> +    master new (next fetch will store in remotes/origin)
> +    side   tracked
> +  Local branches configured for 'git pull':
> +    foo    rebases onto remote master
> +    master merges w/remote master
> +  Local branches configured for 'git push':
>      master:upstream
>      +refs/tags/lastbackup
>  * remote two
>    URL: ../two
> -  HEAD branches:
> -    another
> -    master
> +  HEAD branches: another, master
>  EOF

First, a nit: I don't know if the "w/remote" notation makes sense to non-English speakers.  I also like the alignment achieved by "merges with remote " (note the trailing space).

Second, I think it would be good to also change the format of the 'git push' list, for consistency:

	Local branches configured for 'git push':
	  master               fast-forwards remote upstream
	  refs/tags/lastbackup updates remote       refs/tags/lastbackup

Though I'm not really happy using "updates" when + is specified in the push refspec.  What, precisely, is a "non-fast forward update" anyway?  Is it essentially a rebase?  If so, maybe "rebases onto remote " would be better (again with a trailing space to get nice alignment).

Thanks again!

		M.
