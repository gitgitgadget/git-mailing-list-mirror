From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/20] tests: turn off git-daemon tests if FIFOs are not available
Date: Thu, 28 Jan 2016 13:35:30 -0800
Message-ID: <xmqqd1slmlp9.fsf@gitster.mtv.corp.google.com>
References: <cover.1453818789.git.johannes.schindelin@gmx.de>
	<cover.1453911367.git.johannes.schindelin@gmx.de>
	<35b05b7e0d01bf550b698d3c6ecc577eb80d4149.1453911367.git.johannes.schindelin@gmx.de>
	<CAPig+cRXV-nv1ZZv1MrujdF3YfZMgwusTcBHAXnyCRaYyXmRWg@mail.gmail.com>
	<alpine.DEB.2.20.1601280939170.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:36:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOuE9-0007SK-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 22:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbcA1Vfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 16:35:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161198AbcA1Vfc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 16:35:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BEB23ED40;
	Thu, 28 Jan 2016 16:35:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tSQjF69aM0mozrZaAspO2yYiiaU=; b=t4ZL96
	PXb9FvOKBs3V+wFrrWngXd9g4q6tiuNwOpo8p7+ERT5aBDIj6sksnleC8TxXfE1x
	8hZbt5h8YZkcOAT8hBPJvhYWaJToP5KZybc2bSgxXDgt050mgA0E1OWOLn1VIb04
	Fy9ldmH61no09YDO3v1oOdsJ2XsPC/Hqfk4No=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vaKoz+hD+gURZjzVTCV3DqYtzyPUTgAl
	cvizBDfkSCZWwIMgnZMrEggnHQVzphYtftQZgVoZouskULQHyX9WFF7CSh1vRpvM
	QauH0VFfcduSEybRlzWJUGwfyhgNZXgrrO8y43SJpWMGVFCof30tw/g7uMFnTwl/
	BhRlIyqlqtc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13BE43ED3F;
	Thu, 28 Jan 2016 16:35:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 81C0D3ED3E;
	Thu, 28 Jan 2016 16:35:31 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601280939170.2964@virtualbox> (Johannes
	Schindelin's message of "Thu, 28 Jan 2016 09:40:43 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E869288-C607-11E5-B632-B4986AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285034>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
>> > @@ -23,6 +23,11 @@ then
>> > +if ! test_have_prereq PIPE
>> 
>> Maybe:
>> 
>>     if test_have_prereq !PIPE
>> 
>> ?
>
> Darn. Of course I only looked for '! .*MINGW', but I should have looked
> for '! test_have_prereq' in the patches.

Wow.  Talk about fine-toothed comb ;-)

Will squash in.  Thanks for a set of sharp eyes.
