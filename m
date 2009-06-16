From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not
 request sideband
Date: Mon, 15 Jun 2009 21:16:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906152109240.16467@xanadu.home>
References: <200906142238.51725.j6t@kdbg.org>
 <20090615145716.GW16497@spearce.org> <200906152324.43435.j6t@kdbg.org>
 <7vski1i2ov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 03:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGNIt-0005Bn-EU
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 03:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbZFPBRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 21:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbZFPBRL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 21:17:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60300 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZFPBRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 21:17:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KLB00HW44DKWAF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Jun 2009 21:05:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vski1i2ov.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121643>

On Mon, 15 Jun 2009, Junio C Hamano wrote:

> I think it is a very good idea to squelch progress output that will never
> go to the client (it will be wasted traffic, regardless of the "syslog"
> thing), but
> 
>  (1) Is "not using sideband" the same as "client won't see the progress
>      output" for all vintages of clients that work with the current
>      server?
> 
>      How did we drive upload-pack over native or ssh connection before we
>      introduced sideband?  I vaguely recall that we relied on stderr going
>      to the invoking terminal in the local case.  With this change, does
>      the user suddenly stop seeing progress if the client is older than
>      583b7ea (upload-pack/fetch-pack: support side-band communication,
>      2006-06-21)?  If so, that would be a regression.

Native, or git:// style, certainly never was able to get any kind of 
progress display without sideband support.

As to old clients using ssh... well... that could be a regression.  But 
do we really care?  This is pre v1.4.1 after all, and even the previous 
Debian stable was using a later git version.


Nicolas
