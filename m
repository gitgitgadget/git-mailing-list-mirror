From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Tue, 23 Mar 2010 19:50:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 00:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuDre-00089U-IT
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 00:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab0CWXuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 19:50:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35193 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0CWXuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 19:50:21 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZR00DC8E7VSG90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Mar 2010 19:50:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143058>

On Tue, 23 Mar 2010, Fredrik Kuivinen wrote:

> On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.org> wrote:
> > If that is what we are doing, disabling the release of pack windows
> > when malloc fails, why can't we do that all of the time?
> 
> The idea was that most git programs are single threaded, so they can
> still benefit from releasing the pack windows when they are low on
> memory.

This is bobus. The Git program using the most memory is probably 
pack-objects and it is threaded.  Most single-threaded programs don't 
use close to as much memory.


Nicolas
