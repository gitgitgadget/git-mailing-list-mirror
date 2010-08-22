From: Justin Frankel <justin@cockos.com>
Subject: [PATCH 0/2] git-merge: ignore space support
Date: Sat, 21 Aug 2010 22:43:21 -0700
Message-ID: <20100822054321.GA64856@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 22 07:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On3Tn-0000a0-Qg
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 07:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab0HVFwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 01:52:21 -0400
Received: from ns1.cockos.com ([204.11.104.229]:63810 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab0HVFwV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 01:52:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id 89A171259C01
	for <git@vger.kernel.org>; Sat, 21 Aug 2010 22:43:43 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guO44kN8BqGW for <git@vger.kernel.org>;
	Sat, 21 Aug 2010 22:43:21 -0700 (PDT)
Received: by ns1.blorp.com (Postfix, from userid 1000)
	id 8C50A1259C04; Sat, 21 Aug 2010 22:43:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154165>

Hello,

(Sorry if this is a duplicate, I'm thinking my MIME encoding was causing this 
to get filtered).

I've added  support for merging with ignoring line endings (specifically 
--ignore-space-at-eol) when using recursive merging.  I've added this as a 
strategy-option, so that you can do:

   git merge --strategy-option=ignore-space-at-eol <branch>

and

   git rebase --strategy-option=ignore-space-at-eol <branch>

The only option I needed was ignore-space-at-eol, however it made some sense (to 
me at least) to include the other xdiff options  (ignore-space-change, 
ignore-all-space, patient).

I researched why this wasn't supported already, and only found some vague 
references to why it shouldn't be in there -- if so, I would like to hear that 
explanation (it does seem to me like it should be a good thing to support, even 
if you strongly discourage use of it -- it would have saved me many hours 
yesterday had it been available, but that of course isn't git's fault, but 
Xcode's. ). 

Which branches should we derive from for things like this? The first patch is 
for master, the second for next (there were enough changes in ll-merge that 
the implementations are a bit different).

Thank you for your time, and I'm very happy to be using Git! It is wonderful.

Cheers,

Justin
