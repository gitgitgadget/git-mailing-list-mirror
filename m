From: Russ Allbery <rra@stanford.edu>
Subject: Re: Date handling.
Date: Sat, 23 Apr 2005 23:43:37 -0700
Organization: The Eyrie
Message-ID: <87r7h0u12e.fsf@windlord.stanford.edu>
References: <1113466592.12012.192.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	<1113500316.27227.8.camel@hades.cambridge.redhat.com>
	<20050424030416.GE16751@delft.aura.cs.cmu.edu>
	<1114324729.3419.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 08:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPalc-0005bT-V3
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 08:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVDXGnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 02:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVDXGnq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 02:43:46 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:48317 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262272AbVDXGno
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 02:43:44 -0400
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.64.19.147])
	by smtp3.Stanford.EDU (8.12.11/8.12.11) with SMTP id j3O6hbiN006606
	for <git@vger.kernel.org>; Sat, 23 Apr 2005 23:43:42 -0700
Received: (qmail 2535 invoked by uid 1000); 24 Apr 2005 06:43:37 -0000
To: git@vger.kernel.org
In-Reply-To: <1114324729.3419.78.camel@localhost.localdomain> (David
 Woodhouse's message of "Sun, 24 Apr 2005 16:38:49 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> I don't think we want to be in the business of counting leap seconds; we
> need to let the system do it. I don't much like setting TZ to UTC though
> -- how about we use your test case to find the offset and subtract that?

> Does this work?

Nope, daylight savings time breaks this, since you may or may not be in
the same time zone on January 1st as you are at the current time.

However, you don't need to count leap seconds when you implement your own
mktime, since mktime doesn't have to take leap seconds into account.  Unix
timestamps, unless you're using TAI, don't include leap seconds.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
