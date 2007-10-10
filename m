From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 12:35:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710101231130.20690@woody.linux-foundation.org>
References: <20071010015545.GA17336@lapse.madduck.net>
 <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org>
 <20071010102528.GB20390@lapse.madduck.net>
 <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
 <20071010154831.GA19226@old.davidb.org>
 <20071010190757.GP23810@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Brown <git@davidb.org>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhMR-0001WG-RR
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbXJJTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXJJTgm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:36:42 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53576 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871AbXJJTgm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 15:36:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AJZhTu016212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Oct 2007 12:35:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9AJZgSJ022353;
	Wed, 10 Oct 2007 12:35:43 -0700
In-Reply-To: <20071010190757.GP23810@genesis.frugalware.org>
X-Spam-Status: No, hits=-2.73 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60532>



On Wed, 10 Oct 2007, Miklos Vajna wrote:
> 
> Actually, specifically darcs, different merges _always_ result in the same
> data.

No they don't. You don't understand the problem.

Yes, different merges WITH THE SAME PATCHES always result in the same 
data.

But that's not a realistic - or even very interesting - schenario.

What's much more common is that the same problem gets solved slightly 
differently in two different branches. For example, maybe somebody does it 
as two different patches - where the second one fixes a bug in the first 
fix. And another person does the same fix, but without the bug in the 
first place.

See? A patch-based system gets confused by those kinds of issues (or they 
turn into various special cases). And that is fundamentally why you MUST 
NOT take history into account (where "history" is some series of 
individual patches).

Yes, history is interesting for historical reasons, and to explain what 
the context was, but in many ways, history is exactly the *wrong* thing to 
use when it comes to merging. You should look at the end result, since 
people can - and do - come to the same result through different ways.

			Linus
