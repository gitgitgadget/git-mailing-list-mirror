From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else	fails.
Date: Mon, 22 Oct 2007 17:19:36 +0200
Message-ID: <471CBF88.6020300@op5.se>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022143637.GP16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijz4a-0006YZ-0v
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbXJVPTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbXJVPTk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:19:40 -0400
Received: from mail.op5.se ([193.201.96.20]:40838 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbXJVPTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:19:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EE7201730683;
	Mon, 22 Oct 2007 17:19:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3cPJSLWc9lC; Mon, 22 Oct 2007 17:19:37 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0125A1730598;
	Mon, 22 Oct 2007 17:19:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071022143637.GP16291@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62020>

Scott Parish wrote:
> On Sun, Oct 21, 2007 at 10:59:01PM +0100, Johannes Schindelin wrote:
> 
>> Earlier, we tried to find the git commands in several possible exec
>> dirs.  Now, if all of these failed, try to find the git command in
>> PATH.
> 
> I'm tempted to try a different approach. What if instead of looping
> and building up strings of all the different absolute paths we want
> to try we just prepend to PATH with the correct extra precedence,
> and then call execvp on the command we want?
> 

That's how the original git --exec-dir feature got implemented. There's 
even a nifty function for it in git.c; prepend_to_path(). It's a 
provably workable solution.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
