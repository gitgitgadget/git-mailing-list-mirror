From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: serious performance issues with images, audio files,
 and other "non-code" data
Date: Tue, 18 May 2010 15:37:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005181535130.12758@xanadu.home>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com>
 <20100518190706.GA2383@coredump.intra.peff.net>
 <AANLkTiltNPIR5gAWMOqZ2Y_azFUU93kH54ddHuCFFeCp@mail.gmail.com>
 <20100518192758.GC2383@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	John <john@puckerupgames.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 21:37:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESbz-0004US-FU
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923Ab0ERThu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:37:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58776 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0ERTht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:37:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L2M00MZ0RUSFU00@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 May 2010 15:37:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100518192758.GC2383@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147302>

On Tue, 18 May 2010, Jeff King wrote:

> On Tue, May 18, 2010 at 09:10:58PM +0200, Sverre Rabbelier wrote:
> 
> > On Tue, May 18, 2010 at 21:07, Jeff King <peff@peff.net> wrote:
> > > No, not to my knowledge. Even the "binary" attribute just says "this
> > > file is binary, don't text diff it". I think we will always still do
> > > rewrite-detection for operations like "git status" and the diff summary
> > > of "git commit".
> > 
> > Would that not be a very sensible optimization that would help John
> > (and other users of big files) a lot?
> 
> It might help some, but I worry about overloading the meaning of
> "-delta". Right now it has a very clear meaning: don't delta for
> packfiles. But that doesn't mean I might not want to see break detection
> (or inexact rename detection, for that matter) at some time.

Indeed. Please keep the delta attribute for what it is named after: 
deltas. And those are meant to be used in the context of object packing 
only.


Nicolas
