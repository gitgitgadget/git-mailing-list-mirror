From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Sun, 10 Aug 2008 20:46:08 -0700
Message-ID: <20080811034608.GA27684@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl> <20080808161937.GC9152@spearce.org> <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl> <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808102146050.22892@xanadu.home> <20080811030744.GD27195@spearce.org> <alpine.LFD.1.10.0808102325280.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 05:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSONE-0000Tm-7a
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 05:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYHKDqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 23:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbYHKDqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 23:46:09 -0400
Received: from george.spearce.org ([209.20.77.23]:39711 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbYHKDqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 23:46:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2BC2E38375; Mon, 11 Aug 2008 03:46:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808102325280.22892@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91916>

Nicolas Pitre <nico@cam.org> wrote:
> The actual downside I see with this patch is the fact that real data 
> corruptions might be "fixed" automagically with user unaware of it.  
> This could be a serious sign that the hardware is going bad and 
> requiring the user to consciously use -f to fix things is good.  However 
> it is most unlikely that redundant objects will be kept around in the 
> normal case, hence manual intervention will be needed anyway to bring a 
> copy of bad object into the repository.  So not having to use -f might 
> not be such an issue.

Yup, I agree completely.

Duplicates should be rare, and likely are only the fault of a
dumb transport fetch, or the user trying to fix their repository
by placing copies of corrupt objects obtained from elsewhere.
Requiring -f to fix such cases is heavy-handed.  Some trees can
take many hours to repack with -f; think gcc or OOo.

-- 
Shawn.
