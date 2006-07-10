From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 02:52:08 -0400
Message-ID: <1152514328.3504.58.camel@dv>
References: <20060708183402.GA17644@spearce.org>
	 <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
	 <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de>
	 <20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv>
	 <20060710062513.GZ22573@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 08:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzpdL-0003Sp-3K
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 08:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWGJGw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 02:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWGJGw3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 02:52:29 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6107 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161355AbWGJGw2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 02:52:28 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fzpcz-0005ie-47
	for git@vger.kernel.org; Mon, 10 Jul 2006 02:52:25 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fzpcm-0005vo-A0; Mon, 10 Jul 2006 02:52:08 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060710062513.GZ22573@lug-owl.de>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23597>

On Mon, 2006-07-10 at 08:25 +0200, Jan-Benedict Glaw wrote:
> On Mon, 2006-07-10 02:22:03 -0400, Pavel Roskin <proski@gnu.org> wrote:
> > This means that the Sun compiler has almost all c99 features used by git
> > with just a little exception (initializers).  I think it's fair that we
> > fix this incompatibility.  It's very very minor compared to what "gcc
> > -std=c89 -pedantic" would have required.
>   ^^^^^^^^
> 
> You're kidding, aren't you?

In fact I can build git with this command:

make CFLAGS="-std=c89 -pedantic -Dinline=__inline -D_GNU_SOURCE"

if I fix all C++ comments.  It warns a lot about "flexible array
members" and other violations, but the resulting executable passes the
test.  That's Fedora Core 5 with gcc 4.1.1.

What I meant it that if we go all the way to strict c89 (even with a
modern libc) and fix all the warnings, it will be much more than what is
needed to support Sun's C compiler with its partial c99 support.

We can satisfy the Sun's compiler and yet retain flexible arrays and
other c99 goodies.

Maybe I'm missing your point (or you joke).

-- 
Regards,
Pavel Roskin
