From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-daemon --inetd
Date: Sat, 22 Oct 2005 23:45:31 +1000
Message-ID: <2cfc40320510220645r6e8dc735w32b6ec3633b1d1ff@mail.gmail.com>
References: <43290EFF.3070604@zytor.com>
	 <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
	 <4329BDD9.4010507@zytor.com>
	 <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
	 <4329C93D.2020701@zytor.com>
	 <Pine.LNX.4.58.0509151225410.26803@g5.osdl.org>
	 <46a038f905091514447e13404d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 15:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETJgt-0004OY-0b
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 15:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVJVNpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 09:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJVNpd
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 09:45:33 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:43125 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932232AbVJVNpc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 09:45:32 -0400
Received: by qproxy.gmail.com with SMTP id o12so18887qba
        for <git@vger.kernel.org>; Sat, 22 Oct 2005 06:45:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ph74NKL6f+GWxaYsyabWS+TDe8DhV3lK6kFrkd9cxogDlOVHhtzx6+fqzeYQyBZs5IcBNOOp7aaUJPFeM7iKM/bnRPSMyun/AMgkf7KobkPVpWc7QzSuNH8WI7tlF2hpnxGLrh7onf3JnVqDu8BlgueE9T7DRuDAqioQiNiofek=
Received: by 10.65.153.2 with SMTP id f2mr2395532qbo;
        Sat, 22 Oct 2005 06:45:31 -0700 (PDT)
Received: by 10.64.249.12 with HTTP; Sat, 22 Oct 2005 06:45:31 -0700 (PDT)
To: martin.langhoff@gmail.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <46a038f905091514447e13404d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10470>

On 9/16/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 9/16/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > Btw, I think --merge-order was cool, but its weaker cousin --topo-order is
> > what is actually _used_. Maybe we should deprecate --merge-order? Right
> > now the only real user is git-archimport, and I think that one too really
> > only wants topo-order too. For example, right now I think git-archimport
> > won't actually work if you build without openssl.
> >
> > Jon? Martin?

Sorry for the long delay in replying - I need to fix my mail filter so
that I do see GIT mail that is actually directed to me!

Is the concern with --merge-order the complexity of the logic (and
hence size of object), the intrusiveness into rev-list.c or the fact
that it uses the OPEN_SSL?

I believe I can rework the merge-order algorithm to avoid the need for
bignum support for OPEN_SSL, though I am not going to get a chance to
do that until December at the earliest.

Much as I hate to see my baby being orphaned, how about we deprecate
--merge-order for now and arrange things so that users have to
explicitly enable it if they want it. If enough people complain about
that, then I can produce a bignum-free version in the December
timeframe?

Regards,

jon.
