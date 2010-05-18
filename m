From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: serious performance issues with images, audio files,
 and other "non-code" data
Date: Tue, 18 May 2010 15:33:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 21:34:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESYV-0002gz-6J
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155Ab0ERTeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:34:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61009 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758071Ab0ERTeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:34:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L2M00M7JROMS560@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 May 2010 15:33:58 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100518191933.GB2383@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147301>

On Tue, 18 May 2010, Jeff King wrote:

> So you might want "git gc --aggressive" the _first_ time you pack, or
> possibly even very occasionally. But if you are packing every day, you
> should just use "git gc", which will run much more quickly (and would
> probably have acceptable behavior even without the -delta attribute, as
> it would only have to look at _new_ objects).
> 
> It will have to write the whole 200M packfile out each time, though.

No.  gc will only create a pack with new loose objects by default.  
Only if the number of packs grow too large will it combine them into one 
pack.

> Packing nightly won't hurt, but is perhaps excessive. It sounds like you
> actually have a fairly normal workload.

Packing nightly with a simple "git gc" i.e. without extra options should 
be perfectly fine.


Nicolas
