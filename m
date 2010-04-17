From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [spf:guess,iffy] Re: "Integrated Web Client for git" GSoC proposal
Date: Sat, 17 Apr 2010 11:54:36 +0200
Message-ID: <201004171154.38988.jnareb@gmail.com>
References: <201004130403.42179.chriscool@tuxfamily.org> <201004161118.32163.jnareb@gmail.com> <1271473792.3506.30.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog9@eaglescrag.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 11:54:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O34jp-0002S5-GA
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 11:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab0DQJyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 05:54:53 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54543 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab0DQJyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 05:54:51 -0400
Received: by bwz25 with SMTP id 25so3907139bwz.28
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O2nZyVIehxTUl0GikhLtr4nMABgn+K1RVOFZ9B6/coo=;
        b=QMzA5yxL+cf3O6YFRSkP55ADn7u+LpildBjFAS+Hk0wvOlzMUUWiqhAe5DUEMpqbGg
         S2eqMgRksH7pQ6K3xO7y30baxazRQV9VyQhBw5BjyuPs2qC3sPgktIoR1OR01P29wokw
         6EOVIzJFoQBiysqYzrZhtjAIBngyQogMi9kYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jaM2ndcWFtftcXGCnrbKLK8aau9KFeswwJUUwiPk+Tya7J9lgZ3tKr/XB4JObv1F0n
         24nCrIgDOWxzogejnJmwOftEoohP5J9jEQV5BICIcao6nDLqMT284Ky80mBNIpkrMAVC
         Iqkl5bb5A/lUa14apJqCImBCp2SfI7Awz8ptU=
Received: by 10.204.141.133 with SMTP id m5mr2682417bku.91.1271498089792;
        Sat, 17 Apr 2010 02:54:49 -0700 (PDT)
Received: from [192.168.1.13] (abwa84.neoplus.adsl.tpnet.pl [83.8.224.84])
        by mx.google.com with ESMTPS id 13sm2258760bwz.15.2010.04.17.02.54.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 02:54:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1271473792.3506.30.camel@denix>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145127>

On Sat, 17 Apr 2010, Sam Vilain wrote:
> On Fri, 2010-04-16 at 11:18 +0200, Jakub Narebski wrote: 

> > With local::lib it is easy to install Perl modules from CPAN locally
> > (in home directory), so perhaps we could ease on minimal dependencies
> > rule.  On the other hand gitweb is web app, and one would have to be
> > able to configure web server to use locally installed Perl modules,
> > which might be not possible; this swicthes the problem from "not being
> > able to install Perl modules as non-root" to "not being able to install
> > Perl modules that web server can use without help from sysadmin".
> 
> This is correct for XS modules, using DynaLoader to link in
> arbitrary .so's may be restricted in a web server :).  But for pure Perl
> modules it should be no problem.  Many modules have both XS and
> Pure-Perl versions, for instance Template Toolkit has both and so is
> suitable for this style of bundling.

Errr... how the above addresses "not being able to install Perl modules
that web server can use without help from sysadmin", or in other words
"not being able to tell web server where to find locally installed /
/ additional Perl modules"?  If you can't set PERL5LIB for 'apache'
or 'web' or 'nobody' user, and you can't edit web server configuration
files...

Well, perhaps

  use lib (grep { -d } split /:/, "++GITWEBPERLLIB++");

and associated change to gitweb/Makefile would help here.

> > There exists very many web frameworks in Perl[1][2][3][4]: Catalyst
> > (one of more popular, used by Gitalist), Jifty, CGI::Application (and
> > its offshot Titanium), Mojolicus, Dancer, Squatting, Web::Simple,...
> > 
> > Nowadays many (all mentioned) of those web frameworks are either built
> > on top of PSGI / Plack (Perl Superglue for Web Frameworks and Web Servers),
> > or have PSGI / Plack adapter (see http://plackperl.org).  So another
> > solution would be to use bare-bones Plack instead of CGI with help
> > of CGI.pm, perhaps also using one of URI dispatchers[5][6].  Plack/PSGI
> > looks like the future of Perl web scripting... but is currently quite new,
> > at version 0.9930.
> 
> Ok so PSGI is the port of Python's WSGI to Perl.  Plack is the reference
> implementation, and also quite heavy at 2.5MB tarball.

Tatsuhiko Miyagawa addressed the issue of "2.5MB tarball".  PSGI is
specification, Plack is utilities (and includes reference implementation).

Using PSGI / Plack / PSGI compatibile web framework would give us ability
to run gitweb on many web servers: CGI, FastCGI, mod_perl (all those via
adapters from Plack), mod_psgi, HTTP::Server::PSGI (included in Plack),...
and give us Test::Plack.

But not less important would be ability to use Plack middleware; for
example gitweb output caching could be as simple as

  use Plack::Builder;
  ...

  builder {
     enable "Cache", ...
     $app;
  };

> 
> Titanium is an extension to CGI::Application and requires DBI for
> instance.  That's probably not right.
> 
> Jifty, Mojolicious, will also have prohibitively difficult dependencies
> for the run-anywhere case.
> 
> Squatting has a few XS dependencies, but perhaps they could be excised if
> required.  Dancer however seems to stand out at only 94kB tarball, minimal
> non-core dependencies and support for PSGI.  

Thanks for the research on those Perl web frameworks.

> The HTTP::Server::Simple::PSGI 
> dependency should let it support the 'instaweb' case with pure perl.

Or HTTP::Server::PSGI from Plack.

> > The trouble with splitting is installing split web script.  I have no
> > idea how to do this in cross-webserver way, cross-distribution and
> > cross-system way (the filesystem hierarchy used by web server may
> > differ from distribution to distribution, and from operating system
> > to operating system).
> 
> It should be possible for the script to figure out what filesystem path it
> is being run from, perhaps find a local lib/ dir and then add that to @INC.
> In shell scripts you just use FindBin, I don't know whether that is still
> expected to work from eg mod_perl but there's bound to be a solution for
> that.  So yeah I'd say just aim to ship lots of .pm files in a nearby dir
> alongside the script...

Errr... isn't FindBin considered harmful, and current best practice is
using Self::Dir, or just

        # __DIR__ is taken from Dir::Self __DIR__ fragment
        sub __DIR__ () {
                File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
        }
        use lib __DIR__ . '/lib';


And there is also App::FatPacker and PAR solution; pity that neither is
in core (well, for App::FatPacker it would be build time dependency only).

-- 
Jakub Narebski
Poland
