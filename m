From: Andreas Ericsson <ae@op5.se>
Subject: Re: Whitespace on commit
Date: Thu, 13 Mar 2008 08:34:40 +0100
Message-ID: <47D8D910.5060901@op5.se>
References: <fra7ji$7p9$1@ger.gmane.org> <7viqzr1dsp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhyH-0007QO-I2
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYCMHeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbYCMHen
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:34:43 -0400
Received: from mail.op5.se ([193.201.96.20]:33810 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbYCMHen (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:34:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DDC2A1F080D8;
	Thu, 13 Mar 2008 08:35:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6zs17uX5V6mo; Thu, 13 Mar 2008 08:35:47 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 3A0DF1F080D0;
	Thu, 13 Mar 2008 08:35:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7viqzr1dsp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77047>

Junio C Hamano wrote:
> "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com> writes:
> 
>> I keep getting annoying errors when I try to commit.  Git complains that I
>> have whitespace in the wrong places.  
>>
>> This is fine.. I even like it.  What I don't like is having to change this
>> stuff manually.  Is there anyway to tell git to just fix the stuff and do
>> the commit?  
>>
>> I've tried setting
>>
>> apply.whitespace = fix 
>>
>> in my .gitconfig, but that doesn't seem to help when doing commits.
> 
> Yeah, that is to protect yourself from whitespace mess _other people_
> threw at you in a patch form.
> 
> You can ask git to fix your own stuff up, by pretending that you are that
> other person who made the mess, by doing:
> 
> 	git diff HEAD >P.diff
>         git reset --hard HEAD
>         git apply --index --whitespace=fix P.diff
> 

I have exactly that (except my P.diff sits in /tmp under a different name)
as an alias named wsfix. Here's how to make one of your own, Kenneth:

git config --global alias wsfix '!git diff HEAD >P.diff && git reset --hard HEAD && git apply --index --whitespace=fix P.diff && rm -f P.diff'

Note that there are no newlines in the above command. When you get the whitespace
warnings, just run "git wsfix" and you'll be good to go.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
