From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/7] gitweb: Add option to force version match
Date: Wed, 13 Jan 2010 18:33:55 +0100
Message-ID: <201001131833.55603.jnareb@gmail.com>
References: <1263374828-15342-1-git-send-email-warthog9@eaglescrag.net> <1263374828-15342-2-git-send-email-warthog9@eaglescrag.net> <1263374828-15342-3-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: warthog9@kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV76l-00034o-63
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab0AMReK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756109Ab0AMReJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:34:09 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:35867 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab0AMReG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:34:06 -0500
Received: by fxm25 with SMTP id 25so418039fxm.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=keTGR558hySgl90Kf6IhDQ35jXMnmXvs/2oWQRFSBwU=;
        b=xZIszCQF2H6aAX194Gz/+06jvDJ6cxPDXoPZpj9o6EwgSTiih/TlTb1gTQATqncdhC
         L77EOS1eEVZ6XaYUsNfKZByH4LEzYRwo8RpHyiXwzqCsolQ7Ozts/xa+HKTnIL8cYt5L
         BSquJS5Ucz7yaSCmepH74CE1oACOXBJiSE5WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P8ikJfvbxsprAU4INndM57jxE4uGuKQofzJNeRodGDe1gcKuO9XGT0cgkKC21EgC+E
         x4XWw1PKLs0LdNVb+ITS/S0YtlLaIuaRNQG/9hXZFoyOh7uH/6YwIPtlEHkJne70aqHD
         +jwsesKzWd5oK965g6jfSoarkwnv7JqwlY3lQ=
Received: by 10.223.18.137 with SMTP id w9mr11626856faa.61.1263404044569;
        Wed, 13 Jan 2010 09:34:04 -0800 (PST)
Received: from ?192.168.1.13? (abwq222.neoplus.adsl.tpnet.pl [83.8.240.222])
        by mx.google.com with ESMTPS id 14sm10936673fxm.11.2010.01.13.09.34.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 09:34:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1263374828-15342-3-git-send-email-warthog9@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136846>

On Wed, 13 Jan 2010, John 'Warthog9' Hawley wrote:
> From: John 'Warthog9' Hawley <warthog9@kernel.org>
> 
> This adds $git_versions_must_match variable, which is set to true

s/is set to true value/if set to true,/

> value checks that we are running on the same version of git that we
> shipped with, and if not throw '500 Internal Server Error' error.
> What is checked is the version of gitweb (embedded in building
> gitweb.cgi), against version of runtime git binary used.
> 
> Gitweb can usually run with a mismatched git install.  This is more
> here to give an obvious warning as to whats going on vs. silently
> failing.
> 
> By default this feature is turned off.

[moved version info below, after "---" separator]

> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Moved to the correct place: information about patch versioning should
be put in comment section[1], not in commit message.
 
[1] Which means between "---" separator and diffstat.

> v3 - warthog9: adjust to use die_error instead of recreating it
> v2 - Jakub: Changes to make non-default, and change naming
> v1 - warthog9: Initial

>  gitweb/README      |    3 +++
>  gitweb/gitweb.perl |   28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 0 deletions(-)

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl

> @@ -587,6 +590,31 @@ if (defined $maxload && get_loadavg() > $maxload) {
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
>  
> +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> +if ($git_versions_must_match &&
> +    $git_version ne $version) {
> +	my $admin_contact =
> +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> +	my $err_msg = <<EOT;
> +Internal Server Error
> +<br />
> +</div>
> +<hr />
> +<div class="readme">
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
> +	die_error(500, $err_msg);
> +}

I'm sorry to be this picky, but don't you think that caller should not need
to know "intimate" details on how die_error works.  In particular please
notice that you must have known that die_error wraps its output in <div>...
which is not even mentioned in comments.

The second argument of die_error() subroutine is meant to be alternative
description of error condition: short and one line.  For situations such
like this one, where we want to describe error in more details, it would
be better, I think, to change signature of die_error() to take (optionally)
three arguments, and use 'die_error(500, undef, $err_msg);', with $err_msg
starting from '<h1>...</h1>'.

@@ -3460,6 +3460,7 @@
 sub die_error {
 	my $status = shift || 500;
 	my $error = shift || "Internal server error";
+	my $extra = shift;
 
 	my %http_responses = (
 		400 => '400 Bad Request',
@@ -3475,8 +3476,13 @@ sub die_error {
 <br /><br />
 $status - $error
 <br />
-</div>
 EOF
+	if (defined $extra) {
+		print "<hr />\n" .
+		      "$extra\n";
+	}
+	print "</div>\n";
+
 	git_footer_html();
 	exit;
 }


Other that this minor issue it looks good.

-- 
Jakub Narebski
Poland
