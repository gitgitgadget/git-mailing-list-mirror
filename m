From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 1/2] gitweb: Hyperlink various committags in commit message with regex
Date: Mon, 22 Jun 2009 13:18:18 +0200
Message-ID: <200906221318.19598.jnareb@gmail.com>
References: <200902180438.55081.jnareb@gmail.com> <1245420831-5103-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fg@one2team.net>
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 13:13:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIhSk-0000zM-1F
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 13:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbZFVLNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZFVLNL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 07:13:11 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36754 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZFVLNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 07:13:09 -0400
Received: by bwz9 with SMTP id 9so3034003bwz.37
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=n9Mq8aWHNSC05ligr/LO0ASqIA5QAlTpA+WT063dlnc=;
        b=EFa2kiSuJHy7T+XbQ0Khcbi9zH1SE3p4w1/kyYRK/53O5H3AjpsbwKIysTSkzJW6pd
         gVbHHzNRDko/h+61oj9KmYxUtL/WfWJpR38k4A5PWau4deLfKb0MMOaBzkxIZJC17OfW
         j/u54lkuaIhZCw0PTAWW1+B7obZKQpGJuck5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=fouHSHShIqOIZ5L4UnoPjIoSOEgsvlI1ur8e+jLdWc7VeA8G257dzV+uG3ylBoaM+E
         yc0byr+5mIjdlPwNm6KDVKJZAh4pVFo+vpNOLM3xWmbCISlXmiBKzySheF8lRN7ksgIR
         pftZf7Jn5nTPQGTaxXfKg8vwYFkedTTLQsMkA=
Received: by 10.86.36.4 with SMTP id j4mr6420178fgj.63.1245669190050;
        Mon, 22 Jun 2009 04:13:10 -0700 (PDT)
Received: from ?192.168.1.13? (abrz167.neoplus.adsl.tpnet.pl [83.8.119.167])
        by mx.google.com with ESMTPS id d6sm10143756fga.29.2009.06.22.04.13.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 04:13:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245420831-5103-1-git-send-email-marcel@oak.homeunix.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122027>

On Fri, 19 June 2009, Marcel M. Cary wrote:

Thanks for diligently working on this issue.  Good work!

I see that it is an RFC, and not final submission, but just in case
I'd like to remind you that some of information below should go into
commit message, but some of it should I think go to comments (between
"---" and diffstat).

> I want gitweb to hyperlink commits to my bug tracking system so that
> information regarding the current status of a commit can be easily
> cross-referenced.  For example, the QA and release status of a commit
> cannot be inserted into the comment.  Maybe someday a "git notes"
> feature will help with this, but for now, my organization has a
> separate bug tracking system.  Other repository browsers such as
> unfuddle and websvn support similar features.

The paragraph above should, I think, be made more clear.  You don't
need to mention what you don't do; the comment about "git notes" should
be not in commit message but in comments section.

What you want to have is to have some markers in commit message 
(committags) hyperlinked; namely you want notifications about bug/issue
numbers in the commit message hyperlinked to appropriate bugtracker/issue
tracker URL.  Do I understand this correctly?

I tried here to reword what you said, to come up with better commit
message for a future final submission.

> 
> Since the bug hyperlinking feature was previously discussed as part of
> "committags," a more general mechanism to embellish commit messages,
> implement the more general mechanism instead, including the following
> capabilities:

Well, I think that the fact that it would be not much harder to create
general mechanism for commit message transformation, than to add 
suitably generic and well customizable support for bugtracker 
'committags'.

> 
> * Hyperlinking mentions of bug IDs to Bugzilla
> * Hyperlinking URLs
> * Hyperlinking Message-Ids to a mailing list archive
> * Hyperlinking commit hashes as before by default, now with a
>   configurable regex
> * Defining new committags per gitweb installation

Well, there is one _implicit_ (but important) commit message 
transformation (filter) for display, which has to be always present[1],
namely HTML escaping.  We make use of the fact that you can do
HTML escaping before doing the only currently supported committag, 
namely hyperlinking (shortened) SHA-1 to 'object' gitweb URL, but for
other committags like mentioned "Message-Id to mail archive" committag
(filter) it would make them more difficult.

Also one might consider vertical whitespace simplification (removing
leading empty lines, compacting empty lines to single empty line 
between paragraphs), and syntax highlighting signoff lines to be
a kind of commit message filter like mentioned above committags
(see git_print_log() subroutine).

Although probably vertical whitespace simplification should be not
made into commit message filter, as it is used not for all views.

> 
> Since different repositories may use different bug tracking systems or
> mailing list archives, the URL parameter may be configured
> per-repository without reiterating the regexes.  To accomodate
> different conventions, regexes may also be configured per-project.

Also list of supported committags is separated from the list of 
committags used[1]; just like it is done for snapshot formats.
This could be mentioned in final commit message.

[1] well, sequence rather than list in this case, as here
    ordering does matter a bit

> 
> This patch is heavily based on discussions and code samples from the
> Git list:
> 
> 	[RFC/PATCH] gitweb: Add committags support, Sep 2006
> 	http://thread.gmane.org/gmane.comp.version-control.git/27504
> 
> 	[RFC] gitweb: Add committags support (take 2), Dec 2006
> 	http://thread.gmane.org/gmane.comp.version-control.git/33150
> 
> 	[RFC] Configuring (future) committags support in gitweb, Nov 2008
> 	http://thread.gmane.org/gmane.comp.version-control.git/100415

Hmmm... should this be put in final commit message, or only in comment
to the patch (should this be in commit history of git repository)?

> 
> Some issues I considered but punted:
> 
> * Should this configuration try to follow the bugtraq spec?
> 
>   As far as I know, only subversion implements it.  Separation of
>   regexes by a newline would be a little awkward in the git config.
>   And it is broader than just hyperlinking bugs: it also encompasses
>   GUI bug ID form fields.  So gitweb would only implement a subset.

I didn't even know that there is such spec.  Were you talking about
http://tortoisesvn.net/issuetracker_integration or do you have different
URL in mind?

>   The gitweb configuration mechanism currently only reads
>   keys starting with "gitweb.", but these parameters would be more
>   broadly applicable, potentially to git-gui, for example.

Actually the fact that gitweb reads only keys in the 'gitweb' section
from config is just a convention.  There were (are) no config variables
in other places (other sections) which would be of interest to gitweb.

> 
>   However, it *would* be useful for Git tools to standardize on
>   config keys and interpretations of regexes and url formats.  For
>   example, git-gui might be able to hyperlink the same text as gitweb,
>   and even show a separate bugID field when composing a commit
>   message.

This is I think a very good idea... but I think idea which 
implementation can be left for later.

> 
> * I would prefer the regex match against the whole commit message.
> 
>   This would allow the regex to insist that a bug reference occur
>   on the first line or non-first line of the commit message.  However,
>   even if we concatenated the log lines for the first committag,
>   subsequent committags would see the text broken up.
> 
>   Also, it would allow the regex to match a phrase split across a
>   line boundary, as dicussed at some length in the first thread,
>   but again, only if no prior committags had interfered.
> 
>   This could happen in a later patch.

Well, the change should be fairly easy: just concatenate lines before
passing them as single element list to commit message filters.  OTOH
you would have to take care of end of line characters in committags
regexps.

> 
> * I would prefer the site admin have a way to let a repository
>   owner define new committags, which means having a way to specify
>   the 'sub' key from the repo config or having a flexible default.

Perhaps, following your earlier suggestion to make committags supported
also by other tools, gitweb (and e.g. git-gui / gitk) use config 
variable committag.<name>.<key> (where <key> can be 'pattern' or 'url';
although I wonder if we can allow 'pattern' as malicious user can do
a DoS attack against gitweb / server using badly behaved regexp).

> 
> The bugtraq and some of the regex questions must be decided now to
> avoid breaking gitweb configs later.

True.

> 
> Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> ---
>  gitweb/INSTALL                         |    4 +
>  gitweb/gitweb.perl                     |  221 +++++++++++++++++++++++++++++++-
>  t/t9500-gitweb-standalone-no-errors.sh |  150 +++++++++++++++++++++-
>  3 files changed, 367 insertions(+), 8 deletions(-)
> 
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index 18c9ce3..223e39e 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -123,6 +123,10 @@ GITWEB_CONFIG file:
>  	$feature{'snapshot'}{'default'} = ['zip', 'tgz'];
>  	$feature{'snapshot'}{'override'} = 1;
>  
> +	$feature{'committags'}{'default'} = ['sha1', 'url', 'bugzilla'];
> +	$feature{'committags'}{'override'} = 1;
> +
> +
>  
>  Gitweb repositories
>  -------------------
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..c66fdf3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -195,6 +195,81 @@ our %known_snapshot_format_aliases = (
>  	'x-zip' => undef, '' => undef,
>  );
>  

I understand that comments such as one below would be not present in
a final submission, and they are here to provide running commentary for
code, isn't it?

> +# Could call these something else besides committags... embellishments,
> +# patterns, rewrite rules, ?

They are "commit filters", or "commit message filters" (or 'formatters',
or 'processors'; they are not 'parsers').  

The name 'committag' was first introduced as far as I remember in xmms2
fork of gitweb (in old times when gitweb was separate project, and not
part of git repository).

> +#
> +# In general, the site admin can enable/disable per-project configuration
> +# of each committag.  Only the 'options' part of the committag is configurable
> +# per-project.

See above caveat about allowing to customize 'regexp'/'pattern' part
in untrusted environment; you can construct regexp which has exponential
behavior.

> +#
> +# The site admin can of course add new tags to this hash or override the
> +# 'sub' key if necessary.  But such changes may be fragile; this is not
> +# designed as a full-blown plugin architecture.
> +our %committags = (


You should put the comments here about supported keys, similar to the
one for %known_snapshot_formats and %feature hashes.

> +	# Link Git-style hashes to this gitweb
> +	'sha1' => {
> +		'options' => {
> +			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
> +		},
> +		'override' => 0,

Shouldn't 'override' key be better last?

> +		'sub' => sub {
> +			my ($opts, @match) = @_;
> +			\$cgi->a({-href => href(action=>"object", hash=>$match[1]),
> +			          -class => "text"}, esc_html($match[0], -nbsp=>1));
> +		},

Style: although there is commonly used idiom to use 'sub { <expr>; }'
for a wrapper subroutines (e.g. 'sub { [] }' in Moose examples), one
should use explicit "return" statement instead of relying on Perl 
behavior of returning last statement in a block.

See Perl::Critic::Policy::Subroutines::RequireFinalReturn policy in
Perl::Critic (perlcritic.com).  "Perl Best Practices" says:

  Subroutines without explicit 'return' statements at their ends can be
  confusing. It can be challenging to deduce what the return value will be.

> +	},
> +	# Link bug/features to Mantis bug tracker using Mantis-style contextual cues
> +	'mantis' => {
> +		'options' => {
> +			'pattern' => qr/(?:BUG|FEATURE)\((\d+)\)/,
> +			'url' => 'http://bugs.xmms2.xmms.se/view.php?id=',

I don't think we want to put such URL here.  Please check if Mantis 
documentation uses some specific links, or follow RFC conventions and
use 'example.com' as hostname (e.g. 'bugs.example.com').

By the way the bugtraq proposal you mentioned uses placeholder in URL
for putting issue number (%BUGID%).  Perhaps gitweb should do the same
here.

> +		},
> +		'override' => 0,
> +		'sub' => \&hyperlink_committag,
> +	},
> +	# Link mentions of bug IDs to bugzilla
> +	'bugzilla' => {
> +		'options' => {
> +			'pattern' => qr/bug\s+(\d+)/,
> +			'url' => 'http://bugzilla.kernel.org/show_bug.cgi?id=',

The same comment as above.

> +		},
> +		'override' => 0,
> +		'sub' => \&hyperlink_committag,
> +	},
> +	# Link URLs
> +	'url' => {
> +		'options' => {
> +			# Avoid matching punctuation that might immediately follow
> +			# a url, is not part of the url, and is allowed in urls,
> +			# like a full-stop ('.').
> +			'pattern' => qr!(http|ftp)s?://[-_a-zA-Z0-9\@/&=+~#<>;%:.?]+
> +			                               [-_a-zA-Z0-9\@/&=+~#<>]!x,

If you took this regexp from some place (like blog), it would be good
to mention URL here, to be able to check more detailed explanation of
construction of this URL-catching regexp.

Should we also support irc://, nntp:// (pseudo)protocols? What about
git:// ?

> +		},
> +		'override' => 0,
> +		'sub' => sub {
> +			my ($opts, @match) = @_;
> +			return
> +				\$cgi->a({-href => $match[0],
> +				          -class => "text"},
> +				         esc_html($match[0], -nbsp=>1));
> +		},

Here you use explicit return.

> +	},
> +	# Link Message-Id to mailing list archive
> +	'messageid' => {
> +		'options' => {
> +			# The original pattern, which I don't really understand
> +			#'pattern' => qr!(?:message|msg)-id:?\s+<([^>]+)>;!i,
> +			'pattern' => qr!(?:message|msg)-?id:?\s+(<[^>]+>)!i,

Errr... how original patter is different from the one used?  Also above
comment should be removed in final submission.

> +			'url' => 'http://news.gmane.org/find-root.php?message_id=',

Same comment about generic URL... although on the other hand perhaps
having a few examples of mail archive sites which support finding 
messages by Message-Id could be a good idea.

BTW. you can write 'http://mid.gmane.org/' instead...

> +		},
> +		'override' => 0,
> +		# The original version didn't include the "msg-id" text in the
> +		# link text, but this does.  In general, I think a little more
> +		# context makes for better link text.

I guess that is the result of using generic hyperlink_committag() 
subroutine here.  (This comment should be removed or reworded in final
submitted version, I think.)

BTW. it would be much easier with Perl6-ish (or Perl 5.10.x) named
captures (named groups):

	'pattern' => qr!(?:message|msg)-?id:?\s+(?P<query><[^>]+>)!i,

or something like that.

> +		'sub' => \&hyperlink_committag,
> +	},
> +);
> +
>  # You define site-wide feature defaults here; override them with
>  # $GITWEB_CONFIG as necessary.
>  our %feature = (
> @@ -365,6 +440,21 @@ our %feature = (
>  		'sub' => \&feature_patches,
>  		'override' => 0,
>  		'default' => [16]},
> +
> +	# The selection and ordering of committags that are enabled.
> +	# Committag transformations will be applied to commit log messages
> +	# in this order if listed here.

/this/given/

You need to mention somewhere that committag subroutines return a list
of mixed scalar and reference to scalar elements, where using reference
to scalar removes value from the chain of filters (including implicit
final esc_html filter).

> +
> +	# To disable system wide have in $GITWEB_CONFIG
> +	# $feature{'committags'}{'default'} = [];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'committags'}{'override'} = 1;
> +	# and in project config gitweb.committags = sha1, url, bugzilla
> +	# to enable those three committags for that project

Just a thought: perhaps we should provide support for 'default' in
config (which would currently be "sha1" or "sha1, url").

See also comment text for 'snapshot' feature, which says:

  and in project config, a comma-separated list of [...] or 
  "none" to disable.

> +	'committags' => {
> +		'sub' => \&feature_committags,
> +		'override' => 0,
> +		'default' => ['sha1']},
>  );
>  
>  sub gitweb_get_feature {
> @@ -433,6 +523,18 @@ sub feature_patches {
>  	return ($_[0]);
>  }
>  
> +sub feature_committags {
> +	my (@defaults) = @_;
> +
> +	my ($cfg) = git_get_project_config('committags');
> +
> +	if ($cfg) {
> +		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
> +	}
> +
> +	return @defaults;
> +}

As this would be second feature which uses comma-separated (or for
backward compatibility space separated) list of options, perhaps
we should factor out this part into common helper subroutine named
for example 'feature_list' or 'feature_multi' (like 'feature_bool').

> +
>  # checking HEAD file with -e is fragile if the repository was
>  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
>  # and then pruned.
> @@ -814,6 +916,34 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# ordering of committags
> +our @committags = gitweb_get_feature('committags');
> +
> +# Merge project configs with default committag definitions
> +gitweb_load_project_committags();

Good idea... although gitweb first defines and then uses subroutine,
see evaluate_path_info().

> +
> +# Load committag configs from the repository config file and and
> +# incorporate them into the gitweb defaults where permitted by the
> +# site administrator.
> +sub gitweb_load_project_committags {
> +	return if (!$git_dir);
> +	my %project_config = ();
> +	my %raw_config = git_parse_project_config('gitweb\.committag');

Why not do lazy-loading of a whole config here?  We use committag
info only for project-specific actions in gitweb.

> +	foreach my $key (keys(%raw_config)) {
> +		next if ($key !~ /gitweb\.committag\.[^.]+\.[^.]/);
> +		my ($gitweb_prefix, $committag_prefix, $ctname, $option) =
> +			split(/\./, $key, 4);
> +		$project_config{$ctname}{$option} = $raw_config{$key};
> +	}

And use created subroutines to handle config?

> +	foreach my $ctname (keys(%committags)) {
> +		next if (!$committags{$ctname}{'override'});
> +		foreach my $optname (keys %{$project_config{$ctname}}) {
> +			$committags{$ctname}{'options'}{$optname} =
> +				$project_config{$ctname}{$optname};
> +		}
> +	}
> +}
> +
>  # dispatch
>  if (!defined $action) {
>  	if (defined $hash) {
> @@ -1384,13 +1514,92 @@ sub file_type_long {
>  sub format_log_line_html {
>  	my $line = shift;
>  
> -	$line = esc_html($line, -nbsp=>1);
> -	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> -		$cgi->a({-href => href(action=>"object", hash=>$1),
> -					-class => "text"}, $1);
> -	}eg;
> +	# In this list of log message fragments, a string ref indicates HTML,
> +	# and a string indicates plain text
> +	my @list = ( $line );

Well, to be more exact string ref means that the string referenced is
not to be processed by later filters, including final implicit esc_html.

Perhaps it would be better to use less generic name than @list herem
e.g. @process or something?

>  
> -	return $line;
> +COMMITTAG:
> +	foreach my $ctname (@committags) {
> +		next COMMITTAG unless exists $committags{$ctname};
> +		my $committag = $committags{$ctname};
> +
> +		next COMMITTAG unless exists $committag->{'options'};
> +		my $opts = $committag->{'options'};
> +
> +		next COMMITTAG unless exists $opts->{'pattern'};
> +		my $pattern = $opts->{'pattern'};
> +
> +		my @newlist = ();
> +
> +	PART:
> +		foreach my $part (@list) {
> +			next PART if $part eq "";
> +			if (ref($part)) {
> +				push @newlist, $part;
> +				next PART;
> +			}
> +
> +			my $oldpos = 0;
> +
> +		MATCH:
> +			while ($part =~ m/$pattern/gc) {
> +				my ($prepos, $postpos) = ($-[0], $+[0]);
> +				my $repl = $committag->{'sub'}->($opts, $&, $1);
> +				$repl = "" if (!defined $repl);
> +
> +				my $pre = substr($part, $oldpos, $prepos - $oldpos);
> +				push_or_append(\@newlist, $pre);
> +				push_or_append(\@newlist, $repl);
> +
> +				$oldpos = $postpos;
> +			} # end while [regexp matches]
> +
> +			my $rest = substr($part, $oldpos);
> +			push_or_append(\@newlist, $rest);
> +
> +		} # end foreach (@list)
> +
> +		@list = @newlist;
> +	} # end foreach (@committags)
> +
> +	# Escape any remaining plain text and concatenate
> +	my $html = '';
> +	for my $part (@list) {
> +		if (ref($part)) {
> +			$html .= $$part;
> +		} else {
> +			$html .= esc_html($part, -nbsp=>1);
> +		}
> +	}
> +
> +	return $html;
> +}

Nice.

> +
> +# Returns a ref to an HTML snippet that links the second
> +# parameter to a URL formed from the first and last parameters.
> +# This is a helper function used in %committags.
> +sub hyperlink_committag {
> +	my ($opts, @match) = @_;
> +	return
> +		\$cgi->a({-href => $opts->{url} . CGI::escape($match[1]),

$opts->{'url'} not $opts->{url}

'$cgi->escapeHTML' I think, not 'CGI::escape' (but I am not sure here).
besides, we can always import 'escape'.

> +				  -class => "text"},
> +				 esc_html($match[0], -nbsp=>1));
> +}
> +
> +
> +sub push_or_append (\@@) {

Hmmm... this would be first use of Perl subroutine prototypes in gitweb.
But this is made to imitate 'push' built-in, so I think it is O.K.

> +	my $list = shift;
> +
> +	if (ref $_[0] || ! @$list || ref $list->[-1]) {
> +		push @$list, @_;
> +	} else {
> +		my $a = pop @$list;
> +		my $b = shift @_;
> +
> +		push @$list, $a . $b, @_;
> +	}
> +	# imitate push
> +	return scalar @$list;
>  }
>  
>  # format marker of refs pointing to given object
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> index d539619..37a127c 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -55,9 +55,9 @@ gitweb_run () {
>  	# some of git commands write to STDERR on error, but this is not
>  	# written to web server logs, so we are not interested in that:
>  	# we are interested only in properly formatted errors/warnings
> -	rm -f gitweb.log &&
> +	rm -f resp.http gitweb.log &&
>  	perl -- "$SCRIPT_NAME" \
> -		>/dev/null 2>gitweb.log &&
> +		> resp.http 2>gitweb.log &&
>  	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
>  

Well, if you begin to check _output_ of gitweb, then it should be put 
in separate test, not t/t9500-gitweb-standalone-no-errors.sh which is
only about no-errors... or change name of gitweb test.

>  	# gitweb.log is left for debugging
> @@ -702,4 +702,150 @@ test_expect_success \
>  	 gitweb_run "p=.git;a=summary"'
>  test_debug 'cat gitweb.log'
>  
> +# ----------------------------------------------------------------------
> +# sha1 linking
> +#
> +echo hi > file.txt
> +git add file.txt
> +git commit -q -F - file.txt <<END
> +Summary
> +
> +See also commit 567890ab
> +END
> +test_expect_success 'sha1 link: enabled by default' '
> +	h=$(git rev-parse --verify HEAD) &&
> +	gitweb_run "p=.git;a=commit;h=$h" &&

Actually you can just use "h=HEAD" or use query without 'h' parameter
(which defaults to "HEAD") here.

> +	grep -q \
> +		"commit&nbsp;<a class=\"text\" href=\".*\">567890ab</a>" \
> +		resp.http
> +'
> +test_debug 'cat gitweb.log'
> +test_debug 'grep 567890ab resp.http'

I'd rather use Test::* (e.g. Test::WWW::Mechanize::CGI) for that...
but having some output test for gitweb, even in such simple form would
certainly  be nice.

> +
> +# ----------------------------------------------------------------------
> +# bugzilla commit tag
> +#
> +
> +echo foo > file.txt
> +git add file.txt
> +git commit -q -F - file.txt <<END
> +Fix foo
> +
> +Fixes bug 1234 involving foo.
> +END
> +git config gitweb.committags 'sha1, bugzilla'
> +test_expect_success 'bugzilla: enabled but not permitted' '
> +	h=$(git rev-parse --verify HEAD) &&
> +	gitweb_run "p=.git;a=commit;h=$h" &&
> +	grep -F -q \
> +		"Fixes&nbsp;bug&nbsp;1234&nbsp;involving" \
> +		resp.http
> +'
> +test_debug 'cat gitweb.log'
> +test_debug 'grep 1234 resp.http'
> +
> +echo '$feature{"committags"}{"override"} = 1;' >> gitweb_config.perl
> +test_expect_success 'bugzilla: enabled' '
> +	h=$(git rev-parse --verify HEAD) &&
> +	gitweb_run "p=.git;a=commit;h=$h" &&
> +	grep -F -q \
> +		"Fixes&nbsp;<a class=\"text\" href=\"http://bugzilla.kernel.org/show_bug.cgi?id=1234\">bug&nbsp;1234</a>&nbsp;involving" \
> +		resp.http
> +'

Hmmm...

-- 
Jakub Narebski
Poland
