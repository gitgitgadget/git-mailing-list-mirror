From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Wed, 18 Feb 2009 23:30:22 -0800
Message-ID: <20090219073020.GC25870@gmail.com>
References: <20090216212459.GA25046@efreet.light.src> <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com> <20090217192825.GA2216@efreet.light.src> <e5bfff550902180004x5e10e391wb80988fa892da413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:31:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3NS-00017s-8F
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbZBSH3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbZBSH3p
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:29:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:16748 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZBSH3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:29:44 -0500
Received: by rv-out-0506.google.com with SMTP id g37so296207rvb.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+/FpE+632CWBLNFEN2JgmZEcIq3GTzHwkQLK3/p/s/w=;
        b=q41T996epevPklR0plCHuEPaBl/FJuvLsantW3QzLpa7op2IytdpdOP2zHJWGtyPkc
         PVBUyjqmcJz3fZ6lA92WXnA2bLtcbCUS5+ponF//CRerALo5NgJFdAxfbYJa12wRWs0C
         PdiJEt4i9TUVeru+7KXfk+x0rRjSv3BsQRshw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=svbr2a7OHBnGax5zZqnrtVeBo0+hAe7yStHe9RqGzL/mOEn9gQpulUb77+/TFh3eNo
         ZeGob1rQa15kG20hetmpKT/MRrC1kVA1TTj1D6oCe55Wz88nzDT6guNNeOFGiYIOTweU
         5lWeIZa13yA23tA4Rigs3W66QxZNiEJYx5F5U=
Received: by 10.141.36.17 with SMTP id o17mr4434298rvj.261.1235028582951;
        Wed, 18 Feb 2009 23:29:42 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g31sm1984964rvb.7.2009.02.18.23.29.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:29:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e5bfff550902180004x5e10e391wb80988fa892da413@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110634>

On  0, Marco Costalba <mcostalba@gmail.com> wrote:
> 
> I understand the main reason, as per any GPL project, is having fun
> and good time coding and exchanging ideas with peers, but I really
> lack time and I am now moving to different interests. So, thank you
> very much, but I think I'll stick with qgit.
> 
> Best
> Marco


One thing, though, that I think everyone can agree on is
that getting a common lib for git guis is really step #2.

Step #1 would be to work towards libgit, since it is something
that everyone would benefit from regardless of language or
toolkit.  I know that Shawn and co. have been working
towards this goal.  Keep it in C, keep it simple, and
keep git stupid.  A solid C core is portable and easy
to wrap for Python, Ruby, Perl, etc.

BTW I recall that one of the first questions in this thread
was "what toolkit" with proposed choices of QtCore, glib,
POSIX+Msys, etc.

Just my $.02 -- I feel that the POSIX + MSys combination
is the most viable solution since it has already been
proven by the hard work of the msysgit team.  It is also
the environment which is most familiar to core git
developers and thus there is much benefit to staying
within that world.  It's also the same choice made
by Shawn in his libgit efforts.

The fact that git's output is identical regardless of
platform (for instance, git ls-files always uses "/" as
its path delimiter, even on windows) is really what
has made creating portable git guis possible.

Git to me is like a familiar and happy land that I know
I can escape to even if I have the misfortune of being
stuck on a windows machine.  Thus, a system like msys
that bends over backwards trying to make windows into
something unix-like feels like the right way to go if
you ask me.  I'm *not* a windows user, though =)

-- 

	David
