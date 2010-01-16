From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Fri, 15 Jan 2010 16:43:32 -0800 (PST)
Message-ID: <m3ljfydgmt.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwlc-0000Iu-8A
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758337Ab0APAnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758299Ab0APAnf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:43:35 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:39285 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226Ab0APAne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:43:34 -0500
Received: by fxm25 with SMTP id 25so719793fxm.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=pzfqFg8GuIf2NEAhvotss2Zd/v8ldfmMTCwi+irsKBk=;
        b=QlC3swhMh/AxtOVGrykCrPrVWn0z+9NkuNlUInBzCaHtu7GTeisNeBjBfMt+02qM9A
         kQXF+/pDKbEswTKbFKTwOjFVqzauexX5qu+l/8X4/rDkMSxOFSGhQ+7errm/Q1fJSr0K
         6S4bmVDdi0V+Xg7klcoHRPOX1AHW3yP5K/HLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LtQDMqWPk3aK4FXyq0+yQVMPj8bbR0GRTSIpgbVsKvf5IiScky2PMVEVtOkPaLDkye
         W6bZhES2Hbov6m0gM/9fNV29fwCk2r6mlvTeoVFvFBtpKiONUfTgAlUAvKlnAV8rGMn9
         EP0q+VkC1bntqCLxImr0FmmRB3Cbtrb80Yi28=
Received: by 10.103.126.21 with SMTP id d21mr1523013mun.24.1263602612725;
        Fri, 15 Jan 2010 16:43:32 -0800 (PST)
Received: from localhost.localdomain (abwi123.neoplus.adsl.tpnet.pl [83.8.232.123])
        by mx.google.com with ESMTPS id e8sm8470779muf.47.2010.01.15.16.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 16:43:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0G0h7Nd032699;
	Sat, 16 Jan 2010 01:43:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0G0gp3h032691;
	Sat, 16 Jan 2010 01:42:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137174>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> This converts the output handling of gitweb to using an indirect
> file handle.  This is in preparation to add the caching layer.  This
> is a slight modification to the way I was originally doing it by
> passing the output around.  This should be a nop and this shouldn't
> change the behavior of gitweb.  This does leave error reporting
> functions (die_error specifically) continuing to output directly
> as I want to garauntee those will report their errors regardless of
> what may be going on with respect to the rest of the output.

Signoff?

Compare with my version of this patch:
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557
in the gitweb/cache-kernel branch:
  http://repo.or.cz/w/git/jnareb-git.git/shortlog/refs/heads/gitweb/cache-kernel


My commit message looks like the following:

....
gitweb: Print to explicit filehandle (preparing for caching)

This means replacing

  print <something>;
by
  print {$out} <something>;

and

  binmode STDOUT, <layer>;
by
  binmode $out, <layer>;

where $out is global variable set to \*STDOUT at the beginning of
gitweb, but after reading gitweb config.  This way it would be simple
to e.g. tie output filehandle or use PerlIO layers to simultaneously
write to standard output and to some specified file (like "tee"
utility does), or redirect output to a scalar, or a file.

die_error (re)sets $out to \*STDOUT; we would (probably) want to treat
errors in a special way, and do not cache them.

The only other differences are reindent of continued lines (if needed),
and sometimes word-wrapping lines which this change made too long.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
....

> ---
>  gitweb/gitweb.perl |  880 ++++++++++++++++++++++++++--------------------------
>  1 files changed, 448 insertions(+), 432 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c4a177d..8bb323c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -450,6 +450,13 @@ our %feature = (
>  		'default' => [0]},
>  );
>  
> +# Basic file handler for all of gitweb, there are two of them.  The first
> +# is the basic text/html file handler which is used for everything other
> +# then the binary files, that uses a separate file handler though
> +# these are both set to STDOUT for the time being.
> +our $output_handler = *STDOUT;
> +our $output_handler_bin = *STDOUT;
> +

First it is not file handleR, but filehandle.

Second, there is no need for separate filehandle for binary files, if
you do it correctly (i.e. call binmode on filehandle, and not on
STDOUT).  When caching is enabled, and 'print {$output_handle} <sth>'
prints to in-memory file (or even directly to cache file) it would do
conversion, so when reading from cache file we can dump it raw, in
binary mode.

Third, wouldn't it be better to use shorter variable name, e.g. $out
or $oh, instead of $output_handle?  We would be able to align print(f)
statements without making lines much longer.

Fourth, there is slight difference between
  our $out = *STDOUT;
and
  out $out = \*STDOUT;
In the former we have global variable, in latter we have indirect
filehandle.  CGI::Cache uses the latter form, IIRC.

> @@ -3313,7 +3320,7 @@ EOF
>  		if ($use_pathinfo) {
>  			$action .= "/".esc_url($project);
>  		}
> -		print $cgi->startform(-method => "get", -action => $action) .
> +		print {$output_handler} $cgi->startform(-method => "get", -action => $action) .
>  		      "<div class=\"search\">\n" .
>  		      (!$use_pathinfo &&
>  		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .

Here for example after change gitweb source stops being nicely aligned.
OTOH it makes for bigger patch.  In my version I did realign.

You can always check for true differences with "diff -w".


-- 
Jakub Narebski
Poland
ShadeHawk on #git
