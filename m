From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 23:10:47 +0200
Message-ID: <201005102310.47879.jnareb@gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com> <201005102040.36490.jnareb@gmail.com> <AANLkTilXqAUs5-go-JHgTrQuslTyA1sZ3re5yuLtnxkz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Tatsuhiko Miyagawa <miyagawa@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 23:11:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBaFr-0006Qb-L1
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab0EJVK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 17:10:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab0EJVKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:10:55 -0400
Received: by fxm7 with SMTP id 7so588628fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Kl2IGo3tYQydLVBCPOcKxjgG1yp++Zmt2myy8OZPgQo=;
        b=KHYWPnzLXkZsal3Pd9pLx0bttXAEBa4+p2Ai/Uq3jQ659tm+WiFj15RcYX2C2kvQcX
         jvlkDWMYLutLxfSsrKDoWvlz3Ti4Bs+lFGjWRsAbFeVVlFejHPrkKk4WdtBIDWmCPbWy
         PpQxTQ0IkO3H1yVIuRioL+hsfEHqjFee4h6tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PtZXqTMcyi8/+TnkRV5z7+EuUIGSaPksrcxhClgOS4MZ7YpLaSDMi6gl5jB9HnqajA
         aSNsN/gIt/Wrske6XLk1KzlHLrsI/P07xpYpJ8dEOKn1fhj0LNPrTk31ypNYPenhVgXA
         l8XbaDBQrui7K4/XiHb7r8aor6tafVHapRUH8=
Received: by 10.223.30.130 with SMTP id u2mr5052431fac.70.1273525853302;
        Mon, 10 May 2010 14:10:53 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id y12sm23241741faj.5.2010.05.10.14.10.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 14:10:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilXqAUs5-go-JHgTrQuslTyA1sZ3re5yuLtnxkz@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146852>

On Mon, 10 May 2010, Tatsuhiko Miyagawa wrote:
> On Mon, May 10, 2010 at 11:40 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Mon, 10 May 2010, Tatsuhiko Miyagawa wrote:
>>> 
>>> Yes, that makes sense - if implementing FastCGI is just switching CGI
>>> to CGI::Fast and a while loop, implementing PSGI interface just for
>>> that is far more complicated. I just argued about it because I saw on
>>> a separate thread that PSGI implementation is also on its way.
>>
>> What!?  No, currently there are no plans to add PSGI support to gitweb,
>> nor moving gitweb from CGI (and mod_perl's ModPerl::Registry, and
>> FastCGI now) to PSGI.
>>
>> This separate thread is about adding support for 'plackup' to
>> git-instaweb (and perhaps also adding gitweb.psgi wrapper).
> 
> Yes, that's what I meant.
> 
> If you get plackup support by converting your CGI application into a
> PSGI app, then adding support to FastCGI is just one command line
> option away.

Well, the support for 'plackup' in git-instaweb is / would be done not
by converting gitweb from CGI to PSGI app, but by using gitweb.psgi
wrapper.  This wrapper uses Plack::App::WrapCGI (which in turn uses
CGI::Emulate::PSGI, which in turn use CGI::Compile) to wrap gitweb.cgi,
and Plack::Middleware::Static to serve static files (gitweb.css,
gitweb.js, git-favicon.png, git-logo.png).

To be more exact in current, as yet unpublished version, git-instaweb
generates gitweb.psgi on-the-fly.  I am considering adding gitweb.psgi
wrapper to git repository (to git sources); when building git-instaweb
it would get embedded in $(gitexecdir)/git-instaweb, just like
gitweb.cgi, gitweb.css (or gitweb.min.css) and gitweb.js (or
gitweb.min.js) are.  Running git-instaweb for first time would create
_configured_ gitweb.cgi in $GIT_DIR/gitweb.  For "plackup" git-instaweb
would put configured gitweb.psgi (or app.psgi) there; for other web
servers git-instaweb puts httpd.conf there.

It is true that with gitweb.psgi wrapper running gitweb as FastCGI
script is just one command line option away.  But it does require Plack
to be installed... well, on the other hand the modified gitweb needs
FCGI module to be ran as FastCGI script, which is not a CORE Perl module
either.


I also wonder how running via wrapper script affect performance, as
compared to modified gitweb running as FastCGI script, using CGI::Fast
and FCGI.


P.S. A bit of history: original patch by Sam Vilain adding FastCGI
support by using CGI::Fast is from 2006.  Eric Wong patch adding
gitweb.fcgi wrapper (with 'no warnings; do $file' instead of modern
CGI::Compile->compile($file)) is from 2007.

I have originally replaced 'exit' in die_error() subroutine by non-local
jump to the end of request processing in ultimately a bit failed attempt
to use die_error() in CGI::Carp::set_message(), because when using
'exit' the error didn't get logged (unfortunately you can set error
message, but you can set HTTP headers for error message this way).

I have then noticed that this change would also allow to add FastCGI
support to gitweb in a very simple way.  Therefore I have ported Sam
Vilain patch to modern gitweb codebase.  Well, it did require some
restructuring of gitweb code (some refactoring), so it wasn't that
simple... nevertheless I think that this refactoring is mainly a good
change anyway.


P.P.S. One of constraints to gitweb development is that it should run
with minimal set of non-core modules.  Some people even complain that
gitweb (or was it about git in general?) requires at least Perl 5.8.6 or
about (because of Encode module and Unicode support).

If one wants Modern Perl git web interface, there is always Gitalist...

-- 
Jakub Narebski, Poland
ShadeHawk on #git at FreeNode
jnareb on #plack at irc.perl.org
