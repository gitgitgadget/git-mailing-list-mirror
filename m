From: Andreas Ericsson <ae@op5.se>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 21:34:27 +0100
Message-ID: <475EF453.90404@op5.se>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>	<alpine.LFD.0.99999.0712102231570.555@xanadu.home>	<9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>	<9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>	<9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>	<alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>	<9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>	<alpine.LFD.0.9999.0712111055590.25032@woody.linux-foundation.org> <7v7ijldnq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Smirl <jonsmirl@gmail.com>, Nicolas Pitre <nico@cam.org>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Bob-0000OO-IS
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXLKUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbXLKUec
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:34:32 -0500
Received: from mail.op5.se ([193.201.96.20]:50613 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbXLKUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:34:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 45DB21F08040;
	Tue, 11 Dec 2007 21:34:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.212
X-Spam-Level: 
X-Spam-Status: No, score=-3.212 tagged_above=-10 required=6.6
	tests=[AWL=-0.712, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEsgkGw5DjtQ; Tue, 11 Dec 2007 21:34:29 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 98C201F08039;
	Tue, 11 Dec 2007 21:34:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v7ijldnq1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67935>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> So what you actually want to do is to just re-use already packed delta 
>> chains directly, which is what we normally do. But you are explicitly 
>> looking at the "--no-reuse-delta" (aka "git repack -f") case, which is why 
>> it then blows up.
> 
> While that does not explain, as Nico pointed out, the huge difference
> between the two repack runs that have different starting pack, I would
> say it is a fair thing to say.  If you have a suboptimal pack (i.e. not
> enough reusable deltas, as in the 2.1GB pack case), do run "repack -f",
> but if you have a good pack (i.e. 300MB pack), don't.


I think this is too much of a mystery for a lot of people to let it go.
Even I started looking into it, and I've got so little spare time just
now that I wouldn't stand much of a chance of making a contribution
even if I had written the code originally.

That being said, I the fact that some git repositories really *can't*
be repacked on some machines (because it eats ALL virtual memory) is
really something that lowers git's reputation among huge projects.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
