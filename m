From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 14:33:11 -0400
Message-ID: <1305225191.24667.101.camel@drew-northup.unet.maine.edu>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
	 <201105122008.53322.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 20:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKahc-0001hl-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 20:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492Ab1ELSdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 14:33:32 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:57174 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab1ELSdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 14:33:31 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4CIXG6Z026332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2011 14:33:16 -0400
In-Reply-To: <201105122008.53322.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=7 Fuz1=7
	Fuz2=7
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4CIXG6Z026332
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305829997.66126@7U4eSVlE5poMdVt+KkWjjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173492>


On Thu, 2011-05-12 at 20:08 +0200, Jakub Narebski wrote:
> On Wed, 11 May 2011, Drew Northup wrote:

> > +
> > +The syntax of the configuration files is that of PERL, as these files are
> > +indeed handled as fragments of PERL code (the language that gitweb itself is
> > +written in). Variables may be set using "'our $variable = value'"; text from
> > +"#" character until the end of a line is ignored.
> 
> I think it would be nice to have an example here, something like:
> 
> -----
> our $site_name = 'My Gitweb'; # or 'localhost'
> -----

Looks reasonable to me...

> >                                                    See the perlsyn(1) man page 
> > +for more information.
> 
> Is this how other manpages should be referenced in AsciiDoc?
> 
> 
> BTW. What is &#8211;, and could we write it using something more readable?

That's an en dash. A lot of people write it "blah - blah," but that's
not typographically correct (and asciidoc isn't nice enough to fix it
for us, as that would likely mess something else up). It compiles
properly into both HTML and manpages. I didn't think that dropping the
UTF-8 character into the asciidoc sources would go over well.

> > +One good reason to take advantage of the system-wide and local gitweb
> > +configuration files is that not all settings may be set up directly in the CGI
> > +itself. Optional features &#8211; defined using the '%features' variable
> > +&#8211; must be set in one of the two configuration files.
> > +
> > +CONFIGURATION SETTINGS
> > +----------------------
> > +Standard Options
> > +~~~~~~~~~~~~~~~~~
> > +The following are not typically set or overridden at build time:
> 
> Hmmm... There are four kinds of configuration variables:

Thank you for this extraction & table.

> > +Configuration Options Often Set at Compile Time
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +These configuration variables are often specified at compile time and are
> > +defined by default in the gitweb CGI itself:
> > +
> > +GIT_BINDIR::
> > +	Points where to find the git executable.  You should set it up to
> > +	the place where the git binary was installed (usually /usr/bin) if you
> > +	don't install git from sources together with gitweb.  [Default: $(bindir)]
> [...]
> 
> I think this should be left in gitweb/INSTALL, as those are important
> _only_ during building gitweb.

Understood, I'll have to audit the list for values like that. 

> > +Configuration File Example
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +To enable blame, pickaxe search, and snapshot support, while allowing
> > +individual projects to turn them off, put the following in your
> > +GITWEB_CONFIG file:
> > +
> > +        $feature{'blame'}{'default'} = [1];
> > +        $feature{'blame'}{'override'} = 1;
> 
> I think this example requires explaining upfront what does it mean to
> allow feature override, i.e. about per-repository configuration.

Agreed, I was just pulling thing together in this step. I think that
there are likely other worthy additions to this portion.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
