From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 21:03:55 +0200
Message-ID: <20050517190355.GA7136@pasky.ji.cz>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 21:06:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7M1-0004tm-5g
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEQTEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEQTEI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:04:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46817 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261347AbVEQTEC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 15:04:02 -0400
Received: (qmail 13346 invoked by uid 2001); 17 May 2005 19:03:55 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 16, 2005 at 08:05:19AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> --- a/paths.c
> +++ b/paths.c
> @@ -0,0 +1,199 @@
> +static int initialize_ignore_list(void)
> +{
> +	/* Put the Porcelain layer ignore logic initialization here.
> +	 * Return non-zero after issuing appropriate error message
> +	 * if initialization fails.
> +	 */
> +	return 0;
> +}
> +
> +int path_ignored(const char *path)
> +{
> +	if (!verify_path(path))
> +		return 1;
> +
> +	/* Put the Porcelain layer ignore logic here.
> +	 * Return non-zero if path is to be ignored.
> +	 */
> +	return 0;
> +}

I actually think you shouldn't. All the Porcelain layers should
hopefully use the same git toolkit layer, not each one shipping own due
to differences in things like this.

If we don't agree on something common (implemented in a way to be
still circumventable by a porcelain layer if desired), I wouldn't put
the ignore logic inside at all.

> +/****************************************************************/
> +
> +/* Path canonicalization part */

And why is this in the library?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
