From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 12:32:30 +0200
Message-ID: <201005101232.32908.jnareb@gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com> <201005100105.49985.jnareb@gmail.com> <x2k693254b91005091805re0f63ac5z471e05fa4ab71ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Tatsuhiko Miyagawa <miyagawa@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 12:32:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQIB-0003AE-Px
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab0EJKcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 06:32:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38542 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953Ab0EJKcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 06:32:50 -0400
Received: by fxm10 with SMTP id 10so2165127fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8NXrp1IY7QO81rNHSPWjapeZvKXel21x7dnfPsLdiVo=;
        b=D9gScAo9EfR1IfwmiMgAxX+Gsf9mZTd+fITiIN9MCrHtbNaNMB1aXhbOelp46TyTae
         XoGb024dCnv16A3lyysxSG3mhbd5Y6ztcQ65jjVlQePHrS4TPlXj68Wq0/kB74Nncld/
         wN6uny9o96daCr1QwJgA75e/8874RrU9HXJgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=R3InZperG+n0f4yZTuzH/cZ6A+26IgAg/EsTqFNjDT7ERLWRnb5AudvZlkWOJSU3Hx
         lvx6awD2dvzlX8mU/QNHjWMNonYo1sPeFNekazQXydXb0utGagpcT+TpIhbqvKd9hmML
         QyxV4pamYgYpCVGKzN9d+pctdykkvJBMaRWzA=
Received: by 10.223.17.197 with SMTP id t5mr4012869faa.84.1273487568672;
        Mon, 10 May 2010 03:32:48 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id 13sm20878683fad.19.2010.05.10.03.32.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 03:32:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <x2k693254b91005091805re0f63ac5z471e05fa4ab71ca7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146792>

On Mon, May 10, 2010, Tatsuhiko Miyagawa wrote:
> On Sun, May 9, 2010 at 4:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> 
>>> `plackup -s FCGI` makes your PSGI app a fastcgi handler using FCGI.pm,
>>> or `plackup -s Net::FastCGI` does the same but using Net::FastCGI,
>>> pure perl alternative.
>>
>> It is a pity that Plack::App::WrapFCGI / FCGI::Emulate::PSGI does not
>> exist, so that gitweb.psgi wrapper would not require indirectly
>> CGI::Compile.
> 
> I *think* we discussed about this on IRC, but you still seems to be
> misunderstanding:

I'm sorry for the confusion; I didn't make myself clear (and there also
was some misunderstanding of technologies involved on my side).

> 
> You have a CGI script and you want to turn it into a PSGI application,
> hence we have CGI::Emulate::PSGI and CGI::Compile.
> 
> You usually do not have a FCGI "application". You're writing a .fcgi
> "wrapper" to make your CGI script runnable from a web server (like
> you're doing with gitweb.fcgi).

After thinking about it a bit, I realized that I don't want to have
Plack::App::WrapFCGI wrapper (which if there are no FastCGI-only Perl
web apps, e.g. using FCGI directly and which do not have support for
running as ordinary CGI would be totally unnecessary), but I want to
avoid price of using CGI::Compile.

>From what I understand Plack::App::WrapCGI does something like that
(example taken from CGI::Compile manpage):

   use CGI::Emulate::PSGI;
   use CGI::Compile;

   my $cgi_script = "/path/to/foo.cgi";
   my $sub = CGI::Compile->compile($cgi_script);
   my $app = CGI::Emulate::PSGI->handler($sub);

   # $app is a PSGI application


A typical application that uses CGI::Fast to provide support for running
as FastCGI script looks like this, according to CGI::Fast manpage 
(the example is slightly modified):

   use CGI::Fast;

   do_some_initialization();

   while ($q = new CGI::Fast) {
      process_request();  # it uses 'my $cgi = CGI->new()' inside
   }

I'd like to use the fact that per-request part is separated from
initialization part in wrapper for PSGI.

  use CGI::Emulate::PSGI;
  use CGI::Fast::Loader; # or something like that

  my $fcgi_script = "/path/to/foo.fcgi";
  my $fcgi = CGI::Fast::Loader->load($fcgi_script);
  $fcgi->import(qw(do_some_initialization process_request));

  do_some_initialization();
  my $app = CGI::Emulate::PSGI->handler(\&process_request);

   # $app is a PSGI application


That is of course heavy handwaving, and I am not sure if it is something
that can be generalized for scripts that use FCGI module (and 
FCGI::Request) directly.

> 
> Writing an FCGI emulation layer for PSGI would allow you to run the
> FCGI wrapper from PSGI compatible web server - which does not make
> sense AT ALL!. It's even one more indirection.

Well, it would allow to run FastCGI application in *any* PSGI compatibile
web server, including standalone (HTTP::Server::PSGI), mod_perl and
Test::Plack 'server'.

Also even if wrapping FCGI application as PSGI application to run it
on FCGI server doesn't make much sense on first glance, it neverheless
allows to use many, many Plack::Middleware::*.

Mind you, I don't think that there are many FastCGI-only Perl web apps...
if there are any.


I hope that clarify what I want (and no, I guess FCGI::Emulate::PSGI
ain't it).
-- 
Jakub Narebski
Poland
