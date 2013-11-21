From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 14:04:36 -0800
Message-ID: <xmqqwqk12yyz.fsf@gitster.dls.corp.google.com>
References: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
	<xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
	<87pppt31v9.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 21 23:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjcMs-0008Gv-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 23:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab3KUWEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 17:04:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab3KUWEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 17:04:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A525454A30;
	Thu, 21 Nov 2013 17:04:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOrsCrK8bxaCcQd34EqpHPsaISs=; b=UzX1vd
	owT/ho2ai4ActcEP2HgQtFjSRrAfg0bQCxfsZNuYyNz40are0Xq8+5F8JOY/VyYG
	FCgE0PDJcwQAO+nAq1S5gzy/K5JV5EGKXFeOm0YADlkGi0myFNomYoV3WhnQGcRH
	4opm91uRUzRCc3iYUjj8xamghPYt/5j5RzY7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=escyTMU4NBTxRUy030JWKKfQWsI70TTS
	F2hUe452fKALwY2y8XtxCIWnYHgV8Bg1nqQrdT0taVP5f5U/ZPjCPpndz8y6hZvs
	dB+JIu3H0WNaMpNzJhC+1biykMyv5yk3Lkqfc8QRZO41W1+23aBdlra8Nv/OP0M1
	QV2rN1mOaGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8402754A2F;
	Thu, 21 Nov 2013 17:04:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8252554A2D;
	Thu, 21 Nov 2013 17:04:49 -0500 (EST)
In-Reply-To: <87pppt31v9.fsf@thomasrast.ch> (Thomas Rast's message of "Thu, 21
	Nov 2013 22:02:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F0BBA7BC-52F8-11E3-93EB-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238158>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  OPTIONS
>>>  -------
>>>  -v::
>>> -	Verbose.
>>> +	Verbose.  Currently shows the commit subjects next to their
>>> +	SHA1.
>>
>> Whenever I see "Currently", it makes me wonder "why does it need to
>> say that? Is there a plan to change it soon, and if so where is the
>> plan described?".
>
> I wanted to avoid documenting exactly what it does, so that in the
> future it could do more than that.  Is that overly paranoid?

I would have to say so. After all, the documentation is supposed to
describe the current state of affairs, and we would update it when
"the current state" changes. In places, we may express our plan to
forewarn readers of planned upcoming changes, but still...
