From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: tables in documentation
Date: Tue, 25 May 2010 13:59:19 +0200
Message-ID: <4BFBBB97.7010107@drmicha.warpmail.net>
References: <4BDC74F3.2020206@drmicha.warpmail.net> <20100502050622.GF14776@coredump.intra.peff.net> <4BDD7E96.2050603@drmicha.warpmail.net> <20100525094621.GA984@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 13:59:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGsnL-0002vg-9g
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 13:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0EYL7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 07:59:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33007 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754245Ab0EYL7d (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 07:59:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1FD89F7A86;
	Tue, 25 May 2010 07:59:33 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 25 May 2010 07:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vvE/1W4RcKI0V6xdnhSx9fIbq7Y=; b=KOjV+pMFB3iBNtAvCehwvnCK7o3xNCCCNeuF2pvL5IFDvpBJj8upj8ttRfY+0wZy+o4Ei5i9+fTeJlftTVq9Zh0UefkPZas8Pa+ohx21Q8YbCGz9iCEICz0ANxhVuiTzHX5obfqh4bo5KyTfRv/0Bd6+SYAB7RE/IZuKpucNDpg=
X-Sasl-enc: wR02ld1MZwcPT1XQOKvw3B3+eHCBpnbidEwZLp7EGmUf 1274788772
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8785F4DF9EE;
	Tue, 25 May 2010 07:59:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100525 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <20100525094621.GA984@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147708>

Jeff King venit, vidit, dixit 25.05.2010 11:46:
> [This is an old message, but I'm going through some old threads on my
> todo, and I owed you a response.]

I've been revisiting this myself just the other day - did someone say
connecting minds?

> 
> On Sun, May 02, 2010 at 03:31:02PM +0200, Michael J Gruber wrote:
> 
>>> Conceptually I am in favor of semantic markup where possible. I find the
>>> resulting manpage a little harder to read, though. Is it possible for us
>>> to style it a bit more (e.g., such a simple table looks better, IMHO,
>>> without ascii-art borders).
>>
>> I really don't know (about styling docbook's tables). We can easily
>> switch off the outer borders in AsciiDoc.
> 
> I do think the border-less table that you presented later in the thread
> looks good, modulo the row-span issue.
> 
> And:
> 
>>> Did you put the source up anywhere? I didn't see it, but it would be
>>> interesting to see how painful it is to write.
>>
>> http://repo.or.cz/w/git/mjg.git/shortlog/refs/heads/doc-use-tables
> 
> I think the source remains pretty readable.
> 
> So assuming you can solve the row-span problem, I think it is a
> positive change.
> 
>> The docbook part of the toolchain makes me sick whenever I have to look
>> at it. I really wish AsciiDoc could output roff straight away. I find it
> 
> Yes, I have also wished for that many times.
> 
> -Peff

Unfortunately, docbook still sucks. (I was hoping it would improve with
Fedora 13, although I knew it wouldn't.)

I checked, again, that AsciiDoc produces correct docbook. But docbook
has a problem with adjacent rowspans, and also with frames and grids: As
soon as you specify any line element (say, "frame=topbot" or
"grid=columns") docbook uses full frames and full grids. And I think
having at least topbot would be helpful.

I think we should just get rid off the nroff pages and view man pages in
html through links or such... [I noticed that lynx doesn't cope with the
table, though.]

Alternatively, I would set up a default configuration in asciidoc.conf
which uses topbot for html and no lines whatsoever for docbook, and
circumvent adjacent rowspans. When/if docbook improves that workaround
can be changed in that single place.

Michael
