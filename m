From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Add option to force version match
Date: Thu, 28 Oct 2010 02:52:44 -0700 (PDT)
Message-ID: <m3fwvqir0o.fsf@localhost.localdomain>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
	<1288226574-19068-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Oct 28 11:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBPAj-0002aZ-ED
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 11:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab0J1Jwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 05:52:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41595 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab0J1Jwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 05:52:47 -0400
Received: by bwz11 with SMTP id 11so1367160bwz.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=aEA9oIB+FMo/DSYbEs2O143emTEEJKF0sVjgTdMfl9E=;
        b=EBrz43YAut5qkts7g911txquA2tQQDOpjlblmQ0ff5ywW/AJ9j5j08EOcXOe9zrjaD
         iIOMl6jfD2Fc25EMTmIEQ79P22Kbv6w/BX0Ml33fESY3SDKXdaMWeCCso4pC9yLxbdaT
         ihtynxzA2kfqMfM3hvnGlD1T5pidzBejdLgNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mjbRIdUUEeUQHNbwQiGwn9XmHcI/z8iS7gJmXiFXwy+iqpbFKExBY4+ZQRMLUI9HjV
         L3n8B47rckkGHQPortUe1bS3CKhbVcBSQLk94wlCztMp66bmE0zlnEd7I7Ey/hjlXcSS
         G4ibgPSDpv/Ca0UWiI8xzsQvzpO6/GZe4r2I4=
Received: by 10.204.156.9 with SMTP id u9mr2017640bkw.202.1288259565839;
        Thu, 28 Oct 2010 02:52:45 -0700 (PDT)
Received: from localhost.localdomain (abvj108.neoplus.adsl.tpnet.pl [83.8.207.108])
        by mx.google.com with ESMTPS id f21sm7449357bkf.12.2010.10.28.02.52.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 02:52:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9S9q9U6006614;
	Thu, 28 Oct 2010 11:52:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9S9prgu006609;
	Thu, 28 Oct 2010 11:51:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1288226574-19068-2-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160165>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This adds $git_versions_must_match variable, which is set to true,
> checks that we are running on the same version of git that we
> shipped with, and if not throw '500 Internal Server Error' error.
> What is checked is the version of gitweb (embedded in building
> gitweb.cgi), against version of runtime git binary used.
> 
> Gitweb can usually run with a mismatched git install.  This is more
> here to give an obvious warning as to whats going on vs. silently
> failing.

Were you bitten by mismatch between git version and gitweb version?
Just how serious is that (hypothetical?) situation?

Should it be warning, or erroring out?

> 
> By default this feature is turned on.

I think last time this patch stalled on discussion whether this
feature should be turned on by default, where it can break some
setups; or be turned off by default, where it is much less useful
protecting against errors.

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/README      |    4 ++++
>  gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)

For me, if $git_versions_must_match is to be on by default, I would
prefer also update to t/gitweb-lib.sh, so hat I don't have to
recompile git to test new version of gitweb...  

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8d7e4c5..215a4e9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -232,6 +232,9 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# If it is true, exit if gitweb version and git binary version don't match
> +our $git_versions_must_match = 1;
> +
>  # Used to set the maximum load that we will still respond to gitweb queries.
>  # If server load exceed this value then return "503 server busy" error.
>  # If gitweb cannot determined server load, it is taken to be 0.
> @@ -649,6 +652,29 @@ sub check_loadavg {
>  	}
>  }
>  
> +sub check_versionmatch {
> +	# Throw an error if git versions does not match, if $git_versions_must_match is true.
> +	if ($git_versions_must_match &&
> +	    $git_version ne $version) {
> +		my $admin_contact =
> +			defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> +		my $err_msg = <<EOT;
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
> +		die_error(500, 'Internal server error', $err_msg);
> +	}
> +
> +}

Nice.

> +
>  # ======================================================================
>  # input validation and dispatch
>  
> @@ -1075,6 +1101,7 @@ sub run_request {
>  	evaluate_uri();
>  	evaluate_gitweb_config();
>  	check_loadavg();
> +	check_versionmatch();

Shouldn't it be before check_loadavg()?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
