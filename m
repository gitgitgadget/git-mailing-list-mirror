From: Andreas Ericsson <ae@op5.se>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 10:32:51 +0200
Message-ID: <48B51133.1030400@op5.se>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>	<20080826145719.GB5046@coredump.intra.peff.net>	<1219764860.4471.13.camel@gaara.bos.redhat.com>	<1219766398.7107.87.camel@pmac.infradead.org> <20080826182349.0a1a75e2@hyperion.delvare> <48B46443.6000800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali@linux-fr.org>,
	David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYGTS-0000K6-Db
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYH0Ict (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbYH0Ict
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:32:49 -0400
Received: from mail.op5.se ([193.201.96.20]:52755 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYH0Ics (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:32:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 09DC01B80087;
	Wed, 27 Aug 2008 10:37:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bv4C89ZcrDia; Wed, 27 Aug 2008 10:37:29 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id AAF091B8004E;
	Wed, 27 Aug 2008 10:37:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48B46443.6000800@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93874>

H. Peter Anvin wrote:
> Jean Delvare wrote:
>>
>> Reducing /usr/bin in size was totally worthwhile. Maybe not to you, but
>> to the silent majority I am a proud member of, it was. (I'm not saying
>> that the path that was taken to get there was optimal, just that the
>> goal was sound.)
>>
> 
> You keep trying to use the Nixon argument ("silent majority.")  You *do* 
> know that it was a rhetorical device used by Nixon's speechwriters to 
> push ahead with policies despite compact opposition, don't you?
> 
> As far as I can tell, most of the arguments in favour came from fanbois 
> of $OTHER_SCM which went along the lines of "why does git need all this 
> stuff in /usr/bin, when $OTHER_SCM doesn't?"  It had nothing to do with 
> reality, of course; it was just a difference between git and $OTHER_SCM 
> which they choose to pick on.
> 

Well, some new users both here and on #git have been slightly bewildered
about the number of commands the default bash-completion show when typing
git<tab><tab>. If anything, the move is long overdue, or should have
waited until 2.0 where people would expect to have to re-learn quite a lot.

There were, initially, two drawbacks with having the git-<commands> outside
the users $PATH. The first was performance when used from scripts, which
was addressed in November 2005 when the git wrapper was rewritten in C,
prior to the 1.0 release.
The second is the shell-completion, which was added in September 2006,
prior to the 1.5 release.

In retrospect, it would probably have been a good thing to make the move
with the 1.0 release (which would likely have caused the bash and zsh
completion scripts to pop into existence a lot earlier than 1.4.2), or
in 1.5, when both reasons for keeping the commands in the path were simply
not there anymore. 1.5 was also informally nicknamed "the UI release", so
it would have sort of fitted in there, while 1.0 was the first "this is
how git will work for the foreseeable future" release, so anything before
1.0 could be considered beta software with a very flexible and fast-moving
UI.

Worth remembering for the future perhaps, although I know it's easy to
overlook the fact that the inertia of the userbase grows exponentially
with the headcount of the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
