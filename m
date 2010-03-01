From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb problem?
Date: Mon, 01 Mar 2010 02:24:13 -0800 (PST)
Message-ID: <m3bpf8mj5k.fsf@localhost.localdomain>
References: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Mar 01 11:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm2nX-0001MV-V1
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 11:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739Ab0CAKYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 05:24:17 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59810 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0CAKYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 05:24:17 -0500
Received: by fxm19 with SMTP id 19so530646fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=b8RqcVdvXgE3Odid8VqW1U6SRIkAHtXjpO1vqTKS24Q=;
        b=D8lPrb2IslOE+pTK2jwwzL2C1zX4hHsCdL1Y5r+IDjxa03lJhtoFD5fn1xn5FdUrut
         I3CLan2I4RJd9ZbNk+hza5iEJ4GvJ31XDX3KJ9mmmdtZQL2GLGeaN/Y999Z1elWI9spD
         PN2ZDx3gaVXdXW2qcZ1fftu0LkRyiIZO1Iduw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=CFiBgMTapCLxXwua+NtJqT5pIaGqxWevsB7wIqNDTM63nDPZ/wm651XanPgje+vWZ5
         9c1V3IkVXEJCg95Unwvv6/pcA2iQEpBWR0w458NDBUt6KE2ecpf5DpPLKjirA1gXiyuS
         cOcUdO3IZmXScOHo+YYrW5VfXRQbfo+lA48z8=
Received: by 10.102.207.40 with SMTP id e40mr3318082mug.86.1267439055080;
        Mon, 01 Mar 2010 02:24:15 -0800 (PST)
Received: from localhost.localdomain (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id u9sm16839672muf.39.2010.03.01.02.24.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 02:24:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o21ARaUE007634;
	Mon, 1 Mar 2010 11:27:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o21ARKXs007623;
	Mon, 1 Mar 2010 11:27:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141311>

Eli Barzilay <eli@barzilay.org> writes:

> Whenever I view the toplevel gitweb page (running as a cgi script
> under apache), but not when in a specific repo, I get this in my error
> log:
> 
> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2065.
> fatal: error processing config file(s)
> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2221.
> gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2218.
> 
> (taken verbatim from the apache error log, removed uninteresting line
> prefixes.)

In the future (or if my diagnosis would turn out to be incorrect)
could you please show which lines are those (in *your* gitweb.cgi),
or at least provide gitweb version?  Changes to gitweb can render
such line numbers invalid.
 
> I'm using the pathinfo option, so perhaps there is a problem with that
> setup?

In the future (or if my diagnosis would turn out to be incorrect) could
you please include relevant parts of $GITWEB_CONFIG (by default it is
gitweb_config.perl), at least which features you have enabled, and how
they are configured?

> 
> Looking at the source, the last two line numbers are in
> `git_get_project_config' -- so my guess is that the code is trying to
> get the options from the repository config file even when showing the
> toplevel page.  Based on this, and also guessing that $git_dir is
> unset when viewing the toplevel page, I added
> 
> 	return unless (defined $git_dir);
> 
> to the top (of the `git_get_project_config' function), and I get no
> warnings and everything works as it should.
> 
> (Disclaimer: I can barely read perl, and I'm a git newbie, so all of
> this can be due to some other stupid mistake.)

That looks like lack of hardening against pilot error.  The
git_get_project_config should never be run when $git_dir is not set, as it
is meant to access *project* config.  

But at the top of git_project_list_body subroutine, which is responsible for
generating toplevel page with list of projects, we have:
	my $check_forks = gitweb_check_feature('forks');
and a bit later
	my $show_ctags = gitweb_check_feature('ctags');

Now both of those features are marked as not supporting project specific
override.  It might be that you by accident set $feature{XXX}{'override'}
to true... but I might be mistaken.


It would be strange that this bug was not detected by t9500 test...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
