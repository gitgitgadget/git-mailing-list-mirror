From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Mon, 09 May 2016 09:03:44 -0700
Message-ID: <xmqqposvxlpb.fsf@gitster.mtv.corp.google.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
	<xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
	<20160427101833.GA5536@lanh>
	<xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
	<20160501002852.GA3963@lanh> <20160501060009.GA30748@lanh>
	<xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B16SWsu5xTHdPcR4dz4_z+Br5EGGbJ+B5SChA=sWo-bg@mail.gmail.com>
	<CACsJy8DtFLkfqSHRjFU4N9H9C3MfVOn-XEy4yOwneQaatvvDkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:08:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznez-0005QH-7V
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcEIQDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:03:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751275AbcEIQDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:03:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 16D751763E;
	Mon,  9 May 2016 12:03:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvVfCQ4bI51KbYteoejvMbLJpAg=; b=WFe682
	XhrHZ8tNkX5KPO+PhK03LaAalnhwcB5Hc7JcPzzmv3OMRSXOwzzGn7nMpXguHXJs
	QRiqvgI9GQoU+P398XDRyIh66QMkChn1x/SIW6alpfLNn93hRsC7iuRpxQYs9M0l
	hr/dlehp1mCv42q7g7hU6CePkS4W1izOW/F1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g8Oi2sAkABWcX0IpYWKbctwSBjLrn3Qb
	gjs0bRpDQDQGlYaDdE0SCzCqJficXdBx1HnTW69/1IR/UmaNpF1HQYbrVbERv3fA
	bxGTMZlIa4SkR56j1+igVflI21qhxHQgvP8XOzgGB5aOY+bFnXZOP0m1pxIrsR5u
	CHDBio8xRNY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DD471763D;
	Mon,  9 May 2016 12:03:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8374F1763C;
	Mon,  9 May 2016 12:03:46 -0400 (EDT)
In-Reply-To: <CACsJy8DtFLkfqSHRjFU4N9H9C3MfVOn-XEy4yOwneQaatvvDkQ@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 8 May 2016 16:51:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9C5C4394-15FF-11E6-9579-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294002>

Duy Nguyen <pclouds@gmail.com> writes:

> So among the options we have so far, which way should we go, or leave it as is?

Thanks for reminding me.

I like that version you sent with "I may have rushed to judgment"
comment the most.  Perhaps I can just queue it with s/PATH/PROG/
fixup?

>
> On Tue, May 3, 2016 at 7:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, May 3, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> I may have rushed to judgement. wrap-for-bin.sh has always been the
>>>> dependency for bin-wrappers/*. If we force that file to change, then
>>>> bin-wrappers/* will be recreated when switching branches. So how about
>>>> this?
>>>
>>> I do not think you are "force updating wrap-for-bin" in any way in
>>> the patch, though.  You are building it in such a way that it does
>>> not have to get updated within the revision that contains e6e7530
>>> (assuming that this will be queued directly on top it and merged to
>>> everywhere e6e7530 is contained).
>>
>> Yep.
>>
>>> The new case/esac looks somewhat bad (its knowing that where test-*
>>> lives, test-* is the only thing that is special, etc. troubles me at
>>> the same time that case/esac is funnily formated).
>>
>> We could just make some random changes in this file. That would have
>> the same effect.
>>
>>> Where does "@@PATH@@" come from and who rewrites it?  Is that a
>>> misspelt "@@PROG@@"?
>>
>> Yep. Should have run make distclean before testing :(
>> --
>> Duy
