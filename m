From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Sun, 16 Mar 2008 12:41:51 +0100
Message-ID: <20080316114151.GZ10103@mail-vs.djpig.de>
References: <20080313231413.27966.3383.stgit@rover> <m3ve3nwtl3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 12:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JarGp-0000UF-EA
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 12:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYCPLmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 07:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYCPLmN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 07:42:13 -0400
Received: from pauli.djpig.de ([78.46.38.139]:36492 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYCPLmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 07:42:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 89DAD90077;
	Sun, 16 Mar 2008 12:42:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xEykVDrZqLDe; Sun, 16 Mar 2008 12:41:56 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id A258C90075;
	Sun, 16 Mar 2008 12:41:55 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JarFP-0005jh-Ss; Sun, 16 Mar 2008 12:41:52 +0100
Content-Disposition: inline
In-Reply-To: <m3ve3nwtl3.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77362>

On Sat, Mar 15, 2008 at 02:44:42PM -0700, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
> This could be much simplified with perl-cache (perl-Cache-Cache).
> Unfortunately this is non-standard module, not distributed (yet?)
> with Perl.

I think somebody who actually needs this can be bothered to install a
CPAN perl module. This should probably not enabled by default anyway.

> Warning: not tested in gitweb!
> 
> +	use Cache::FileCache;
> +
> +	my $cache;
> +	my $projects;
> +	
> +	if ($cache_lifetime) {
> +		$cache = new Cache::FileCache(
> +			{ namespace => 'gitweb',
> +			  default_expires_in => $cache_lifetime
> +			});
> +		$projects = $cache->get('projects_list');
> +	}
> +	if (!defined $projects) {
> +		$projects = [ git_get_projects_details($projlist, $check_forks); ];
> +		$cache->set('projects_list', $projects)
> +			if defined $cache;
> +	}

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
