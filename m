From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: grafts generalised
Date: Mon, 07 Jul 2008 08:28:48 +0200
Message-ID: <4871B7A0.1090604@op5.se>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:29:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFkEW-0001XH-9F
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbYGGG25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbYGGG25
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:28:57 -0400
Received: from mail.op5.se ([193.201.96.20]:45860 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbYGGG2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:28:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 679E524B0C41;
	Mon,  7 Jul 2008 08:28:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eMBXAChs2ej6; Mon,  7 Jul 2008 08:28:04 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.163])
	by mail.op5.se (Postfix) with ESMTP id 47CF824B0C3E;
	Mon,  7 Jul 2008 08:28:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080702174255.GB16235@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87585>

Stephen R. van den Berg wrote:
> Michael J Gruber wrote:
>> Maybe the upcoming git-sequencer could be the appropriate place? It 
>> tries to achieve just that: edit history by specifying a list of 
>> commands. The currently planned set of commands would need to be 
> 
> That's the problem.  Like git filter-branch, git sequencer needs you to
> parameterise the changes, which, in my case, is hardly possible, since
> the changes are randomlike.
> Also, having to run the sequencer to dig 20000 commits into the past,
> then change something, then come back up and rewrite all following
> history and relations (parents/tags/merges) will take a sizeable amount
> of time.  I need something that can be changed at will, then viewed with
> gitk a second later.
> 

A second later might be too much, but for the case where you need to
add a patch in the middle (which I suspect is the most timeconsuming
and tricky part at the moment), you might want to use a temporary
branch checked out where you need to apply the patch, apply the patch
and then rebase the rest of the history onto that new commit. Rebase
is fairly quick (although not a one-second thing for 20k commits), so
you'll get the time down quite a bit, I imagine.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
