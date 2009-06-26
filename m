From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Fri, 26 Jun 2009 21:42:28 +0200
Message-ID: <200906262142.28845.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKHKH-0003ao-Nv
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761137AbZFZTm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761053AbZFZTm3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 15:42:29 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42876 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZFZTm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 15:42:28 -0400
Received: by fxm9 with SMTP id 9so2301644fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hBCGsmHAmnEy7XAdbfh68AqwCiCFeYy/601Vw/JzIns=;
        b=GpSidUUQkBnDb9/ErhNmNBg3ioyxajzNSY9P/58yBtLoe+7ZojfPhsKieKLDOF9kqn
         n7HPEyGVk+IPzaPQXn2IyrvqMtfuKadk+A0WRYflrvYdjPa5NdiYci4tO269/Mi3aS05
         R+kZmTYXtOIkD6DHPpt1MkSwu1Jw1yJyHnouw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NAIyck1hthZklRxvnG1u7ifg0YR5eML7iWUhTrzDQ3YWiXo3QEHWV0K1R/H86WKZIh
         d7jFjCvra+z8iznzDpfjTPyGfzn5bS574j7H5OkY4v4BqJiohmubQYMn+8VP7uptGcxa
         P+CZFO5YeK6I92Ga3b2SFFbM33RAo/Gf8HZxs=
Received: by 10.103.174.16 with SMTP id b16mr2504119mup.28.1246045349916;
        Fri, 26 Jun 2009 12:42:29 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id w5sm19126346mue.4.2009.06.26.12.42.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 12:42:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122317>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> Introduce avatar support: the featuer adds the appropriate img tag next
> to author and committer in commit(diff), history, shortlog and log view.

You forgot about 'tag' view (but I guess it would be done in next 
version of this patch series).

There is also 'feed' action (Atom and RSS formats), but that is certainly
separate issue, for a separate patch.

> Multiple avatar providers are possible, but only gravatar is implemented
> at the moment (and not enabled by default).
> 
> Gravatar support depends on Digest::MD5, which is a core package since
> Perl 5.8. If gravatars are activated but Digest::MD5 cannot be found,
> the feature will be automatically disabled.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Almost-Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.css  |    4 +++
>  gitweb/gitweb.perl |   67 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 67 insertions(+), 4 deletions(-)

You would _probably_ want to squash the following, just in case:

diff --git i/t/t9500-gitweb-standalone-no-errors.sh w/t/t9500-gitweb-standalone-no-errors.sh
index d539619..e8b57c5 100755
--- i/t/t9500-gitweb-standalone-no-errors.sh
+++ w/t/t9500-gitweb-standalone-no-errors.sh
@@ -660,6 +660,7 @@ cat >>gitweb_config.perl <<EOF
 
 \$feature{'blame'}{'override'} = 1;
 \$feature{'snapshot'}{'override'} = 1;
+\$feature{'avatar'}{'override'} = 1;
 EOF
 
 test_expect_success \
@@ -678,6 +679,7 @@ test_expect_success \
 	'config override: tree view, features enabled in repo config (1)' \
 	'git config gitweb.blame yes &&
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
+	 git config gitweb.avatar gravatar &&
 	 gitweb_run "p=.git;a=tree"'
 test_debug 'cat gitweb.log'
 
(this is not yet a proper solution).

But even if you don't squash it, please run t9500 with this patch
applied, to catch Perl errors and warnings.

> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 7240ed7..ad82f86 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -28,6 +28,10 @@ img.logo {
>  	border-width: 0px;
>  }
>  
> +img.avatar {
> +	vertical-align: middle;
> +}
> +

Good.  All concerns were addressed.

>  div.page_header {
>  	height: 25px;
>  	padding: 8px;
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cdfd1d5..f2e0cfe 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -195,6 +195,14 @@ our %known_snapshot_format_aliases = (
>  	'x-zip' => undef, '' => undef,
>  );
>  
> +# Pixel sizes for icons and avatars. If the default font sizes or lineheights
> +# are changed, it may be appropriate to change these values too via
> +# $GITWEB_CONFIG.
> +our %avatar_size = (
> +	'default' => 16,
> +	'double'  => 32
> +);
> +

Nice.  

>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -365,6 +373,22 @@ our %feature = (
>  		'sub' => \&feature_patches,
>  		'override' => 0,
>  		'default' => [16]},
> +
> +	# Avatar support. When this feature is enabled, views such as
> +	# shortlog or commit will display an avatar associated with
> +	# the email of the committer(s) and/or author(s).
> +
> +	# Currently only the gravatar provider is available, and it
> +	# depends on Digest::MD5.

Sidenote: Gravatar API description[1] mentions 'identicon', 'monsterid',
'wavatar'.  There are 'picons' (personal icons)[2].  Also avatars doesn't
need to be global: they can be some local static image somewhere in web
server which serves gitweb script, or they can be stored somewhere in
repository following some convention.

Current implementation is flexible enough to leave place for extending
this feature, but also doesn't try to plan too far in advance.  YAGNI
(You Ain't Gonna Need It).

[1] http://www.gravatar.com/site/implement/url
[2] http://www.cs.indiana.edu/picons/ftp/faq.html

> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'avatar'}{'default'} = ['gravatar'];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'avatar'}{'override'} = 1;
> +	# and in project config gitweb.avatar = gravatar;
> +	'avatar' => {
> +		'override' => 0,
> +		'default' => ['']},

Note that to disable feature with non-boolean 'default' we use empty
list [] (which means 'undef' when parsing, which is false); see 
description of features 'snapshot', 'actions'; 'ctags' what is strange
uses [0] here...  Using [''] is a bit strange; and does not protect
you, I think.

>  );
>  
>  sub gitweb_get_feature {
> @@ -814,6 +838,13 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# check if avatars are enabled and dependencies are satisfied
> +our ($git_avatar) = gitweb_get_feature('avatar');

IMPORTANT!!!

Because you now allow possibility that there can be other avatars
than those provided by Gravatar, you should explain in comment
what this check below does (e.g. something like "load Digest::MD5,
required for gravatar support, and disable it if it does not exist"),
so people adding (in the future) support for other kind of avatars
would know that they should put similar test there, if needed.

> +if (($git_avatar eq 'gravatar') &&
> +   !(eval { require Digest::MD5; 1; })) {
> +	$git_avatar = '';
> +}

Here you would have to protect against $git_avatar being undefined...
but you should do it anyway, as gitweb_get_feature() can return 
undef / empty list.

So either

  +our ($git_avatar) = gitweb_get_feature('avatar') || '';

or

  +if (defined $git_avatar && $git_avatar eq 'gravatar' &&
  +   !(eval { require Digest::MD5; 1; })) {
  +	$git_avatar = '';
  +}


> +
>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -1476,7 +1507,9 @@ sub format_author_html {
>  	my $tag = shift;
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> -	return "<$tag class=\"author\">" . $author . "</$tag>\n";
> +	return "<$tag class=\"author\">" .
> +	       git_get_avatar($co->{'author_email'}, 'pad_after' => 1) .
> +	       $author . "</$tag>\n";
>  }

Ah, it uses the fact that format_author_html is used in 'history' and
'shortlog' views, to format only author name for 'Author' column. 

BTW. wouldn't it be better if git_get_avatar was defined _before_ this
use?


This might be good enough starting point, but I wonder if it wouldn't
be a better solution to provide additional column with avatar image
when avatar support is enabled.  You would get a better layout in
a very rare case[3] when 'Author' column is too narrow and author is
info is wrapped:

  [#] Jonathan
  H. Random

versus in separate columns case:

  [#] | Jonathan
      | H. Random

But this is a very minor problem, which can be left for separate patch.

[3] unless you use netbook or phone to browse...

>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3224,6 +3257,29 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# Insert an avatar for the given $email at the given $size if the feature
> +# is enabled.
> +sub git_get_avatar {
> +	my ($email, %params) = @_;
> +	my $pre_white  = ($params{'pad_before'} ? "&nbsp;" : "");
> +	my $post_white = ($params{'pad_after'}  ? "&nbsp;" : "");
> +	my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};

The same comment as for first patch in series: gitweb uses 
%opts not %params, and '-size' not 'size' (CGI-like).

> +	my $url = "";
> +	if ($git_avatar eq 'gravatar') {
> +		$url = "http://www.gravatar.com/avatar.php?gravatar_id=" .
> +			Digest::MD5::md5_hex(lc $email) . "&amp;size=$size";
> +	}
> +	# Currently only gravatars are supported, but other forms such as
> +	# picons can be added by putting an else up here and defining $url
> +	# as needed. If no variant puts something in $url, we assume avatars
> +	# are completely disabled/unavailable.

Very nice solution to provide support for future alternate avatar
sources, like picons or local images (for a gitweb installation).

> +	if ($url) {
> +		return $pre_white . "<img class=\"avatar\" src=\"$url\" />" . $post_white;
> +	} else {
> +		return "";
> +	}
> +}

Nice idea.

> +
>  # Outputs the author name and date in long form
>  sub git_print_authorship {
>  	my $co = shift;
> @@ -3243,7 +3299,8 @@ sub git_print_authorship {
>  			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
>  		}
>  	}
> -	print "]</$tag>\n";
> +	print "]" . git_get_avatar($co->{'author_email'}, 'pad_before' => 1)
> +		  . "</$tag>\n";
>  }

Nice solution for 'log' and perhaps 'commitdiff' views.

>  
>  # Outputs table rows containign the full author and commiter information.
> @@ -3251,7 +3308,8 @@ sub git_print_full_authorship {
>  	my $co = shift;
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
> -	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
> +	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_avatar($co->{'author_email'}, 'size' => 'double') . "</td></tr>\n" .

Nitpick: perhaps it would be better to put git_get_avatar invocation
in separate line, to limit line length.

Minor nitpick: use ". git_get_avatar(...", i.e. space between '.' string
concatenation operator and 'git_get_avatar'.

>  	      "<tr>" .
>  	      "<td></td><td> $ad{'rfc2822'}";
>  	if ($ad{'hour_local'} < 6) {
> @@ -3263,7 +3321,8 @@ sub git_print_full_authorship {
>  	}
>  	print "</td>" .
>  	      "</tr>\n";
> -	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
> +	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td>".
> +	      "<td rowspan=\"2\">" .git_get_avatar($co->{'committer_email'}, 'size' => 'double') . "</td></tr>\n";
>  	print "<tr><td></td><td> $cd{'rfc2822'}" .
>  	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
>  	      "</td></tr>\n";

Same as above.

BTW. if you refactor printing _single_ authorship info, either into
separate subroutine or as code in (short) loop, you wouldn't have
this code repetition.  OTOH there would be also 'committing by night'
warning, like current 'coding by night' (localtime)...


Nice solution for 'commit' and with 2nd patch in series also 
'commitdiff' view.

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
