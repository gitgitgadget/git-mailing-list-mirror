From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 15:24:56 +0200
Message-ID: <20070619132456.GA15023@fiberbit.xs4all.nl>
References: <18039.52754.563688.907038@lisa.zopyra.com> <Pine.LNX.4.64.0706191359160.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0dhi-0005vr-M9
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbXFSNZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757485AbXFSNZE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:25:04 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:55670 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbXFSNZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:25:03 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1I0dhY-0003uv-GA; Tue, 19 Jun 2007 15:24:56 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706191359160.4059@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50479>

On Tuesday June 19th 2007 at 14:00 Johannes Schindelin wrote:

> On Tue, 19 Jun 2007, Bill Lear wrote:
> 
> > Also breaks (tar fails) if I do the 'make configure; ./configure'
> > route.
> 
> Then there is a test missing in configure.
> 
> > /home/blear/build/git-1.5.2.2/utf8.c:328: undefined reference to `libiconv'
> 
> You are missing libiconv.

On Linux there usually is no separate libiconv as this is integrated
into GNU libc. Most of the time this kind of error results when somehow
there _is_ a separate installation of libiconv under /usr/local/lib or
something. An #include <iconv.h> then finds the version under
/usr/local/include/iconv.h which has rather different definitions, due to
using all kind of macros.

If this is Bills situation try uninstalling the separate iconv package
or at least temporarily rename its iconv.h header.
-- 
Marco Roeland
