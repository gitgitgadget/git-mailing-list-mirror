From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: fix uninitialized variable warning.
Date: Sun, 17 Sep 2006 02:00:16 -0700
Message-ID: <7vzmcy6f6n.fsf@assigned-by-dhcp.cox.net>
References: <20060916210902.GW17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 11:00:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsVi-0005LK-B4
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWIQJAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWIQJAS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:00:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3295 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932341AbWIQJAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 05:00:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917090016.XJGJ18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 05:00:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PM041V0091kojtg0000000
	Sun, 17 Sep 2006 05:00:04 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060916210902.GW17042@admingilde.org> (Martin Waitz's message
	of "Sat, 16 Sep 2006 23:09:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27170>

Martin Waitz <tali@admingilde.org> writes:

> @@ -2436,7 +2432,11 @@ sub git_blob {
>  		} else {
>  			die_error(undef, "No file name defined");
>  		}
> +	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
> +		# blobs defined by non-textual hash id's can be cached
> +		$expires = "+1d";
>  	}
> +
>  	my $have_blame = gitweb_check_feature('blame');
>  	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
>  		or die_error(undef, "Couldn't cat $file_name, $hash");

Will apply, but you seem to be out of sync.
