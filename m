From: Junio C Hamano <junkio@cox.net>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 10:05:23 -0700
Message-ID: <7virnv8ib0.fsf@assigned-by-dhcp.cox.net>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
	<46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
	<93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
	<20060524122246.GA3997@coredump.intra.peff.net>
	<93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com>
	<20060524132317.GA4594@coredump.intra.peff.net>
	<93c3eada0605240647i48db0588ja343e348f5feb08e@mail.gmail.com>
	<20060524135828.GA23934@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	geoff@austrics.com.au
X-From: git-owner@vger.kernel.org Wed May 24 19:05:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiwnZ-0003sx-5N
	for gcvg-git@gmane.org; Wed, 24 May 2006 19:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWEXRF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEXRF0
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 13:05:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22180 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751144AbWEXRFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 13:05:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524170524.EULU15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 13:05:24 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060524135828.GA23934@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 24 May 2006 09:58:28 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20693>

Jeff King <peff@peff.net> writes:

> Odd. It's either a bug with importing tags in older versions, or there's
> some deep perl voodoo that I don't understand (either way, it is "fixed"
> in more recent versions).  Importing ENOENT directly is reasonable.

Sounds good.  Thanks for the back-and-forth helping others in
the community.  I appreciate it.

> Junio, can you apply the following fix?

Will do, but I would have preferred if you did the commit log
message and the stuff properly.  Less work for me ;-).

>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index af331d9..76f6246 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -23,7 +23,7 @@ use File::Basename qw(basename dirname);
>  use Time::Local;
>  use IO::Socket;
>  use IO::Pipe;
> -use POSIX qw(strftime dup2 :errno_h);
> +use POSIX qw(strftime dup2 ENOENT);
>  use IPC::Open2;
>  
>  $SIG{'PIPE'}="IGNORE";
