From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] remove inline iteration variable
Date: Thu, 17 Aug 2006 11:11:44 +0200
Message-ID: <81b0412b0608170211p7289889av43eb7c35ba07fe02@mail.gmail.com>
References: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
	 <81b0412b0608160027l2ac53c10gd9a75525ca144f1d@mail.gmail.com>
	 <Pine.LNX.4.63.0608161011100.20470@chino.corp.google.com>
	 <20060816201019.GA6083@steel.home>
	 <Pine.LNX.4.63.0608161441070.29566@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 11:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDdux-0000c0-HG
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHQJL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHQJL4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:11:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:29329 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932366AbWHQJLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 05:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so912481nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 02:11:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qx41W69w6vUGyl/5i2WBaZ5UbZkRE+azwZruzgTqXt4oVPeczBLjA6DLJTmCclmZtrf++9yeBNIQsvtbF09B4e9Znmg/C9cjCHKDzE+BvhR4XQ3tKpzuDaQ7LHCbJan9wdNG9IQ48hHP2RQLXvwTwjTKgyoIMUxrBfQuR6l1LQM=
Received: by 10.49.29.3 with SMTP id g3mr1941428nfj;
        Thu, 17 Aug 2006 02:11:44 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 17 Aug 2006 02:11:44 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608161441070.29566@chino.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25561>

On 8/16/06, David Rientjes <rientjes@google.com> wrote:
> > > > > Remove unnecessary iteration variable in inline.
> > > > > -       for (i = 0; i < in; i++) putchar(' ');
> > > > > +       for (; in > 0; in--)
> > > >
> > > > while(in--) putchar(' ');
> > > >
> > >
> > > That goes into an infinite loop if the argument is negative because
> > > it emits a cmpl $0, x(%ebp).  Should never happen, but there's no
> > > reason not to prevent it with a for loop.
> >
> > while (in-- > 0) putchar(' ');
> >
> > still shorter :)
> >
>
> It emits a slightly rearranged assembly with the same number of instructions.
>

oops. I should've looked at the output. But the point moot anyway, Junio says :)
