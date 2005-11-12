From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Sat, 12 Nov 2005 01:58:03 +0100
Message-ID: <20051112005803.GZ30496@pasky.or.cz>
References: <20051112004958.21857.95728.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 02:00:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eajic-0005ma-FN
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 01:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVKLA6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKLA6H
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 19:58:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37033 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750837AbVKLA6G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 19:58:06 -0500
Received: (qmail 31862 invoked by uid 2001); 12 Nov 2005 01:58:03 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051112004958.21857.95728.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11654>

Dear diary, on Sat, Nov 12, 2005 at 01:49:59AM CET, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  http-fetch.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/http-fetch.c b/http-fetch.c
> index e7655d1..e6e7df6 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -795,7 +795,7 @@ static int fetch_alternates(char *base)
>  	buffer.buffer = data;
>  
>  	if (get_verbosely)
> -		fprintf(stderr, "Getting alternates list\n");
> +		fprintf(stderr, "Getting alternates list for %s\n", base);
>  	
>  	url = xmalloc(strlen(base) + 31);
>  	sprintf(url, "%s/objects/info/http-alternates", base);
> @@ -918,7 +918,7 @@ static int fetch_indices(struct alt_base
>  	buffer.buffer = data;
>  
>  	if (get_verbosely)
> -		fprintf(stderr, "Getting pack list\n");
> +		fprintf(stderr, "Getting pack list for %s\n", repo->base);
>  	
>  	url = xmalloc(strlen(repo->base) + 21);
>  	sprintf(url, "%s/objects/info/packs", repo->base);

By the way, this is only a pathetic remnant of my brave effort to get
rid of seeing the "Getting alternates list" message on the same
repository 20 times now since the parallel fetching got introduced.
I know how to do silence the messages, but doing the _fetching_ itself
seems as downright stupid thing in the first place.

Therefore, can I somehow stall fetching of an object? The idea is:

	I want to check the alternates list!
	I don't have it yet...
	...but a request for it is already queued. Ok, I'll wait.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
