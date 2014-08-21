From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Added tests for the case of merged and unmerged entries for the same file
Date: Thu, 21 Aug 2014 15:21:31 -0700
Message-ID: <xmqq7g21qyac.fsf@gitster.dls.corp.google.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<7782c581021d529947a1385939231eeb145d150e.1408533065.git.jsorianopastor@gmail.com>
	<xmqq8umiub9x.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NGUTw8NLTyJSgphh=XBgxy4eTFQLF5yxGD3GgpKbc-Vog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKajp-0006Wt-TS
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 00:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbaHUWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 18:21:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53877 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbaHUWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 18:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13B003432F;
	Thu, 21 Aug 2014 18:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XBAr4w5REPxmM+sBP6KLdCsjEtA=; b=OzWljG
	lOq7wmnghr/WpKTBD43W5vslCSID48qwOso6sI+fdDUcskBOgcQ1AmNKekmN0dii
	RcpBnhipGxriEtFg86jn8ftEmD0YQ+49q1hKlujRhR72WOgq9yd0U5BQ45BITzjI
	BQiG1qYoeb6TxFidxu+nRhf9uy1BoSvoEf2NM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JKemoabtllu7djYpKYxcHfWLwqNExqc9
	t2p7Sp0M0Z07UNzPHy7jpWYn/559yOusOm0Zuz1xFZ8VJ6CC3AygRSuPYoRSRleF
	rPQfFq1Xp8w+9kRn8dwf4QdkrvBrbBSt5HIweKXDPoGCgVDzdOkOlpwGwa77fOqv
	jID1ieP152Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 093123432E;
	Thu, 21 Aug 2014 18:21:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EE1734325;
	Thu, 21 Aug 2014 18:21:33 -0400 (EDT)
In-Reply-To: <CAPuZ2NGUTw8NLTyJSgphh=XBgxy4eTFQLF5yxGD3GgpKbc-Vog@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Thu, 21 Aug 2014 15:51:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 81CF38A4-2981-11E4-A3C4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255642>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> On Wed, Aug 20, 2014 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>>
>>> Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
>>> ---
>>>  t/t9904-unmerged-file-with-merged-entry.sh | 86 ++++++++++++++++++++++++++++++
>>
>> Isn't this number already used for another test?  A test on the
>> index probably belongs to t2XXX or t3XXX family.
>>
> Umm, I though this test number was free, I just added it to the last+1
> position, if I finally add a test I'll take this into account. Thanks.

Please check t/README for classes of features and appropriate first
digit; also do not forget that there are topics by other people in
flight and you may need to at least check with the tip of the 'pu'
branch.

Thanks.

>>>  1 file changed, 86 insertions(+)
>>>  create mode 100755 t/t9904-unmerged-file-with-merged-entry.sh
>>>
>>> diff --git a/t/t9904-unmerged-file-with-merged-entry.sh b/t/t9904-unmerged-file-with-merged-entry.sh
>>> new file mode 100755
>>> index 0000000..945bc1c
>>> --- /dev/null
>>> +++ b/t/t9904-unmerged-file-with-merged-entry.sh
>>> @@ -0,0 +1,86 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='Operations with unmerged files with merged entries'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +setup_repository() {
>>> +...
>>> +}
>>
>> No error is checked here?
>>
> This is only a helper function for setup, not a test itself.

So what?  If the set-up fails, we would want

    $ sh tXXXX-my-test.sh -i

to immediately stop without going further.
