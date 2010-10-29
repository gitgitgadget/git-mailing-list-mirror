From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add support for the SUA layer (interix; windows)
Date: Fri, 29 Oct 2010 09:08:32 -0700
Message-ID: <7vsjzp6kxr.fsf@alter.siamese.dyndns.org>
References: <1288168793-11159-1-git-send-email-markus.duft@salomon.at>
 <1288168793-11159-2-git-send-email-markus.duft@salomon.at>
 <7veib99608.fsf@alter.siamese.dyndns.org> <4CCA5B50.2040208@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Markus Duft <mduft@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 18:08:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBrVY-0005iH-Ec
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 18:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900Ab0J2QIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 12:08:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0J2QIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 12:08:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F8C1499;
	Fri, 29 Oct 2010 12:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qNLsChNjc69q9g13OESI+ctViB8=; b=Ca+Ew/
	mTbTlvr8LUABcK7ZmLQe+x+E9NsEBFhyCG+lwWQl0f08JqUefbzWRz36oOFs9ykh
	Sdn5YsvklWx8OpcmayOtOxFf0R5UzN0989tQx8776DY2dZyr4Ys6cG6nPjZ+KNtc
	sBa/O9MQCjb47NzYqBl8Sa9V1jVz+MrE6eI1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C301UrJDUqms7sqQgKvJDFTr4zYIe+Q4
	cEOhxkhSccmPQvrTyFtuQHlbSkr5Snd9VeThLe3dkYy2iv1/q5r2Ar6rmgwKVXgG
	sDWctML1FEOaHRLw41O1HCAal1N0OT1leSkvHLH0fnIC5mK8sw8tI1/9HMNb0fS2
	uUlCL3vMKKE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 008A41495;
	Fri, 29 Oct 2010 12:08:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43B7B1494; Fri, 29 Oct
 2010 12:08:34 -0400 (EDT)
In-Reply-To: <4CCA5B50.2040208@gentoo.org> (Markus Duft's message of "Fri\,
 29 Oct 2010 07\:27\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA0AAB26-E376-11DF-9D85-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160337>

Markus Duft <mduft@gentoo.org> writes:

> On 10/29/2010 02:50 AM, Junio C Hamano wrote:
>> mduft@s01en22.salomon.at writes:
> [snip]
>> 
>> It would be much nicer to do this:
>> 
>>         #ifdef NO_INITGROUPS
>>         #define initgroups(x,y) (0) /* nothing */
>>         #endif
>> 
>> near the beginning of the file.  That would make life of people who have
>> changes in flight that would touch the same area of the code a lot easier.
>
> ok, i see the point, thanks for your suggestion! I'll change this.
>
> may i ask where i should send v3 of the patch so it gets processed further?
> just the ml again, or is there a specific maintainer i should send this to?

If your v3 will be different from your v2 with only that change, there is
no need to resend.  Please check what I queued in 'pu'---it has the above
fix already squashed in.
