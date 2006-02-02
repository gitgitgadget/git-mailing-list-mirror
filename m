From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport.perl: fix for 'arg list too long...'
Date: Thu, 2 Feb 2006 16:26:38 +0200
Message-ID: <20060202142638.GD32188@sashak.voltaire.com>
References: <20060201155331.GE18078@sashak.voltaire.com> <7v64nybz9m.fsf@assigned-by-dhcp.cox.net> <20060201215454.GB31711@sashak.voltaire.com> <7v3bj27kxe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:27:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4fPl-0001dH-EI
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 15:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWBBO0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 09:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBBO0M
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 09:26:12 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:61459 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751083AbWBBO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 09:26:12 -0500
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 2 Feb 2006 16:26:00 +0200
Received: by sashak (sSMTP sendmail emulation); Thu,  2 Feb 2006 16:26:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bj27kxe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Feb 2006 14:26:00.0728 (UTC) FILETIME=[97232180:01C62804]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15507>

On 14:50 Wed 01 Feb     , Junio C Hamano wrote:
> 
> *1* I do not think this makes much of a difference but here is what
> I mean.
> 
> diff --git a/git-svnimport.perl b/git-svnimport.perl

Tested. Works good. I think your version is cleaner. Cosmetic comment btw:

> +		open my $F, "|-",
> +			qw(git-update-index --force-remove -z --stdin)
> +				or die $!;
> +		print $F "$_\0" for @u;
> +		close $F or die $!;

It is not critical, but this block may be under if(@u) {..} to prevent
"empty" git-update-index invocations.

Sasha.
