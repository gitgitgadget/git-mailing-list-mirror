From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rerere.txt: Document forget subcommand
Date: Wed, 16 Jun 2010 09:42:24 +0200
Message-ID: <4C188060.5000903@drmicha.warpmail.net>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com> <ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net> <7vr5k86ylg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 09:43:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOnHF-0006V0-PS
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 09:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab0FPHnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 03:43:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55162 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438Ab0FPHm7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 03:42:59 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CAF5BF88F6;
	Wed, 16 Jun 2010 03:42:58 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 16 Jun 2010 03:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=7VumK8Pk6S+vcRQm6ZGvEmaZ5RI=; b=WbXFVh0qY5dqN79quq02jp8AB0Jz1/Pb5zKBupTzHEs5xhWjqzf20d5jfH/spxvDf+nbkcPfyHSa2S+bblxCM0Hc2aB1in0Jfze3uG9C3ZrvH5mbBlYGPaAGmEsmLh66Q1H+lqvbjqlSL6b7/ZQlCiFAPzzBna6MeGGH3tcqih0=
X-Sasl-enc: 7BKiPvTD1WR5dBFwtjfhNQslvq2a9KJRwZjvrrkIGuEK 1276674178
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 227EB4D6C90;
	Wed, 16 Jun 2010 03:42:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vr5k86ylg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149256>

Junio C Hamano venit, vidit, dixit 15.06.2010 18:37:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> dea4562 (rerere forget path: forget recorded resolution, 2009-12-25)
>> introduced the forget subcommand for rerere.
>> ...
>> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
>> index acc220a..a7370d3 100644
>> --- a/Documentation/git-rerere.txt
>> +++ b/Documentation/git-rerere.txt
>> @@ -40,6 +40,10 @@ This resets the metadata used by rerere if a merge resolution is to be
>>  aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
>>  will automatically invoke this command.
>>  
>> +'forget' <pathspec>::
>> +
>> +This resets the conflict resolutions which rerere has recorded for <pathspec>.
>> +
> 
> This description is not _incorrect_ per-se, but it does not convey one
> important aspect of the subcommand; unlike "clear" and "gc", "forget" only
> works in the context of the _current_ conflict resolution, just like
> "diff" and "status".

Does "current context" mean

- any recorded resolutions for the hunks which are currently recorded as
in in conflict

or

- the resolution which has (just) been recorded for the current conflict?

I'm completely agnostic of the underlying implementation of rerere (as
demonstrated by my questions probably...).

> Perhaps s/for <pathspec>/for the current conflict in <pathspec>/ would be
> a sufficient improvement?

I guess that would mean 2 above?

In any case, rerere forget is not a solution for the original "amend
merge commit and forget previous resolution" question, I guess (I just
happened to note it's undocumented). One would have to redo the merge to
get the conflict info into the index, right?

Michael
