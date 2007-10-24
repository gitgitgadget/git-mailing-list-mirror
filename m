From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 21:39:54 +0200
Message-ID: <20071024193954.GA5280@steel.home>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net> <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikm5M-0000Ec-C4
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 21:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbXJXTj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbXJXTj7
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 15:39:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:56613 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbXJXTj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 15:39:58 -0400
Received: from tigra.home (Fc9f1.f.strato-dslnet.de [195.4.201.241])
	by post.webmailer.de (klopstock mo40) (RZmta 14.0)
	with ESMTP id L0398fj9OHXcsV ; Wed, 24 Oct 2007 21:39:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1A5A8277AE;
	Wed, 24 Oct 2007 21:39:55 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 69CE756D22; Wed, 24 Oct 2007 21:39:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcjYaY=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62228>

Junio C Hamano, Wed, Oct 24, 2007 13:49:51 +0200:
> Perhaps....
> 
>  git-remote.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/git-remote.perl b/git-remote.perl
> index 9ca3e7e..4cee044 100755
> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -244,7 +244,8 @@ sub show_remote {
>  	print "* remote $name\n";
>  	print "  URL: $info->{'URL'}\n";
>  	for my $branchname (sort keys %$branch) {
> -		next if ($branch->{$branchname}{'REMOTE'} ne $name);
> +		next if (!$branch->{$branchname}{'REMOTE'} ||

just you never call yor branches "0".
