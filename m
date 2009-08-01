From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 01 Aug 2009 14:11:40 -0700 (PDT)
Message-ID: <m3hbwrqly9.fsf@localhost.localdomain>
References: <1CE4F545-1ACA-4786-B0F2-EE7C746E6585@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Aug 01 23:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXLrz-0001MX-83
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZHAVLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZHAVLm
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 17:11:42 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37227 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZHAVLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 17:11:41 -0400
Received: by ewy10 with SMTP id 10so2227255ewy.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5I84P+jaHrNNfSqZDsroWW11Dkccj0AYINqkK9dIEqg=;
        b=m3n2jNd/WyBeqUbucca3lrty/GNO/osVkHCv8fUk7fxj5Qe4h22/DWQSlugjAPTGJh
         jXsVymu3cWSiVycKKa0PXs9NnCZoiaLCX45zdh715PXQnHWu6KVXlaVK676vEmUG9cBt
         sESP/cQgDS1Az0of8ZXM9RV9BDZOIg+UF6Hk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fd6NN44GbGh7sqfvaXSxb2XPOURxuSYdCC3fGWl5CzISlWPNcdAwNQmcl8j9E3L5Sb
         RQSw4MwTKQLbQSnEEBx1gVx5YE93G+8WG+kPSot7/N+3RQLt28OOnK39WB9tqqxIx2r/
         h7d0N8j5trV0PdZnBQfq3ai1G+LD24m4lnPTY=
Received: by 10.210.34.2 with SMTP id h2mr5052480ebh.79.1249161100680;
        Sat, 01 Aug 2009 14:11:40 -0700 (PDT)
Received: from localhost.localdomain (abvt157.neoplus.adsl.tpnet.pl [83.8.217.157])
        by mx.google.com with ESMTPS id 5sm7038874eyh.16.2009.08.01.14.11.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 14:11:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n71LBAGm015611;
	Sat, 1 Aug 2009 23:11:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n71LAsQX015606;
	Sat, 1 Aug 2009 23:10:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1CE4F545-1ACA-4786-B0F2-EE7C746E6585@uwaterloo.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124647>

Mark A Rada <marada@uwaterloo.ca> writes:

> ------->8-------------
> From: Mark Rada <marada@uwaterloo.ca>
> Date: Sat, 1 Aug 2009 13:24:03 -0400
> Subject: [PATCH 2/2] gitweb: support to globally enable/disable a snapshot format
> 
> I added a 'disabled' variable to to the $known_snapshot_formats keys so
> that a Gitweb administrator can globally enable or disable a specific
> format for snapshots.
> 
> All formats are enabled by default because project specific overriding
> is disabled by default.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>

O.K.  I think this patch now covers everything needed.  Well, except
documentation.

> ---
>   gitweb/gitweb.perl |   17 ++++++++++++-----
>   1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3398163..a59569f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -167,27 +167,31 @@ our %known_snapshot_formats = (

At the beginning of %known_snapshot_formats definition there is a
comment with description of structure of this hash.  You should have
updated it, for example in the following way:

@@ -168,7 +168,8 @@ our %known_snapshot_formats = (
 	# 	'suffix' => filename suffix,
 	# 	'format' => --format for git-archive,
 	# 	'compressor' => [compressor command and arguments]
-	# 	                (array reference, optional)}
+	# 	                (array reference, optional),
+	# 	'disabled' => boolean (optional)}
 	#
 	'tgz' => {
 		'display' => 'tar.gz',

The above is, of course, not the only possible way.

>   		'type' => 'application/x-gzip',
>   		'suffix' => '.tar.gz',
>   		'format' => 'tar',
> -		'compressor' => ['gzip']},
> +		'compressor' => ['gzip'],
> +		'disabled' => 0},
> 
>   	'tbz2' => {
>   		'display' => 'tar.bz2',
>   		'type' => 'application/x-bzip2',
>   		'suffix' => '.tar.bz2',
>   		'format' => 'tar',
> -		'compressor' => ['bzip2']},
> +		'compressor' => ['bzip2'],
> +		'disabled' => 0},
> 
>   	'txz' => {
>   		'display' => 'tar.xz',
>   		'type' => 'application/x-xz',
>   		'suffix' => '.tar.xz',
>   		'format' => 'tar',
> -		'compressor' => ['xz']},
> +		'compressor' => ['xz'],
> +		'disabled' => 0},
> 
>   	'zip' => {
>   		'display' => 'zip',
>   		'type' => 'application/x-zip',
>   		'suffix' => '.zip',
> -		'format' => 'zip'},
> +		'format' => 'zip',
> +		'disabled' => 0},
>   );

Although I though that we don't need to put "'disabled' => 0", as 
the fact that 'disabled' key does not exist means that it is enabled.

But if you chose to have all known formats not disabled, then I think
it is a correct solution.  (And then choosing between 'enabled' and
'disabled' is mainly a matter of taste.)

> 
>   # Aliases so we understand old gitweb.snapshot values in repository
> @@ -502,7 +506,8 @@ sub filter_snapshot_fmts {
>   		exists $known_snapshot_format_aliases{$_} ?
>   		       $known_snapshot_format_aliases{$_} : $_} @fmts;
>   	@fmts = grep {
> -		exists $known_snapshot_formats{$_} } @fmts;
> +		exists $known_snapshot_formats{$_} &&
> +		!$known_snapshot_formats{$_}{'disabled'}} @fmts;
>   }
> 
>   our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
> @@ -5171,6 +5176,8 @@ sub git_snapshot {
>   		die_error(400, "Unknown snapshot format");
>   	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>   		die_error(403, "Unsupported snapshot format");
> +	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
> +		die_error(403, "Snapshot format not allowed");
>   	}
> 
>   	if (!defined $hash) {

Now I think that covers everything: preventing displaying known but
disabled snapshot formats in snapshots links in gitweb, and preventing
using known but disabled snapshot format.

-- 
Jakub Narebski

Git User's Survey 2009
http://tinyurl.com/GitSurvey2009
