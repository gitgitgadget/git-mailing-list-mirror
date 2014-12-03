From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -i: allow list (un)selection by regexp
Date: Wed, 03 Dec 2014 08:13:46 -0800
Message-ID: <xmqqwq68k8xx.fsf@gitster.dls.corp.google.com>
References: <DB3PR04MB25020F247555E521936E676EB7D0@DB3PR04MB250.eurprd04.prod.outlook.com>
	<xmqqiohvqqqv.fsf@gitster.dls.corp.google.com>
	<DB3PR04MB2509E51F1DE708549483845EB7A0@DB3PR04MB250.eurprd04.prod.outlook.com>
	<xmqq8uiqm081.fsf@gitster.dls.corp.google.com>
	<CAPig+cSAUkG7APutRcb3AG1hLCBQACThfDBi-p75CSk_UsSK7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aarni Koskela <aarni.koskela@andersinnovations.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"akx\@iki.fi" <akx@iki.fi>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:14:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCZ1-0005Ul-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbaLCQNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:13:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752255AbaLCQNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:13:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90B9322880;
	Wed,  3 Dec 2014 11:13:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFVBdIEmTClEXFdE2J530ISRwW8=; b=PEF4Yh
	HZniMMCKWEEl3gPbAPUIxrEhW5r0EPUQ2c4dz38ZCoPY14RnASZXyrEaQ46xGsbN
	Y+8uXmBKAVm/hF8idjJQS/XE+pQiZQorJKJmlH4qGg2Brv/x/+bI7ONWc+7lOw55
	fkT1Rm2OvcsciTnEUxgui1ajRLF/LWeK2MJpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cov8vbhYKuVnflZpUJJjlErqW4UNJ/za
	cmxPEv4D7X0c00v0HnfFnTMy2C6Ie6Iv0T6epfH7/h0dH7L+TZa9C15HJHuyRJ1I
	hshA2ZVtRe5CSg7pMW4bF6/Frne0KRM15lIjqx+tmlyXPOLls+lMhskOn/alaO7M
	0gOgdJb3HfE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83F702287F;
	Wed,  3 Dec 2014 11:13:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 048362287B;
	Wed,  3 Dec 2014 11:13:47 -0500 (EST)
In-Reply-To: <CAPig+cSAUkG7APutRcb3AG1hLCBQACThfDBi-p75CSk_UsSK7Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 2 Dec 2014 19:08:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CD3E144-7B07-11E4-884C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260657>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Dec 2, 2014 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Aarni Koskela <aarni.koskela@andersinnovations.com> writes:
>>
>>> From 9096652a71666920ae8d59dd4317d536ba974d5b Mon Sep 17 00:00:00 2001
>>> From: Aarni Koskela <akx@iki.fi>
>>> Date: Tue, 2 Dec 2014 13:56:15 +0200
>>> Subject: [PATCH] git-add--interactive: allow list (un)selection by regular
>>>  expression
>>
>> Remove the three lines from the top, move the content on Subject: to
>> the subject of the e-mail.
>>
>> Other than that, everything I see in this message is very well
>> done.
>>
>> Thanks, will queue.
>
> This change deserve a documentation update
> (Documentation/git-add.txt), does it not?

Sure.  Any volunteers?

> Tests too, perhaps (assuming other git-add--interactive selections
> selection modes are already tested)?

That too ;-).
