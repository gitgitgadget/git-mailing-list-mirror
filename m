From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Improve on 'approxidate'
Date: Mon, 31 Aug 2009 17:27:03 -1000 (HST)
Message-ID: <alpine.LFD.2.00.0908311725260.21913@eeepc.linux-foundation.org>
References: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain> <20090830223558.GA29807@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 05:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiK2G-00056J-Cm
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 05:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbZIAD1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 23:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbZIAD1p
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 23:27:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55239 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751485AbZIAD1p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 23:27:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n813R6pO027112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Aug 2009 20:27:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n813R3sE009829;
	Mon, 31 Aug 2009 20:27:04 -0700
In-Reply-To: <20090830223558.GA29807@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127518>



On Sun, 30 Aug 2009, Jeff King wrote:
> 
> This breaks relative dates like "3.months.ago", because
> approxidate_alpha needs to see the "current" date in tm (and now it sees
> -1, subtracts from it, and assumes we are just crossing a year boundary
> because of the negative).  3.years.ago is also broken, but I don't think
> 3.days.ago is.

Gaah. Thanks for noticing and the fixes. I had tested the relative modes, 
but only the "fixed offset" ones (days, hours, minutes, seconds), not the 
months and years cases.

			Linus
