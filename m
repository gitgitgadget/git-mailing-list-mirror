From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 13:57:55 -0800
Message-ID: <xmqqoaq181p8.fsf@gitster.dls.corp.google.com>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
	<20150114121915.GB30383@peff.net> <20150114123536.GA31530@peff.net>
	<xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
	<20150114205437.GB1155@peff.net>
	<CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
	<20150114210222.GA5396@peff.net>
	<CAPig+cT+bG=Pzws0WKpgnZX2mg4+VmAgxTBCwNiOGDmY4AzSKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Henning Moll <newsScott@gmx.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVwx-0007fP-KM
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbbANV57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:57:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752308AbbANV56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:57:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD7A2DED8;
	Wed, 14 Jan 2015 16:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ydaONiqeEv+DCIP+bs3eCI4/Fd4=; b=s0W8rE
	hsCjpobdM/YzrS+NLvR+7sUUKjZ1eT5iX6LkXhMJDKisKQMUmKigTof9dACmp4Re
	Ucotvi5Kv/6ADLpFLCRRPIb6b7h9uk05RNuV+1x9yraaWkExX7f2psjoWTuY/wQK
	CCaqnlQOpHxDoqcMsGY8M5EMDJfe6wFnDHxyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzF7YueabeAUtsv8Vw9bnAJX+Yoflequ
	p3jOtubDxCyjraH1FAim9VdWPTuWjvL4NOcXqj0BC/aI1bA4c/o4PTUmmVahTX5c
	q6uQCVcMA7KfKMu1XDxCrdvcWLm7k5JwwPji0lD2Ks1vSTUet8S/MdehU1ci4rlf
	SRVpl/Q8dFE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D06822DED7;
	Wed, 14 Jan 2015 16:57:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 553D92DED0;
	Wed, 14 Jan 2015 16:57:56 -0500 (EST)
In-Reply-To: <CAPig+cT+bG=Pzws0WKpgnZX2mg4+VmAgxTBCwNiOGDmY4AzSKQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 14 Jan 2015 16:11:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6622A5C6-9C38-11E4-8A79-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262435>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 14, 2015 at 4:02 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Jan 14, 2015 at 04:00:37PM -0500, Eric Sunshine wrote:
>>
>>> > So yeah, the most plausible theory to me so far is unluckiness combined
>>> > with pre-1.8.4.2. That should be easy to disprove if Henning tells us
>>> > his git version.
>>>
>>> Henning mentioned it at the very top of his original problem report:
>>>
>>>     "(git version 2.2.0)"
>>
>> Ah, reading comprehension. It pays off.
>>
>> I'm stumped, then.
>
> Perhaps some new code been added to git-rebase--interactive.sh since
> 75c69766 which neglects to invoke expand_todo_ids()?
>
> Or, possibly some older version of git is being invoked somehow during
> rebase despite his "front end" use of 2.2.0?

Or git_sequence_editor creates conflicting objects?
