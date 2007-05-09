From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: config_boolean() -> config_bool()
Date: Wed, 9 May 2007 17:13:37 +0200
Message-ID: <20070509151337.GX4489@pasky.or.cz>
References: <20070427020601.22991.13792.stgit@rover> <7v7irxko81.fsf@assigned-by-dhcp.cox.net> <20070509104941.GK4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 17:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlnrO-0007az-2i
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892AbXEIPNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758067AbXEIPNk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:13:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41292 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757892AbXEIPNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:13:39 -0400
Received: (qmail 30827 invoked by uid 2001); 9 May 2007 17:13:37 +0200
Content-Disposition: inline
In-Reply-To: <20070509104941.GK4489@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46724>

On Wed, May 09, 2007 at 12:49:41PM CEST, Petr Baudis wrote:
> @@ -526,14 +528,16 @@ This currently wraps command('config') so it is not so fast.
>  
>  =cut
>  
> -sub config_boolean {
> +sub config_bool {
>  	my ($self, $var) = @_;
>  	$self->repo_path()
>  		or throw Error::Simple("not a repository");
>  
>  	try {
> -		return $self->command_oneline('config', '--bool', '--get',
> -					      $var);
> +		my $val = $self->command_oneline('config', '--bool', '--get',
> +					      $val);
                                               ^^^

Sorry, should be $var. Looks like I forgot to make install or something
when "testing" the patch, also judging by the error messages repo.or.cz
spewed furiously in the last update round.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
