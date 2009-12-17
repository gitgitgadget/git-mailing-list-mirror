From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: link to toggle 'no merges' option
Date: Thu, 17 Dec 2009 16:37:44 +0100
Message-ID: <200912171637.45810.jnareb@gmail.com>
References: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 16:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLIR4-0008Ck-3Q
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 16:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbZLQPh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 10:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbZLQPh7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 10:37:59 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44704 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965172AbZLQPh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 10:37:58 -0500
Received: by bwz27 with SMTP id 27so1574002bwz.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 07:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hRkNQK7TwkwxG2uPa8ABosZhWN8T9CQv8HDYq3UhHPs=;
        b=MqS6uPgx0y19g+0DzvMoYILXXAD1+fUscMwQL54CZ2prIECVP0vyq3UcMGr6jynPkf
         hVcIRuTS2sXyEtCkkRNwoyHXeUwwKKbbNFONzIwyVAkwHQTBgbTE5kWGeD4na4BWqeer
         5ri2VuRAM9Li4rKrDR8jPko8ziPH7nKoIIX58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YNDCJOfedF6ipOCJrqYW09la8/OjDD+UVq2EBXtWCMIR6P2eHGs7B00ga/Hsm8/wYU
         4QYfALo5La+f+2MQSB+HZVlAJkqTjI01e7miFZWxArCvKTqNTDr9OXFW9wyh+gxhLu4D
         bByO2VpLHBVhumstDbK5GpTuRr6NVXTr1U4yc=
Received: by 10.204.34.14 with SMTP id j14mr1542300bkd.76.1261064275859;
        Thu, 17 Dec 2009 07:37:55 -0800 (PST)
Received: from ?192.168.1.13? (abvp4.neoplus.adsl.tpnet.pl [83.8.213.4])
        by mx.google.com with ESMTPS id 14sm645610bwz.1.2009.12.17.07.37.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 07:37:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135374>

On Thu, 17 Dec 2009 10:05 +0100, Giuseppe Bilotta wrote:

> In views that support --no-merges, introduce a link that toggles the
> option.

I like this idea of introducing interface for so far hidden feature
(well, except hidden in one of feed <link ...> in page header).
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> 
> ---
>  gitweb/gitweb.css  |   11 +++++++++++
>  gitweb/gitweb.perl |   14 ++++++++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
> 
> This is something I've been wanting for a while. There are a number of
> things that don't 'click' with this proof of concept, and I'm coming to
> the list to hear the opinion of users and developers on how to improve
> the thing.
> 
> The patch is live at http://git.oblomov.eu/, an example affected page is
> http://git.oblomov.eu/git/shortlog

You should tell here that one must put mouse over main header (the one
with 'projects / project / action' breadcrumbs) for the new link to be
visible... because I was wondering where is this new link.

> 
> Things that are sure to change:
> 
>  * the aesthetics and location of the toggle link (it shows on mousehover
>    in the title). 

It is not only the question where to put link, but also where to put
the *code* (where the code should belong to).

At first I thought: WTF? Why the feature that deals with log-like views
is put in very generic and common for all actions/views git_header_html
subroutine?  Especially after change that made all loglike views use
common infrastructure of git_log_generic.

But then I realized that it is specific example of *generic* feature
that deals with extra_options... which admittedly is currently limited
to '--no-merges' only.  So if it is put in git_header_html, then all
views with HTML output (which does not include 'atom' and 'rss' actions,
but which actions IIRC have their own handling of '--no-merges')
which have support for extra_options would have ability to turn them
on and off.

What you need to add (if this link is to be in git_header_html) is
to create links only when $status == 200, because otherwise the link
would be present also for error pages, which I think is wrong.

>    Other options I've considered are: 
>     + next to pagination (first | prev | next), either before or after
>       the existing entries

This would fit with the fact that sometimes present "patches" link is on
the line with pagination links, after pagination links.

But this secondary navigation bar is about other views, and extra_options
is about modifying current view, and functions more like toggles.  OTOH
we have such toggle for 'blame' <-> 'blame_incremental' switch in 
secondary navigation bar.

Also this would mean that each view type would have to handle extra_options
itself, as secondary navigation bar is very much action-specific.  Not
that it matters now, with only single '--no-merges' option supported.

>     + on mouseover for the table section that refers to the (short)log;
>       this would make it possible to put it summary view too, for example

This would mean having link inside link, as those headers in summary view
functions as link to 'shortlog' view (quite useful I think), and to the
project summary in the 'shortlog' view itself (I'm not sure how useful 
that is).  We already have problems with ref markers being links inside
links and having broken layout in some strict XHTML conformance browsers.


In short: I am not sure what would be the best solution.  Nevertheless
I think that link should be more visible, and perhaps more toggle-like.

>  * if you toggle merge view when not on the first page, the reference
>    (first) commit in the view is likely to change drastically, which
>    causes confusion. I have not found a satisfactory solution for this,
>    since the obvious way to 'lock' the view (start paginating from the
>    current top commit) prevents prev/next navigation

Alternate solution would be to clean page (start from 0th page) when
changing to '--no-merges'.

You would probably need something like 'skip' option, with number of
commits, not number of pages to skip, and/or 'skip_to' which takes
commit-id.  But i have not thought about this much... 

> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 50067f2..0da6ef0 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -572,3 +572,14 @@ span.match {
>  div.binary {
>  	font-style: italic;
>  }
> +
> +span.merge_toggle a {
> +	font-size: 66%;
> +	color: white !important;
> +	font-weight: normal;
> +	vertical-align: top;
> +	text-decoration:none;
> +	visibility: hidden;
> +}

I think it should be more visible.

Otherwise only people "in the know" would be able to use this.

> +
> +*:hover > span.merge_toggle a { visibility:visible }

I'd rather not have this rule to have different style, i.e. not all
in single line.  Unless it is for RFC only...

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7e477af..a63f419 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3118,11 +3118,15 @@ sub git_header_html {
>  	my $status = shift || "200 OK";
>  	my $expires = shift;
>  
> +	my $can_have_merges = grep(/^$action$/, @{$allowed_options{'--no-merges'}});
> +	my $has_merges = !grep(/^--no-merges$/, @extra_options);
> +

Wouldn't it be better to use straight

 +	my $no_merges = grep(/^--no-merges$/, @extra_options);

Because $has_merges is true also for example for 'tree' view... which
absolutely doesn't make any sense whatsoever.


In more generic solution (which could be perhaps put in a separate commit)
it could be:

  +	my %extra_options = map { $_ => 0 } keys %$allowed_options;
  +	$extra_options{$_} = 1 foreach @extra_options;

which means that %extra_options is hash which keys are allowed options,
and which has true value for allowed option which is actually used.

Or something like that, if above is to cryptic.

>  	my $title = "$site_name";
>  	if (defined $project) {
>  		$title .= " - " . to_utf8($project);
>  		if (defined $action) {
>  			$title .= "/$action";
> +			$title .= " (no merges)" unless $has_merges;

Wouldn't it be better to use

  +			$title .= " (no merges)" if $no_merges;

More straightforward, and without misleading $has_merges.

>  			if (defined $file_name) {
>  				$title .= " - " . esc_path($file_name);
>  				if ($action eq "tree" && $file_name !~ m|/$|) {
> @@ -3235,6 +3239,16 @@ EOF
>  		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
>  		if (defined $action) {
>  			print " / $action";
> +			if ($can_have_merges) {
> +				print " <span class='merge_toggle'>";
> +				if ($has_merges) {
> +					printf('<a href="%s">hide merges</a>', href(-replay=>1, 'extra_options'=>('--no-merges', @extra_options)));

It would be more symmetric to use:

  +					my @href_extra = ('--no-merges', @extra_options);
  +					printf('<a href="%s">hide merges</a>', href(-replay=>1, 'extra_options'=>@href_extra));


> +				} else {
> +					my @href_extra = grep(!/^--no-merges$/, @extra_options);
> +					printf('<a href="%s">show merges</a>', href(-replay=>1, 'extra_options'=>@href_extra));
> +				}

and then this conditional could be simplified a bit.

> +				print "</span>";
> +			}
>  		}
>  		print "\n";
>  	}
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
