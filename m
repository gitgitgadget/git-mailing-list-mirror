From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 4 Jun 2012 19:36:57 +0000
Message-ID: <20120604193657.GA24738@dcvr.yhbt.net>
References: <20120430081939.GA27715@dcvr.yhbt.net>
 <7vipghgq9a.fsf@alter.siamese.dyndns.org>
 <20120430165315.GO4023@login.drsnuggles.stderr.nl>
 <20120430190200.GA27108@dcvr.yhbt.net>
 <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
 <7vy5pcd7xu.fsf@alter.siamese.dyndns.org>
 <20120603104914.GA21276@hashpling.org>
 <7vfwacxe7p.fsf@alter.siamese.dyndns.org>
 <20120604090016.GA4023@login.drsnuggles.stderr.nl>
 <7vwr3mswsr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 21:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbd5L-0005Jx-Al
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2FDTg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 15:36:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38820 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab2FDTg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 15:36:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9E91F451;
	Mon,  4 Jun 2012 19:36:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vwr3mswsr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199172>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric, I can directly queue this as a regression fix in my tree, you
> can eyeball and give your blessing (or "No, that is wrong--here is
> the right version" is even better), or you can queue it and tell me
> to pull from you.  How do we want to proceed?

Looks reasonable, you can queue directly
Acked-by: Eric Wong <normalperson@yhbt.net>

> -- >8 --
> Subject: [PATCH] git-svn: platform auth providers are working only on 1.6.15
>  or newer
> 
> Matthijs Kooijman reports that the cut-off point 082afee (git-svn:
> use platform specific auth providers, 2012-04-26) set at 1.6.12 to
> use this feature safely was incorrect, and it is 1.6.15 instead:
> 
>     http://svn.apache.org/repos/asf/subversion/trunk/CHANGES
>     Version 1.6.15
>        * improve some swig parameter mapping (r984565, r1035745)
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-svn.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 1a17f94..abbd6b8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -5481,7 +5481,7 @@ ()
>  
>  	# earlier 1.6.x versions would segfault, and <= 1.5.x didn't have
>  	# this function
> -	if (::compare_svn_version('1.6.12') > 0) {
> +	if (::compare_svn_version('1.6.15') >= 0) {
>  		my $config = SVN::Core::config_get_config($config_dir);
>  		my ($p, @a);
>  		# config_get_config returns all config files from
> -- 
