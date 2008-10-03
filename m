From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: Identify all summary metadata table rows
Date: Thu, 2 Oct 2008 17:30:53 -0700
Message-ID: <20081003003053.GT21310@spearce.org>
References: <1222957505-5150-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <petr.baudis@novartis.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 02:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlYaT-0005r9-8A
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 02:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYJCAay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 20:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYJCAay
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 20:30:54 -0400
Received: from george.spearce.org ([209.20.77.23]:56000 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbYJCAay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 20:30:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 747493835F; Fri,  3 Oct 2008 00:30:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222957505-5150-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97385>

Petr Baudis <pasky@suse.cz> wrote:
> In the metadata table of the summary page, all rows have their
> id (or class in case of URL) set now. This for example lets sites
> easily disable fields they do not want to show in their custom
> stylesheet (e.g. they are overly technical or irrelevant for the site).
> 
> Many of my other patches depend on this, so I would appreciate to hear
> as soon as possible if someone has an issue with this patch.

Its pretty trivial and painless.  So its applied.  Marking up unique
elements so you can control them via CSS isn't rocket science.  ;-)
 

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index da474d0..bd8124a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4070,10 +4070,10 @@ sub git_summary {
>  
>  	print "<div class=\"title\">&nbsp;</div>\n";
>  	print "<table class=\"projects_list\">\n" .
> -	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
> -	      "<tr><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
> +	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
> +	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
>  	if (defined $cd{'rfc2822'}) {
> -		print "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
> +		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
>  	}
>  
>  	# use per project git URL list in $projectroot/$project/cloneurl
> @@ -4083,7 +4083,7 @@ sub git_summary {
>  	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
>  	foreach my $git_url (@url_list) {
>  		next unless $git_url;
> -		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
> +		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
>  		$url_tag = "";
>  	}
>  	print "</table>\n";

-- 
Shawn.
