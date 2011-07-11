From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Mon, 11 Jul 2011 18:49:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1107111846260.14596@xanadu.home>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com>
 <1310084657-16790-3-git-send-email-gitster@pobox.com>
 <7voc14fyy8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 00:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgPIl-00074u-1o
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 00:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab1GKWt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 18:49:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38904 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758180Ab1GKWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 18:49:58 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LO6007O4Y1P8LB0@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jul 2011 18:49:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7voc14fyy8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176907>

On Fri, 8 Jul 2011, Junio C Hamano wrote:

> The moral of the story is that index-pack is not a workload to optimize
> for ;-) and the following is a wrong patch to apply.

Right.  And if it was possible to slow down index-pack while speeding up 
the other workloads then this would actually be worthwhile because 
index-pack is not used as often and people are not expecting it to be 
fast either.


Nicolas
