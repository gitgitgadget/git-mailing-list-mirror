From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 12:11:20 -0400
Message-ID: <fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	 <Pine.LNX.4.64.0707261534550.14781@racer.site>
	 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	 <Pine.LNX.4.64.0707261638100.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE5w1-0005BN-9Q
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 18:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbXGZQLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 12:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbXGZQLX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 12:11:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:37955 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbXGZQLW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 12:11:22 -0400
Received: by wr-out-0506.google.com with SMTP id i30so350850wra
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 09:11:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Awi/y97c9KGF/IZL3NP3SNTg2gDCkoYLjfivMDjw18fULJVC0SjDl0J3Pj6K6lMCM8Q7Y+Gp9rwPagO4Vw/QpGWt07zp6F1ECkG1XkQAas8hSZB/eeXj/sKrLSjxzqSQESxH2X2jPNZT73muILQ0n9wMq/C5SMpmJhKp+O1ETlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=il+G9XqjUkj6UaLfRCemWzMVQj2TLFdi4SzKziNSHN9pVILQEzTxPpkC7zBgsjcobT0fgVL6WghqNwaNX01uVq0wyEKzZ7738zxIM2xYt7pPv6mPyFKWUKKMkwbOC9rC07I5Pm4aZxcPegaqduB66IGzRwR8MkM+Lwff+NWHYEs=
Received: by 10.100.190.8 with SMTP id n8mr1551153anf.1185466280328;
        Thu, 26 Jul 2007 09:11:20 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 09:11:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707261638100.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53841>

On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>
> > I make MinGW busybox part of git for some reasons:
> >
> > - Making a full MinGW busybox would take lots of time. I don't need
> > busybox for Windows. What I need is a shell and enough POSIX utilities
> > to run git shell scripts without any dependencies. Windows users
> > (including myself when I have to use Windows) hate dependencies.
>
> I think that if you succeed to compile ash on MinGW, the rest is easy.

No it's not. With a couple of ifdefs you can compile it fine. Then
there goes fork(), fcntl(F_DUPFD), /dev/*, job/signal handling...
Fortunately Git does not use lots of features. It only needs /dev/null
(and /dev/zero for tests), SIGEXIT and no job usage.. That cuts down
the effort porting ash.

> > - I don't want MinGW busybox to be used outside of git (if it is
> > installed separated from git), there are cygwin and msys already. I
> > don't want to compete them. And I don't like conflicts (not sure
> > though) because you have multiple UNIX emulations on the same system.
>
> But you'd be my hero.

Can't say I don't love to ;-) It's just that I don't have enough time.
Once project "busybox for Windows" is born, people may scream for
features. Even if they don't, there are still bunch of work because I
have only ported a small number of tools. With Git as its sole
customer, I can beg Git contributors to limit POSIX tools that they
use.

But if someone steps up for the project, I'm all for it.

> Installing Cygwin is often overkill if all I need is just a tiny shell
> with just enough POSIX tools to run my scripts.

I see your point. Although you can install git and have git-box to
play with (oh spread git! lolz) Just keep in mind you don't have all
POSIX tools.

> > - MinGW busybox (or gitbox as I call it now) utilizes compat/mingw.c
> > and other stuff like run-command.c... Making it separate (as source
> > code) duplicates code for nothing.
>
> It is not duplication.  It is forking.  Which is a good thing.

I still don't see why duplicating compat/*, git-compat-util.h,
run-command.[ch]... and keeping fixing bugs in two places is a good
thing.
-- 
Duy
