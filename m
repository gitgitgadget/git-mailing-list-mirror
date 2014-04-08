From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Tue, 08 Apr 2014 09:26:36 -0700
Message-ID: <xmqqbnwblrcz.fsf@gitster.dls.corp.google.com>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com>
	<533FCA92.8060006@kdbg.org> <5342EFD4.6020007@kdbg.org>
	<CACsJy8A0oNRZ45xLvGTDPmDu0ZEAyHbdQBt2gdyo1yUtUeeB_g@mail.gmail.com>
	<5343F602.8080007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Zager <szager@chromium.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 18:26:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXYrF-0000C1-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 18:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbaDHQ0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 12:26:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbaDHQ0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 12:26:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A05B7A75E;
	Tue,  8 Apr 2014 12:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/gHNh0RTNI6KgjhprC+kK797uk=; b=HiTZHs
	A4de249EkVgv7K8rnpswQEyYuqorBxePwIXBD7RxFij/K2Ibdj50KKLy6u4++Gnu
	cpChXa7dVzQPhXgDbgFgU7JdOc2N6sv/0upZ6b1h9LEDpNqNj2Ywxi7e5CzaPmlw
	UCG6vZBWdTVPGUOhOfVzLb45z8th5d6XW1gDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UM4HU30g40VkuQAmfheSSCyE+e1GlQ6r
	fPjqvk3GpXkgr5X1/bH//rBWsuOuVGZW0qDYK57r0jvDm4XMr9/YdEuKW+XWESI9
	tkeRetYEseG4Az5BQDODGllv/qMUdLfnh2sbUkaoLUqv81OA2bzS3mhV3VViMk0Q
	ldM+B/RjiXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6565F7A75D;
	Tue,  8 Apr 2014 12:26:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3887B7A758;
	Tue,  8 Apr 2014 12:26:38 -0400 (EDT)
In-Reply-To: <5343F602.8080007@kdbg.org> (Johannes Sixt's message of "Tue, 08
	Apr 2014 15:13:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F2E3344-BF3A-11E3-BDED-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245930>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.04.2014 02:39, schrieb Duy Nguyen:
>> On Tue, Apr 8, 2014 at 1:35 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> Am 05.04.2014 11:19, schrieb Johannes Sixt:
>>>> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>>>>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>>>>  - Enable index-pack threading in msysgit.
>>>>>
>>>>>  What is the status of this topic?  A failure report exists
>>>>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>>>>  where the discussion stalled.  Is everybody waiting for everybody
>>>>>  else to get the discussion unstuck?
>>>>
>>>> I still have to cross-check Duy's patch. I'll hopefully get to it in the
>>>> next days and report back.
>>>
>>> The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
>>> with this patch with a MinGW build.
>> 
>> Is "this patch" the one on 'pu', or mine?
>
> "This patch" is the one on pu (sz/mingw-index-pack-threaded). I'm sorry
> for the confusion.

... which has been dropped from 'pu'.  So the next step would be
perhaps to queue $gmane/245034 instead and see if it gets the
parallelism Stefan wanted to see in that codepath?

Thanks.
