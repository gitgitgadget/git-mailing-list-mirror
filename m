From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Approxidate with YYYY.MM
Date: Tue, 10 May 2011 10:36:44 +0200
Message-ID: <4DC8F91C.5090709@drmicha.warpmail.net>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com> <4DC8DCC2.8050208@drmicha.warpmail.net> <964517.31047.1305010481774.JavaMail.trustmail@mail1.terreactive.ch> <4DC8EBD8.50707@terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Tue May 10 10:37:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJiRF-0001Hv-1D
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 10:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab1EJIgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 04:36:52 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47724 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932442Ab1EJIgr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 04:36:47 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4925120245;
	Tue, 10 May 2011 04:36:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 10 May 2011 04:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KszbpIXS8LDRxngF51nZg8BDaO0=; b=hiswS7hohxK+CeHSjvqH2J74Od5V30IOex6UJ9anPCC6C4OYYMrwEIT5ABKaeajE6PZgS7bjNzI+LNvB4Dq8Qe93wr4rAcAIxhsckPUJ+/fW7LzfWzW8GrchVdW7z6katOLdFc3368ZsdBc/V8Ei5plkY/s/XMx9y//lYwUDLR0=
X-Sasl-enc: s3FJweZZAv678udLUeOHmXgkxjFJGjjGbHzpLkkjBJoS 1305016606
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4216040794F;
	Tue, 10 May 2011 04:36:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <4DC8EBD8.50707@terreactive.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173321>

Victor Engmark venit, vidit, dixit 10.05.2011 09:40:
> On 05/10/2011 08:54 AM, Andreas Ericsson wrote:
>> On 05/10/2011 08:35 AM, Michael J Gruber wrote:
>>> Brian Gernhardt venit, vidit, dixit 09.05.2011 21:02:
>>>> (This is in response to a discussion on #parrot.)
>>>>
>>>> Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form
>>>> YYYY.MM for their monthly releases.  When we were attempting to find
>>>> the cause of a slowdown, somewhat was trying to find what commits
>>>> occurred after the 2011.01 release with "git log --after=2011.01".
>>>> His mistake was pointed out but this led to the confusion of why this
>>>> was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't
>>>> date.c:match_multi_number() parse something with only two numbers as
>>>> a beginning of month instead of allowing it to pass through to the
>>>> generic parsing?
>>>
>>> I just don't think there is a format like that. There is dd.mm.[yy]yy
>>> and apparently also yyyy.mm.dd, but without leading zeros in mm for the
>>> latter. Our date parser also takes "." for a space so that you don't
>>> need to quote a space ("1.day.ago"). I can see the logic behind parsing
>>> 2011.01 as January 2011, but it's a stretch from the existing formats:
>>>
>>
>> It would be far more logical to parse "2011-01" as "January 2011" as
>> that's the preferred way to write month-precision dates in most
>> countries that use both the metric system and the gregorian calender.
>>
>> I've never seen that date-type with dot as a separator, but with the
>> dash it's very, very common.
> 
> Seconded. ISO dates are getting pretty common, and in the extended
> format hyphens are the default separator between year, month, and date
> <https://secure.wikimedia.org/wikipedia/en/wiki/ISO_8601#Calendar_dates>.

Please, guys, this is not about ISO dates. It's about abbreviations of
yyyy.mm.dd, and that is not ISO at all!

Incidentally, we do not parse 2010-3 as March of 2010 either. Again,
this is not ISO date format (but an unofficial abbreviation). We may
decide to dwim that to 2010-03-01, and I would even appreciate that.

But yyyy.mm.dd is a format we don't support at all (because it's no
standard), so before supporting an abbreviation we would have to decide
about supporting that format.

> A few notes on support:

[notes about ISO dates cut]

Michael
