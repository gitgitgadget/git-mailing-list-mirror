From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to
	~/.gitexcludes.
Date: Thu, 26 Nov 2009 12:07:30 -0800
Message-ID: <20091126200728.GA2665@gmail.com>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr> <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr> <4B0E6DC9.3070105@drmicha.warpmail.net> <36ca99e90911260501q571929e5l114cb0af9f374a98@mail.gmail.com> <4B0E8529.3040609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 21:06:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkc5-0003gN-Di
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 21:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZKZUGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 15:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbZKZUGi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 15:06:38 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:49396 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbZKZUGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 15:06:37 -0500
Received: by pwi3 with SMTP id 3so640089pwi.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 12:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VwQS7nQPdv7pMkJdvCur7v1xD1jZiGeABW7AgNyUdu0=;
        b=l9VhjNaZZjAZ6vYSioP7fgX4W/sF0bEZz+NXuYa8m260jsqSbzdZZEYrLh0nI/aL9N
         LSxbE/nc4AkEG8HO7WgTuwVz2cEKlxR+UiuV4dsMznPZaRtcaNqF+gkdqYOWReCI6V1O
         LfYFqmmnE8RwNxdk1+Qh0hZ761nUhpPPyLFvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YYNeGNChChIt1uy0wm0ELkWKJN0azelocHg5ALd7I/wctRRrpBWwcHwSlJOWv8oe0S
         KzHVK4Pf2vX8z+vgCVc7X8rE6Tt56YR28aKy8/9DLwfq+CXQgIA2YwkQFPyz1CPD2u6c
         wLoFqJHXcNFCsJYP23/6+brRsqYDkuVDBOW4E=
Received: by 10.115.102.16 with SMTP id e16mr166932wam.202.1259266003544;
        Thu, 26 Nov 2009 12:06:43 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm696821pzk.12.2009.11.26.12.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 12:06:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B0E8529.3040609@drmicha.warpmail.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133831>

On Thu, Nov 26, 2009 at 02:39:53PM +0100, Michael J Gruber wrote:
> 
> Now, that is bike shedding ;)
> 
> It seems to me that all ~/.*rc that I have are config files (.bashrc,
> .xinitrc...), and all condif subdirs ~/.* are named by the
> program/subsystem (.qt, .kde, .gnupg), which we cannot do any more, and
> which is why I suggested .gitglobal. But I'd be fine with .gitrc.
> 
> > On the other
> > hand the --global option to git config specifies the .gitconfig in
> > your HOME.
> 
> That would have to change (ouch, ducking). Transition plan would be:
> 
> ~/.gitconfig, ~/.gitrc/config::
>         User-specific configuration file. Also called "global"
>         configuration file. Git looks in these locations in the
> 	specified order and uses the first one it finds.
> 
> $(prefix)/etc/gitconfig, $(prefix)/etc/gitrc/config::
>         System-wide configuration file. Git looks in these locations
> 	in the specified order and uses the first one it finds.
> 
> This would mean no surprises for users with existing config, one could
> teach the new preferred locations exclusively, and at some future point
> one could phase out the old paths.
> 
> Michael


If we're going to bikeshed then let's throw a standard in there:

http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html

~/.gitrc/ doesn't make sense (it's not a file) and ~/.gitglobal/
hurts my eyes.

"global"?  Huh?  Isn't it really user-specific?
Why not call it ~/.gituser/ then?

And what about the standard?
The silly standard says to use ~/.config/git/.


I'm quite happy with ~/.gitconfig and ~/.gitexclude if that's all
there is to git's per-user configuration abilities, especially
since ~/.gitexclude is less common.  _Much_ less common from
what I've seen in practice.

Being that we cannot predict the future then there is some
appeal to a top-leve ~/.config/git/-like directory.  But...


Like Junio said, I would stop only after adding support for
the new paths.  We don't want to confuse old or new users
and we should never deprecate existing ~/.gitconfig.


So now the "user" config is not just tied to one file but
is instead multiple files?  I dunno.. I kinda don't like
that but the only reason is because I'm going to have to
go and change code to take that into account.

When I have to change code for little added benefit
I ask questions.


What about:

	$ git config --global foo.bar baz

What file does that touch?
	~/.gitconfig or ~/.config/git/config?

What if ~/.gitconfig exists and ~/.config/git/config doesn't?
What about vice versa?

Okay, I also don't like it for that reason.


What if you jump between git versions?  Now the previous
question is much more important -- it means that we *must*
write to ~/.gitconfig to keep backwards compatibility otherwise
someone will config something with git-vNew and be surprised
when git-vOld does not find it.

And if we must write to ~/.gitconfig then
why does ~/.config/git/config even exist?


I guess all I'm saying is that I'm quite happy with
~/.gitconfig and do not see a compelling reason as
to why we'd need to transition to a different path.

Yes, I'm being lazy.  I don't feel like changing code
when stuff works just fine right now ;-)

And if we were to change it, then what about JGit,
Dulwich, GitSharp, etc?  Who's going to change those?


To quote an old famous horse, "No sir, I don't like it."

-- 
		David
