From: Junio C Hamano <gitster@pobox.com>
Subject: Re: General support for ! in git-config values
Date: Wed, 01 Feb 2012 17:39:42 -0800
Message-ID: <7v7h06109t.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 02:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsleQ-0006zk-K2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2BBBjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:39:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab2BBBjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 20:39:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20276861;
	Wed,  1 Feb 2012 20:39:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bftuURIbfrIkdf1IlT3ELI+0X2o=; b=fgjL8M
	UyWqHAQAyyD5aiNRdD9FwUZYhPQ084stOO2MzawzaqbGSqCWSAlak9AeI5J+6nnu
	yh0PZDsN8fyVY5Cdpk2heLP2kg+u7RzFoRonYFweIkqOedodGwgggVd0wKOi/Hc+
	4S48E/AuGkVK0Aj6jSf6YqQVZXOO9KZuffmro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aJYLDSmP2k31QMST0aAi84sax9TyjWyM
	KXUy9eY8uW5rr7LMI9F+SqMT7KSBrCtOGx18Ez5BeFwy53a2RFjKXfMJSlTLMWFo
	7yBkzfHV3Z1R515t1j60o+7RZUdLEBqkosL87D/nZKoWh0vWy+uJEXjC6H0/APuy
	BA6DMXNY80k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9C296860;
	Wed,  1 Feb 2012 20:39:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AFFE685F; Wed,  1 Feb 2012
 20:39:44 -0500 (EST)
In-Reply-To: <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 (demerphq@gmail.com's message of "Thu, 2 Feb 2012 02:14:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C85BB3D2-4D3E-11E1-B1AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189570>

demerphq <demerphq@gmail.com> writes:

> On 2 February 2012 01:27, Junio C Hamano <gitster@pobox.com> wrote:
>> demerphq <demerphq@gmail.com> writes:
>>
>>> user.name=!ldap_full_name
>>> user.email=!ldap_email
>>
>> I didn't get the impression that that was what he was proposing, but
>> regardless of who's suggesting it, the above does not make any sense,
>> from the syntax point of view.
>
> Does that mean that from a utility point of view it does?

Not really.

I do not think whatever "utility" value outweighs the hassle of having to
think through the ramifications (including but not limited to security) of
running arbitrary user command every time a value is looked up.
