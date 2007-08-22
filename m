From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 15:37:27 +0200
Message-ID: <46CC3C17.8040901@op5.se>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INqqe-0003iK-29
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbXHVOGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbXHVOGL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:06:11 -0400
Received: from mail.op5.se ([193.201.96.20]:42662 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbXHVOGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:06:10 -0400
X-Greylist: delayed 1720 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2007 10:06:09 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AEBB4194435;
	Wed, 22 Aug 2007 15:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XXiLQZOPn+uo; Wed, 22 Aug 2007 15:37:28 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id C28EA1943CB;
	Wed, 22 Aug 2007 15:37:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <86absjenc3.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56381>

David Kastrup wrote:
> Carlos Rica <jasampler@gmail.com> writes:
> 
>> This is the first version of the program "builtin-reset.c",
>> intended for replacing the script "git-reset.sh".
>>
>> The --mixed option with -- paths is not implemented yet.
>>
>> The tests I made for it are not finished so they are not included,
>> but it seems to pass the rest of the test suite.
> 
> Could you be so kind as to give a one-sentence summary what the
> benefits over using a shell script would be?

One word: Portability.

There's a plethora of various shell syntaxes. Discerning what's correct
shell and what's a bash'ism that may or may not be posixly correct (but
perhaps not supported on a multitude of out-of-the-box solaris system)
has so far taken almost as much time as convincing newcomers to git that
there really is no point in tracking file renames explicitly.

Otoh, the list of large and renowned projects that have shunned git for
its weak windows support grows longer, meaning we potentially lose
competent programmers simply because they're forced to use something
else.


>  I think this work has
> started before I joined the list, and I'd be interested in the
> motivation for it.  In general, I find shell scripts more pleasant for
> hacking on than C code, and there is no long-term plan to replace all
> of them, is there?

There is, but nobody is putting a full-time effort into it, so the change
is gradual and happens one program at a time whenever someone sends in a
well-written C-program to replace a shell-script. Normally the C-program
has to either show tremendous speed improvements or retain all functionality
of the shell-script in order to be accepted.

>  So unless there is some issue that can't be
> addressed reliably or efficiently by reverting to other commands for
> everything involving bulk processing, I am not really happy to see
> shell scripts replaced.
> 

It will happen, sooner or later. We may not like MS or their products, but
sooner or later we'll have to cater to their users or face the problem of
all the competent programmers helping out on some other SCM, because that
other SCM works everywhere, while git doesn't.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
