From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
	/etc/gitweb.conf (WIP)
Date: Tue, 07 Jun 2011 09:00:58 -0400
Message-ID: <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
	 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
	 <20110606221236.GD30588@elie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:02:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTvv0-0002f4-Pc
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 15:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab1FGNBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 09:01:43 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:53859 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1FGNBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 09:01:42 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p57D136v013944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jun 2011 09:01:08 -0400
In-Reply-To: <20110606221236.GD30588@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=5
	Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p57D136v013944
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1308056471.71096@RH0QEyJMdrLixq/BcaTmWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175202>


On Mon, 2011-06-06 at 17:12 -0500, Jonathan Nieder wrote:
> Jakub Narebski wrote:


> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'/etc/gitweb.conf'
> > +'$GITWEBDIR/gitweb_config.perl'
> 
> Micronit: a single line like
> 
> 	SYNOPSIS
> 	--------
> 	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf
> 
> might fit better with the pattern established by gitattributes(5) and
> its kin.

I thought that's how I had originally put it.
> 
> > +DESCRIPTION
> > +-----------
> > +The gitweb CGI script for viewing Git repositories over the web uses a
> > +perl script fragment as its configuration file.  You can set variables
> > +using "`our $variable = value`"; text from a "#" character until the
> > +end of a line is ignored.  See *perlsyn*(1) for details.
> > +
> > +An example:
> > +
> > +    # gitweb configuration file for http://git.example.org
> > +    #
> > +    our $projectroot = "/srv/git"; # FHS recommendation
> > +    our $site_name = 'Example.org >> Repos';
> 
> Nice.
> 
> > +The configuration file is used to override the default settings that
> > +were built into gitweb at the time 'gitweb.cgi' script was generated.
> > +
> > +While one could just alter the configuration settings in the gitweb
> > +CGI itself, those changes would be lost upon upgrade.
> 
> What if I upgrade using RCS "merge"? :)  So maybe:
> 
> 	s/one could just alter/one can alter/
> 	s/would be lost/could be lost/
> 
> to clarify that (1) editing the CGI script is allowed and fine but (2)
> it might be a pain to keep those changes.

The point of this was originally if you were a mere mortal then upgrades
of the gitweb CGI would flush all of the settings you just spent a week
getting right down the drain. That's the point of the stronger language.
It's meant to be a solid "If you do it that way you can expect it to
hurt" message.
> 
> > Configuration
> > +settings might also be placed into a file in the same directory as the
> > +CGI script with the default name 'gitweb_config.perl' -- allowing
> > +one to have multiple gitweb instances with different configurations by
> > +the use of symlinks.
> 
> Might also in addition to what?  

This comment is nonsensical, please clarify it.

> Continuing the thought from before:
> 
> 	So gitweb allows settings to be placed in a separate file named
> 	'gitweb_config.perl' in the same directory as the CGI script.
> 	This also allows one to set up multiple gitweb instances with
> 	different configurations by using symlinks to a common gitweb.cgi
> 	script.

How is this any different from what I wrote?
> 
> > +DISCUSSION
> > +----------
> 
> First, as a general thought, by the time I get this far I start
> thinking, "so where's the list of possible settings?".  But there are
> certainly some more basic pieces of information to cover before then
> (like the global configuration file), so I think this part is in the
> right place.  It just could benefit from being a little shorter.

I used resolv.conf(5) as the model here. I realized that without a
little introduction most of the settings and the way they are applied
didn't make a heck of a lot of sense if you've never seen them before.
> 
> > +The location of system-wide gitweb configuration file is defined at compile
> > +time using the configuration value `GITWEB_CONFIG_SYSTEM` and defaults to
> > +'/etc/gitweb.conf'.  The name of the per-instance configuration file is
> > +defined in gitweb by `GITWEB_CONFIG`, and defaults to 'gitweb_config.perl'
> > +(relative path means located in the same directory gitweb is installed).
> 
> Maybe:
> 
> 	In addition to the per-instance configuration file, there can
> 	be a system-wide configuration file to act as a fallback when
> 	the per-instance configuration file does not exist.
> 
> 	The system-wide configuration file is named /etc/gitweb.conf
> 	by default.  Filenames for the system-wide and per-instance
> 	configuration variables can be overridden at compile time and
> 	run time; see the FILES section for details.

This is the manpage for the system wide configuration file. If you'd
like to scrap this effort in favor of something else please speak up.
> 
> [...]
> > +Values defined in configuration files override built-in values found in the
> > +gitweb CGI.
> 
> Reasonable.
> 
> > +*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
> > +then system-wide configuration file ('/etc/gitweb.conf') is _not used at
> > +all_!!!
> 
> Over the top. :)  I think the best way to document this is to contrast
> it with /etc/gitweb-common.conf once the latter exists.

If we were to change gitweb to handle configuration files like the rest
of git (and in fact like most things we deal with daily, where settings
are overridden one by one) then this section becomes moot. Until or
unless that becomes the case it is important to loudly make note of it. 

Also (and unfortunately), what appears to be truly over the top markup
in plain text is just barely visible in the compiled manpage and is
actually reasonable in the (X)HTML version. Please check the final
output before complaining about my markup, if that is indeed your
intent.
> 
> > +The syntax of the configuration files is that of Perl, as these files are
> > +indeed handled as fragments of Perl code (the language that gitweb itself is
> > +written in). Variables may be set using "`our $variable = value`"; text from
> > +"#" character until the end of a line is ignored. See the *perlsyn*(1) man
> > +page for more information.
> 
> Duplicates DESCRIPTION.

Perhaps it does, but not everybody is a Perl coder. It was that way in
the text I started from and I saw little point in changing it.
> 
> > +
> > +Actually using `our` qualifier in `our $variable = <value>;` is a safety
> > +check: if newer gitweb does no longer use given variable, by using `our` we
> > +won't get syntax errors.
> 
> Maybe this could move to a later NOTES section?

Fine with me.
> 
> > +
> > +The default configuration with no configuration file at all may work
> > +perfectly well for some installations.  Still, a configuration file is
> > +useful for customizing or tweaking the behavior of gitweb in many ways, and
> > +some optional features will not be present unless explicitly enabled using
> > +the configurable `%features` variable (see also "Configuring gitweb
> > +features" section below).
> 
> I suppose this is based on the text
> 
> 	The most notable thing that is not configurable at compile time are the
> 	optional features, stored in the '%features' variable.
> 
> I'd suggest removing the paragraph.

The motivation for this paragraph was actually the innumerable tutorials
out there which tell people to mangle the CGI directly because:
(1) There didn't seem to be a standard documented configuration file
(2) There wasn't an appropriate place to shove %features settings that
the author could find.
(3) It really needed to be said that you might not actually have to mess
with anything.

Apparently you think that clearing these misconceptions up is a useless
exercise, or at least it sounds a lot like it.

> > +Links and their targets
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +Configuration variables described below configure some of gitweb links:
> > +their target and their look (text or image), and where to find page
> > +prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
> > +at their default values, with the possible exception of `@stylesheets`
> > +variable.
> 
> Does "Usually they are left at" mean "Usually there is no reason to change
> them from"?  Aside from that, makes sense.

Yes, that's equivalent.

> 
> Stopping here.  Will resume later but since having something is better
> than nothing, I am tempted to say this should be applied e.g. to
> "next" so people can start using it right away and finding/fixing
> documentation bugs.

And so am I [stopping], I suppose. I have had work to do for the past
few weeks that really caused me to NEED my weekends for things other
than writing code and flossing documentation. Unless I am needed for
something I'm going to just let this live or die on it's own for now, as
I cannot keep up with this pace of patching right now. (That was in
large part the whole point of my flagging this as WIP.)
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
