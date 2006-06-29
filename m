From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] autoconf: Use autoconf to write installation directories to config.mak
Date: Thu, 29 Jun 2006 09:18:13 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060629071813.GB1127@informatik.uni-freiburg.de>
References: <200606290301.51657.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 09:18:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvqnL-00023o-2J
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 09:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWF2HSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 03:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWF2HSS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 03:18:18 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48318 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751750AbWF2HSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 03:18:17 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Fvqn1-0003qD-Il; Thu, 29 Jun 2006 09:18:15 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k5T7IE1v001448;
	Thu, 29 Jun 2006 09:18:14 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k5T7IEQw001447;
	Thu, 29 Jun 2006 09:18:14 +0200 (MEST)
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200606290301.51657.jnareb@gmail.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22845>

Jakub Narebski wrote:
> This is beginning of patch series introducing installation configuration
> using autoconf (and no other autotools) to git. The idea is to generate
> config.mak using ./configure (generated from configure.ac) from
> config.mak.in, so one can use autoconf as an _alternative_ to ordinary
> Makefile, and creating one's own config.mak.
> 
> This patch includes minimal configure.ac and config.mak.in, so one 
> can set installation directories using ./configure script
> e.g. ./configure --prefix=/usr

autoconf does to much things, even with that little configure.ac.  (But
I agree, it's much better than automake :-)

E.g.

	./configure --prefix=$HOME/usr --mandir=$HOME/usr/share/man

is supported by the configure script, but the manpages are installed in
$HOME/usr/man all the same.

BTW: Even if I specify mandir=... in config.mak, it is not respected,
because only the toplevel Makefile includes config.mak.  (I didn't test
it, but I think I could export mandir in config.mak ...)

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+hertz+in+sec**-1
