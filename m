From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Tue, 16 Jun 2009 12:49:28 +0200
Message-ID: <4A3778B8.5040903@drmicha.warpmail.net>
References: <4A35FCFB.1080000@drmicha.warpmail.net>	 <1245098728-7502-1-git-send-email-bert.wesarg@googlemail.com>	 <4A374C4E.2090304@drmicha.warpmail.net> <36ca99e90906160056w4f892dc7n761b7e7fb91a288d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 12:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGWEn-0001Et-7a
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 12:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbZFPKts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZFPKtr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 06:49:47 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47960 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752173AbZFPKtq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 06:49:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BF9C83622A9;
	Tue, 16 Jun 2009 06:49:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 16 Jun 2009 06:49:48 -0400
X-Sasl-enc: LB32vcwukd+871W2ax0OLKh7YzvrObFsi2FMhZjmYu4O 1245149388
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E7C913A66B;
	Tue, 16 Jun 2009 06:49:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090615 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <36ca99e90906160056w4f892dc7n761b7e7fb91a288d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121669>

Bert Wesarg venit, vidit, dixit 16.06.2009 09:56:
> On Tue, Jun 16, 2009 at 09:39, Michael J Gruber<git@drmicha.warpmail.net> wrote:
>> Bert Wesarg venit, vidit, dixit 15.06.2009 22:45:
>>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>>
>>> ---
>>>
>>> On Mon, Jun 15, 2009 at 09:49, Michael J Gruber<git@drmicha.warpmail.net> wrote:
>>>> Jim Meyering venit, vidit, dixit 14.06.2009 21:46:
>>>>>
>>>>> * builtin-remote.c (get_one_entry): Use xmalloc, not malloc.
>>>>
>>>> Learning something new with every patch... Sorry, Junio; thanks, Jim!
>>>>
>>> One more reason to re-use existing string handling functions.
>>
>> Well, when we discussed this before v2 I asked for guidance about
>> strbuf, esp. regarding the issue of allocating/freeing.
> Well, I stopped reading after this question of yours: "But what do
> strbufs bring us here?"

Well, as I said I was strbuf-agnostic - some questions are really meant
to be questions ;)
In any case, I've learned from your patch.

> 
>> From your patch
>> I infer that "strbuf_detach" is what I was looking for. (And yes, it is
>> in the api doc where I overlooked it.)
>>
>>>  builtin-remote.c |   21 ++++++++++-----------
>>>  1 files changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/builtin-remote.c b/builtin-remote.c
>>> index 709f8a6..31adeaa 100644
>>> --- a/builtin-remote.c
>>> +++ b/builtin-remote.c
>>
>> For whatever reason, your patch does not apply (am) here on top of next
>> + Jim's patch. Given the context (xmallocs), it looks like it's against
>> something + Jim's patch. OTOH: 709f8a6 show's a get_one_entry with
>> mallocs. Did you hand edit the diff?
> Its on top of next (d6a466e528119011d512379f7f9dfac26deb7fd9), plus
> hand editing s/malloc/xmalloc/g.
> Sorry for this.
> 
> Bert

Junio will have to deal with it...

Michael
