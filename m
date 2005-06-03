From: Daniel Serpell <daniel.serpell@gmail.com>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 18:01:06 -0400
Message-ID: <f0796bb7050603150168c1db95@mail.gmail.com>
References: <20050603152212.GA4598@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
	 <1117814982.32257.64.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org>
	 <1117819137.32257.75.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org>
	 <1117827011.8970.2.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031320190.1876@ppc970.osdl.org>
	 <1117832172.8970.22.camel@jmcmullan.timesys>
	 <Pine.LNX.4.58.0506031410560.1876@ppc970.osdl.org>
Reply-To: Daniel Serpell <daniel.serpell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jun 03 23:58:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeKAu-0008Ft-0M
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 23:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFCWBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 18:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFCWBI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 18:01:08 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:60586 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVFCWBG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 18:01:06 -0400
Received: by wproxy.gmail.com with SMTP id 69so424670wra
        for <git@vger.kernel.org>; Fri, 03 Jun 2005 15:01:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oCZGhug586uwxXbcb0PISNaesrSIulfy1OE/HTFAviA9ScS+WNYlRf/gXXQo+tQRKmEq0x/bS4mCY4+vH+AluZMIeaMhBrQ7wZTRt72p1EAjienSBpVMLVIMpKT9BS8GDiMdJFZuonlS7U40O38MNmtL6ms579oNbB+WD4ArkRQ=
Received: by 10.54.30.54 with SMTP id d54mr1446436wrd;
        Fri, 03 Jun 2005 15:01:06 -0700 (PDT)
Received: by 10.54.18.74 with HTTP; Fri, 3 Jun 2005 15:01:06 -0700 (PDT)
To: GIT Mailling list <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506031410560.1876@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/3/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Fri, 3 Jun 2005, McMullan, Jason wrote:
> >
> > 3) Because I can't figure out how to get /bin/sh to give me two pipes
> >    that hook together two processes. What I really want:
> >
> > ssh user@remote git server --db /my/git.git <|> git server request HEAD
> 
> Ok, so a ssh connection _would_ work per se, and the only real issue is
> the pipe itself is one-directional as done by the shell?
> 
[...]
> Anyway, with _something_ like the above you could do something like
> 
>         git-sync --exec "ssh master.kernel.org git-sync" ....
> 
> and it would do the obvious thing.
> 

I would prefer a command line more like the rsync one:
       git-sync master.kernel.org:directory  ....

Or:
       git-sync :ssh:master.kernel.org:directory  ....

Or "uri like":
       git-sync ssh://mylogin@master.kernel.org/directory  ....

It seems much easier, and I suppose that SSH should be the
default "developer" protocol.

     Daniel.
