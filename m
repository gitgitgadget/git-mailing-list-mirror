From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 15:05:00 -0800
Message-ID: <xmqqbnnwurmr.fsf@gitster.dls.corp.google.com>
References: <6997784.RuzRO1AFsK@al> <27811375.1kgEM3BV3q@al>
	<20141124222243.GA9055@peff.net> <1660121.8PEbpzfRYH@al>
	<20141124225457.GA9942@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Peter Wu <peter@lekensteyn.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2hN-0007sS-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaKXXFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 18:05:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751596AbaKXXF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:05:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF2F21384;
	Mon, 24 Nov 2014 18:05:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fSwlNtW3gWr3I/7ZHU/P5OtnV04=; b=aZDANi
	e7MuMfp20Vgc88GIoAeoVKsAYVD5Gg1HtM5M6x6rXeeiqWo3aV4Z+vwMLqDFt+7g
	hkDQjJFdQF7SPcZYaiRjBzzs2y5HaFLuiogai03aHiLF16TN20I0Fa2yF1lkU9WI
	SMdYVu1867GED7/kV3iZk0muNAm359YB4b01M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eTI9RqTEibmLiZBP2EGqH6L401aRxoCD
	5yFiBD1mwbZZM7mNrVzex0U3Z7NO5Prca5DVxNUd9bmmG6WF9Er2OaQr0N5ANTuu
	x+2ot8sHxkCkEJcMRIDrthk48Arr14f3yNmhJr8gr3FPBWgUj43uHdXKPsIBo4y5
	Upw9dYUbKDo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02D1A21383;
	Mon, 24 Nov 2014 18:05:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4D822135C;
	Mon, 24 Nov 2014 18:05:02 -0500 (EST)
In-Reply-To: <20141124225457.GA9942@peff.net> (Jeff King's message of "Mon, 24
	Nov 2014 17:54:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52774E28-742E-11E4-9170-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260168>

Jeff King <peff@peff.net> writes:

> My complaint is that you have three possible options to provide: --push,
> --fetch, or no option at all. And "--fetch" sometimes behaves like no
> option, and sometimes not. Which is the confusing/non-orthogonal part.
>
>> I can understand that --fetch sounds a bit weird, what about this
>> natural translation:
>> 
>>     "git remote: set the URL (only the fetch one) for NAME to URL"
>>     git remote set-url --only=fetch NAME URL
>> 
>>     "git remote: set the URL (only the push one) for NAME to URL"
>>     git remote set-url --only=push NAME URL
>>     (obsoletes --push)
>> 
>>     "git remote: set the URL (both) for NAME to URL"
>>     git remote set-url --only=both NAME URL
>>     (it would be nice if --only=both (weird!) can be removed in the
>>     future such that the option is more natural)
>> 
>>     "git remote: set the URL for NAME to URL"
>>     git remote set-url NAME URL
>>     (current behavior: YOU git guru knows what I do right?)
>
> Yeah, I think that addresses my concern (because it explicitly leaves
> no-option as a historical curiosity, and not as an implicit version of
> "--both").

Fine by me, too.
