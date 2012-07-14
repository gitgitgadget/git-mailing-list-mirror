From: sascha-ml@babbelbox.org
Subject: Re: Git Garbage Collect Error.
Date: Sat, 14 Jul 2012 05:36:30 +0200
Message-ID: <7478187.7CcD6s6PIO@toshi>
References: <4FD86AF8.1050100@zuken.co.uk> <20120712093221.GA4443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 03:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SprHV-0002DN-9Q
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 03:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523Ab2GNBgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 21:36:20 -0400
Received: from babbelbox.org ([83.133.105.186]:55050 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab2GNBgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 21:36:19 -0400
Received: (qmail 971 invoked from network); 14 Jul 2012 01:36:28 -0000
Received: from unknown (HELO toshi.localnet) (sascha@babbelbox.org@89.204.130.9)
  by babbelbox.org with ESMTPA; 14 Jul 2012 01:36:28 -0000
User-Agent: KMail/4.8.4 (Linux/3.4.4-gentoo; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120712093221.GA4443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201432>

On Thursday 12 July 2012 05:32:21 Jeff King wrote:

> [...] which means you are probably not even getting to use all 4Gb of your
> address space (my impression is that without special flags, 32-bit Windows
> processes are limited to 2Gb of address space).

Indeed, that's how windows partitions memory on 32-Bit Systems. See:

http://msdn.microsoft.com/en-us/library/windows/desktop/aa366912.aspx

As it's always with that strange company, they don't spend a word about how 
they do it in the emulated 32 bit environment. However, a short testing 
reveals that a 32 bit process running on 64 bit Windows 7 with 6 GiB memory is 
not able to malloc() more than 1 GiB at once (which is not a big suprise at 
all - as malloc'ed memory has to be continuous inside the address space).

So one might guess that there is no difference in memory partitioning for 32 
bit processes running on 64 bit OS.

SaCu
