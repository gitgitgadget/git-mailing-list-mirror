From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 15:16:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201512560.3305@eeepc-johanness>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness> <20080720130407.GF10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 15:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYnb-00030o-GL
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 15:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYGTNQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbYGTNQH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 09:16:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:51871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754166AbYGTNQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 09:16:07 -0400
Received: (qmail invoked by alias); 20 Jul 2008 13:16:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp052) with SMTP; 20 Jul 2008 15:16:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S2Xx/OP+SZZAN/A9O0TppsGMBBp7W1tL6jxwCb+
	W2sl2Jh8weH0xd
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080720130407.GF10347@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89200>

Hi,

On Sun, 20 Jul 2008, Miklos Vajna wrote:

> First, currently you can specify multiple strategies in the config
> (pull.twohead, pull.octopus) using a space separated list.

Oh, I did not mean to change that.  I just misremembered.

> Second, we could allow custom strategies, as we started to discuss here:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/86584/focus=87684

In my opinion, this would make it easier for interested parties to start 
implementing that blame-based merge strategy I mentioned.

> Third, it would be nice to allow passing extra parameter(s) to the
> backends, but I do not know what concept is the best here. The
> strategy1=foo,stategy2=bar limits the input to a single string. Is that
> enough? Given that recursive=theirs was considered harmful, we don't
> have too much examples; for subtree the only parameter I could think of
> is the path, so a string there is enough.
> 
> However, further strategies, like blame, could take more parameters,
> like git blame -C<num> -M<othernum>. Or do I just overcomplicate it? ;-)

The common solution is like with gcc's -Wl option, which translates 
commata into spaces, like so: "-Wl,--machine,i386" is added as "--machine 
i386" to the linker command line.

Our own cvsimport implements the same principle:

	$ git cvsimport -p -b,HEAD

will only update the main branch.

Ciao,
Dscho
