From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Template files location
Date: Fri, 05 Aug 2005 13:50:29 -0400
Message-ID: <42F3A6E5.2070502@gmail.com>
References: <42DC4537.2080103@orionmulti.com>	<20050805024222.GE7762@shell0.pdx.osdl.net>	<42F2E571.6040207@orionmulti.com>	<7voe8dow4w.fsf@assigned-by-dhcp.cox.net>	<20050805042332.GG7762@shell0.pdx.osdl.net>	<7vd5otov7s.fsf@assigned-by-dhcp.cox.net>	<20050805094324.GF29216@pasky.ji.cz> <7vpsssjnld.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Chris Wright <chrisw@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 19:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E16Nj-0001yL-0E
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 19:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVHERwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 13:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVHERw0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 13:52:26 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:35396 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262766AbVHERum (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 13:50:42 -0400
Received: by wproxy.gmail.com with SMTP id i13so657690wra
        for <git@vger.kernel.org>; Fri, 05 Aug 2005 10:50:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GL03d+HvJ7R6MAEe/nlVRYp0Wsn7A3TuRU2CB0r6XqDgT+AFySlq7nESXr2x5NT/q6G2lDLSMT1Fh+FW79ENqi1Q/+XOqClNgKC2W80tvPQzJYk7J8sJCfu91yTpvCzHZ3glKP7lSPGOqvKup8dTokoJ0sPs12zlhBJspnxzKGA=
Received: by 10.54.46.72 with SMTP id t72mr2777022wrt;
        Fri, 05 Aug 2005 10:50:37 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g3sm2524673wra.2005.08.05.10.50.37;
        Fri, 05 Aug 2005 10:50:37 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsssjnld.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
...
> If the template files are to become something that always have
> to exist, /etc first and then falling back on /usr/share would
> make a lot of sense.  But as Johannes Schindelin correctly
> argued against the "Use the template mechanism to set up refs/
> hierarchy as well." patch [*2*], I think git-init-db should work
> when there is no template directory.  In other words, its
> primary purpose is to help local project administrators ensure
> newly created repositories have hooks and probably info/exclude
> that they recommend to the project members.

So templates are project specific.

> The reason to have a sample one shipped as part of the core
> package is just to help newbies --- they would get a boilerplate
> hooks/update that explains how they can set it up when they do
> git-init-db even when they do not have their own customized set
> of templates yet.  For this kind of use, I do not think one
> default falling back to another is needed.

Shipping samples with the plumbing makes sense, especially when the 
documentation in is insufficient. But installing the samples as part of 
the default install process seems less than desirable. Or, alternately, 
install the samples in with the documentation as (non-executable) examples.

...
> *1* This would probably break Linus, myself and others ---
> everybody has to say "make prefix=$HOME", so I do not think I am
> actually going to do it any time soon, if ever.
> 
> Having prefix=/usr/local as default only helps people who are
> installing system-wide from the source, and nobody else.  People
> who are writing spec.in and/or debian/rules need to override it
> to prefix=/usr anyway, and it forces people who are installing
> to their home to say prefix=$HOME/.  I suspect it is an inertia
> from the good old days when nobody used binary distributions.

Rather than changing the default install location in such a way as to 
make half the user unhappy, make everybody (un)happy by removing the 
default and forcing it to be specified when make is executed.
