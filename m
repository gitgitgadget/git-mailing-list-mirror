From: Andreas Ericsson <ae@op5.se>
Subject: Re: Windows symlinks
Date: Thu, 26 Jun 2008 08:33:28 +0200
Message-ID: <48633838.6060502@op5.se>
References: <911589C97062424796D53B625CEC0025E46196@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: apenwarr@gmail.com, jnareb@gmail.com, git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Thu Jun 26 08:34:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBl3x-0007we-QS
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYFZGdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYFZGdh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 02:33:37 -0400
Received: from mail.op5.se ([193.201.96.20]:51477 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYFZGdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 02:33:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5779624B0AE6;
	Thu, 26 Jun 2008 08:31:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6h29gr8jvBU9; Thu, 26 Jun 2008 08:31:32 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 200531B8037B;
	Thu, 26 Jun 2008 08:31:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <911589C97062424796D53B625CEC0025E46196@USCOBRMFA-SE-70.northamerica.cexp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86404>

Patrick.Higgins@cexp.com wrote:
>> From: Avery Pennarun [mailto:apenwarr@gmail.com]
>> 
>>> Agreed. The first thing we started working on was getting
>> symlinks out of our repositories.
>>> Unfortunately, we chose to use them because we are using
>> broken development tools that
>>> don't support proper modularity. We found the best way to
>> Perhaps git-submodule would do what you're looking for.
> 
> We might be able to get by with them, but submodules appear to be
> significantly more complex than symlinks, and we sometimes symlink
> just a file or two if that's all we need. Splitting up submodules to
> that level of granularity would be hard to manage.
> 
> My understanding of the submodule workflow is:
> 
> Projects A, B, and C (we actually have about 17 of these) all share
> common code in project Common. Then, each of A, B, and C adds Common
> as a submodule. While working on project A, the need arises to modify
> Common, so the developer changes it there, commits, pushes the change
> to Common, then commits and pushes the change to A. To update B and
> C, they would have to change to each of those projects, run a git
> pull, then git submodule update, and compile and test.
> 
> Is that correct? If so, it's a lot more work than letting a symlink
> propagate the change to all the other projects. Of course, since
> Windows doesn't have symlinks...

That is correct, but you only need to do the change if the projects
B, C, D, n... actually requires the new feature/bugfix introduced in
Common. Otherwise you can just leave it as-is.

Besides, when an important bugfix is added to Common, you probably
want to cut new releases from B, C, D, n... anyway, so it still
means doing stuff to those repositories.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
