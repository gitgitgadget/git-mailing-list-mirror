X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] change the unpack limit threshold to a saner value
Date: Wed, 06 Dec 2006 19:19:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612061915240.2630@xanadu.home>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
 <7vejrcy860.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 7 Dec 2006 00:19:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vejrcy860.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33539>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs6zK-00016S-9w for gcvg-git@gmane.org; Thu, 07 Dec
 2006 01:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937829AbWLGATn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 19:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937830AbWLGATm
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 19:19:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59510 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937829AbWLGATm (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 19:19:42 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9V00667NKTM040@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Wed,
 06 Dec 2006 19:19:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 6 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Let's assume the average object size is x. Given n objects, the needed 
> > storage size is n*(x + b), where b is the average wasted block size on 
> > disk.
> > ...
> > This is why I think the current default treshold should be 3 instead of 
> > the insane value of 5000.  But since it feels a bit odd to go from 5000 
> > to 3 I setled on 10.
> 
> I see you are optimizing for disk footprint, and this will
> result in tons of tiny packs left between "repack -a".

Depends how often i.e. how big pushes are, and how often you repack.

> I have not benched it yet, but the runtime pack handling code
> was written assuming we have only a handful of big packs; I
> suspect this change would affect the performance at runtime in
> quite a bad way.

Possibly.

Still a treshold of 5000 is way too large IMHO.


