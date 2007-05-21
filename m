From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: git log -S problem
Date: Mon, 21 May 2007 07:27:23 +0200
Message-ID: <200705210727.23898.johannes.sixt@telecom.at>
References: <200705202115.39325.johannes.sixt@telecom.at> <7vy7jjjjdm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j.sixt@eudaptics.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 07:27:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq0Qg-0007a9-Aa
	for gcvg-git@gmane.org; Mon, 21 May 2007 07:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbXEUF10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 01:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbXEUF10
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 01:27:26 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.117]:48224 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbXEUF10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 01:27:26 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id B65EC351D5;
	Mon, 21 May 2007 07:27:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7D2A3573C6;
	Mon, 21 May 2007 07:27:24 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7jjjjdm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47965>

On Sunday 20 May 2007 23:05, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > I had expected that the set of commits found by the second search string
> > are a proper superset of those found by the first one. What's wrong here?
> > Why does a search for 'merge-base' not find occurences of
> > 'builtin-merge-base'?
>
> 71dfbf224 removes one line that has "git-merge-base$X" and adds
> one line that has "builtin-merge-base.o".  If you count the
> number of occurences of substring "builtin-merge-base" in the
> preimage and the postimage, you see one addition.  If you count
> the same for substring "merge-base", the net difference is 0.

But is this how -S is *designed* to work? 

Hm, the documentation says (diff-options.txt):

-S<string>::
	Look for differences that contain the change in <string>.

which can be interpreted both to match my expectations as well as the current 
implementation.

-- Hannes
