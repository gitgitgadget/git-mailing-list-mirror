From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Wed, 23 Jun 2010 00:04:02 +0530
Message-ID: <AANLkTim2qOENdcyjbYF8NNmEfMJ-ijhwQY-Pf46JWuiO@mail.gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
	<201006221311.05339.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 22 20:34:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR8IX-0003Xe-Uw
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 20:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab0FVSeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jun 2010 14:34:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50460 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0FVSeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 14:34:03 -0400
Received: by gwaa12 with SMTP id a12so1188335gwa.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G4qaCFli4fY2LzfG7Cn6iD3btSPSrq1z+tyZ3F7a5cw=;
        b=EXrBFPCAVglPOom3knXQwEs9ItR9EgqswPhiLH/gnaGg3PxzxsCqRcCXGIpwId5pJ9
         r4zbAnU4loNWMBgFFAAklcwWtbo49hoNXCVzFvwm50hxt4QuhclSNegmf3STru1sM/+T
         U3aNBtSSiB4SayowS8Z8Opy5izqk/CGBL+PIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tFTDU9Uiom4CSVcTYJAy3p4aadwTlRE5Q5DujvPDOWqe3tgbI5B1MRP5VwKH+lhd/b
         G8cBvXvv6+zy/YVSEwglngEGyUtUEeUq4Q/SVFrrFiErND3JBoo3vimNUWKWUYn5zog/
         hhTuNbd7XzzC2PLiUKpn9Lo4b8WsgsBnWKQMM=
Received: by 10.101.130.40 with SMTP id h40mr5604129ann.45.1277231642318; Tue, 
	22 Jun 2010 11:34:02 -0700 (PDT)
Received: by 10.100.141.14 with HTTP; Tue, 22 Jun 2010 11:34:02 -0700 (PDT)
In-Reply-To: <201006221311.05339.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149487>

2010/6/22 Jakub Narebski <jnareb@gmail.com>:
> Thank you very much for providing such detailed cover letter. =A0It m=
akes
> commenting on this series much easier.
>
>
> On Tue, 22 June 2010 at 03:30:36 +0530, Pavan Kumar Sunkara wrote:
>
>> The patch series is based on 'pu' branch.
>
> You should probably say also which commit (which branch) this depends
> on, rather than blanket 'pu'.
>
>>
>> 10 patches out of the 11 patches in this patch series split gitweb i=
nto
>> several small sized modules which is one of the goal of my GSoC's pr=
oject.
>>
>> The first patch of this patch series is for fixing esc_url function =
which is
>> previously missed by commit 425e225.
>
> I think it would be better to send this patch separately, standalone
> (not in series), based on 'master' or even 'maint' to have it applied=
,
> and not being held back by being in this series. =A0This is pure bugf=
ix
> for a (rare) bug.
>
>>
>> The second patch is produced by my commit amend to Jakub Narebski's
>> initial commit to prepare splitting of gitweb in the message-id:
>> http://mid.gmane.org/1276531710-22945-4-git-send-email-jnareb@gmail.=
com
>>
>> There is a small ammendment to that patch.
>> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(mod)'
>> is changed to
>> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir $(mod))=
';)
>> because it is better if we gave 'dir $(mod)' as the target for insta=
ll command
>> rather than '$(mod)' because it may cause problems in the future whe=
n gitweblibdir
>> is used and the modules are installed elsewhere rather than in /use/=
share/gitweb.
>
> Thanks for finding it, and for improving it.
>
> Actually, as long as we have only individual files in $(GITWEB_MODULE=
S),
> it should not matter. =A0The version before changes used
>
> =A0install [OPTION]... SOURCE DEST
>
> form, and after changes it uses
>
> =A0install [OPTION]... SOURCE... DIRECTORY
>
> with a single SOURCE. =A0So I don't think it is strictly necessary, b=
ut
> it might be a good improvement anyway.

Thanks.

>>
>> The modules created and being used by Gitweb are
>> =A0 =A0 =A0 Gitweb::Git
>> =A0 =A0 =A0 Gitweb::Config
>> =A0 =A0 =A0 Gitweb::Request
>> =A0 =A0 =A0 Gitweb::Escape
>> =A0 =A0 =A0 Gitweb::RepoConfig
>> =A0 =A0 =A0 Gitweb::View
>> =A0 =A0 =A0 Gitweb::Util
>> =A0 =A0 =A0 Gitweb::Format
>> =A0 =A0 =A0 Gitweb::Parse
>
> What I would like to see here is a dependency graph, i.e. which modul=
es
> include (use) which modules, and perhaps also how much this split
> reduces size of main gitweb.perl file.

The dependency is written in individual commits.

>>
>> shortlog:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Nitpick: I would say "Table of contents", because shortlog it is not =
;-)))
>
>>
>> 1. gitweb: fix esc_url
>>
>> The custom CGI escaping done in esc_url failed to escape UTF-8
>> properly. Fix by using CGI::escape on each sequence of matched
>> characters instead of sprintf()ing a custom escaping for each byte.
>>
>> Additionally, the space -> + escape was being escaped due to greedy
>> matching on the first substitution. Fix by adding space to the
>> list of characters not handled on the first substitution.
>>
>> Finally, remove an unnecessary escaping of the + sign.
>>
>> commit 425e225 has missed fixing esc_url.
>
> I would probably write this commit message differently, saying that
> original author (Giuseppe Bilotta) fixed esc_param, but didn't finish
> fixing this bug by not fixing esc_url, and that this commit finishes
> it. =A0Probably also use "fix esc_url, use CGI::escape" in subject.
> But that's me, not you.
>
> Note: the commit is 452e225, not 425e225 !!!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^ =A0 =A0 =A0 =A0 =A0 ^^

ok.

>>
>>
>> 2. gitweb: Prepare for splitting gitweb
>>
>> Prepare gitweb for having been split into modules that are to be
>> installed alongside gitweb in 'lib/' subdirectory, by adding
>>
>> =A0 use lib __DIR__.'/lib';
>>
>> to gitweb.perl (to main gitweb script), and preparing for putting
>> modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.
>
> It makes adding modules to install very easy, isn't it?
yes.

>> 3. gitweb: Create Gitweb::Git module
>>
>> Create a Gitweb::Git module in =A0'gitweb/lib/Gitweb/Git.pm'
>> to deal with running git commands (and also processing output
>> of git commands with external programs) from gitweb.
>
> The "processing output of git commands with external programs"
> looks a bit strange to me. =A0If it is about quote_command()
> subroutine, it is more about shell escaping of commands, or
> about running other programs... but it might be O.K., if what
> you want to say that quote_command() is used in pipe-ing output
> of git commands (e.g. git-archive) to other programs (e.g. gzip).
>
> So take the above comment with a bit of salt...

actually that message has been written by you itself in one of the
earlier threads.

>>
>> This module is intended as standalone module, which does n>ot requir=
e
>> (include) other gitweb' modules to avoid circular dependencies. =A0T=
hat
>> is why it includes $GIT variable, even though this variable is
>> configured during building gitweb. =A0On the other hand $GIT is more
>> about git configuration, than gitweb configuration.
>>
>> Subroutines moved:
>> =A0 =A0 =A0 evaluate_git_version
>> =A0 =A0 =A0 git_cmd
>> =A0 =A0 =A0 quote_command
>>
>> Update gitweb/Makefile to install Gitweb::Git module alongside gitwe=
b
>
> O.K.
>
>> 4. gitweb: Create Gitweb::Config module
>>
>> Create Gitweb::Config module in 'gitweb/lib/Gitweb/Config.pm'
>> to store all the configuration variables and subroutines
>> regarding the gitweb.perl script.
>>
>> This module depends only on $git_dir from Gitweb::Git and
>> includes most of the configuration related variables and
>> subroutines (Including those required for configuration
>> of gitweb features).
>
> "Most" meaning what? =A0Which subroutines weren't moved, and why (the=
y
> should not be in Gitweb::Config, they cannot be moved for technical
> reasons)?

Yes, due to either unment dependency or circular dependency problem.
But no need to worry as they are very small.

>>
>> Subroutines moved:
>> =A0 =A0 =A0 evaluate_gitweb_config
>> =A0 =A0 =A0 configure_gitweb_features
>
> I'm not sure if configure_gitweb_features() should be there, as it
> is run-once subroutine, about flow of the main program... but perhaps
> it is O.K. to have it here.

That's what I thought.

>> =A0 =A0 =A0 filter_snapshot_fmts
>> =A0 =A0 =A0 gitweb_get_feature
>> =A0 =A0 =A0 gitweb_check_feature
>>
>> Update gitweb/Makefile to install Gitweb::Config module alongside gi=
tweb
>
> O.K.
>
>> 5. gitweb: Create Gitweb::Request module
>>
>> Create a Gitweb::Request module in 'gitweb/lib/Gitweb/Request.pm'
>> to store and handle all the cgi params and related variables
>> regarding the gitweb.perl script.
>>
>> This module is intended as standalone module, which does not require
>> (include) other gitweb' modules to avoid circular dependencies.
>>
>> validate_project and validate_action can't be included in this
>> module due to unmet dependencies.
>
> What unment dependencies? =A0Can it be worked around by changing thei=
r
> signatures to use additional parameters, e.g.:
>
> =A0sub validate_action {
> =A0 =A0 =A0 =A0my $input =3D shift || return undef;
> =A0 =A0 =A0 =A0my $actions =3D shift || return undef;
>
> =A0 =A0 =A0 =A0return undef unless exists $actions->{$input};
> =A0 =A0 =A0 =A0return $input;
> =A0}
>

Yes. I think we can but don't you think that we need to import
$actions everytime we use validate_action.
So, I figured it would be better If i leave it untouched for now.

> But I guess it would be very hard to do the same with validate_projec=
t.
> Also such change might be out of scope for _this_ series.
>
>>
>> Subroutines moved:
>> =A0 =A0 =A0 evaluate_uri
>> =A0 =A0 =A0 evaluate_query_params
>> =A0 =A0 =A0 validate_pathname
>> =A0 =A0 =A0 validate_refname
>
> I'm not completly sure if validate_* subroutines should be not separa=
te,
> as they do require more knowledge about setup, and about git reposito=
ries
> served, than the rest of Gitweb::Request subroutines...

But they are being used in Gitweb::Request subroutines, so I included
them in there.

>>
>> Update gitweb/Makefile to install Gitweb::Request module alongside g=
itweb
>
> O.K.
>
>> 6. gitweb: Create Gitweb::Escape module
>>
>> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
>> to store all the quoting/unquoting and escaping subroutines
>> regarding the gitweb.perl script.
>>
>> This module imports $fallback_encoding variable from
>> Gitweb::Config module to use it in sub 'to_utf8'
>>
>> Subroutines moved:
>> =A0 =A0 =A0 to_utf8
>> =A0 =A0 =A0 esc_param
>> =A0 =A0 =A0 esc_url
>> =A0 =A0 =A0 esc_html
>> =A0 =A0 =A0 esc_path
>> =A0 =A0 =A0 quot_cec
>> =A0 =A0 =A0 quot_upr
>
> O.K.
>
>> =A0 =A0 =A0 unquote
>
> Shouldn't unquote be in Gitweb::Parse, as contrary to the rest of
> subroutines is is not about gitweb output escaping/quoting, but
> about processing (parsing) output of git commands? =A0Perhaps it
> could even be provate to Gitweb::Parse (i.e. not exported by
> default)...

It would result in circular dependency. So, Escape module is best for
it's place.

>> =A0 =A0 =A0 untabify
>>
>> Update gitweb/Makefile to install Gitweb::Escape module alongside gi=
tweb
>>
>>
>> 7. gitweb: Create Gitweb::RepoConfig module
>>
>> Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.=
pm'
>> to store and handle all the configuration and subroutines
>> related to a single repository regarding the gitweb.perl script.
>>
>> This module depend on several other modules like Git.pm,
>> Config.pm, Request.pm and Escape.pm.
>>
>> It also include subroutines regarding project_list and
>> it's handling.
>
> Why? =A0Is it to not have too many tiny modules, or is simply there n=
o
> single good place where to put this subroutine?

There is no single good place. Anyhow, as they are regarding project
configuration, I thought it would be better place for it.

>>
>> Subroutines moved:
>> =A0 =A0 =A0 check_head_link
>> =A0 =A0 =A0 check_export_ok
>
> O.K.
>
>> =A0 =A0 =A0 hash_set_multi
>> =A0 =A0 =A0 config_to_bool
>> =A0 =A0 =A0 config_to_int
>> =A0 =A0 =A0 config_to_multi
>> =A0 =A0 =A0 git_parse_project_config
>
> Hmmm... I think that in the future all the subroutines dealing with
> reading of gitweb config and making its values available should be
> encapsulated in a separate module... Git::Config perhaps?
>
> But I guess that is for the future commit.
>
>> =A0 =A0 =A0 git_get_project_config
>> =A0 =A0 =A0 git_get_project_description
>> =A0 =A0 =A0 git_get_project_ctags
>> =A0 =A0 =A0 git_populate_project_tagcloud
>> =A0 =A0 =A0 git_show_project_tagcloud
>> =A0 =A0 =A0 git_get_project_url_list
>> =A0 =A0 =A0 git_get_projects_list
>> =A0 =A0 =A0 git_get_project_list_from_file
>> =A0 =A0 =A0 git_get_project_owner
>> =A0 =A0 =A0 get_file_owner
>
> O.K.
>
>> =A0 =A0 =A0 project_in_list
>
> Hmmm...
>
>>
>> Update gitweb/Makefile to install Gitweb::RepoConfig module
>> alongside gitweb
>>
>>
>> 8. gitweb: Create Gitweb::View module
>>
>> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
>> to store the subroutines related to the HTML output
>> for gitweb.
>
> I find that this module looks a bit like a collection of fairly unrel=
ated
> subroutines at very different levels of abstractions.
>
> I guess that you don't want to split gitweb into too many modules,
> and splitting gitweb is more of one of steps to final goal of adding
> write functionality to gitweb, rather than the goal in and of itself.
> Nevertheless it would be good to be able to immediately know from the
> description of module what kind of subroutines should be there.
>
>>
>> This module depends on Git.pm, Config.pm, Request.pm,
>> Escape.pm and RepoConfig.pm. Some subroutines which
>> output HTML but are not included in this module due
>> to unmet dependencies.
>
> Which subroutines and what unmet dependencies?

action specific HTML divs. They include format_* and parse_* subs.

>>
>> Subroutines moved:
>
> Perhaps this list should be grouped in categories, either by separati=
ng
> groups with empty line, or by putting '*' before first subroutine in
> group, as shown in example below:
>
>> =A0 =A0 =A0 href
>
> Hmmm... that's the opposte side of Gitweb::Request, crating rather th=
an
> parsing gitweb links...
>
>> =A0 =A0 =A0 get_feed_info
>
> To be passed to href(); I think it is the only one.
>
>> =A0 =A0 =A0 chop_str
>> =A0 =A0 =A0 chop_and_escape_str
>
> Those are pure utility functions.
>
>> =A0 =A0 * age_class
>> =A0 =A0 =A0 age_string
>
> Those are about coloring based on relative time and (age_string - not
> a great name) generating relative time ("nn units ago").
>
>> =A0 =A0 * print_local_time
>> =A0 =A0 =A0 format_local_time
>
> Shouldn't this be in Gitweb::Format? =A0If not, why?
>
>> =A0 =A0 * S_ISGITLINK
>> =A0 =A0 =A0 mode_str
>> =A0 =A0 =A0 file_type
>> =A0 =A0 =A0 file_type_long
>
> Those are all about types of files from git-ls-tree and friends, but
> with single exception of S_ISGITLINK they are about gitweb output sid=
e.
>
>> =A0 =A0 =A0 get_page_title
>> =A0 =A0 =A0 git_header_html
>> =A0 =A0 =A0 git_footer_html
>> =A0 =A0 =A0 die_error
>
> Main parts of page.
>
>> =A0 =A0 * git_print_page_nav
>> =A0 =A0 =A0 format_paging_nav
>> =A0 =A0 =A0 git_print_header_div
>> =A0 =A0 =A0 git_print_page_path
>
> Fragments of page (used in most of views). =A0This decidely belong to
> Gitweb::View.
>
>> =A0 =A0 * insert_file
>
> More of utility function.
>
>> =A0 =A0 * git_get_link_target
>> =A0 =A0 =A0 normalize_link_target
>> =A0 =A0 =A0 git_print_tree_entry
>
> Should it be here? =A0The *_body subroutines aren't there in Gitweb::=
View.
> The *_link_target are utility subroutines for git_print_tree_entry.
>
>> =A0 =A0 =A0 print_sort_th
>> =A0 =A0 =A0 format_sort_th
>
> Hmmm...

Ok.

>>
>> Update 'gitweb/Makefile' to install Gitweb::View alongside gitweb.
>
> I have my doubts...
>
>> 9. gitweb: Create Gitweb::Util module
>>
>> Create Gitweb::Util module in 'gitweb/lib/Gitweb/Util.pm'
>> to store the git utility subroutines related to gitweb.
>>
>> This module include subroutines in various categories
>> such as git utility subs invoking git commands, git
>> utility subs accessing git repository, mimetype related
>> subs and HTML output utility subs.
>>
>> Subroutines moved:
>> =A0 =A0 =A0 git_get_head_hash
>> =A0 =A0 =A0 git_get_full_hash
>> =A0 =A0 =A0 git_get_short_hash
>> =A0 =A0 =A0 git_get_hash
>> =A0 =A0 =A0 git_get_type
>> =A0 =A0 =A0 git_get_hash_by_path
>> =A0 =A0 =A0 git_get_path_by_hash
>> =A0 =A0 =A0 git_get_last_activity
>> =A0 =A0 =A0 git_get_references
>> =A0 =A0 =A0 git_get_rev_name_tags
>> =A0 =A0 =A0 git_get_heads_list
>> =A0 =A0 =A0 git_get_tags_list
>> =A0 =A0 =A0 mimetype_guess_file
>> =A0 =A0 =A0 mimetype_guess
>> =A0 =A0 =A0 blob_mimetype
>> =A0 =A0 =A0 blob_contenttype
>> =A0 =A0 =A0 guess_file_syntax
>> =A0 =A0 =A0 fill_from_file_info
>> =A0 =A0 =A0 is_deleted
>> =A0 =A0 =A0 is_patch_split
>
> O.K.
>
>> =A0 =A0 =A0 run_highlighter
>
> _Perhaps_ with exception of this subroutine.

Well. It was in the utility category in gitweb.perl script. So, I
added it in here without giving much thought.

>>
>> Update 'gitweb/Makefile' to install Gitweb::Util alongside gitweb.
>>
>>
>> 10. gitweb: Create Gitweb::Format module
>>
>> Create Gitweb::Format module in 'gitweb/lib/Gitweb/Format.pm'
>> to store the subroutines related to formatting of HTML
>> fragments required for gitweb.
>>
>> This module depends on Config.pm, View.pm, Escape.pm,
>> Util.pm and Request.pm. It mainly contain functions returning
>> short HTML fragments or transforming HTML fragments. Also
>> include subroutines regarding avatar formatting.
>
> Why it depends on Gitweb::View, and not the reverse? =A0I understand =
why
> it depends on Gitweb::Config and Gitweb::Escape, and I guess it needs
> $cgi from Gitweb::Request (or is it something more?).

$hash, $hash_parent also.

>>
>> Subroutines moved:
>> =A0 =A0 =A0 format_log_line_html
>> =A0 =A0 =A0 format_ref_marker
>> =A0 =A0 =A0 format_subject_html
>> =A0 =A0 =A0 picon_url
>> =A0 =A0 =A0 gravatar_url
>> =A0 =A0 =A0 git_get_avatar
>> =A0 =A0 =A0 format_search_author
>> =A0 =A0 =A0 format_author_html
>> =A0 =A0 =A0 format_git_diff_header_line
>> =A0 =A0 =A0 format_extended_diff_header_line
>> =A0 =A0 =A0 format_diff_from_to_header
>> =A0 =A0 =A0 format_diff_cc_simplified
>> =A0 =A0 =A0 format_diff_line
>> =A0 =A0 =A0 format_snapshot_links
>
> O.K., I think.
>
>>
>> Update 'gitweb/Makefile' to install Gitweb::Format alongside gitweb.
>>
>>
>> 11. gitweb: Create Gitweb::Parse module
>>
>> Create Gitweb::Parse module in 'gitweb/lib/Gitweb/Parse.pm'
>> to store the subroutines which related to parsing functions
>> required for gitweb.
>>
>> This module depends on Git.pm, Escape.pm, View.pm and Util.pm.
>
> Why it depends on Gitweb::View? =A0It is a strange dependency.
> I understand depending on Gitweb::Git to some extent, I'm not sure
> if we shouldn't simply move unescape to it instead of requiring
> Gitweb::Escape (unless there is more: to_utf8 perhaps?), and
> I understand that Gitweb::Util has some required subroutines.

for die_error.

>>
>> Subroutines moved:
>> =A0 =A0 =A0 parse_date
>> =A0 =A0 =A0 parse_tag
>> =A0 =A0 =A0 parse_commit_text
>> =A0 =A0 =A0 parse_commit
>> =A0 =A0 =A0 parse_commits
>> =A0 =A0 =A0 parse_difftree_raw_line
>> =A0 =A0 =A0 parsed_difftree_line
>> =A0 =A0 =A0 parse_ls_tree_line
>> =A0 =A0 =A0 parse_from_to_diffinfo
>
> O.K.
>
>>
>> Update 'gitweb/Makefile' to install Gitweb::Parse alongside gitweb.
>>
>>
>> Pavan Kumar Sunkara (11):
>> =A0 gitweb: fix esc_url
>> =A0 gitweb: Prepare for splitting gitweb
>> =A0 gitweb: Create Gitweb::Git module
>> =A0 gitweb: Create Gitweb::Config module
>> =A0 gitweb: Create Gitweb::Request module
>> =A0 gitweb: Create Gitweb::Escape module
>> =A0 gitweb: Create Gitweb::RepoConfig module
>> =A0 gitweb: Create Gitweb::View module
>> =A0 gitweb: Create Gitweb::Util module
>> =A0 gitweb: Create Gitweb::Format module
>> =A0 gitweb: Create Gitweb::Parse module
>>
>> =A0gitweb/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 +
>> =A0gitweb/gitweb.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| 3855 +++---------=
---------------------------
>
> Nice!
>
>> =A0gitweb/lib/Gitweb/Config.pm =A0 =A0 | =A0498 +++++
>> =A0gitweb/lib/Gitweb/Escape.pm =A0 =A0 | =A0175 ++
>> =A0gitweb/lib/Gitweb/Format.pm =A0 =A0 | =A0537 ++++++
>> =A0gitweb/lib/Gitweb/Git.pm =A0 =A0 =A0 =A0| =A0 48 +
>> =A0gitweb/lib/Gitweb/Parse.pm =A0 =A0 =A0| =A0378 ++++
>> =A0gitweb/lib/Gitweb/RepoConfig.pm | =A0424 +++++
>> =A0gitweb/lib/Gitweb/Request.pm =A0 =A0| =A0153 ++
>> =A0gitweb/lib/Gitweb/Util.pm =A0 =A0 =A0 | =A0447 +++++
>> =A0gitweb/lib/Gitweb/View.pm =A0 =A0 =A0 | 1022 +++++++++++
>> =A011 files changed, 3909 insertions(+), 3642 deletions(-)
>> =A0create mode 100644 gitweb/lib/Gitweb/Config.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Escape.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Format.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Git.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Parse.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/RepoConfig.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Request.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/Util.pm
>> =A0create mode 100644 gitweb/lib/Gitweb/View.pm
>
> Keep up good work!
>
> --
> Jakub Narebski
> Poland
>

So, If you can tell me what I need to change in this series, I would
like to complete it and send a second version so that you can ack it
and junio can merge it soon.

Thanks,
Pavan.
