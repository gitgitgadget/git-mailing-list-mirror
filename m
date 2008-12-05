From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] gitweb: Optional grouping of projects by category
Date: Fri, 5 Dec 2008 03:08:52 +0100
Message-ID: <200812050308.52891.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <87iqq022gz.wl%seb@cine7.net> <87hc5k22dr.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-2?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Q91-0007X0-Pr
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbYLECI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 21:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYLECI4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:08:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:18422 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbYLECIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:08:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3961546ugf.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 18:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XHYoTOpAKQk9oSTGPKG7w3srJKX5gobdLpXkUjfh2hc=;
        b=GKcwnlhVfbuXSFAizFguz+s6RAEisDa75gUAIofFpqP+wB3KT5CpOc3Eb8Pxvyvcji
         FlUuC9iAUqTUMnTIZF3bdSTK9FmPH1Xf0WSSQK5UCdrPXkLsMVZBDvJqPosJbbYZmtQy
         t5kfaqo6QwtSvN0zytRNHMqJtUrALxPWtsLjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GGomMBuG67+yjmZcBMNPU2ARr5a8bohvJ93dpKbHZtK+TTPgCq9Qy7UW2twJO3nfER
         NsC8H6YScTW45vkly8VMhlb+kyIZGXWcsFOpYvvgthWLxUzEKIekgN/fH9m9czJbXLTl
         yg1yMAyli7w4fLgsB9q3sNwFAubqWEB7yIW2A=
Received: by 10.66.245.2 with SMTP id s2mr126477ugh.66.1228442933108;
        Thu, 04 Dec 2008 18:08:53 -0800 (PST)
Received: from ?192.168.1.11? (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id q40sm19981187ugc.1.2008.12.04.18.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 18:08:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87hc5k22dr.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102388>

On Thu, 4 Dec 2008, S=E9bastien Cevey wrote:

> This adds the $projects_list_group_categories option which, if enable=
d,
> will result in grouping projects by category on the project list page=
=2E
> The category is specified for each project by the $GIT_DIR/category f=
ile
> or the 'category' variable in its configuration file. By default, pro=
jects
> are put in the $project_list_default_category category.
>=20
> Note:
> - Categories are always sorted alphabetically, with projects in
>   each category sorted according to the globally selected $order.
> - When displaying a subset of all the projects (page limiting), the
>   category headers are only displayed for projects present on the pag=
e.
>=20
> The feature is inspired from Sham Chukoury's patch for the XMMS2
> gitweb, but has been rewritten for the current gitweb development
> HEAD. The CSS for categories is inspired from Gustavo Sverzut Barbier=
i's
> patch to group projects by path.
>=20
> Thanks to Florian Ragwitz for Perl tips.

Very nice, and nicely done and thought out, idea.

>=20
> Signed-off-by: Sebastien Cevey <seb@cine7.net>
> ---
>=20
> Cleaner patch this time indeed.  Still no fancy sorting of categories=
,
> only alphabetical.
>=20
>  gitweb/README      |   16 ++++++++++++
>  gitweb/gitweb.css  |    7 +++++
>  gitweb/gitweb.perl |   67 ++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>  3 files changed, 87 insertions(+), 3 deletions(-)
>=20
> diff --git a/gitweb/README b/gitweb/README
> index 825162a..f8f8872 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -188,6 +188,15 @@ not include variables usually directly set durin=
g build):
>     full description is available as 'title' attribute (usually shown=
 on
>     mouseover).  By default set to 25, which might be too small if yo=
u
>     use long project descriptions.
> + * $projects_list_group_categories
> +   Enables the grouping of projects by category on the project list =
page.
> +   The category of a project is determined by the $GIT_DIR/category
> +   file or the 'gitweb.category' variable in its repository configur=
ation.
> +   Disabled by default.
> + * $project_list_default_category
> +   Default category for projects for which none is specified.  If se=
t
> +   to the empty string, such projects will remain uncategorized and
> +   listed at the top, above categorized projects.
>   * @git_base_url_list
>     List of git base URLs used for URL to where fetch project from, s=
hown
>     in project summary page.  Full URL is "$git_base_url/$project".

Good.

> @@ -269,6 +278,13 @@ You can use the following files in repository:
>     from the template during repository creation. You can use the
>     gitweb.description repo configuration variable, but the file take=
s
>     precedence.
> + * category (or gitweb.category)
> +   Singe line category of a project, used to group projects if
> +   $projects_list_group_categories is enabled. By default (file and
> +   configuration variable absent), uncategorized projects are put in
> +   the $project_list_default_category category. You can use the
> +   gitweb.category repo configuration variable, but the file takes
> +   precedence.
>   * cloneurl (or multiple-valued gitweb.url)
>     File with repository URL (used for clone and fetch), one per line=
=2E
>     Displayed in the project summary page. You can use multiple-value=
d

Good.

> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..64f2a41 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -264,6 +264,13 @@ td.current_head {
>  	text-decoration: underline;
>  }
> =20
> +td.category {
> +	background-color: #d9d8d1;
> +	border-top: 1px solid #000000;
> +	border-left: 1px solid #000000;
> +	font-weight: bold;
> +}
> +
>  table.diff_tree span.file_status.new {
>  	color: #008000;
>  }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a6bb702..97a9b73 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -87,6 +87,14 @@ our $projects_list =3D "++GITWEB_LIST++";
>  # the width (in characters) of the projects list "Description" colum=
n
>  our $projects_list_description_width =3D 25;
> =20
> +# group projects by category on the projects list
> +# (enabled if this variable evaluates to true)
> +our $projects_list_group_categories =3D 0;
> +
> +# default category if none specified
> +# (leave the empty string for no category)
> +our $project_list_default_category =3D "";
> +
>  # default order of projects list
>  # valid values are none, project, descr, owner, and age
>  our $default_projects_order =3D "project";

Nice.

> @@ -2023,6 +2031,11 @@ sub git_get_project_description {
>  	return git_get_file_or_project_config('description', $path);
>  }
> =20
> +sub git_get_project_category {
> +	my $path =3D shift;
> +	return git_get_file_or_project_config('category', $path);
> +}
> +

Good. Nicely uses earlier patch, which adds this infrastructure.

>  sub git_get_project_ctags {
>  	my $path =3D shift;
>  	my $ctags =3D {};
> @@ -3915,8 +3928,9 @@ sub git_patchset_body {
> =20
>  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . =
=2E . .
> =20
> -# fills project list info (age, description, owner, forks) for each
> -# project in the list, removing invalid projects from returned list
> +# fills project list info (age, description, owner, category, forks)
> +# for each project in the list, removing invalid projects from
> +# returned list
>  # NOTE: modifies $projlist, but does not remove entries from it
>  sub fill_project_list_info {
>  	my ($projlist, $check_forks) =3D @_;
> @@ -3939,6 +3953,11 @@ sub fill_project_list_info {
>  		if (!defined $pr->{'owner'}) {
>  			$pr->{'owner'} =3D git_get_project_owner("$pr->{'path'}") || "";
>  		}
> +		if ($projects_list_group_categories && !defined $pr->{'category'})=
 {
> +			my $cat =3D git_get_project_category($pr->{'path'}) ||
> +			                                   $project_list_default_category=
;
> +			$pr->{'category'} =3D to_utf8($cat);
> +		}
>  		if ($check_forks) {
>  			my $pname =3D $pr->{'path'};
>  			if (($pname =3D~ s/\.git$//) &&

Nice. I see that you choose to go with $pr->{'category'} like existing
$pr->{'owner'}, rather than $pr->{'cat'} like existing $pr->{'descr'}.

> @@ -3956,6 +3975,19 @@ sub fill_project_list_info {
>  	return @projects;
>  }
> =20
> +# returns a hash of categories, containing the list of project
> +# belonging to each category
> +sub build_projlist_by_category {
> +	my $projlist =3D shift;
> +	my %categories;
> +
> +	for my $pr (@$projlist) {
> +		push @{$categories{ $pr->{'category'} }}, $pr;
> +	}
> +
> +	return %categories;
> +}

This is very nice and simple way to group by categories, and it works
quite well with sorting (assuming that @$projlist is already sorted),
but I wonder how it works with $from / $to, i.e. with selecting
projects.

> +
>  # print 'sort by' <th> element, generating 'sort by $name' replay li=
nk
>  # if that order is not selected
>  sub print_sort_th {
> @@ -4077,7 +4109,36 @@ sub git_project_list_body {
>  		      "</tr>\n";
>  	}
> =20
> -	print_project_rows(\@projects, $from, $to, $check_forks, $show_ctag=
s);
> +	if ($projects_list_group_categories) {
> +		# only display categories with projects in the $from-$to window
> +		my %categories =3D build_projlist_by_category(\@projects);

Nice... but perhaps it would be better to simply pass $from / $to to
build_projlist_by_category function, and have in %categories only
projects which are shown... well, unless filtered out in=20
print_project_rows() by $show_ctags; so I think that there is nonzero
probability of empty (no project shown) categories.

> +		foreach my $cat (sort keys %categories) {
> +			my $num_cats =3D @{$categories{$cat}};
> +
> +			# out of the window to display, done
> +			last if defined $to and $to < 0;
> +
> +			# in the window to display
> +			if (!defined $from or $from < $num_cats) {
> +				unless ($cat eq "") {
> +					print "<tr>\n";
> +					if ($check_forks) {
> +						print "<td></td>\n";
> +					}
> +					print "<td class=3D\"category\" colspan=3D\"5\">$cat</td>\n";
> +					print "</tr>\n";
> +				}
> +
> +				print_project_rows($categories{$cat}, $from, $to, $check_forks, =
$show_ctags);
> +			}
> +
> +			# adjust $from/$to offset, keep $from positive
> +			$from =3D ($from > $num_cats) ? $from - $num_cats : 0 if defined =
$from;
> +			$to -=3D $num_cats if defined $to;

I don't think that the games we play with $from / $to would be enough.
Check what happens (I think that it wouldn't work correctly) if we have
something like that:

 project | category | shown
 --------------------------
  1      | A        |
  2      | A        |
  3      | B        | Y
  4      | C        | Y
  5      | B        | Y
  6      | C        |
  7      | C        |

It means that we display for example second page in projects list.

> +		}
> +	} else {
> +		print_project_rows(\@projects, $from, $to, $check_forks, $show_cta=
gs);
> +	}

Nice.

> =20
>  	if (defined $extra) {
>  		print "<tr>\n";
> --=20
> 1.5.6.5
>=20
>=20

I'll try to examine the code in more detail later... currently I don't
know why but I can't git-am the second patch (this patch) correctly...

--=20
Jakub Nar=EAbski
Poland
