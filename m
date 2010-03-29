From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Remove usage of deprecated Python "has_key"
 method
Date: Sun, 28 Mar 2010 21:08:23 -0700
Message-ID: <7v8w9bkbwo.fsf@alter.siamese.dyndns.org>
References: <1269737112-21631-1-git-send-email-davvid@gmail.com>
 <7vy6hc4d0h.fsf@alter.siamese.dyndns.org> <20100328215442.GA31195@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 06:08:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw6HJ-0006zF-AP
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 06:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039Ab0C2EIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 00:08:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0C2EIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 00:08:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5C0BA5C0B;
	Mon, 29 Mar 2010 00:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PdUC/JNb0OVHVP+anzFQgZ6Hm08=; b=nZJ379
	820HBmMWvtlHpfvINiNFTTThHubs2ipg/SlYY2OBnEAEoFhMV8Rgx8JRMSZFABF2
	AqfRwVtB5+tJDW/SMKUwJqCwwfw1/ASrJ1PI6ZKTg3J3mvtzhk502kqx0Bn7VmGm
	yZno8nnXOVcj2q3mFQEgMt9b5PolsLfOkejsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNbaHktafiRKB34o0Gh3hkTBhMA+7/PK
	9JYhMEkD6qArchNkglNU7URmtY8PSTi9rz+5YEOJnVLRs5y8KGlojxRahEEVNKM/
	H8tuWVLf7yfKs2p337bY9925IU0n9qmyzw3kGxqK1Qb0vWacYz46v5dYws5Ix139
	34+MppDKTXA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77BDAA5C09;
	Mon, 29 Mar 2010 00:08:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB68BA5C03; Mon, 29 Mar
 2010 00:08:24 -0400 (EDT)
In-Reply-To: <20100328215442.GA31195@gmail.com> (David Aguilar's message of
 "Sun\, 28 Mar 2010 14\:54\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BB5C2D48-3AE8-11DF-9F67-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143433>

David Aguilar <davvid@gmail.com> writes:

> On Sun, Mar 28, 2010 at 09:38:54AM -0700, Junio C Hamano wrote:
>> David Aguilar <davvid@gmail.com> writes:
>> 
>> > "has_key" is a deprecated dictionary method in Python 2.6+.
>> > Simplify the sys.path manipulation for installed scripts by
>> > passing a default value to os.getenv().
>> 
>> It looks like the old code was replacing sys.path[0] but you are
>> prepending this.  Doesn't that change also make a difference?
>
> The original code replaced sys.path[0] which is ''
> (aka the current directory).  It's a little odd to
> rely on the 0th element being something that is safe
> to remove.
>
> By prepending the path we have the same intended effect without
> having to know that the 0th element is something that is
> safe to remove.
>
> Does removing '' break relative imports? (It might...)

That is exactly why I asked if it was an improvement that was not
described in the log message.

I'll queue with Johan's Ack, perhaps rewording the message a bit.
Thanks.
