From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 15:06:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010051504530.3107@xanadu.home>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101005005003.GA2768@nibiru.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Enrico Weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:06:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Cq8-0005oN-KP
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab0JETGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:06:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32089 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0JETGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:06:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9T00C2TZQ50Y70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Oct 2010 15:06:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101005005003.GA2768@nibiru.local>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158224>

On Tue, 5 Oct 2010, Enrico Weigelt wrote:

> * Shawn Pearce <spearce@spearce.org> wrote:
> 
> > The mmap() isn't the problem.  Its the allocation of a buffer that is
> > larger than the file in order to hold the result of deflating the file
> > before it gets written to disk.  
> > When the file is bigger than physical memory, the kernel has to
> > page in parts of the file as well as swap in and out parts of
> > that allocated buffer to hold the deflated file.
> 
> What are the access pattern of these memory areas ?

Perfectly linear.

> Perhaps madvise() could help ?

Perhaps.


Nicolas
