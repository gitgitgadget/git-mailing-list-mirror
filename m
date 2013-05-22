From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 15:58:16 -0700
Message-ID: <7v4nduipvb.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHzE-0006ds-AM
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041Ab3EVW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:58:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756992Ab3EVW6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:58:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB40C211C9;
	Wed, 22 May 2013 22:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V7ggSATk+kBRRof+fbMljqmkNC0=; b=fasulG
	iCcKmTZGhPpYJABZDAAUJ/9XtHDMhVNTWkIjBzLboHvmWkDzTNW+beln/oTIpL/Z
	6ylkmw1S0UBwRWOrIcpvoPqUBSStxeWO+KerWxdbI5q89c5xP3t2DchFTh+S1/eS
	iQBXeDxFURTecoBeobuX5syCM/74T38BAp1ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c29LVYn3m/J1Dzpj7CqAvwFpi7960LnQ
	hrxSKms5Xj6b+upj7qClKdN5qjiO805xSnbKRNyKG9ooSh/xR2H+8CBQmXH+6Z+c
	yK89ZYjMx99IhF0kfQP9yLNeSDwxnIhn6isafK2HiZsm0+cju9TlJaYhCVLqyFms
	fYvUkHKQTHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C007B211C8;
	Wed, 22 May 2013 22:58:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32675211C7;
	Wed, 22 May 2013 22:58:18 +0000 (UTC)
In-Reply-To: <7v8v36iq3e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 May 2013 15:53:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17A7E65C-C333-11E2-89D9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225203>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, May 22, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> As I already said in the above, the answer is no, when you are
>>> trying to find who moved the code from the original place.
>>
>> But I'm not trying to find who moved the code, I'm trying to find
>> related commits; hence the name 'git related'.
>>
>> The person who moved the code will be on the list regardless,
>
> That is exactly the point I have been trying to raise.  Does the
> person appear in the list when you run blame with -CCC?  You ask for

s/person/commit/;

> the body of the function, and the -C mode of blame sees through the
> block-of-line movement across file boundaries, and goes straight to
> the last commit that touched the body of the function in its original
> file, no?
