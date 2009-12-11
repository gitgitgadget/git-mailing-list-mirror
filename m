From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/6] GITWEB - Add git:// link to summary pages
Date: Fri, 11 Dec 2009 05:44:52 -0800 (PST)
Message-ID: <m3tyvxd3pr.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
	<1260488743-25855-3-git-send-email-warthog9@kernel.org>
	<1260488743-25855-4-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 14:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ5ny-0007p4-LD
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 14:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbZLKNo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 08:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757552AbZLKNo5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 08:44:57 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:62331 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbZLKNo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 08:44:57 -0500
Received: by ewy1 with SMTP id 1so1034910ewy.28
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 05:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1Ie+/nnEx53hoJ6tsKFYOMep08Wc+9jdgWcnjBtM2v8=;
        b=TzrXvfGtSdBToO7WaYAaoiWLEJFz330GH48PFyJVSq1FA4hHoGv2UBsJeiKF4zii4v
         1gpc8qkH67j3AkT0papK6hDlkxWkgpW1dglFgPyHofMRPkYvla+fVV6We0Y2LvcTBvTB
         k+q1x9rTRJPFfEhyJSjIXyM1GOAY/5RNDCqts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mMDpBHmVLhRNMhQ1/vbtlgCBkWQEwmIUisVT/zQJ9hOFTyOSGq1LieFIEbkcbMl44K
         oqrtV3txoR45pmJWwNZmlPN1IN3xDeBrkQEOr6GO87QEa7KZQye1wvZqN38a3nWM46o1
         hi7yjOYMJelev+L72Hawtev+iEiXSvQUAqy5o=
Received: by 10.213.110.9 with SMTP id l9mr1617373ebp.14.1260539092858;
        Fri, 11 Dec 2009 05:44:52 -0800 (PST)
Received: from localhost.localdomain (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id 13sm1162216ewy.13.2009.12.11.05.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 05:44:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBBDjgQB004439;
	Fri, 11 Dec 2009 14:45:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBBDjK9g004434;
	Fri, 11 Dec 2009 14:45:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-4-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135086>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

> This adds a git:// link to the summary pages should a common
> $gitlinkurl be defined (default is nothing defined, thus nothing
> shown)
> 
> This does make the assumption that the git trees share a common
> path, and nothing to date is known to actually make use of the link

The problem I had and have with this patch is the duplication of data:
$gitlinkurl contains subset of information in @git_base_url_list,
which in turn is filled from GITWEB_BASE_URL build config variable.

I can understand that for performance reason you don't want to check
$projectroot/$project/cloneurl nor gitweb.url config variable for
each and every displayed project; if the link to repository (for git)
cannot be derived from project path (repository path), then simply
do not dosplay it.

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d84f4c0..7ad096c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -224,6 +224,10 @@ our %avatar_size = (
>  # This is here to allow for missmatch git & gitweb versions
>  our $missmatch_git = '';
>  
> +#This is here to deal with an extra link on the summary pages - if it's left blank
> +# this link will not be shwon.  If it's set, this will be prepended to the repo and used

s/shwon/shown/

I'd say that 'Full URL is "$gitlinkurl/$project"' instead of last
sentence in above comment.

Please watch for excessive line lengths.

> +our $gitlinkurl = '';

Why not

our $gitlinkurl_base = "++GITWEB_BASE_URL++";

of course changing the name everywhere.

> +
>  # Used to set the maximum load that we will still respond to gitweb queries.
>  # if we exceed this than we do the processing to figure out if there's a mirror
>  # and redirect to it, or to just return 503 server busy
> @@ -4454,6 +4458,10 @@ sub git_project_list_body {
>  		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
>  		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
>  		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
> +     		if( $gitlinkurl ne '' ){
> +			print " | ". $cgi->a({-href => "git://$gitlinkurl/".esc_html($pr->{'path'})}, "git");
> +		}
> +		print "".

Does it even pass tests?

 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+     		      ($gitlinkurl_base ? 
+		       " | " . $cgi->a({-href=>"$gitlinkurl_base/$pr->{'path'}", "git") : '') .
 		      "</td>\n" .
 		      "</tr>\n";
 	}

Changes made: 
* Instead of using separate if conditional statement and print
  statement (note that you forgot to change '.' to ';' to end
  statement) use ternary conditional operator "?:"
* Make $gitlinkurl_base include "git://" protocol specifier
* Do not create "git" link if $gitlinkurl_base is false, which means
  undef, empty string '' and 0 (but 0 is not very likely to be base
  for "git" link).
* Do not use esc_html on fragment of URL.  The CGI.pm should escape
  attributes itself.  If it was HTTP link, one should perhaps esc_url
  on whole link, but esc_html is for escaping HTML.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
