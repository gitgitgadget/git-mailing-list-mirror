From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 11:31:11 -0500
Message-ID: <499D894F.90508@xiplink.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>	 <499D82BC.7020500@xiplink.com> <bd6139dc0902190816m3c70923eg132e89bff28a216f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBpW-0006jo-BL
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZBSQbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZBSQbW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:31:22 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:41254 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZBSQbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:31:22 -0500
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id CA12D7BC17B;
	Thu, 19 Feb 2009 11:31:18 -0500 (EST)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 87DA47BC227;
	Thu, 19 Feb 2009 11:31:17 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <bd6139dc0902190816m3c70923eg132e89bff28a216f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110716>

Sverre Rabbelier wrote:
> 
> A non-fast forward update in terms of pushing means you overwrite
> whatever the remote currently has set as that branch's head. This can
> be desirable in a private repository or branch, but is usually not
> desired on shared branches.

Let me see if I understand what you're saying.  If my local repo has

	o--o--o--A--B  <-- origin/thing
	       \
	        X--Y--Z  <-- mystuff

and I do 'git push origin +mystuff:thing', does the origin end up with

	        A--B  <-- (branch with no symbolic reference)
	       /
	o--o--o--X--Y--Z  <-- origin/thing

So commits A and B are basically left dangling?

If that's the case, then I'd say "replaces" or "overwrites" is the right word to use in the 'remote show' output.  But more importantly, I think the 'git push' man page needs to explain this!

		M.
