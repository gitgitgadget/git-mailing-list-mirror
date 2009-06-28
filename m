From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 7/9] gitweb: picon avatar provider
Date: Sun, 28 Jun 2009 13:35:38 +0200
Message-ID: <200906281335.40312.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 13:30:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKsaZ-00065R-GI
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 13:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZF1LaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 07:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbZF1LaP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 07:30:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:39358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbZF1LaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 07:30:13 -0400
Received: by fg-out-1718.google.com with SMTP id e21so733298fga.17
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zfVXsUYL5QJeTqiXaEPR+KEhF5qjFRmE+tPhFh3o738=;
        b=mSVQHXX/6eCJf8MHvzIjXVpOGZJUT86mPt+M7kvESxWcsMn+xbHrfdgyBuxhQEBAu7
         A3zX2Rj4j0OPp2Y7Gn3bQTmh1IKKXJDJIN+xYBiFUnifKW0wgo9wdiAOH+JxakTfcvRK
         xhm/hh09pM2iCQao90Ri/ELZK2dWIaUkfXGMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=w0/G+jBPvvd2Pbq6+X+5g4cZAaD9v7+L0UU1gIxxoDo4LpW+7yfWdYzbEGmLwMLQXq
         yyBSsEKHGBKwRYmCn4N77J7EtXMfHioDm9r9ZDaK6s2GtZqSbMN5yBpBHbvFmjbsZm5+
         cCR/volv+voO5VSqQKzlLwjivZZFUaKDoQuB0=
Received: by 10.86.3.5 with SMTP id 5mr1074629fgc.41.1246188613989;
        Sun, 28 Jun 2009 04:30:13 -0700 (PDT)
Received: from ?192.168.1.13? (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id l19sm10032649fgb.6.2009.06.28.04.30.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 04:30:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122398>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> Simple implementation of picon that only relies on the indiana.edu
> database.

I'd like to see where you got information about picons.  But it is
not necessary to have in commit message.

... Ah, I'm sorry, it is stated in comment.  Nevermind then.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index de4cc63..ae73d45 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -378,14 +378,17 @@ our %feature = (
>  	# shortlog or commit will display an avatar associated with
>  	# the email of the committer(s) and/or author(s).
>  
> -	# Currently only the gravatar provider is available, and it
> -	# depends on Digest::MD5.
> +	# Currently available providers are gravatar and picon.
> +
> +	# Gravatar depends on Digest::MD5.
> +	# Picon currently relies on the indiana.edu database.
>  
>  	# To enable system wide have in $GITWEB_CONFIG
> -	# $feature{'avatar'}{'default'} = ['gravatar'];
> +	# $feature{'avatar'}{'default'} = ['provider'];
> +	# where provider is either gravatar or picon.

I wonder if it wouldn't be better to use "<provider>" (or "'<provider>'")
in place of "'provider'", as it is not about literal 'provider', but 
about one of 'gravatar' or 'picon'.

>  	# To have project specific config enable override in $GITWEB_CONFIG
>  	# $feature{'avatar'}{'override'} = 1;
> -	# and in project config gitweb.avatar = gravatar;
> +	# and in project config gitweb.avatar = provider;

Same as above.

>  	'avatar' => {
>  		'sub' => \&feature_avatar,
>  		'override' => 0,
> @@ -856,6 +859,8 @@ our @snapshot_fmts = gitweb_get_feature('snapshot');
>  our ($git_avatar) = gitweb_get_feature('avatar');
>  if ($git_avatar eq 'gravatar') {
>  	$git_avatar = '' unless (eval { require Digest::MD5; 1; });
> +} elsif ($git_avatar eq 'picon') {
> +	# no dependencies
>  } else {
>  	$git_avatar = '';
>  }

Nice.

> @@ -1523,6 +1528,17 @@ sub format_subject_html {
>  # given page, there's no risk for cache conflicts.
>  our %avatar_cache = ();
>  
> +# Compute the picon url for a given email, by using the picon search service over at
> +# http://www.cs.indiana.edu/picons/search.html
> +sub picon_url {
> +	my $email = lc shift;
> +	if (!$avatar_cache{$email}) {
> +		my ($user, $domain) = split('@', $email);
> +		$avatar_cache{$email} = "http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/$domain/$user/users+domains+unknown/up/single";

Hmmm... perhaps it would be better to break this very long URL (link)
in lines...

> +	}
> +	return $avatar_cache{$email};
> +}

I wonder if it is worth caching picons, at least in this form.  It isn't
as if splitting on '@' is expensive.  But perhaps to not break pattern
(that avatar URLs are cached) it is a good thing.

Thoughts for the possible future enhancements: find final URL of an image
via http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/$domain/$user/users+domains+unknown/up/off/1/order
by scrapping (parsing) it for .gif link, and store this URL in cache.
But that most probably isn't worth it.  Just feel like mentioning it.

> +
>  # Compute the gravatar url for a given email, if it's not in the cache already.
>  # Gravatar stores only the part of the URL before the size, since that's the
>  # one computationally more expensive. This also allows reuse of the cache for
> @@ -1546,6 +1562,8 @@ sub git_get_avatar {
>  	my $url = "";
>  	if ($git_avatar eq 'gravatar') {
>  		$url = gravatar_url($email, $size);
> +	} elsif ($git_avatar eq 'picon') {
> +		$url = picon_url($email);
>  	}
>  	# Currently only gravatars are supported, but other forms such as
>  	# picons can be added by putting an else up here and defining $url

Very nice pattern, nice use of infrastructure.

I think that adding 'width' attribute to img tag of avatar should
perhaps be put here rather than in previous patch, which is about
adding gravatar URL cache.  This chunk:

         # Currently only gravatars are supported, but other forms such as
         # picons can be added by putting an else up here and defining $url
         # as needed. If no variant puts something in $url, we assume avatars
         # are completely disabled/unavailable.
         if ($url) {
 -               return $pre_white . "<img width=\"$size\" class=\"avatar\" src=\"$url\" />" . $post_white;
 +               return $pre_white .
 +                      "<img width=\"$size\" " .
 +                           "class=\"avatar\" " .
 +                           "src=\"$url\" " .
 +                      "/>" . $post_white;
         } else {
                 return "";
         }

should be, I think, in this patch and not in previous one (or at least
in some other patch than the previous one).

BTW. you should have updated the comment here.


Should it be stated that <img width="$size" ...> is here because not 
all kinds of avatars (not all avatar providers) support selecting size
of avatar, somewhere in this comment?


Very nice, well thought infrastructure, which makes adding new avatar
providers easy.  Good work!

-- 
Jakub Narebski
Poland
