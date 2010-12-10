From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 13/18] gitweb: Add commented url & url hash to page footer
Date: Thu, 09 Dec 2010 16:26:00 -0800 (PST)
Message-ID: <m38vzy1nkl.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-14-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqoO-0000Yz-Jw
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab0LJA0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:26:06 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:38582 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab0LJA0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:26:04 -0500
Received: by bwz16 with SMTP id 16so3394457bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 16:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eSRSicw/l/a/Omt28Xs50Qz/N5rl9yrvCRTiGItKuh0=;
        b=jszGnXq6UJ2IJtrs1PBPHvml5t1qLDlGQ4cL6dMSD5gutKxcmvyG6eobbg5sK14ksF
         EyHcMn/qobjn8P7e2wjBOR+UufwLceybANxeWW5YtWRtnEyUSJ5LJH9SP2y6n5Yb1ao0
         wJ0ykdaU3E6fCKB7Ob/gk5kSsa+mE0Mr8Fcjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KImWGDgpZxkBbrJHTfeOomeex+33j2ByFIoI56k0eMohaCktin/EGb0fd8Y6fDcHq0
         k46Fq8SoECil7JWut9CIeoLGjZt2dAbDx/VWxwxdc5/lQnYGoon05OCQXRfs+hqNnjyD
         +s65aEh7hBQ6Hr8qOg6FWDJ6mSzZPlN1573Go=
Received: by 10.204.123.14 with SMTP id n14mr105082bkr.49.1291940761231;
        Thu, 09 Dec 2010 16:26:01 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id b17sm1252659bku.20.2010.12.09.16.25.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 16:26:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBA0PUl5020420;
	Fri, 10 Dec 2010 01:25:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBA0PENW020416;
	Fri, 10 Dec 2010 01:25:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-14-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163366>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This is mostly a debugging tool, but it adds a small bit of information
> to the footer:
> 
> <!--
> 	Full URL: |http://localhost/gitweb-caching/gitweb.cgi?p=/project.git;a=summary|
> 	URL Hash: |7a31cfb8a43f5643679eec88aa9d7981|
> -->

Nice idea.  It helps with debugging and doesn't introduce information
leakage.

Note that in my rewrite there would be *three* pieces of information,
not two.  Namely:

  Full URL: |http://localhost/gitweb-caching/gitweb.cgi/project.git|
  Key:      |http://localhost/gitweb-caching/gitweb.cgi?p=/project.git;a=summary|
  Key hash: |7a31cfb8a43f5643679eec88aa9d7981|

> 
> The first bit tells you what the url that generated the page actually was, the second is
> the hash used to store the file with the first two characters being used as the directory:
> 
> <cachedir>/7a/31cfb8a43f5643679eec88aa9d7981

Isn't it

  <cachedir>/7a/7a31cfb8a43f5643679eec88aa9d7981

in your series?

> 
> Also useful for greping through the existing cache and finding files with unique paths that
> you may want to explicitly flush.

Though probably better 'cache_admin' page would be ultimately best
solution, see proof of concept in

  [RFC PATCHv6 24/24] gitweb: Add beginnings of cache administration page (proof of concept)
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163051
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/aa9fd77ff206eae8838fdde626d2afea563f9f75

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl  |    7 +++++++
>  gitweb/lib/cache.pl |    4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e8c028b..7f8292e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -303,6 +303,9 @@ our $fullhashpath = *STDOUT;
>  our $fullhashbinpath = *STDOUT;
>  our $fullhashbinpathfinal = *STDOUT;
>  
> +our $full_url;
> +our $urlhash;
> +
>  # configuration for 'highlight' (http://www.andre-simon.de/)
>  # match by basename
>  our %highlight_basename = (
> @@ -3663,6 +3666,10 @@ sub git_footer_html {
>  
>  	print "<div class=\"page_footer\">\n";
>  	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
> +	print	"<!--\n".
> +		"	Full URL: |$full_url|\n".
> +		"	URL Hash: |$urlhash|\n".
> +		"-->\n" if ($cache_enable);

Don't you need to esc_html on it?  $full_url can contain ' -->', and
what you would do then?

>  	if (defined $project) {
>  		my $descr = git_get_project_description($project);
>  		if (defined $descr) {
> diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
> index fafc028..63dbe9e 100644
> --- a/gitweb/lib/cache.pl
> +++ b/gitweb/lib/cache.pl
> @@ -30,8 +30,8 @@ sub cache_fetch {
>  		print "Cache directory created successfully\n";
>  	}
>  
> -	our $full_url = "$my_url?". $ENV{'QUERY_STRING'};

Note that $my_url is $cgi->url(), which does not include path_info.

> -	our $urlhash = md5_hex($full_url);
> +	$full_url = "$my_url?". $ENV{'QUERY_STRING'};
> +	$urlhash = md5_hex($full_url);
>  	our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";
>  
>  	eval { mkpath( $fullhashdir, 0, 0777 ) };
> -- 
> 1.7.2.3

Looks quite nice. 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
