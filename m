From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/9] gitweb: Add option to force version match
Date: Fri, 15 Jan 2010 15:36:45 -0800 (PST)
Message-ID: <m3tyunc55t.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvir-0003se-9t
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab0AOXgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469Ab0AOXgu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:36:50 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52126 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380Ab0AOXgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:36:49 -0500
Received: by fxm25 with SMTP id 25so690295fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+35KsuAdLJo05l7W/AunlAx5C3NbA1CyHeXKqzOY0xE=;
        b=Cz9e0Uz7J5KhkdVR3RwAMsUlH1aF6cjwwkNcJgH/E001pRvZJWEnaQ8ajil867sOQL
         8FcMOon/6+FiS6O+CkePN9K0wek9AJ0gYyEg87/zZKd27D9ADDv6k+vGzNYQf+WC02rS
         G/PP1W1Kx6jQ8lusH7JUnkfFyy8qOpe7G1TxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=n8r90Bim8lf1Q7A66ObNvbHv3DjuUdBoffM9JQbpENJoX6zIOrg/HqdSFMcBIWUcJv
         wu4rojzosSqXDRYV7VCbmzW4hwVk2suvitYxoKAmxhTSuhPpPrZCmdji3ylEeUq1xXmV
         qwG3QN7KYy3+d0cwOXDTTm204/olScgXwVKyU=
Received: by 10.223.15.92 with SMTP id j28mr3490792faa.11.1263598607645;
        Fri, 15 Jan 2010 15:36:47 -0800 (PST)
Received: from localhost.localdomain (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id 18sm505644fkq.11.2010.01.15.15.36.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 15:36:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0FNaFLZ031477;
	Sat, 16 Jan 2010 00:36:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0FNZwXO031473;
	Sat, 16 Jan 2010 00:35:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137161>

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
> 
> By default this feature is turned on.

If this feature is turned on, then I would prefer for gitweb tests to
have it explicitly turned off, so I don't need to rebuild git to test
gitweb.  

Also it would be nice to have some tests for this new feature.

See patch below (proposed to be squashed with this one).


P.S. t is there where I have noticed the issue with undefined $action
in git_footer_html(), mentioned in reply to patch 1/9.
 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Here could be information about differences from previous versions of
this patch.

>  gitweb/README      |    3 +++
>  gitweb/gitweb.perl |   23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/README b/gitweb/README
> index 6c2c8e1..03151d2 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -233,6 +233,9 @@ not include variables usually directly set during build):
>     If server load exceed this value then return "503 Service Unavaliable" error.
>     Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
>     undefined value to turn it off.  The default is 300.
> + * $git_versions_must_match
> +   If set, gitweb fails with 500 Internal Server Error if the version of gitweb
> +   doesn't match version of git binary.  The default is true.
>  
>  
>  Projects list file format
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 8298de5..b41bc33 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -221,6 +221,9 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# If it is true, exit if gitweb version and git binary version don't match
> +our $git_versions_must_match = 1;
> +
>  # Used to set the maximum load that we will still respond to gitweb queries.
>  # If server load exceed this value then return "503 server busy" error.
>  # If gitweb cannot determined server load, it is taken to be 0.
> @@ -587,6 +590,26 @@ if (defined $maxload && get_loadavg() > $maxload) {
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
>  
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
>  $projects_list ||= $projectroot;
>  
>  # ======================================================================
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 76d8b7b..d9ffc90
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -25,6 +25,7 @@ our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
 our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
+our \$git_versions_must_match = 0;
 
 EOF
 
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 0688a57..721900e 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -113,5 +113,31 @@ test_expect_success 'snapshots: bad object id' '
 '
 test_debug 'cat gitweb.output'
 
+# ======================================================================
+# check $git_versions_must_match feature
+# should be last section, just in case
+cp -f gitweb_config.perl gitweb_config.perl.bak
+echo 'our $git_versions_must_match = 1;' >>gitweb_config.perl
+
+cat <<\EOF >>gitweb_config.perl
+our $version = "current";
+EOF
+test_expect_success 'force version match: no match' '
+	gitweb_run "p=.git" &&
+	grep "500 - Internal Server Error" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+cat <<\EOF >>gitweb_config.perl
+# must be kept in sync with code in gitweb/gitweb.perl
+our $version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+EOF
+test_expect_success 'force version match: match' '
+	gitweb_run "p=.git" &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+mv -f gitweb_config.perl.bak gitweb_config.perl
 
 test_done

> -- 
> 1.6.5.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
