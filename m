From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 13:06:46 +0100
Message-ID: <4D873F56.1060803@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318194802.GB27825@sigill.intra.peff.net> <4D871401.6020900@drmicha.warpmail.net> <20110321105431.GB16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 13:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1dsp-0004xd-Tq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 13:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab1CUMGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 08:06:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55221 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753167Ab1CUMGq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 08:06:46 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB8B7207EE;
	Mon, 21 Mar 2011 08:06:45 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 08:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ZFaucAprSrC7EgMb2DLpMxO3sBk=; b=DaWpsRph6YACBQ746+XFRY2szxq2TSB1yIbcHNl5i/4vNmmqmhMlnmf+4jMVCxJiNvnWWtyCYBVAFbSllA9NKeYCU/C42LqiD3qzC3eCsF+PsKro/FaOkRNYQ3omr9FDQrqJWqMAvFMvxrbRp9GGoemDgUOlKNx0E8RAWRkffdI=
X-Sasl-enc: gA8Q344aEnZuUgiAwPHF8+7Cw46VXvgXDdjbWTDlWwo8 1300709205
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E036C4417D3;
	Mon, 21 Mar 2011 08:06:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110321105431.GB16334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169587>

Jeff King venit, vidit, dixit 21.03.2011 11:54:
> On Mon, Mar 21, 2011 at 10:01:53AM +0100, Michael J Gruber wrote:
> 
>>>> +	Show only commits which have at least resp. at most that many
>>>> +	commits, where `--max-parents=8` denotes infinity (i.e. no upper
>>>> +	limit). In fact, 7 (or any negative number) does, but 8 is
>>>> +	infinity sideways 8-)
>>>
>>> I didn't quite parse this "resp." in the middle.
>>
>> Well, there are two options (--min-parents, --max-parents) which we
>> describe in one paragraph. Sooo...
> 
> I figured out what you were trying to say. I just had never seen the
> abbreviation "resp." before. I guessed it meant "respectively", but the
> syntax is all wrong.
> 
> Digging around via google, I was able to find that it is a mathematical
> term with a specific syntax, but one I had never seen before. Maybe I am
> just clueless and sheltered, but after 30-odd years of reading English
> (12 of which involved reading academic computer science papers!), I
> can't help but think it is not all that common and may confuse other
> readers. Add on top that it is usually used in parentheses, which helps
> make it more obvious what is going on.

In my community it is very common, which may partly be due to the fact
that there is a strong proportion of non-native speakers. It took it for
granted that it's a standard expression.

> 
> I really think "Show only commits which have at least (or at most,
> respectively) that many commits" says the same thing, but is way more
> accessible.

Sounds good, I'm happy with that. Resend or squash on apply?

> 
>>> That way it is obvious that "--merges" cancels a previous --min-parents
>>> on the command line (maybe the text should be "this is an alias for..."
>>> to make it clear that doing it is exactly the same).
>>
>> Yes, that is helpful. I have doubts about "alias" for. Without wanting
>> to sound elitist or something, I have the impression that we start
>> catering for users who understand "equivalent" more reliably than "alias".
> 
> I just wanted to make sure people didn't think "equivalent" meant "has a
> similar effect to" as opposed to "is exactly as if you did". But reading
> it again, I think "equivalent" is fine, and I see you picked it up in
> the latest series.

I may be wrong about what is common in this case, too. For me, "alias"
is foremost a technical term, and I would guess that many non-native
speaker know "alias" either in the technical sense or not at all, but
not so much in the common English sense. But either way is fine.

Michael
