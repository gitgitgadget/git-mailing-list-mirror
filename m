From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Makefile: make ppc/sha1ppc.o depend on GIT-CFLAGS
Date: Wed, 06 Jan 2010 13:17:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001061309540.21025@xanadu.home>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113323.GC10059@progeny.tock> <20100106063759.GA882@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaRd-0001Bp-2N
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab0AFSRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458Ab0AFSRM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:17:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42477 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530Ab0AFSRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:17:10 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KVU0084O84GRSK0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Jan 2010 13:17:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100106063759.GA882@progeny.tock>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136282>

On Wed, 6 Jan 2010, Jonathan Nieder wrote:

> The %.o: %.S pattern rule should depend on GIT-CFLAGS to avoid
> trouble when ALL_CFLAGS changes.
> 
> The pattern only applies to one file (ppc/sha1ppc.S) and that
> file does not use any #ifdefs, so leaving the dependency out is
> probably harmless.  Nevertheless, it is safer to include the
> dependency in case future code's behavior does depend on the
> build flags.

Is the PPC SHA1 code still needed?  Is it actually ever used?

We have block-sha1/* which is already about just as fast if not faster 
on most targets.  So I'd simply remove the ppc directory and its content 
which is the only remaining platform specific assembly code in the 
source tree.


Nicolas
