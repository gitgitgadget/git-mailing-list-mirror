From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch/parse-remote: refs/remotes/* support
Date: Thu, 09 Mar 2006 09:23:59 -0800
Message-ID: <7vzmjz5y6o.fsf@assigned-by-dhcp.cox.net>
References: <20060309115452.GA13369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 09 18:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHOrv-0000fc-S0
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 18:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWCIRYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWCIRYE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 12:24:04 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17580 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750738AbWCIRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 12:24:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309172050.HIFU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 12:20:50 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060309115452.GA13369@localdomain> (Eric Wong's message of
	"Thu, 9 Mar 2006 03:54:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17427>


> @@ -103,6 +103,9 @@ append_fetch_head () {
>      refs/tags/*)
>  	note_="$(expr "$remote_name_" : 'refs/tags/\(.*\)')"
>  	note_="tag '$note_' of " ;;
> +    refs/remotes/*)
> +	note_="$(expr "$remote_name_" : 'refs/remotes/\(.*\)')"
> +	note_="remote branch '$note_' of " ;;
>      *)
>  	note_="$remote_name of " ;;
>      esac

I vaguely recall that if you touch this part of the code you
would also need to check if fmt-merge-msg does sensible thing
for it.
