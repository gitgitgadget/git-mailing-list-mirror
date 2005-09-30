From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Support SPARSE in Makefile, better SPARSE_FLAGS
Date: Fri, 30 Sep 2005 18:14:29 -0400
Message-ID: <1128118469.7352.15.camel@dv>
References: <1128026765.24397.46.camel@dv>
	 <7vek779kg0.fsf@assigned-by-dhcp.cox.net> <1128087662.14543.14.camel@dv>
	 <433D8FA6.2080808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 00:15:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELT9v-0006D0-91
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 00:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVI3WOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVI3WOq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 18:14:46 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:31949 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932597AbVI3WOp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 18:14:45 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ELT9O-0003dC-0X
	for git@vger.kernel.org; Fri, 30 Sep 2005 18:14:42 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1ELT9B-00028g-Fm; Fri, 30 Sep 2005 18:14:29 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433D8FA6.2080808@zytor.com>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9574>

On Fri, 2005-09-30 at 12:19 -0700, H. Peter Anvin wrote:
> Pavel Roskin wrote:
> > 
> > I hate to say that, but a better alternative is to fix sparse to act
> > like the native compiler by default (possibly with options to imitate
> > other architectures or to be fully arch-neutral).
> > 
> 
> $(CC) $(CFLAGS) -E -dM -x c /dev/null -o builtin.h
> 
> ... will output a file containing all the buildin macros that you can 
> feed to sparse with -include.

I know.  That's what I'm using in the wrapper (plus -m64 and some
warnings).  But it should be the default.  Until then, hassle-free
sparse support in the Makefile is only possible for the projects that
already know the architecture (e.g. the Linux kernel).

-- 
Regards,
Pavel Roskin
