From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Mon, 10 May 2010 17:29:03 +0200
Message-ID: <201005101729.07334.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005092018.54580.jnareb@gmail.com> <20100510071340.GA3382@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Mon May 10 17:29:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBUvF-0003NA-5H
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 17:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab0EJP32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 11:29:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35624 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab0EJP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 11:29:25 -0400
Received: by fxm7 with SMTP id 7so202837fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=X2BcxH9VAGX6QbzSTe2HTaYte1aa33h9MOvRDpmELPE=;
        b=pjCtSQ9fow9LEHmJvg1f+NhXxXQdTzfcWloHiC3gpKXSK5IS+hk6Jizk96H1YRmrWD
         lwg6VGw/xr0aKYM+9WkVQi1ZpXpyd8btAsd7q3WF93XxZucf8g8po+yIaM1/t3/yNzoc
         fjq5IFeY/O6RmWcPKRQXLoZki66g8oVmDF7Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=j59O/Oo++uOmSow9n1zb4uJlHJXo0ny0Gm/Td708BHEe/keLCZeySiUmc+R7fX0T1W
         Nn41MnVrwqnnrZQMDky3viC2vcsO6lVJlZPAx3AvifuNTiCSS7AZpofBF09+MK/JHfEV
         T44tAgzjAMNoRujLvd7KQu1FHeP6RaJ+qU1rQ=
Received: by 10.223.17.150 with SMTP id s22mr480067faa.14.1273505364036;
        Mon, 10 May 2010 08:29:24 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id u12sm21956601fah.16.2010.05.10.08.29.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 08:29:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100510071340.GA3382@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146821>

On Mon, 10 May 2010, Peter Vereshagin wrote:
> 2010/05/09 20:18:52 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
> 
> Great! I was just about to ask on caching, etc. What a complex history on all
> of that, will be on those tracks after some of my whiles. ;-)

You can find current state of my take on gitweb output caching (based
on / inspired by work by John 'Warthog9' Hawley) in my repository on
repo.or.cz, in the 'gitweb/cache-kernel-pu' branch:

  http://repo.or.cz/w/git/jnareb-git.git  gitweb/cache-kernel-pu
 
You can find progress reports (and what current show-stoppers are) in
git mailing list archives.


Note that http://repo.or.cz does its own gitweb caching, IIRC by
caching Perl data, and only for 'projects_list' page (the most costly
one).

There was also "Gitweb caching" projects in GSoC 2008 by Lea Wiemann,
which IIUC cached output of git commands. This project was, I think,
completed but didn't get merged into git.

> JN> What are required changes to gitweb to use FCGI::Spawn to run gitweb as
> JN> a FastCGI script?  Alternatively, how the wrapper script for gitweb 
> JN> (gitweb.fcgi) to be run as FastCGI should look like to use FCGI::Spawn?
> 
> By far it's only an exit() of the what I use (1.6.0.6):

Why so old git?  Current version is git version 1.7.1

> 
> --- /usr/local/share/examples/git/gitweb/gitweb.cgi     2010-02-25 13:49:30.068287112 +0300
> +++ www/gitweb.cgi                                      2010-03-13 14:28:45.326244103 +0300

Hrmph.  Why not use "git diff --no-index <file1> <file2>" here?

The Perl-aware equivalent of '-p' option of GNU diff, i.e. showing in
which function we are in hunk headers, would help here.

> @@ -933,7 +933,7 @@
>         die_error(400, "Project needed");
>  }
>  $actions{$action}->();
> -exit;
> +#      exit;

This 'exit' was here just in case there were some forgotten code below
this line outside subroutines (that should not be run).  It can be
safely removed.

>  
>  ## ======================================================================
>  ## action links
> @@ -3371,7 +3371,7 @@ sub die_error {

I have added my guess of in which subroutine this code is above.

>  </div>
>  EOF
>         git_footer_html();
> -       exit;
> +#              exit;
>  }

Err... and gitweb works correctly with this change?  This 'exit' was
required for die_error to function like 'die' in that it finishes
serving request, and should not continue subroutine it was called
from.

I have changed this 'exit' to non-local goto to toplevel.  It could be
done instead by redefining 'exit' subroutine, like shown below, but I
feel that would be hacky if you can change gitweb code (it is not
black box you should not touch).

>  
>  ## ----------------------------------------------------------------------
> 
> but it's probably even not necessary with -e parameter:
> http://search.cpan.org/~veresc/FCGI-Spawn-0.16.1/fcgi_spawn#Command_line_options
> which is definitely required for bugzilla, the worst boy in that sandbox. The
> parameter does just this: 
> ===
> my $cref = sub {
>   if ('FCGI::ProcManager' eq scalar caller) {
>     CORE::exit @_;
>   } else {
>     no warnings;
>     last CALLED_OUT;
>   }
> };
> *CORE::GLOBAL::exit = $cref;
> *CORE::GLOBAL::exit;
> ===

This is quite nice idea to replace 'exit' by subroutine that does
non-local jump to outside of application, at the end of request loop.
Such "monkey patching" is the only solution if you can't or shouldn't
modify application code (like FCGI::Spawn being generic solution).

> so this requires configuration 
> ( $PREFIX/etc/fcgi_spawn/preload_nonprepared_01.pl, in my case ) for fcgi_spawn
> daemon like this:
> ===
>   $spawn->{ callout } =  sub{ do shift;
>   CALLED_OUT: 
>   };
> ===

Here

   $spawn->{'callout'} = sub {
   	my $cgi_app = shift;
   	do $cgi_app;

        # this is needed for sane error handling
        die "Couldn't parse $cgi_app: $@" if $@;

   CALLED_OUT: 
   };

could be simply replaced by

  use CGI::Compile;

  # ...

  $spawn->{'callout'} = \&{CGI::Compile->compile}

or something like that.  See CGI::Compile manpage and CGI::Compile source:
http://cpansearch.perl.org/src/MIYAGAWA/CGI-Compile-0.11/lib/CGI/Compile.pm

>
> All of that is not needed without exit() in gitweb, now.

BTW I wonder what are the consequences for performance on replacing
'exit' by non-local jump.  It can degrade performance a bit for gitweb
run as pure CGI (mod_cgi / mod_cgid), but should improve performance
for mod_perl, at least if there are more connections... unless
ModPerl::Registry does similar trick with exit().

> 
> I didn't mean FCGI::PM is a problem by itself. The standalone gitweb daemon is
> great thing for those who need such a choice. FCGI::Spawn is just for some
> different task: to put several ( wish to say: any CGI app ) applications inside
> the same fork()ed processes. It should be just obviously documented for a user
> as a dependency for implementation of a gitweb fastcgi daemon. Although I'm not
> sure if the FCGI::PM package should be a dependency for git package for any OS:
> for those modules use()d in eval() my guess is: particular user's choice to be
> offered.
> 
> So FCGI::PM usage I think makes a flavor taste for any daemon and thus should
> be explicit. YMMV for those uninvolved in daemonizing, of course. ;-)

Hmmm... is FCGI::Spawn really needed, or can it be replaced by simple
PSGI wrapper using either Plack::App::CGIBin, 

  use Plack::App::CGIBin;
  use Plack::Builder;

  my $app = Plack::App::CGIBin->new(root => "/path/to/cgi-bin")->to_app;
  builder {
        mount "/cgi-bin" => $app;
  };

or Plack::App::WrapCGI plus Plack::App::URLMap, the last indirectly
via Plack::Builder DSL:

  use Plack::Builder;
  use Plack::App::WrapCGI;

  builder {
        mount "/foo" =>
                Plack::App::WrapCGI->new(script => "foo.cgi")->to_app;
        mount "/bar" =>
                Plack::App::WrapCGI->new(script => "bar.cgi")->to_app;
  };

> 
> Is it probable that gitweb doesn't take any POSTs requests? The main trick
> around FCGI::Spawn is the need to patch the CGI.pm but if that is the case...
> I'd try to redefine the STDIN to /dev/null or zero so FCGI.Spawn.CGI.pm.patch
> should be unnecessary for one who only wants to run the gitweb in FCGI::Spawn.
> If switch to FCGI.pm will be way complicated to me.

Errr... excuse me, what you wanted to say in the paragraph above?

Gitweb doesn't use no POST requests: it is read-only web repository
browser... well, except for the 'show_ctags' action.
-- 
Jakub Narebski
Poland
