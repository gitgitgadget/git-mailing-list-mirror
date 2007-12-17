From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] threaded pack-objects: Use condition variables for
 thread communication.
Date: Sun, 16 Dec 2007 22:13:38 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712162203470.8467@xanadu.home>
References: <200712160018.54171.johannes.sixt@telecom.at>
 <200712161941.38109.johannes.sixt@telecom.at>
 <20071216190016.GC4999@xp.machine.xx>
 <200712162045.34456.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 17 04:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J46Qh-00020t-QR
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 04:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765061AbXLQDNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 22:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764676AbXLQDNm
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 22:13:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43770 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760117AbXLQDNl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 22:13:41 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT6000R5BMQK690@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 16 Dec 2007 22:13:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200712162045.34456.johannes.sixt@telecom.at>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68505>

On Sun, 16 Dec 2007, Johannes Sixt wrote:

> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

One micro nit:

> +		for (;;) {
> +			for (i = 0; !target && i < delta_search_threads; i++)
> +				if (!p[i].working)
> +					target = &p[i];
> +			if (target)
> +				break;
> +			pthread_cond_wait(&progress_cond, &progress_mutex);
> +		};

There's a spurious ; here.

Otherwise:

Acked-by: Nicolas Pitre <nico@cam.org>


Nicolas
