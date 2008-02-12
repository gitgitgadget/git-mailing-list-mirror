From: Michal Rokos <michal@rokos.cz>
Subject: Re: libcrypto core dump in 64bit
Date: Tue, 12 Feb 2008 15:26:16 +0000 (UTC)
Message-ID: <loom.20080212T152138-849@post.gmane.org>
References: <20080211112822.16b69495@pc09.procura.nl> <alpine.LSU.1.00.0802112240280.3870@racer.site> <20080212150612.4d28c373@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 16:31:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOx6w-0001Ft-QI
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 16:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763154AbYBLPaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 10:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763145AbYBLPaH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 10:30:07 -0500
Received: from main.gmane.org ([80.91.229.2]:37267 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763090AbYBLPaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 10:30:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JOx58-0000GU-Hh
	for git@vger.kernel.org; Tue, 12 Feb 2008 15:30:02 +0000
Received: from 89-24-233-232.i4g.tmcz.cz ([89.24.233.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 15:30:02 +0000
Received: from michal by 89-24-233-232.i4g.tmcz.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 15:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.24.233.232 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20071030 Ubuntu/8.04 (hardy) Firefox/2.0.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73667>

Hello,

H.Merijn Brand <h.m.brand <at> xs4all.nl> writes:
> On Mon, 11 Feb 2008 22:42:16 +0000 (GMT), Johannes Schindelin
> <Johannes.Schindelin <at> gmx.de> wrote:
> > > #0  0xc0000000033c8940:0 in sha1_block_asm_host_order+0x22e0 ()
> > >    from /usr/local/ssl/lib/libcrypto.so
> > 
> > This seems to be an OpenSSL issue, probably in its Itanium-optimised code 
> > (since Itanium is not _all_ that common, it is quite likely that no many 
> > people exercise this part of the code).
> 
> Now tried with HP C-ANSI-C -O3, -O2, -O1, and -O0 and with GNU gcc 4.2.1 -O3
> All give the same failure
> 
> > Unfortunately, I am not at all an expert in Itanium's assembler, otherwise 
> > I'd try to help...

yes, this is OpenSSL issue. I had to recompile OpenSSL myself to make it work
(with no-asm option)

I'm using only HP cc for building git (with all the toolchain). (No gcc here)

# uname -mrs
HP-UX B.11.23 ia64
# cc --version
cc: HP C/aC++ B3910B A.06.14 [Feb 22 2007]

Michal
