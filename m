From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 14:01:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710311350100.3342@woody.linux-foundation.org>
References: <20071030160232.GB2640@hermes.priv>
 <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
 <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
 <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org>
 <85lk9jzsxb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org>
 <20071031204729.GB13300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKhp-0007eA-EP
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbXJaVCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXJaVCL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:02:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43002 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754373AbXJaVCK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 17:02:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VL1ts7027909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 14:01:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VL1sTV027881;
	Wed, 31 Oct 2007 14:01:55 -0700
In-Reply-To: <20071031204729.GB13300@coredump.intra.peff.net>
X-Spam-Status: No, hits=-1.833 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_15,J_CHICKENPOX_44,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62868>



On Wed, 31 Oct 2007, Jeff King wrote:
> 
> Yes, this means that if you have a bizarre repo name, you can't
> necessarily switch between host:file syntax and git:// syntax by simple
> cut and paste. But you really can't _anyway_, since there is no
> guarantee that they are rooted at the same location, or have the same
> view of the filesystem.

.. but in practice it works fine, especially for something like kernel.org 
where it really *is* the same filesystem, just mirrored out.

Also, more importantly, I think the quoting is *stupid*. It adds pointless 
code for absolutely zero gain. Are you going to unquote '/'? Or how about 
'~'?

It's much nicer to just not have the quoting issue at all. Repo names are 
names. Straight up.

> > Personally, I think it's a much better idea to just be git-specific. 
> 
> Then why in the world did you choose a specifier syntax that looks
> _exactly_ like a URL?

.. because it's a simple format, and it *works*. The same way INI config 
files are simple and *work*.

And because I didn't think I'd have to care about people who like f*cking 
around with idiotic details, rather than just get something that is useful 
and works!

If you don't like the fact that git doesn't quote, just don't use the 
magic characters. It's that easy. And if somebody quotes the '/', just 
tell him off for being an ass.

But git can and should do the *sane* thing.

			Linus
