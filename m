From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Tue, 22 Jun 2010 13:11:00 +0200
Message-ID: <201006221311.05339.jnareb@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:17:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1TY-0007IJ-C0
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab0FVLRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:17:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52461 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0FVLRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:17:00 -0400
Received: by bwz7 with SMTP id 7so1352762bwz.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GM5lwM9LJ7TiQJQf9UeH6G+Bp88ODiOewXiTTzc149M=;
        b=T4pY4hf8fdprJV7SoEAcxr8H48iImZJcIYrir3fie+iDrJYyIeJnh8wcj3d+8lmZmw
         Z8xC4/VA52k9xd5TUwtqdC38L7khe7f8Tm1Qvl0i0B4f6BRl4V3jh7fxXEkwRZ2F5Tg3
         fAaMit2GAYoME78vTHjNoCzRmRhtYw157+6MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aYQRw3x2Gj363QkP0mCpZeAlc/6e5LvWLtul8EDGGroyEAl+OJkx57yPd1b91mMYrZ
         QzpxNWBFByXXc6xx42T+eF0Liag8MgvH2nOwdmcae70y6P4b0c1gAutx/O7kkGBEy7Ml
         llxLwBDS0yyGq+6aXnpu5rUOIwc33eZEVS4e4=
Received: by 10.204.83.39 with SMTP id d39mr4121984bkl.23.1277205074587;
        Tue, 22 Jun 2010 04:11:14 -0700 (PDT)
Received: from [192.168.1.15] (abvn56.neoplus.adsl.tpnet.pl [83.8.211.56])
        by mx.google.com with ESMTPS id jq1sm9879814bkb.35.2010.06.22.04.11.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 04:11:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149474>

Thank you very much for providing such detailed cover letter.  It makes
commenting on this series much easier.


On Tue, 22 June 2010 at 03:30:36 +0530, Pavan Kumar Sunkara wrote:

> The patch series is based on 'pu' branch.

You should probably say also which commit (which branch) this depends
on, rather than blanket 'pu'.

> 
> 10 patches out of the 11 patches in this patch series split gitweb into
> several small sized modules which is one of the goal of my GSoC's project.
> 
> The first patch of this patch series is for fixing esc_url function which is
> previously missed by commit 425e225.

I think it would be better to send this patch separately, standalone
(not in series), based on 'master' or even 'maint' to have it applied,
and not being held back by being in this series.  This is pure bugfix
for a (rare) bug.

> 
> The second patch is produced by my commit amend to Jakub Narebski's
> initial commit to prepare splitting of gitweb in the message-id:
> http://mid.gmane.org/1276531710-22945-4-git-send-email-jnareb@gmail.com
> 
> There is a small ammendment to that patch. 
> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(mod)'
> is changed to
> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir $(mod))';)
> because it is better if we gave 'dir $(mod)' as the target for install command
> rather than '$(mod)' because it may cause problems in the future when gitweblibdir
> is used and the modules are installed elsewhere rather than in /use/share/gitweb.

Thanks for finding it, and for improving it.

Actually, as long as we have only individual files in $(GITWEB_MODULES),
it should not matter.  The version before changes used

  install [OPTION]... SOURCE DEST

form, and after changes it uses

  install [OPTION]... SOURCE... DIRECTORY

with a single SOURCE.  So I don't think it is strictly necessary, but
it might be a good improvement anyway.
> 
> The modules created and being used by Gitweb are
> 	Gitweb::Git
> 	Gitweb::Config
> 	Gitweb::Request
> 	Gitweb::Escape
> 	Gitweb::RepoConfig
> 	Gitweb::View
> 	Gitweb::Util
> 	Gitweb::Format
> 	Gitweb::Parse

What I would like to see here is a dependency graph, i.e. which modules
include (use) which modules, and perhaps also how much this split
reduces size of main gitweb.perl file.

> 
> shortlog:
> =========

Nitpick: I would say "Table of contents", because shortlog it is not ;-)))

> 
> 1. gitweb: fix esc_url
> 
> The custom CGI escaping done in esc_url failed to escape UTF-8
> properly. Fix by using CGI::escape on each sequence of matched
> characters instead of sprintf()ing a custom escaping for each byte.
> 
> Additionally, the space -> + escape was being escaped due to greedy
> matching on the first substitution. Fix by adding space to the
> list of characters not handled on the first substitution.
> 
> Finally, remove an unnecessary escaping of the + sign.
> 
> commit 425e225 has missed fixing esc_url.

I would probably write this commit message differently, saying that
original author (Giuseppe Bilotta) fixed esc_param, but didn't finish
fixing this bug by not fixing esc_url, and that this commit finishes
it.  Probably also use "fix esc_url, use CGI::escape" in subject.
But that's me, not you.

Note: the commit is 452e225, not 425e225 !!!
                     ^^           ^^

> 
> 
> 2. gitweb: Prepare for splitting gitweb
> 
> Prepare gitweb for having been split into modules that are to be
> installed alongside gitweb in 'lib/' subdirectory, by adding
> 
>   use lib __DIR__.'/lib';
> 
> to gitweb.perl (to main gitweb script), and preparing for putting
> modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.

It makes adding modules to install very easy, isn't it?
 
> 3. gitweb: Create Gitweb::Git module
> 
> Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
> to deal with running git commands (and also processing output
> of git commands with external programs) from gitweb.

The "processing output of git commands with external programs"
looks a bit strange to me.  If it is about quote_command()
subroutine, it is more about shell escaping of commands, or
about running other programs... but it might be O.K., if what
you want to say that quote_command() is used in pipe-ing output
of git commands (e.g. git-archive) to other programs (e.g. gzip).

So take the above comment with a bit of salt...

> 
> This module is intended as standalone module, which does not require
> (include) other gitweb' modules to avoid circular dependencies.  That
> is why it includes $GIT variable, even though this variable is
> configured during building gitweb.  On the other hand $GIT is more
> about git configuration, than gitweb configuration.
> 
> Subroutines moved:
> 	evaluate_git_version
> 	git_cmd
> 	quote_command
> 
> Update gitweb/Makefile to install Gitweb::Git module alongside gitweb

O.K.

> 4. gitweb: Create Gitweb::Config module
> 
> Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
> to store all the configuration variables and subroutines
> regarding the gitweb.perl script.
> 
> This module depends only on $git_dir from Gitweb::Git and
> includes most of the configuration related variables and
> subroutines (Including those required for configuration
> of gitweb features).

"Most" meaning what?  Which subroutines weren't moved, and why (they
should not be in Gitweb::Config, they cannot be moved for technical
reasons)?

> 
> Subroutines moved:
> 	evaluate_gitweb_config
> 	configure_gitweb_features

I'm not sure if configure_gitweb_features() should be there, as it
is run-once subroutine, about flow of the main program... but perhaps
it is O.K. to have it here.

> 	filter_snapshot_fmts
> 	gitweb_get_feature
> 	gitweb_check_feature
> 
> Update gitweb/Makefile to install Gitweb::Config module alongside gitweb

O.K.

> 5. gitweb: Create Gitweb::Request module
> 
> Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
> to store and handle all the cgi params and related variables
> regarding the gitweb.perl script.
> 
> This module is intended as standalone module, which does not require
> (include) other gitweb' modules to avoid circular dependencies.
> 
> validate_project and validate_action can't be included in this
> module due to unmet dependencies.

What unment dependencies?  Can it be worked around by changing their
signatures to use additional parameters, e.g.:

  sub validate_action {
  	my $input = shift || return undef;
  	my $actions = shift || return undef;
  
  	return undef unless exists $actions->{$input};
  	return $input;
  }

But I guess it would be very hard to do the same with validate_project.
Also such change might be out of scope for _this_ series.

> 
> Subroutines moved:
> 	evaluate_uri
> 	evaluate_query_params
> 	validate_pathname
> 	validate_refname

I'm not completly sure if validate_* subroutines should be not separate,
as they do require more knowledge about setup, and about git repositories
served, than the rest of Gitweb::Request subroutines...

> 
> Update gitweb/Makefile to install Gitweb::Request module alongside gitweb

O.K.

> 6. gitweb: Create Gitweb::Escape module
> 
> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
> to store all the quoting/unquoting and escaping subroutines
> regarding the gitweb.perl script.
> 
> This module imports $fallback_encoding variable from
> Gitweb::Config module to use it in sub 'to_utf8'
> 
> Subroutines moved:
> 	to_utf8
> 	esc_param
> 	esc_url
> 	esc_html
> 	esc_path
> 	quot_cec
> 	quot_upr

O.K.

> 	unquote

Shouldn't unquote be in Gitweb::Parse, as contrary to the rest of 
subroutines is is not about gitweb output escaping/quoting, but
about processing (parsing) output of git commands?  Perhaps it
could even be provate to Gitweb::Parse (i.e. not exported by
default)...

> 	untabify
> 
> Update gitweb/Makefile to install Gitweb::Escape module alongside gitweb
> 
> 
> 7. gitweb: Create Gitweb::RepoConfig module
> 
> Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.pm'
> to store and handle all the configuration and subroutines
> related to a single repository regarding the gitweb.perl script.
> 
> This module depend on several other modules like Git.pm,
> Config.pm, Request.pm and Escape.pm.
> 
> It also include subroutines regarding project_list and
> it's handling.

Why?  Is it to not have too many tiny modules, or is simply there no
single good place where to put this subroutine?

> 
> Subroutines moved:
> 	check_head_link
> 	check_export_ok

O.K.

> 	hash_set_multi
> 	config_to_bool
> 	config_to_int
> 	config_to_multi
> 	git_parse_project_config

Hmmm... I think that in the future all the subroutines dealing with
reading of gitweb config and making its values available should be
encapsulated in a separate module... Git::Config perhaps?

But I guess that is for the future commit.

> 	git_get_project_config
> 	git_get_project_description
> 	git_get_project_ctags
> 	git_populate_project_tagcloud
> 	git_show_project_tagcloud
> 	git_get_project_url_list
> 	git_get_projects_list
> 	git_get_project_list_from_file
> 	git_get_project_owner
> 	get_file_owner

O.K.

> 	project_in_list

Hmmm...

> 
> Update gitweb/Makefile to install Gitweb::RepoConfig module
> alongside gitweb
> 
> 
> 8. gitweb: Create Gitweb::View module
> 
> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
> to store the subroutines related to the HTML output
> for gitweb.

I find that this module looks a bit like a collection of fairly unrelated
subroutines at very different levels of abstractions.  

I guess that you don't want to split gitweb into too many modules,
and splitting gitweb is more of one of steps to final goal of adding
write functionality to gitweb, rather than the goal in and of itself.
Nevertheless it would be good to be able to immediately know from the
description of module what kind of subroutines should be there.

> 
> This module depends on Git.pm, Config.pm, Request.pm,
> Escape.pm and RepoConfig.pm. Some subroutines which
> output HTML but are not included in this module due
> to unmet dependencies.

Which subroutines and what unmet dependencies?

> 
> Subroutines moved:

Perhaps this list should be grouped in categories, either by separating
groups with empty line, or by putting '*' before first subroutine in
group, as shown in example below: 

> 	href

Hmmm... that's the opposte side of Gitweb::Request, crating rather than
parsing gitweb links...

> 	get_feed_info

To be passed to href(); I think it is the only one.

> 	chop_str
> 	chop_and_escape_str

Those are pure utility functions.

>     * age_class
>       age_string

Those are about coloring based on relative time and (age_string - not
a great name) generating relative time ("nn units ago").

>     * print_local_time
>       format_local_time

Shouldn't this be in Gitweb::Format?  If not, why?

>     * S_ISGITLINK
> 	mode_str
> 	file_type
> 	file_type_long

Those are all about types of files from git-ls-tree and friends, but
with single exception of S_ISGITLINK they are about gitweb output side.

> 	get_page_title
> 	git_header_html
> 	git_footer_html
> 	die_error

Main parts of page.

>     * git_print_page_nav
> 	format_paging_nav
> 	git_print_header_div
> 	git_print_page_path

Fragments of page (used in most of views).  This decidely belong to
Gitweb::View.

>     * insert_file

More of utility function.

>     * git_get_link_target
> 	normalize_link_target
> 	git_print_tree_entry

Should it be here?  The *_body subroutines aren't there in Gitweb::View.
The *_link_target are utility subroutines for git_print_tree_entry.

> 	print_sort_th
> 	format_sort_th

Hmmm...

> 
> Update 'gitweb/Makefile' to install Gitweb::View alongside gitweb.

I have my doubts...

> 9. gitweb: Create Gitweb::Util module
> 
> Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
> to store the git utility subroutines related to gitweb.
> 
> This module include subroutines in various categories
> such as git utility subs invoking git commands, git
> utility subs accessing git repository, mimetype related
> subs and HTML output utility subs.
> 
> Subroutines moved:
> 	git_get_head_hash
> 	git_get_full_hash
> 	git_get_short_hash
> 	git_get_hash
> 	git_get_type
> 	git_get_hash_by_path
> 	git_get_path_by_hash
> 	git_get_last_activity
> 	git_get_references
> 	git_get_rev_name_tags
> 	git_get_heads_list
> 	git_get_tags_list
> 	mimetype_guess_file
> 	mimetype_guess
> 	blob_mimetype
> 	blob_contenttype
> 	guess_file_syntax
> 	fill_from_file_info
> 	is_deleted
> 	is_patch_split

O.K.

> 	run_highlighter

_Perhaps_ with exception of this subroutine.

> 
> Update 'gitweb/Makefile' to install Gitweb::Util alongside gitweb.
> 
> 
> 10. gitweb: Create Gitweb::Format module
> 
> Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
> to store the subroutines related to formatting of HTML
> fragments required for gitweb.
> 
> This module depends on Config.pm, View.pm, Escape.pm,
> Util.pm and Request.pm. It mainly contain functions returning
> short HTML fragments or transforming HTML fragments. Also
> include subroutines regarding avatar formatting.

Why it depends on Gitweb::View, and not the reverse?  I understand why
it depends on Gitweb::Config and Gitweb::Escape, and I guess it needs
$cgi from Gitweb::Request (or is it something more?).

> 
> Subroutines moved:
> 	format_log_line_html
> 	format_ref_marker
> 	format_subject_html
> 	picon_url
> 	gravatar_url
> 	git_get_avatar
> 	format_search_author
> 	format_author_html
> 	format_git_diff_header_line
> 	format_extended_diff_header_line
> 	format_diff_from_to_header
> 	format_diff_cc_simplified
> 	format_diff_line
> 	format_snapshot_links

O.K., I think.

> 
> Update 'gitweb/Makefile' to install Gitweb::Format alongside gitweb.
> 
> 
> 11. gitweb: Create Gitweb::Parse module
> 
> Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
> to store the subroutines which related to parsing functions
> required for gitweb.
> 
> This module depends on Git.pm, Escape.pm, View.pm and Util.pm.

Why it depends on Gitweb::View?  It is a strange dependency.
I understand depending on Gitweb::Git to some extent, I'm not sure
if we shouldn't simply move unescape to it instead of requiring
Gitweb::Escape (unless there is more: to_utf8 perhaps?), and
I understand that Gitweb::Util has some required subroutines.

> 
> Subroutines moved:
> 	parse_date
> 	parse_tag
> 	parse_commit_text
> 	parse_commit
> 	parse_commits
> 	parse_difftree_raw_line
> 	parsed_difftree_line
> 	parse_ls_tree_line
> 	parse_from_to_diffinfo

O.K.

> 
> Update 'gitweb/Makefile' to install Gitweb::Parse alongside gitweb.
> 
> 
> Pavan Kumar Sunkara (11):
>   gitweb: fix esc_url
>   gitweb: Prepare for splitting gitweb
>   gitweb: Create Gitweb::Git module
>   gitweb: Create Gitweb::Config module
>   gitweb: Create Gitweb::Request module
>   gitweb: Create Gitweb::Escape module
>   gitweb: Create Gitweb::RepoConfig module
>   gitweb: Create Gitweb::View module
>   gitweb: Create Gitweb::Util module
>   gitweb: Create Gitweb::Format module
>   gitweb: Create Gitweb::Parse module
> 
>  gitweb/Makefile                 |   14 +
>  gitweb/gitweb.perl              | 3855 +++------------------------------------

Nice!

>  gitweb/lib/Gitweb/Config.pm     |  498 +++++
>  gitweb/lib/Gitweb/Escape.pm     |  175 ++
>  gitweb/lib/Gitweb/Format.pm     |  537 ++++++
>  gitweb/lib/Gitweb/Git.pm        |   48 +
>  gitweb/lib/Gitweb/Parse.pm      |  378 ++++
>  gitweb/lib/Gitweb/RepoConfig.pm |  424 +++++
>  gitweb/lib/Gitweb/Request.pm    |  153 ++
>  gitweb/lib/Gitweb/Util.pm       |  447 +++++
>  gitweb/lib/Gitweb/View.pm       | 1022 +++++++++++
>  11 files changed, 3909 insertions(+), 3642 deletions(-)
>  create mode 100644 gitweb/lib/Gitweb/Config.pm
>  create mode 100644 gitweb/lib/Gitweb/Escape.pm
>  create mode 100644 gitweb/lib/Gitweb/Format.pm
>  create mode 100644 gitweb/lib/Gitweb/Git.pm
>  create mode 100644 gitweb/lib/Gitweb/Parse.pm
>  create mode 100644 gitweb/lib/Gitweb/RepoConfig.pm
>  create mode 100644 gitweb/lib/Gitweb/Request.pm
>  create mode 100644 gitweb/lib/Gitweb/Util.pm
>  create mode 100644 gitweb/lib/Gitweb/View.pm

Keep up good work!

-- 
Jakub Narebski
Poland
