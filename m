From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: support hiding projects from user-visible lists
Date: Sat, 13 Dec 2008 14:02:01 -0800 (PST)
Message-ID: <m3ljujg2eh.fsf@localhost.localdomain>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
	<1229203007.31181.6.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcaD-0001Pf-SG
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYLMWCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYLMWCG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:02:06 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26689 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYLMWCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:02:04 -0500
Received: by ey-out-2122.google.com with SMTP id 6so291801eyi.37
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Brre2E6UKZcA6esqX8oWGrUKSO6uZIUEqsFV0/A4VlM=;
        b=eLH3IH7424I3LbIbh290pBTcbHPBUaxqv3JPb1SlBvFbobIeJuyRSjZ0jTeFAR1Qm2
         2LTnwbFgTksuJQqs1oH31e6oMMCD38Fhnt/1VUfwfus17mRCorJx6tadji9Il+J6nm42
         REPfPzjvMzom8NdPK6N1geRjGM27EjoZAVQfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=DSjBQTp+J3gB8LLPqdcloiBtKjw4F/M5j9hZY3ICe2afR8xCr9w11xikGd9vUZlcUl
         VU7nlIoxiTqMNv9PrwkTvXD4+OzkUCcgBZyU9THsc+jVIs7hyMJ23qJPjScoygueYc/f
         sYXU0tNBvtMHm6pDubcsiEM09jbbVo3hKfxrI=
Received: by 10.210.139.15 with SMTP id m15mr5929612ebd.118.1229205722256;
        Sat, 13 Dec 2008 14:02:02 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id b30sm7462387ika.7.2008.12.13.14.02.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 14:02:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBDM20rs011670;
	Sat, 13 Dec 2008 23:02:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBDM1wjP011667;
	Sat, 13 Dec 2008 23:01:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1229203007.31181.6.camel@mattlaptop2.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103026>

Matt McCutchen <matt@mattmccutchen.net> writes:

Commit message, please?

> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> ---
> 
> My Web site has a single gitweb installation in which some of the
> repositories are protected by a basic authentication login.  By virtue
> of my aforementioned setup with gitweb and pulling at the same URL, the
> login applies uniformly to both.  I had to include these repositories in
> the projects_list because I use strict_export, but I want to hide them
> when the user views the project list.  This patch implements that
> feature, and the previous one fixes a bug I noticed along the way.
> 
> Matt

Cannot you do this with new $export_auth_hook gitweb configuration
variable, added by Alexander Gavrilov in 
   dd7f5f1 (gitweb: Add a per-repository authorization hook.)
It is used in check_export_ok subroutine, and is is checked also when
getting list of project from file

>From gitweb/INSTALL

  - Finally, it is possible to specify an arbitrary perl subroutine that
    will be called for each project to determine if it can be exported.
    The subroutine receives an absolute path to the project as its only
    parameter.

    For example, if you use mod_perl to run the script, and have dumb
    http protocol authentication configured for your repositories, you
    can use the following hook to allow access only if the user is
    authorized to read the files:

      $export_auth_hook = sub {
          use Apache2::SubRequest ();
          use Apache2::Const -compile => qw(HTTP_OK);
          my $path = "$_[0]/HEAD";
          my $r    = Apache2::RequestUtil->request;
          my $sub  = $r->lookup_file($path);
          return $sub->filename eq $path
              && $sub->status == Apache2::Const::HTTP_OK;
      };


>  gitweb/gitweb.perl |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

No documentation, in gitweb/README or gitweb/INSTALL

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 5357bcc..085cc60 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1144,7 +1144,7 @@ sub untabify {
>  
>  sub project_in_list {
>  	my $project = shift;
> -	# Tell git_get_projects_list to include forks.
> +	# Tell git_get_projects_list to include forks and hidden repositories.
>  	my @list = git_get_projects_list(undef, 1);
>  	return @list && scalar(grep { $_->{'path'} eq $project } @list);
>  }
> @@ -2174,15 +2174,18 @@ sub git_get_projects_list {
>  		# 'git%2Fgit.git Linus+Torvalds'
>  		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
>  		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
> +		#
> +		# 1 in the third field hides the project from user-visible lists, e.g.:
> +		# 'linux%2Fembargoed-security-fixes.git John+Doe 1'

I guess I'd rather use _last_ field, in the event we add project
description to project list file format.

>  		my %paths;
>  		open my ($fd), $projects_list or return;
>  	PROJECT:
>  		while (my $line = <$fd>) {
>  			chomp $line;
> -			my ($path, $owner) = split ' ', $line;
> +			my ($path, $owner, $hidden) = split ' ', $line;
>  			$path = unescape($path);
>  			$owner = unescape($owner);
> -			if (!defined $path) {
> +			if (!defined $path || ($hidden && !$for_strict_export)) {
>  				next;
>  			}
>  			if ($filter ne '') {
> @@ -2227,6 +2230,8 @@ sub git_get_projects_list {
>  	return @list;
>  }
>  
> +# This is used to look up the owner of a project the user is already allowed to
> +# see, so we shouldn't omit hidden repositories.
>  our $gitweb_project_owner = undef;
>  sub git_get_project_list_from_file {
>  
> @@ -2241,7 +2246,7 @@ sub git_get_project_list_from_file {
>  		open (my $fd , $projects_list);
>  		while (my $line = <$fd>) {
>  			chomp $line;
> -			my ($pr, $ow) = split ' ', $line;
> +			my ($pr, $ow, $hidden) = split ' ', $line;
>  			$pr = unescape($pr);
>  			$ow = unescape($ow);
>  			$gitweb_project_owner->{$pr} = to_utf8($ow);
> -- 
> 1.6.1.rc2.27.gc7114
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
