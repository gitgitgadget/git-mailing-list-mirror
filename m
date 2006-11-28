X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for commit.signoff config option
Date: Tue, 28 Nov 2006 12:17:07 -0800
Message-ID: <7vd5772unw.fsf@assigned-by-dhcp.cox.net>
References: <200611281202.43394.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 20:18:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32572>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9Oq-0002b5-AB for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965904AbWK1URM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbWK1URM
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:17:12 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15573 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S965904AbWK1URL
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:17:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128201708.QDEK9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 15:17:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sLHG1V01D1kojtg0000000; Tue, 28 Nov 2006
 15:17:17 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Whether patches require signing off or not is probably a per-project
> setting rather than a per-commit setting.  Therefore as a convenience to
> the user, the commit.signoff setting will automtically add --signoff to
> commits.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

I muttered something about commit templates which would make
this change a moot point, but independent of that...

> +# Config
> +case "$(git-repo-config --get commit.signoff)" in
> +1|on|yes|true)
> +	signoff=t
> +	;;
> +esac

this is ugly; please use --bool and check only for 'true'.


