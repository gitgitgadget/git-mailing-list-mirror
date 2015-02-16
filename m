From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] migrate api-strbuf.txt into strbuf.h
Date: Mon, 16 Feb 2015 14:41:33 -0800
Message-ID: <xmqqegpp4gyq.fsf@gitster.dls.corp.google.com>
References: <20150116090225.GA30797@peff.net>
	<xmqqh9uqpwe9.fsf@gitster.dls.corp.google.com>
	<20150212230513.GA21222@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNUMF-0007wb-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 23:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbbBPWlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 17:41:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751538AbbBPWlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 17:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E95813828A;
	Mon, 16 Feb 2015 17:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GHLMD5U4yYDrKGdonNXjs+YQiXw=; b=Fs9nnz
	xcYTd6LEyMsKSW4nRpNJCk+JJ+KlX67DabI8B6ruBOnFfLNigfWPRKJzw94Dt009
	uuEUrao9mRhMwVPrWgj6C/zphZvfEyK6SgU+lnn1DBignHy7JWHWnuliCldqnjBr
	k2FylsK4kd9mKYzsQoEaE18LneBpZP5HsX3O0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WFnszFhkT34HSVOahtShBTqXJKMoJ6Q5
	K3wdtwoxO4drZ5Dhu7qyPjovcuofoeSF0BomMvcBkeN8s8o01HxbkA8BL+egIYiy
	Wt6/CaF7trEDHTaj+MafO/gpyq0+PlZ20Kbd1aEXfnMcxhcyvDwwrePQ8JIOOxKi
	e/0OUiXgVMg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEE3C38289;
	Mon, 16 Feb 2015 17:41:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 667CD38288;
	Mon, 16 Feb 2015 17:41:34 -0500 (EST)
In-Reply-To: <20150212230513.GA21222@peff.net> (Jeff King's message of "Thu,
	12 Feb 2015 18:05:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F5A98E54-B62C-11E4-A137-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263921>

Jeff King <peff@peff.net> writes:

>> Is there a general concensus on the direction?
>> 
>> I am inclined to merge this to 'next', if there is a general
>> understanding that we will try to make the headers _the_ single
>> source of truth of the API by (1) not adding to api-*.txt without
>> describing new things in the headers and (2) moving things from
>> api-*.txt to corresponding headers when clarifying, fixing or
>> updating the API.
>
> I'm fine with that (unsurprisingly), but I would like to hear an "OK"
> from Jonathan before going ahead.

OK.  Jonathan?
