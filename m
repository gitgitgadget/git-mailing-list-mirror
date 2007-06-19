From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 15:57:31 -0500
Message-ID: <18040.17211.575543.403408@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
	<20070619132456.GA15023@fiberbit.xs4all.nl>
	<18039.57099.57602.28299@lisa.zopyra.com>
	<20070619143000.GA15352@fiberbit.xs4all.nl>
	<18039.60598.264803.940960@lisa.zopyra.com>
	<86k5u0q8q9.fsf@lola.quinscape.zz>
	<18040.346.208040.842060@lisa.zopyra.com>
	<20070619200939.GA4180@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0klm-00019j-Dk
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 22:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbXFSU5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbXFSU5p
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 16:57:45 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60986 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbXFSU5o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 16:57:44 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JKvfY04590;
	Tue, 19 Jun 2007 15:57:41 -0500
In-Reply-To: <20070619200939.GA4180@steel.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50508>

On Tuesday, June 19, 2007 at 22:09:39 (+0200) Alex Riesen writes:
>Bill Lear, Tue, Jun 19, 2007 18:16:26 +0200:
>> % cat foo
>> set -x
>> type tar
>> type cd
>> (cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates && tar xf -)
>
>what would you see if your script contained:
>
>    set -x
>    (cd blt && tar cf - .) |less
>
>?
>Does the output look like a tar archive to you?

Well, not sure.  Lots of gobbledygook.

>Can you share it with us if you're not sure?

Ok, I've tried to send a limited amount of data, hopefully useful.  If
I redirect to a file:

(cd blt && tar cf - .) > tar.tar

and then try to view it with tar:

% tar tvf tar.tar

I get the same error as before.  I sent the output through
'od' as so:

(cd blt && tar cf - .) | od -a | head -50

Here is the result of that:

0000000   /   h   o   m   e   /   b   l   e   a   r   /   b   u   i   l
0000020   d   /   g   i   t   -   1   .   5   .   2   .   2   /   t   e
0000040   m   p   l   a   t   e   s   /   b   l   t  nl   .   / nul nul
0000060 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0000220   0   0   0   0   7   5   5 nul   0   0   0   1   3   5   0 nul
0000240   0   0   0   0   1   5   4 nul   0   0   0   0   0   0   0   0
0000260   0   0   0 nul   1   0   6   3   5   7   6   5   2   7   4 nul
0000300   0   1   0   7   2   4 nul  sp   5 nul nul nul nul nul nul nul
0000320 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0000440 nul nul nul nul nul nul nul nul nul nul nul nul nul   u   s   t
0000460   a   r  sp  sp nul   b   l   e   a   r nul nul nul nul nul nul
0000500 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0000520 nul nul nul nul nul   s   o   f   t   w   a   r   e nul nul nul
0000540 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001040 nul nul nul nul nul nul nul nul nul nul nul nul   .   /   d   e
0001060   s   c   r   i   p   t   i   o   n nul nul nul nul nul nul nul
0001100 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001220   0   0   0   0   6   4   4 nul   0   0   0   1   3   5   0 nul
0001240   0   0   0   0   1   5   4 nul   0   0   0   0   0   0   0   0
0001260   0   7   2 nul   1   0   6   3   5   7   6   5   2   7   4 nul
0001300   0   1   3   1   7   1 nul  sp   0 nul nul nul nul nul nul nul
0001320 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001440 nul nul nul nul nul nul nul nul nul nul nul nul nul   u   s   t
0001460   a   r  sp  sp nul   b   l   e   a   r nul nul nul nul nul nul
0001500 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0001520 nul nul nul nul nul   s   o   f   t   w   a   r   e nul nul nul
0001540 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0002040 nul nul nul nul nul nul nul nul nul nul nul nul   U   n   n   a
0002060   m   e   d  sp   r   e   p   o   s   i   t   o   r   y   ;  sp
0002100   e   d   i   t  sp   t   h   i   s  sp   f   i   l   e  sp   t
0002120   o  sp   n   a   m   e  sp   i   t  sp   f   o   r  sp   g   i
0002140   t   w   e   b   .  nl nul nul nul nul nul nul nul nul nul nul
0002160 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0003040 nul nul nul nul nul nul nul nul nul nul nul nul   .   /   b   r
0003060   a   n   c   h   e   s   / nul nul nul nul nul nul nul nul nul
0003100 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0003220   0   0   0   0   7   5   5 nul   0   0   0   1   3   5   0 nul
0003240   0   0   0   0   1   5   4 nul   0   0   0   0   0   0   0   0
0003260   0   0   0 nul   1   0   6   3   5   7   6   5   2   7   3 nul
0003300   0   1   2   5   1   0 nul  sp   5 nul nul nul nul nul nul nul
0003320 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*

If I run this from the command-line, instead of a script, I get
this (and if it is redirected to a file instead of 'od', tar
can read it):

0000000   .   / nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0000020 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0000140 nul nul nul nul   0   0   0   0   7   5   5 nul   0   0   0   1
0000160   3   5   0 nul   0   0   0   0   1   5   4 nul   0   0   0   0
0000200   0   0   0   0   0   0   0 nul   1   0   6   3   5   7   6   5
0000220   2   7   4 nul   0   1   0   7   2   4 nul  sp   5 nul nul nul
0000240 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0000400 nul   u   s   t   a   r  sp  sp nul   b   l   e   a   r nul nul
0000420 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0000440 nul nul nul nul nul nul nul nul nul   s   o   f   t   w   a   r
0000460   e nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0000500 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001000   .   /   d   e   s   c   r   i   p   t   i   o   n nul nul nul
0001020 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001140 nul nul nul nul   0   0   0   0   6   4   4 nul   0   0   0   1
0001160   3   5   0 nul   0   0   0   0   1   5   4 nul   0   0   0   0
0001200   0   0   0   0   0   7   2 nul   1   0   6   3   5   7   6   5
0001220   2   7   4 nul   0   1   3   1   7   1 nul  sp   0 nul nul nul
0001240 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0001400 nul   u   s   t   a   r  sp  sp nul   b   l   e   a   r nul nul
0001420 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0001440 nul nul nul nul nul nul nul nul nul   s   o   f   t   w   a   r
0001460   e nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0001500 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0002000   U   n   n   a   m   e   d  sp   r   e   p   o   s   i   t   o
0002020   r   y   ;  sp   e   d   i   t  sp   t   h   i   s  sp   f   i
0002040   l   e  sp   t   o  sp   n   a   m   e  sp   i   t  sp   f   o
0002060   r  sp   g   i   t   w   e   b   .  nl nul nul nul nul nul nul
0002100 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0003000   .   /   b   r   a   n   c   h   e   s   / nul nul nul nul nul
0003020 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0003140 nul nul nul nul   0   0   0   0   7   5   5 nul   0   0   0   1
0003160   3   5   0 nul   0   0   0   0   1   5   4 nul   0   0   0   0
0003200   0   0   0   0   0   0   0 nul   1   0   6   3   5   7   6   5
0003220   2   7   3 nul   0   1   2   5   1   0 nul  sp   5 nul nul nul
0003240 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
*
0003400 nul   u   s   t   a   r  sp  sp nul   b   l   e   a   r nul nul
0003420 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0003440 nul nul nul nul nul nul nul nul nul   s   o   f   t   w   a   r
0003460   e nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
0003500 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul


Bill
