From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 02:20:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230219100.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org> <alpine.DEB.1.00.0807230033000.8986@racer> <20080723004108.GB14668@spearce.org> <20080723010928.GG11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLT2c-0004yG-Qj
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYGWBUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYGWBUS
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:20:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:40323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751856AbYGWBUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:20:17 -0400
Received: (qmail invoked by alias); 23 Jul 2008 01:20:15 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp022) with SMTP; 23 Jul 2008 03:20:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18St7lJutYSS5DJ4K4YPk7DGPdPHp5mjFstfEcv0/
	5iLXCesmRHdCYr
X-X-Sender: gene099@racer
In-Reply-To: <20080723010928.GG11831@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89591>

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

> I had a core that I stupidly lost, but I remember that the broken malloc 
> was:
> 
> 
>     static void *get_data_from_pack(struct object_entry *obj)
>     {
> 	    off_t from = obj[0].idx.offset + obj[0].hdr_size;
> 	    unsigned long len = obj[1].idx.offset - from;
> 	    unsigned long rdy = 0;
> 	    unsigned char *src, *data;
> 	    z_stream stream;
> 	    int st;
> 
> 	    src = xmalloc(len);
>             ^^^^^^^^^^^^^^^^^^
> 
>   len was horribly big, and outputing obj[1].idx showed that `sha1` had
> text in it. I mean something like "could not\r\n     han" IIRC.
> 
>   I don't remember the rest of the backtrace, and have stupidly not kept
> any ways of reproducing it.

That would not have helped.  The memory corruption almost _certainly_ took 
place way before that.

Ciao,
Dscho
