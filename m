From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
 998 symbols
Date: Fri, 21 Nov 2008 12:46:17 +0100
Message-ID: <49269F89.3040105@op5.se>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>	 <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>	 <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com> <1227265742.3311.8.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, git@vger.kernel.org
To: Arafangion <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Fri Nov 21 12:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3UU0-0007yy-1F
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 12:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYKULqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 06:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYKULqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 06:46:16 -0500
Received: from mail.op5.se ([193.201.96.20]:46180 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbYKULqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 06:46:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D3F7F24B000A;
	Fri, 21 Nov 2008 12:41:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHG2-ZMqS7Gk; Fri, 21 Nov 2008 12:41:24 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3EDA424B0012;
	Fri, 21 Nov 2008 12:41:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1227265742.3311.8.camel@therock.nsw.bigpond.net.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101512>

Arafangion wrote:
> On Fri, 2008-11-21 at 12:37 +0200, Andy Shevchenko wrote:
>> On Fri, Nov 21, 2008 at 12:34 PM, Arafangion <thestar@fussycoder.id.au> wrote:
>>>> By default git-send-email does not accept patch which is contain lines longer
>>>> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
> <snip>
>>> As a curiosity, why is such a check even neccessary?
>> I'm not an author of that strange check (possible it's somehow related
>> to b8ebe08b9a643f432866eb7150c3b20d59b755f2)
> 
> I can't seem to find that changeset, however the reason why I asked is
> because I thought I remembered that some mail clients could crash if
> they got lines longer than that, and we should cater for that even if
> those clients should handle mails better than that!  Apparently it's
> specified in the relevant RFC2822, and this particular solution has
> already been contributed as:
> https://kerneltrap.org/mailarchive/git/2008/1/18/579779
> 

Well, there's quite a lot of arguing following that mail, and it
doesn't seem to end with a final decision.

> I would be inclined to suggest that such patches should be sent as an
> attachment instead?

No, that would be bad. Many communities (git included) discard
patches that aren't sent inline unless that's for a very good reason
(translation patches are almost always inline, as they tend to break
stuff for people who lack the proper encoding).

> While patches should be sent inline to encourage discussion of the
> patch, if the patch has such insanely long lines, the probability that
> the bulk of your audience in having a good email client that doesn't
> mangle your patch may become rather low.
> 

Reviewable source-code doesn't contain lines longer than 100 or so lines
anyway, so we might as well break on some arbitrary (say, 200) width
and ask the user to resubmit with the "--attach" option if they really
want to send their patch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
