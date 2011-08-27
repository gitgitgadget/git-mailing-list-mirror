From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] git-replace.txt: Clarify list mode
Date: Sat, 27 Aug 2011 16:07:28 +0200
Message-ID: <4E58FA20.4030204@drmicha.warpmail.net>
References: <4E574D61.8050501@drmicha.warpmail.net> <0a88518db0b0db8f1a4a4deeebd6dffc2d603e74.1314345131.git.git@drmicha.warpmail.net> <7v4o14f844.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 16:07:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxJXu-0007Hl-2e
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 16:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab1H0OHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 10:07:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50725 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905Ab1H0OHc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2011 10:07:32 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6EF6620773;
	Sat, 27 Aug 2011 10:07:31 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Sat, 27 Aug 2011 10:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LrmkSKecB8I/w6gWAnLhwn
	t2F+E=; b=t6EbEWA08D37dn5VZd/THIUTYt9USQSqOwCBdcKP89W5QH74ypWguJ
	AAW9HSsNUOVgQRRk8a8bY0+NNxMmxG4kAjXraLQRDZdNZ7js/QvlHnVlsufmULxO
	CXWWxA9dKyoVwOyb+h34Yy3Xjjzgpq0xT9NAFrWkW/27ole49THKU=
X-Sasl-enc: K7c0A3KlL5cp7xXGzwEEejHR/arhtJ/fH21JCDJi2kmG 1314454051
Received: from localhost.localdomain (p548580F9.dip0.t-ipconnect.de [84.133.128.249])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 148759C01D7;
	Sat, 27 Aug 2011 10:07:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7v4o14f844.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180229>

Junio C Hamano venit, vidit, dixit 26.08.2011 18:30:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Clarify that in list mode, "git replace" outputs the shortened ref
>> names, not their values.
>>
>> Also, point to the difficult to find git show-ref $(git replace -l).
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/git-replace.txt |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
>> index 17df525..cd00837 100644
>> --- a/Documentation/git-replace.txt
>> +++ b/Documentation/git-replace.txt
>> @@ -61,6 +61,13 @@ OPTIONS
>>  	all if no pattern is given).
>>  	Typing "git replace" without arguments, also lists all replace
>>  	refs.
>> ++
>> +Note that this lists the names of the replace refs, not their values
>> +(not their replacements). You can get the latter like this, e.g.:
> 
> Hmm, the update is _not wrong_ per-se, but...
> 
> I highly doubt we would want to try to cover confusions that may come from
> any and all different mis-/pre-conceptions people may have by making the
> description _longer_.
> 
> Which part of the wording in the existing description made you think that
> the command might list both names and their contents?  We should identify
> that misleading description (if there is) and fix that, instead of tacking
> clarifying clauses at the end.

Full disclosure: I misunderstood it when I read it the first time. I
never expected it to list pairs of refs, but the questions is: Does it
list the original sha1 or the replacement sha1?

"replace ref" can be very easily misunderstood as "the ref which
replaces", i.e. the replacement sha1. I know a ref is not a rev, but
"replace ref" can easily be misread as "replace rev", "replaced ref" etc.

Secondly, "git replace -l sha1" is completely useless, and I did not
expect that either. Granted, it outputs sha1 or not, depending on
whether it is replaced or not, so "completely" is a bit harsh, but still.

So, while I still have things to learn about git, I've also had my share
of exposure to refs and revs, and if I misunderstand a man page, it
indicates that there may be others whom I could help with what I've
learned from my own misunderstandings.

Also, as regards to clarifying: In out man pages, we often show
practical, non-obvious ways in which a user can combine commands, and I
think git show-ref $(git replace -l) is one of them.

> Given these statements:
> 
> 	"git replace" lists all replace refs.
>         "ls" lists paths in the directory.
> 
> I would say a natural reading of them is that they list "replace refs" and
> "paths", not "replace refs and their contents" and "paths and their contents".

This is natural, and the confusion above is a non-issue, *if* the reader
is very aware of the implementation of replacements as lightweight
tag-like refs with the sha1 as refname.

> By the way, one thing I forgot to say was that I do not think the variant
> of the output you wanted to have is necessarily a bad thing (it is bad to
> change the existing output to that variant, breaking other
> people). Perhaps it can become "-v(erbose)" output?

I'd say yes, Christian seems to prefer having "-v" even closer to
"branch -v". I'd say a user has the right to expect "-v,--verbose"
giving more information, but the type and extent of information should
depend on the actual command :)

Michael
