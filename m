From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 13:03:09 -0400
Message-ID: <1305219789.24667.64.camel@drew-northup.unet.maine.edu>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
	 <20110512105325.GA13490@elie>  <201105121701.26547.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 19:04:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKZIv-0005OG-78
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 19:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054Ab1ELRDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 13:03:55 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:35037 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab1ELRDx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 13:03:53 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4CH3Edp023216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2011 13:03:14 -0400
In-Reply-To: <201105121701.26547.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4CH3Edp023216
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305824594.58278@5BnATDKPbN5v0XuuyxA8EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173485>


On Thu, 2011-05-12 at 17:01 +0200, Jakub Narebski wrote:
> On Thu, 12 May 2011, Jonathan Nieder wrote:
> > Drew Northup wrote:
> > 
> > > This is a work in progress. Much of what is in it has been pulled
> > > directly from the README and INSTALL files of gitweb. No effort has yet
> > > been made to de-duplicate any of this.
> 
> While it might be a good idea to split main part of gitweb/README into
> gitweb.conf.txt (documenting configuration), and perhaps also separate
> gitweb.txt (main page for gitweb, like SVN::Web manpage), I don't think
> that much of gitweb/INSTALL should be moved.

That's pretty much my conclusion as well. I'm focusing solely on the
configuration portion right now. A main page for Gitweb itself will
definitely be useful.

> > > TODO:
> > >   * Clean up README and INSTALL files
> > >   * Add Makefile rules to build man / HTML pages.
> > >   * Remove or rephrase redundant portions of original documentation
> > >   * A lot more...
> > 
> > I agree with this TODO list. :)  It should be possible to reuse rules from
> > Documentation/Makefile if you put this under Documentation/.  gitweb already
> > keeps its tests under t/ for convenience; I think it's okay if it
> > puts some documentation under Documentation/.
> 
> Note that git-gui and gitk both also keep their manpages in Documentation/
> as Documentation/git-gui.txt and Documentation/gitk.txt

I've been keeping my work in the gitweb directory mostly for
convenience. I've put my "compilation" script there for testing the
asciidoc compilation just so that I don't need to mess with make for the
time being.

> We can add "doc" target to gitweb/Makefile, which would delegate work to
> ../Documentation/Makefile, similarly to existing "test" target in
> gitweb/Makefile.

That makes sense to me. Shouldn't be too much work for me to piece that
together when I'm ready.

> > > --- /dev/null
> > > +++ b/gitweb/gitweb.conf.txt
> > > @@ -0,0 +1,294 @@
> > > +gitweb.conf(5)
> > > +==============
> > > +
> > > +NAME
> > > +----
> > > +gitweb.conf - Gitweb configuration file
> > 
> > It sounds like a tautology.  Maybe "configuration for git's web
> > interface"?  Except that there is at least one other web interface for
> > git (cgit).  Hm.
> 
> Let's take a look how it is done in other section 5 manpages documenting
> configuration files:
> 
>   dhclient.conf(5):  dhclient.conf - DHCP client configuration file
>   ldap.conf(5):      ldap.conf, .ldaprc - ldap configuration file
>   yum.con(5):        yum.conf - Configuration file for yum(8).
> 
> So it is not much of tautology, I think.

I had started with resolv.conf(5) actually. Same idea--concise but
perhaps not amazingly informative.

> > > +
> > > +SYNOPSIS
> > > +--------
> > > +/etc/gitweb.conf
> 
> I'd say
> 
>     +SYNOPSIS
>     +--------
>     +gitweb_conf.perl
>     +/etc/gitweb.conf
> 
> or
> 
>     +SYNOPSIS
>     +--------
>     +$GITWEBDIR/gitweb_conf.perl
>     +/etc/gitweb.conf
>  
> > gitweb will also look for gitweb_config.perl along @INC, and
> > the $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM envvars can override
> > these paths.
> 
> I think that we don't need to describe envvars in synopsis, but we
> should have per-gitweb configuration file (gitweb_conf.perl) in
> "Synopsis" section.

Sounds reasonable to me.
 
> > > +
> > > +DESCRIPTION
> > > +-----------
> > > +'Gitweb' is a CGI application for viewing Git repositories over the web. The
> > > +configuration file is used to override the default settings that were built
> > > +into gitweb at the time Git itself was compiled.
> > 
> > Style nit: I'd launch into what gitweb.conf contains right away, like
> > so:
> > 
> > 	The gitweb CGI script for viewing Git repositories over the
> > 	web uses a perl script fragment as its configuration file.
> > 	You can set variables using "our $variable = value"; text
> > 	from a "#" character until the end of a line is ignored.
> > 	See *perlsyn*(1) for details.
> > 
> > 	The configuration file is used to override the default
> > 	settings that were built into gitweb at the time it was
> > 	installed.
> 
> I agree with Jonathan here.

Comment noted. Perhaps resolv.conf(5) wasn't the best example for
this...
 
> > > +While one could just alter
> > > +the configuration settings in the gitweb CGI itself, those changes would be
> > > +lost upon upgrade. Configuration settings my also be placed into a file in
> > > +the same directory as the CGI script with the default name
> > > +`gitweb_config.perl` &#8211; allowing one to have multiple gitweb instances
> > > +with different configurations by the use of symlinks.
> > 
> > Good point; I hadn't thought about the multiple-configurations use case.
> 
> Right.
> 
> > > +DISCUSSION
> > > +----------
> > > +
> > > +The location of `gitweb.conf` is defined at compile time using the
> > > +configuration value `GITWEB_CONFIG_SYSTEM` and defaults to /etc/gitweb.conf.
> > > +The name of the per-instance configuration file is defined in gitweb by
> > > +`GITWEB_CONFIG`.
> > > +
> > > +*NOTE:* Values defined in the per-instance configuration file override both
> > > +values found in the gitweb CGI as well as values found in the sytem-wide
> > > +gitweb.conf file.
> > 
> > Doesn't gitweb_config.perl suppress the effect of gitweb.conf altogether?
> 
> Yes it does.
> 
> The sequence is as following:
> 
> 1. Per-gitweb configuration file is given by envvar GITWEB_CONFIG; if it
>    is not set, then by default gitweb_conf.perl is used (one can override
>    the latter name via build-time configuration variable GITWEB_CONFIG).
>    Note: relative path means relative to installed gitweb.cgi script.
> 
> 2. System-wide configuration file is given by envvar GITWEB_CONFIG_SYSTEM;
>    if it is not set, then by default /etc/gitweb.conf is used (one can
>    override the latter name via build-time configuration variable
>    GITWEB_CONFIG_SYSTEM).  Note: sysconfdir is not taken into account
>    by gitweb/Makefile, but perhaps it should.
>  
> Gitweb obtains configuration data from the following sources in the
> following order:
> 
>   1. gitweb's installation configuration file ($GITWEBDIR/gitweb_conf.perl)
>   2. system-wide configuration file (/etc/gitweb.conf)
> 
> First existing config file is used.

Let me see if I understand this correctly: If there is an instance-local
configuration file ($GITWEBDIR/gitweb_conf.perl by default) we outright
ignore all settings in the system-wide (/etc/gitweb.conf) configuration
file? That would mean that the system-wide configuration file isn't
really a system-wide set of defaults--to be built upon by a local
configuration--at all, but is something much more akin to /etc/skel;
used in total or completely overridden.

Coming from the perspective of an administrator of a fair amount of web
hosting space I'd actually prefer that it be settable that both the
system-wide configuration and the local one affect operation. This would
allow for local setting of things such as adding a stylesheet while
ensuring consistency otherwise. The order of evaluation of configuration
settings sets would be "built-in, system, local" in that case (provided
all exist). I can provide a patch to gitweb.perl for that if there is
interest.

> Sidenote: we could replace GITWEB_CONFIG and GITWEB_CONFIG_SYSTEM in 
> gitweb.conf.txt during building documentation.

I wasn't sure yet if I wanted to do @@thingy@@ substitution or not. (I'm
still not...)

> > > +
> > > +The syntax of the configuration files is that of PERL, as these files are
> > > +indeed handled as fragments of PERL code (the language that gitweb itself is
> > > +written in). Variables may be set using "'our $variable = value'"; text from
> > > +"#" character until the end of a line is ignored. See the perlsyn(1) man page
> > > +for more information.
> 
> Actually using 'our $variable = <value>' is a safety check: if newer gitweb
> does no longer use given value, using 'our' wouldn't cause errors.

That was boilerplate language taken pretty directly from the INSTALL and
README files. If we change it here we should change it there as well (if
it remains once we're done).

> > The perl manual spells the name of that language as "Perl".  

I've seen it spelled all sorts of ugly ways, but if that's what they're
using I can too. ;-)

> I think
> > it might make sense to mention the syntax earlier, since it makes it
> > less daunting to dive into the file right away.
> 
> I think it might be good idea to provide bare-bones example here.
>  
> > > +
> > > +One good reason to take advatage of the system-wide and local gitweb
> > > +configuration files is that not all settings may be set up directly in the CGI
> > > +itself. Optional features &#8211; defined using the '%features' variable
> > > +&#8211; must be set in one of the two configuration files.
> > 
> > I don't follow what this paragraph is saying.  Is the idea something
> > like this?
> > 
> > 	The default configuration with no configuration file at all
> > 	may work perfectly well for some installations.  Still, a
> > 	configuration file is useful for customizing or tweaking the
> > 	behavior of gitweb in many ways, and some optional features
> > 	will not be present unless explicitly enabled using the
> > 	configurable %features variable.
> 
> I think the idea is that not all of configuration knobs can be tweaked
> during "compile"-time.  Some require setting from configuration file.

Yes, that would benefit from some rewording.

> Note: we probably want to mention gitweb/config.mak or config.mak somewhere
> as place to save build-time configuration, persistently.

Given your preference for keeping gitweb/INSTALL as intact as possible,
should that not go there?

> > > +
> > > +CONFIGURATION SETTINGS
> > > +----------------------
> > 
> > Configuration settings as opposed to non-configuration settings? :)
> > 
> > Maybe something like
> > 
> > 	VARIABLES
> > 	---------
> > 
> > would be clearer.
> 
> Perhaps.

But variables to do what?

> > > +Standard Options
> > > +~~~~~~~~~~~~~~~~~
> > > +The following are not typically set or overridden at build time:
> [...]
> > > +
> > > +$GIT::
> > > +	Core git executable to use.
> > 
> > Ah, what a variable to start with.  Maybe this can be snuck later in
> > the list somehow, so the reader can get to juicier bits first.
> 
> This is set at build time, by default to $(bindir)/git

I chose to leave that in due to the fact that we've had a few threads on
the list and other places on the Internet in recent memory where it was
asked how to override that. Order is thus far as given in my source
materials. If it is set at build time I can move it to the other
(non-standard) list.

> > > +$version::
> > > +	Gitweb version, set automatically when creating gitweb.cgi from
> > > +	gitweb.perl. You might want to modify it if you are running modified
> > > +	gitweb.
> > 
> > Why would I want to set this in the config file?  Wouldn't my patch to
> > gitweb.cgi modify $version?
> 
> Well, for running gitweb.perl (not build!) from command line I use
> 
>   our $version = "current";
> 
> But this is I think rare case.

I would hope so. In any case, as we part gitweb out I suspect it will be
useful to mention somewhere that this is settable, as distribution
maintainers are apt to fuss with things (for starters). As far as I'm
concerned the README and INSTALL files are fair game for modification if
this could be made more clear in one of them.

> > > +$projectroot::
> > > +	Absolute filesystem path which will be prepended to project path;
> > > +	the path to repository is `$projectroot/$project`.  Set to
> > > +	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
> > > +	set correctly for gitweb to find repositories.
> > 
> > This is an interesting one.  The description is not so clear to me ---
> > I guess the idea is that if $projectroot = "/srv/git" then
> > 
> >  http://path/to/gitweb/installation/?p=foo/bar.git
> > 
> > will map to /srv/git/foo/bar.git on the filesystem (and likewise for
> > PATH_INFO based URLs)?
> 
> Yes.

This was the one which bit me hard enough to decide to take this task
on. I really didn't appreciate having my gitweb and gitolite
installations which had been getting along so well suddenly refuse to
talk to each other.

> > > +$projects_list::
> > > +	Source of projects list, either directory to scan, or text file
> > > +	with list of repositories (in the "`<URI-encoded repository path> SP
> > > +	<URI-encoded repository owner>`" line format; actually there can be
> > > +	any sequence of whitespace in place of space (SP)).  Set to
> > > +	`$GITWEB_LIST` during installation.  If empty, `$projectroot` is used
> > > +	to scan for repositories.
> > 
> > Maybe clearer to emphasize the kinds of values it takes first?  That
> > is:
> > 
> > 	Space-separated list of paths to files listing projects or
> > 	directories to be scanned for projects.  Project list files
> > 	should list one project per line, with each line having the
> > 	format "`<URI-encoded filesystem path to repository> SP
> > 	<URI-encoded repository owner>`.  The default is determined
> > 	by the GITWEB_LIST makefile variable at installation time.
> > 	If this variable is empty, gitweb will fall back to scanning
> > 	the `$projectroot` for repositories.
> 
> I think to not have long wall of text here, we should reference part
> of documentation that explains how gitweb finds repositories, including
> format of $projects_list file.

Perhaps this longer explanation is fodder for gitweb.txt?

> > [...]
> > > +Configuration Options Often Set at Compile Time
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +These configuration variables are often specified at compile time and are
> > > +defined by default in the gitweb CGI itself:
> > > +
> > > +GIT_BINDIR::
> > > +	Points where to find the git executable.  You should set it up to
> > > +	the place where the git binary was installed (usually /usr/bin) if you
> > > +	don't install git from sources together with gitweb.  [Default: $(bindir)]
> > 
> > I don't think there is a GIT_BINDIR configuration variable, though
> > there is a makefile variable with that name used to determine the
> > default value of $GIT.

Ok, upon checking that is indeed "compiled out" during the build
process.

> > Likewise for the others.  I don't think they belong in the manpage.
> 
> I agree.  What is important during build time "only" should remain in
> gitweb/INSTALL.

We need to define what that is then, as some of these "build time only"
listed values are indeed settable items (granted, once the case is set
properly and a dollar sign is prefixed) such as $site_name,
$site_header, and $site_footer. 

Remember, many people install from packages and not from source. If we
make them second-class citizens we only make our lives more difficult.

In any case, as I noted earlier, thus far I've been mostly just pulling
stuff in from other places. It is now time to start cleaning it up.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
