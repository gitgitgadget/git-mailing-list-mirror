From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Wed, 04 May 2011 08:55:01 +0200
Message-ID: <4DC0F845.2080903@drmicha.warpmail.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org> <20110502193321.GB10487@sigill.intra.peff.net> <7vhb9clu0n.fsf@alter.siamese.dyndns.org> <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org> <20110502210141.GA15753@sigill.intra.peff.net> <4DBFA31E.40207@drmicha.warpmail.net> <7vvcxrit07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHVzi-0002BS-5e
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 08:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab1EDGzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 02:55:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50222 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751047Ab1EDGzE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 02:55:04 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5EFBF208A3;
	Wed,  4 May 2011 02:55:03 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 04 May 2011 02:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=u5MLTIjNyylg2SV2TOnNiWLEQvo=; b=UsG7pO7jPrT22gNAqW1G5cFl30ZLYhyAgggPlX3jWzfUc2NzwJICZotRVjUeUTzA9oJfWsaOjUA/985mMEaW4adUynuX5ErcnlP78NnqAlcW10ueTt5wN8W87V4YbiuDf6wZlf94fGLTOROgbkvabJUMYSZ2zTxcPTo2HpcaoeU=
X-Sasl-enc: gZkrJxSb2VrM1lq7SI2MsHFu+0wTGJO62YLgveCvU3WP 1304492103
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCE294003EC;
	Wed,  4 May 2011 02:55:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vvcxrit07.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172720>

Junio C Hamano venit, vidit, dixit 03.05.2011 19:38:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>>> Helped-by: Jeff King <peff@peff.net>
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>
>>> Looks good to me.
>>
>> I'm sorry but I don't like this at all, because:
>>
>>> Doing "..." is still allowed, but will never produce any useful results.
>>> I don't know if it is worth disallowing it to catch errors. I am tempted
>>> to say it should be magic for "@{u}...HEAD", but I think just "..." is
>>> getting unreadably magical. "@{u}...HEAD" is already pretty concise and
>>> is much more readable.
>>
>> We need to disambiguate any pathspec with "--" which could be a revision
>> parameter. Therefore I find it very unnatural to disambiguate ".." to a
>> pathspec automatically (and have "..." error out). "../" is really
>> simple enough to type.
> 
> If you are comfortable typing "../", why do you even care?  It would be a

I care about:

- sane defaults
- sane arguments

> different story if the patch made ".." error out and forbade to be used as
> an empty range even when you disambiguated, i.e. "git log .. --", but that
> is not what we are doing.
> 
> And we do not even special case "...".  Between the two potential requests
> of asking for an empty revision range and asking for a pathspec "...", both
> are just as unlikely.
> 
> Contrast that with ".." and realize that is very different.  It is
> infinitely more likely that the user meant the immediate parent directory
> than an empty revision range.

and that is a straw man argument. I suggested "@{u}..HEAD" for "..",
because I consider that much more useful. "Infinitely more likely" is
obviously true and obviously pointless when you compare with something
of zero likelihood (and nonsense otherwise). I have no problem accepting
a majority vote or sane arguments, but not something like this, sorry.

Michael
