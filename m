From: "Goo GGooo" <googgooo@gmail.com>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 17:49:00 +1200
Message-ID: <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
	 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
	 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 07:49:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr7Ce-0000bt-M0
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 07:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWFPFtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 01:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWFPFtD
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 01:49:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:28857 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751035AbWFPFtA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 01:49:00 -0400
Received: by wr-out-0506.google.com with SMTP id 36so526190wra
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 22:49:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVbQEOW72JRJ9AngyZ0Lx1V7O/afh3gCUH6CYnxx+xo6MPkIzKEjBWf61XVJfWDC52I7jBh/qsmJPHopvFG+ftyQGp6AaZIiu+VO9OMJmr2TfYl+c6dBbOItdYeDDqOIgV53Ig4f78IsUlghocIVv/0rt15jXQFCAzyO08dMrg8=
Received: by 10.65.250.18 with SMTP id c18mr1164944qbs;
        Thu, 15 Jun 2006 22:49:00 -0700 (PDT)
Received: by 10.65.110.6 with HTTP; Thu, 15 Jun 2006 22:49:00 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21931>

On 6/16/06, Linus Torvalds <torvalds@osdl.org> wrote:

> So to recap:
>  - http is fundamentally weaker, and needs some server-side help to work
>  - rsync is fine for the initial clone, but doesn't actually know what
>    it's doing, so the end result can actually even be a corrupted
>    repository, because you happened to rsync just as it was updating.
>  - the native git protocol generally should be considered the golden
>    standard, where the other ones are just fallbacks in case of problems
>    (like firewalls that don't let git:// through, or more commonly hosted
>    servers that don't do the git protocol at all).
>
> Which hopefully clarifies the issue a bit.

Thanks for explanation. Unfortunately I can't use git:// with "git
pull" (at least in git-1.3.2). First it does some traffic, that
suddenly stops - I guess the server starts doing *something*, perhaps
preparing the update for me or whatnot. After a pretty long while it
sends some more data but in the meanwhile my ADSL router dropped the
NAT entry and git sits on my side waiting for data forever. Recently I
tried the same on a system with direct Inet connection and that worked
just fine.

I suggest adding SO_KEEPALIVE option on the git socket.

Goo
