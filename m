From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] Fix 'crlf' attribute semantics.
Date: Mon, 16 Apr 2007 03:37:22 +0400
Message-ID: <20070415233722.GA20222@hermes>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net> <200704131033.15751.andyparkins@gmail.com> <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org> <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org> <7vr6ql1ben.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEHm-0005fL-1b
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbXDOXha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXDOXha
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:37:30 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:65226 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbXDOXh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:37:29 -0400
Received: by hu-out-0506.google.com with SMTP id 24so1922973hud
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 16:37:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=QdC34564wihzhqohqQjSBOuDo45o1OxY1oL8ZL/H1Rbp7Kr1vYvuxjFA6j+oXuQ76w3vFj0NskBttOYqEPW6TWuMiuzMrHOxLAHrstwojUSi26ERsjTjRBbr6VxUco6J/MtjBp1dJZ7u4208QX1zqv4buHQHZMHj9RC4IzvlyBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=odFQ5OXJY8z+ZPYcq3fC2wNIlK4ruyn9p34fIADAWO25uT9HyTs75OnXNvab8tWaDeoDAYXZCpr9z9s2OLCZ8Bp2ukyp2jhtcppzoFzBOeBL73mpLbnsHjDKW5UbotR22I/2o35tQrrvu5n66mj/B4Fm47obJKeFbzESImEdB8o=
Received: by 10.67.24.18 with SMTP id b18mr3878275ugj.1176680248356;
        Sun, 15 Apr 2007 16:37:28 -0700 (PDT)
Received: from hermes ( [80.240.215.209])
        by mx.google.com with ESMTP id l40sm5865114ugc.2007.04.15.16.37.27;
        Sun, 15 Apr 2007 16:37:28 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Mon, 16 Apr 2007 03:37:27 +0400 (MSD)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6ql1ben.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.0 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  3.0 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?80.240.215.209>]
 *  4.0 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
 *      [80.240.215.209 listed in sbl-xbl.spamhaus.org]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44547>

On Sun, Apr 15, 2007 at 04:10:56PM -0700, Junio C Hamano wrote:
> Earlier we said 'crlf lets the path go through core.autocrlf
> process while !crlf disables it altogether'.  This fixes the
> semantics to:

This change means there is no way to enable the automatic heuristics for a
specific pattern once it has been disable for a more generic pattern. Would it
make sense to make the attributes more than simply boolean?

  Tom
