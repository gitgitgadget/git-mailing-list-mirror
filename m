From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why /var/cache/git?
Date: Tue, 26 Oct 2010 09:47:55 -0700 (PDT)
Message-ID: <m3y69kj40i.fsf@localhost.localdomain>
References: <20101025103006.GA18782@brong.net>
	<4CC5A13F.2090702@eaglescrag.net> <20101026012224.GA3360@brong.net>
	<1288099299.8291.6.camel@drew-northup.unet.maine.edu>
	<20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Bron Gondwana <brong@fastmail.fm>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 26 18:48:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAmh1-00086G-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 18:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090Ab0JZQsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 12:48:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37854 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759628Ab0JZQr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 12:47:58 -0400
Received: by fxm16 with SMTP id 16so4289207fxm.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1LsYVtaPQzzfi2Te8nrV9lsJyo/MFwv0JHYesQDSs0E=;
        b=lMGuZ/8eKgQTg60APKslbeuui1Ih4jsr1HCHd/BjfsqmYkw90inDUJKcTgLtA20KIk
         W3sdQuUQpGl3cnXrWAe2yH8CU8TPMG2jPIm5gfkxjmmwpzOTI8L6kRENxfqLwNvvZXbR
         1suwJNTK/UWHpYgOkX376kZr9WO438/62psOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=C5NNLg/o0Nflia6bh9MgTkBl5QdwFe/J3f+sq0JeAHsGNTXcVBqXoiXOyHmiBN3DPR
         aAEZZVm9/LabAviP0dxMmoxbJKe1uUzl1A+0iwDuYOjIMzObePUu7gW/bZlBdvGV5VGy
         Yaov3h9DYQwGHZxoACHkm9ZSXBgdO4tn4quVY=
Received: by 10.223.79.2 with SMTP id n2mr1061684fak.133.1288111677039;
        Tue, 26 Oct 2010 09:47:57 -0700 (PDT)
Received: from localhost.localdomain (abwo92.neoplus.adsl.tpnet.pl [83.8.238.92])
        by mx.google.com with ESMTPS id j8sm3654962fah.6.2010.10.26.09.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Oct 2010 09:47:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9QGl5Hv010884;
	Tue, 26 Oct 2010 18:47:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9QGkbsL010878;
	Tue, 26 Oct 2010 18:46:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159998>

Gerrit Pape <pape@smarden.org> writes:
> On Tue, Oct 26, 2010 at 09:21:39AM -0400, Drew Northup wrote:
> > On Tue, 2010-10-26 at 12:22 +1100, Bron Gondwana wrote:

> > > I have no problem with /var/git - it's /var/cache/git that worries
> > > me, since the FHS quite clearly says that blowing away /var/cache/*
> > > is not a problem.  It makes sense to back up /var/lib/ on any machine,
> > > since that's somewhere that contains application data.  We already
> > > back up a few things from /var/lib (like /var/lib/svn for example,
> > > at least until we finish this switchover!)
> > 
> > Doing a 'git grep "/var"' on the git sources and then searching that
> > output for "cache" turns up nothing. I think you'd best bring this up
> > with the Debian package maintainer. Debian is well known for thinking it
> > knows better than the original authors where stuff should be--and that's
> > why I don't run Debian as a server (too much time spent transliterating
> > paths just to make stuff work properly--when I'm lucky; it makes an
> > excellent desktop for beginners).
> 
> Hi, it's also not my preference, but Debian adheres to the FHS.
> Unfortunately /var/git is not allowed by the FHS, so a different
> location must be chosen for Debian.  I chose /var/cache/git/, and
> suggested to populate that directory with symlinks to the repositories
> that should be available through git-daemon or gitweb, see
> http://bugs.debian.org/483788

Where did you get '/var/git' from?  "git grep /var/git" finds it
mentioned in one place in git-cvsserver manpage and in two places in
gitweb/README.  But git-daemon and gitweb's defaults are /pub/scm/git
or /pub/git - they are FHS-compatibile, aren't they?

So why Debian doesn't use either /pub/scm/git or /pub/git for 
git-daemon, git-cvsserver and gitweb?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
