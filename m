From: Andreas Ericsson <ae@op5.se>
Subject: Re: No "pull" in git gui?
Date: Fri, 26 Sep 2008 16:47:17 +0200
Message-ID: <48DCF5F5.3040409@op5.se>
References: <588192970809260737i46ce0c30y191e29156bbf6396@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:48:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEcY-0002Qy-TW
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYIZOr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYIZOr2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:47:28 -0400
Received: from mail.op5.se ([193.201.96.20]:43082 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbYIZOr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:47:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7E90624B0042;
	Fri, 26 Sep 2008 16:38:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vq-YFU0OeOEn; Fri, 26 Sep 2008 16:38:12 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C4E561B80046;
	Fri, 26 Sep 2008 16:38:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <588192970809260737i46ce0c30y191e29156bbf6396@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96861>

Steve Hoelzer wrote:
> Why isn't there a pull command in git gui's remote menu? Am I supposed
> to fetch and then merge? Is that preferred over pull for some reason?
> 

Yes, it is. Blind "git pull" without knowing what you're going to
fetch is not recommended, because it tends to create tons and tons
of "useless" merges, where all commits are on one branch and there's
no clear distinction between them. Such merges are useless because
you'd be better off with a linearized history (bisection turns out
slightly easier, fe).

"git pull" is primarily intended for
* people like Linus, who merge in a lot of other people's code.
* bleeding-edge *users* that just want the latest and greatest.
* "vcs = cvs" users, that never care about history

For all other workflows I've ever encountered, doing "git pull"
blindly always ends up being worse than
* developing on topic-branches and merging those when ready.
* doing 'git pull --rebase', to linearize a series of small
  fixes before pushing them back up.
* 'git fetch' + manually inspect new code + 'git merge'.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
