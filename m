From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
 count in bytes
Date: Thu, 04 Feb 2010 12:58:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002041249200.1681@xanadu.home>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org>
 <7vtytxexjl.fsf@alter.siamese.dyndns.org> <20100204172421.GA18548@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:58:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5y7-0004UU-0k
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab0BDR6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:58:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29638 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713Ab0BDR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:58:11 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXB002FNWKZ7560@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 Feb 2010 12:58:11 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100204172421.GA18548@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138991>

On Thu, 4 Feb 2010, Shawn O. Pearce wrote:

> How about for a transition period we do:
> 
>   if (v < 8192) {
>   	warning("max-pack-size is now in bytes, assuming %dm", v);
> 	v *= 1024 * 1024;
>   }
> 
> So that existing users won't be completely broken if they are
> relying on this flag, and have some time to adjust.

For 'git fast-import' which is not meant to be directly user operated 
this makes sense.  I don't think this is a good idea for 'git repack' 
though.  In the later case it is best if the user simply adjust right 
away.

Also the warning text above could be less ambigous. Something like:

	"max-pack-size is now in bytes, assuming --max-pack-size=%dm"


Nicolas
