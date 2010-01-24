From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/9] gitweb: Add option to force version match
Date: Sun, 24 Jan 2010 22:59:24 +0100
Organization: 
Message-ID: <20100124215924.GA9553@machine.or.cz>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 22:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZAUY-0006S6-9Y
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 22:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0AXV72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 16:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840Ab0AXV72
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 16:59:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43276 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0AXV71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 16:59:27 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 40CFE125A0E9; Sun, 24 Jan 2010 22:59:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137922>

  Hi!

On Wed, Jan 13, 2010 at 05:22:59PM -0800, John 'Warthog9' Hawley wrote:
> +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> +if ($git_versions_must_match &&
> +    $git_version ne $version) {
> +	my $admin_contact =
> +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> +	my $err_msg = <<EOT;
> +<h1 align="center">*** Warning ***</h1>
> +<p>
> +This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
> +however git version <b>@{[esc_html($git_version)]}</b> was found on server,
> +and administrator requested strict version checking.
> +</p>
> +<p>
> +Please contact the server administrator${admin_contact} to either configure
> +gitweb to allow mismatched versions, or update git or gitweb installation.
> +</p>
> +EOT
> +	die_error(500, 'Internal server error', $err_msg);
> +}
> +

  I get very unhappy when *I* am the server administrator and read
messages like this. ;-) Could you please mention the
\$git_versions_must_match in the text?

				Petr "Pasky" Baudis
