From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 19:15:52 +0300
Message-ID: <20060610191552.7d5a44d9.tihirvon@gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	<46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
	<Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
	<9e4733910606092302h646ff554p107564417183e350@mail.gmail.com>
	<7vr71xk047.fsf@assigned-by-dhcp.cox.net>
	<9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 18:15:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp67o-000621-5i
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 18:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWFJQPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 12:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWFJQPp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 12:15:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:16114 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751543AbWFJQPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 12:15:44 -0400
Received: by nf-out-0910.google.com with SMTP id y38so656204nfb
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 09:15:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SqEO+pUQV9yGA2IpYYz5gto7A2PY9pnRHC4NNPxk2VcS8uFS8/xt19KmGAdeBPIIaBW/aQFyvSXGXHSeAuxuj2ped0++FWlOZ5sZUIAfMzK0lCO4y7d0TlvsNi1Yz/MXq/k3dD6RBEOfzSfKNwtPdFy6Q6hIaglV9jT88WS7v7U=
Received: by 10.49.65.12 with SMTP id s12mr3353723nfk;
        Sat, 10 Jun 2006 09:15:43 -0700 (PDT)
Received: from garlic.home.net ( [82.128.201.71])
        by mx.gmail.com with ESMTP id o9sm4524283nfa.2006.06.10.09.15.42;
        Sat, 10 Jun 2006 09:15:42 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21611>

"Jon Smirl" <jonsmirl@gmail.com> wrote:

> On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > Here's a new transport problem. When using git-clone to fetch Martin's
> > > tree it kept failing for me at dreamhost. I had a parallel fetch
> > > running on my local machine which has a much slower net connection. It
> > > finally finished and I am watching the end phase where it prints all
> > > of the 'walk' messages. The git-http-fetch process has jumped up to
> > > 800MB in size after being 2MB during the download. dreamhost has a
> > > 500MB process size limit so that is why my fetches kept failing there.
> >
> > The http-fetch process uses by mmaping the downloaded pack, and
> > if I recall correctly we are talking about 600MB pack, so 500MB
> > limit sounds impossible, perhaps?
> 
> The fetch on my local machine failed too. It left nothing behind, now
> I have to download the 680MB again.

That's sad.  Could git-clone be changed to not remove .git directory if
fetching objects fails (after other files in the .git directory have
been fetched)?  You could then hopefully continue with git-pull.

-- 
http://onion.dynserv.net/~timo/
