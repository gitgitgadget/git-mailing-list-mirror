From: Jeff King <peff@peff.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 04:43:13 -0400
Message-ID: <20060521084313.GA12825@coredump.intra.peff.net>
References: <20060521054827.GA18530@coredump.intra.peff.net> <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net> <20060521081435.GA4526@coredump.intra.peff.net> <7vlksvzsmd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 10:43:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhjWx-0000pe-6T
	for gcvg-git@gmane.org; Sun, 21 May 2006 10:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWEUInQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWEUInQ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 04:43:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:65234 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751508AbWEUInP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 May 2006 04:43:15 -0400
Received: (qmail 638 invoked from network); 21 May 2006 08:43:14 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 21 May 2006 08:43:14 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 May 2006 04:43:14 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlksvzsmd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20441>

On Sun, May 21, 2006 at 01:31:22AM -0700, Junio C Hamano wrote:

> We do not delta an otherwise perfectly deltifiable object if its
> delta base happens to be at the depth edge in the original pack.
> So no, we do _NOT_ know if it is not worth it merely from the
> fact that it is not deltified in the existing pack.  And the

Yes, you're right. What do you suggest for this performance issue, then?
A manual no-delta trigger, or just going to get a cup of coffee while
pushing (my tests showed 5-6x slowdown from deltifying)?

-Peff
