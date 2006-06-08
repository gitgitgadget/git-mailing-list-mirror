From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 8 Jun 2006 15:13:56 +0200
Message-ID: <dbfc82860606080613n5b5f6a5bs7a8f461a4188228c@mail.gmail.com>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060608120216.46722.qmail@web25908.mail.ukl.yahoo.com>
	 <dbfc82860606080506y52dc2771sbf6c90e7246ca4c9@mail.gmail.com>
	 <Pine.LNX.4.63.0606081415380.26091@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Sven Ekman" <svekman@yahoo.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 15:14:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoKKu-00010F-A4
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 15:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWFHNN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFHNN7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 09:13:59 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:39377 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWFHNN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 09:13:59 -0400
Received: by wx-out-0102.google.com with SMTP id h28so299738wxd
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 06:13:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=uCQ/s0nmBdGL83sxGJh/wutxEcK6Sstu7K3ZGbtjNv8qvU29Z/dzLxcIz5I4l6svKoMNOTWiIcsJ+hkPkU/WKZgBY8Sf6kvNuM5VdSrtJBSBHoTZJ//zRB6eWEZV9/SWW7orlVaYkHrZnc7VVZxb1ZCz7GbHSJs6+NWIrDpkxZw=
Received: by 10.70.25.9 with SMTP id 9mr2045430wxy;
        Thu, 08 Jun 2006 06:13:56 -0700 (PDT)
Received: by 10.70.66.6 with HTTP; Thu, 8 Jun 2006 06:13:56 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606081415380.26091@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 210d90610b1d0dc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21487>

On 6/8/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 8 Jun 2006, Nikolai Weibull wrote:
> > On 6/8/06, Sven Ekman <svekman@yahoo.se> wrote:
> > > <Johannes.Schindelin@gmx.de> skrev:

> > > Have you considered making ~/.gitconfig a directory?
> > > Maybe Git wants to store more data later.

> > I second that.

> I don't. What's wrong with the simple approach of a single config file?
> You can use a single tool for all the configuration, and do not need to
> care about anything.

Who said anything about something more than one configuration file?
It's nice to have a directory if we later decide to store other kinds of files
there as well, e.g., templates or some keyring information or something else,
perhaps not well-suited for storing in an ini-like file.

> > And it'd be nice if it was configurable through an environment variable,
> > e.g., GIT_USER_CONFIG_HOME.

> Let's see. AFAIK all programs I know (including cvs and vim, for
> one) have a fixed name. Hmm. Perhaps this is for a reason? Like, to reduce
> confusion?

That's hardly a very good reason.  It's not like you _have_ to use another name.

I keep as many configuration files as possible in ~/.local/etc/, as it
simplifies
keeping them in a Git repository.  Here's an extract from my .zprofile:

XDG_CONFIG_HOME=~/.local/etc
VIMINIT="so $XDG_CONFIG_HOME/vim/vimrc"
INPUTRC=$XDG_CONFIG_HOME/inputrc
INDENT_PROFILE=$XDG_CONFIG_HOME/indentrc
SCREENRC=$XDG_CONFIG_HOME/screenrc
GNUPGHOME=$XDG_CONFIG_HOME/gnupg
IRBRC=$XDG_CONFIG_HOME/irbrc
LFTP_HOME=$XDG_CONFIG_HOME/lftp
MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer
GTK2_RC_FILES=$XDG_CONFIG_HOME/gtkrc

The only programs that don't play along, yet, are Mozilla, OpenSSH,
and Subversion.  (Mozilla is actually compile-time configurable.)

But I guess I should be providing a patch instead of just a bunch of
reasoning for someone else to write one...

> Alternatively, we could introduce a config variable "core.globalConfig" to
> see where the global config is.

That is a very good idea.  We wouldn't need an environment variable in
that case.

  nikolai (who wonders if people can spot irony and sarcasm without extra help)
