From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitosis-lite
Date: Mon, 24 Aug 2009 11:44:55 -0700 (PDT)
Message-ID: <m363cdm4pm.fsf@localhost.localdomain>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfeXk-0006UP-HY
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 20:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbZHXSo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbZHXSo6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 14:44:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46693 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbZHXSo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 14:44:57 -0400
Received: by bwz19 with SMTP id 19so1618420bwz.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LH5K3skWy6BLOGyFe8fnO1SGvEFT8lBnoHxFK1uEHkM=;
        b=Cf/JDKRaLUHzQqcFrOmfpJxFQATZrtrKJ902YHdjXM/Sn9x8rhgj81PXyaDwCpeGir
         UD/E5t6slwGO/Qu5mi41X6vxRruhZGMGjBA8cf8RmO/QOAQvEItFVOrAHyCn6d9s+OiB
         TEL+3UO9uKB2MgxYpVI2XHYBmzjfbfNyWBtcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Pofdm901H9NuW4LZIygRJ1sRHPS8UcXnhQv3PNpWwJr8TK0xS5kP+HMSqmZgW564do
         GGgnjHG3E55As98nF12O/PumsZMSl23tpA6IKG0fzH/RcXUTcRMCGBMsvfOfMnGInP3P
         Ll72e4IgT2S/ntZqrpYiPTod2zBMKSVPyhAAg=
Received: by 10.103.126.36 with SMTP id d36mr2079773mun.104.1251139497400;
        Mon, 24 Aug 2009 11:44:57 -0700 (PDT)
Received: from localhost.localdomain (abwd173.neoplus.adsl.tpnet.pl [83.8.227.173])
        by mx.google.com with ESMTPS id 12sm23582187muq.59.2009.08.24.11.44.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 11:44:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7OIiuUJ024240;
	Mon, 24 Aug 2009 20:44:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7OIis4g024237;
	Mon, 24 Aug 2009 20:44:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126954>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> I created a new project called gitosis-lite, which combines
> the essential pieces of gitosis with the per-branch
> permissions stuff in the example in the howto directory of
> git.git.

As for the name: gitness, gitamine, gitrify,... ;-)
 
> The config file is different, (there's an annotated example
> you can look at).
> 
> The "why" and the "what" are all at
> http://github.com/sitaramc/gitosis-lite

A few comments about the code, taking gl-auth-command as example.

> #!/usr/bin/perl -w
>
> use strict;

Wouldn't it be better to use "use warnings" instead of 'perl -w'?

> # === auth-command ===
> # the command that GL users actually run
> 
> # part of the gitosis-lite (GL) suite
> 
> # how run:      via sshd, being listed in "command=" in ssh authkeys
> # when:         every login by a GL user
> # input:        $1 is GL username, plus $SSH_ORIGINAL_COMMAND
> # output:
> # security:
> #     - currently, we just make some basic checks, copied from gitosis
>
> # robustness:
>
> # other notes:

It would be, I think, better if you have used POD for such
documentation.  One would be able to generate manpage using pod2man,
and it is no less readable in source code.  See e.g. perl/Git.pm or
contrib/hooks/update-paranoid.

> our $GL_ADMINDIR;
> our $GL_CONF;
> our $GL_KEYDIR;
> our $GL_CONF_COMPILED;
> our $REPO_BASE;
> our %repos;

Why is the reason behind using 'our' instead of 'my' here?

> # first, fix the biggest gripe I have with gitosis, a 1-line change
> my $user=$ENV{GL_USER}=shift;       # there; now that's available everywhere!

Eh?  This is standalone script, isn't it?  Shouldn't it be

  my $user = $ENV{GL_USER} = $ARGV[0];       # there; now that's available everywhere!

> my $perm = 'W'; $perm = 'R' if $verb =~ $R_COMMANDS;

Either split it into two lines, or use ?: confitional operator:

  my $perm = ($verb =~ $R_COMMANDS ? 'R' : 'W');

> open(LOG, ">>", "$GL_ADMINDIR/log");
> print LOG "\n", scalar(localtime), " $ENV{SSH_ORIGINAL_COMMAND} $user\n";
> close(LOG);

It is better practice to use lexical variables instead of barewords
for filehandles:

  if (open my $logfh, ">>", "$GL_ADMINDIR/log") {
  	print $logfh "\n", scalar(localtime), " $ENV{SSH_ORIGINAL_COMMAND} $user\n";
  	close $logfh;
  }

Don't forget to check for error.

> $repo = "'$REPO_BASE/$repo.git'";
> exec("git", "shell", "-c", "$verb $repo");

That's not enough.  You have to shell-quote $repo, like in gitweb or
using String::ShellQuote module, or somehow use list form to pass
arguments to git-shell.  You protect here againts spaces in filename,
but not againts "'" (single quote) and for show shells "!"
(exclamation mark).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
