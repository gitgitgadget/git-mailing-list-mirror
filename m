From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version
 of git
Date: Fri, 07 Dec 2007 13:38:10 +0100
Message-ID: <47593EB2.3020309@op5.se>
References: <87hciv7jkt.fsf@osv.gnss.ru>	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>	<87d4ti7qu1.fsf@osv.gnss.ru>	<7vodd23i1v.fsf@gitster.siamese.dyndns.org> <871w9y7mei.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 13:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cTX-00027x-Dj
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXLGMiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbXLGMiR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:38:17 -0500
Received: from mail.op5.se ([193.201.96.20]:42159 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbXLGMiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 07:38:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A054A1F0809D;
	Fri,  7 Dec 2007 13:38:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxtCoNEHd9OZ; Fri,  7 Dec 2007 13:38:13 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 82F951F0802A;
	Fri,  7 Dec 2007 13:38:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <871w9y7mei.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67419>

Sergei Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
 >> Having written that, it is very tempting to further clarify the above:
>>
>>     Usually, if a user has his own version of git and regularly uses it
>>     by having the non-system executable directory (e.g. $HOME/bin/git)
>>     early in his $PATH, its corresponding documentation would also be in
>>     a non-system documentation directory (e.g. $HOME/man) early in his
>>     $MANPATH, and this change is a no-op.  The only case this change
>>     matters is where the user installs his own git outside of his $PATH
>>     and $MANPATH, and explicitly runs his git executable
>>     (e.g. "$HOME/junk/git-1.5.4/bin/git diff").
> 
> First, I don't think you need to clarify like this. It is just
> implementation detail of git-help that it uses 'man', and thus
> implicitly relies on MANPATH. The essential thing has been already
> stated above: git-help should show correct documentation.
> 
> Second, the change is still useful even if user did put custom path to
> 'git' into its PATH, but didn't even thought of customizing
> MANPATH. Besides, a user could be entirely unaware of 'man' the utility.
> 

The number of users in the entire world that are completely unaware of
the 'man' utility but still manages to build git and install it in a
non-default path can probably be counted on one hand of a 65 year old
saw-mill worker.

I'm not sure if we're doing them a greater service by DWIMing this or
by telling them about the 'man' utility.

> 
>> How typical would that use be, to run your git executable by always
>> naming it by path without relying on $PATH environment variable?
> 
> To tell the truth, I'd prefer to just use -M option of man and don't
> rely on MANPATH at all, so that 'git help' will issue error if there is
> no documentation installed for this particular version of git.
> 

Does "man -M" work everywhere, or is your patch opening a can of worms
to get probably-not-needed functionality?

Otoh, you submitted a patch, so there are probably a few people out
there that care about this. I'm not one of them, so I'll shut up now
that my lunch is over ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
