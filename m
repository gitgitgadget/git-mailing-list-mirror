From: Tatsuhiko Miyagawa <miyagawa@bulknews.net>
Subject: Re: [spf:guess,iffy] Re: "Integrated Web Client for git" GSoC proposal
Date: Sat, 17 Apr 2010 06:27:16 +0000 (UTC)
Message-ID: <loom.20100417T081957-371@post.gmane.org>
References: <201004130403.42179.chriscool@tuxfamily.org>  <201004150204.42813.jnareb@gmail.com> <1271293123.6248.147.camel@denix>  <201004161118.32163.jnareb@gmail.com> <1271473792.3506.30.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 08:30:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O31Xs-0001A5-Qu
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 08:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab0DQGaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 02:30:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:38175 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab0DQGaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 02:30:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O31XX-00013n-NH
	for git@vger.kernel.org; Sat, 17 Apr 2010 08:30:04 +0200
Received: from 154.14.204.web-pass.com ([154.14.204.web-pass.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 08:30:03 +0200
Received: from miyagawa by 154.14.204.web-pass.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 08:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.14.154.160 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145115>

Sam Vilain <sam <at> vilain.net> writes:

> > of CGI.pm, perhaps also using one of URI dispatchers[5][6].  Plack/PSGI
> > looks like the future of Perl web scripting... but is currently quite new,
> > at version 0.9930.

I admit that it's quite new - not old anyway, but don't get fooled by its
version number. It's already adapted by almost all perl frameworks and
used by lots of companies on production.
 
> Ok so PSGI is the port of Python's WSGI to Perl.  Plack is the reference
> implementation, and also quite heavy at 2.5MB tarball.

No, the tarball just contains 2.4MB of .jpeg file for large-file download
and upload testing. Its  dependencies are kept minimal - only requires
LWP, URI and some pure perl modules.

> required.  Dancer however seems to stand out at only 94kB tarball, minimal
> non-core dependencies and support for PSGI.  The HTTP::Server::Simple::PSGI
> dependency should let it support the 'instaweb' case with pure perl.

You can already use CGI::Emulate::PSGI (via Plack::App::CGIBin) to run
gitweb.cgi on Plack, or whatever web server that supports PSGI - like
HTTP::Server::Simple::PSGI you just mentioned.
http://gist.github.com/346068

> It should be possible for the script to figure out what filesystem path it
> is being run from, perhaps find a local lib/ dir and then add that to @INC.
> In shell scripts you just use FindBin, I don't know whether that is still
> expected to work from eg mod_perl but there's bound to be a solution for
> that.  So yeah I'd say just aim to ship lots of .pm files in a nearby dir
> alongside the script...

Or use App::FatPacker.

--
Tatsuhiko Miyagawa
