From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Thu, 11 Jul 2013 14:57:47 -0700
Message-ID: <7v8v1crc84.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jul 11 23:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxOs7-0002oe-ND
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 23:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab3GKV5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 17:57:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756726Ab3GKV5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 17:57:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 007582F680;
	Thu, 11 Jul 2013 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eCmWl6SLmgGCZh+1DuYAwK+kMZY=; b=FhRClt
	jNrfCY5anYXgK7SpUZFz1Q1GmIpT9U5GDRdmur8oXluqDBZ6dbCgG6ScJx4FZ75z
	Q4ZhONhyDkNTOkCWjGoPl7mBmsBzTnrPOZI0dNyLnyDVBLQ8Shnrw5d2Ww0VIrjR
	q/QDjmk7IJw+FPq/Mq30+7WUIDG0A3VCzbPy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hXrbBuoYlw11wMuOomvEL6T3I6Tanhqh
	Zu1Hkg2jZh+vd+f5pw4Ig4BrTFBd8sqUeHdVWLIZcy9h8/RAM5HbV+MbCJ64+sLU
	EmdGGAvhVNJnUfGehQog83s4aQMRHNqh67ysEyEBGwh4cvQlQKd/rfMPo3cvQTzC
	OvoOvBRIbbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0282F67D;
	Thu, 11 Jul 2013 21:57:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A452F670;
	Thu, 11 Jul 2013 21:57:49 +0000 (UTC)
In-Reply-To: <51DF1F56.9000705@kdbg.org> (Johannes Sixt's message of "Thu, 11
	Jul 2013 23:10:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED3ECDE0-EA74-11E2-96F1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230133>

Johannes Sixt <j6t@kdbg.org> writes:

>> Or perhaps you were implicitly assuming that "--lockref" would
>> automatically mean "I know I am rewinding, so as soon as I say
>> --lockref, I mean --allow-no-ff", and I did not realize that.
>
> That's what I mean, sort of. Because of your 4 cases of a ref update, I
> do not think that
>
>> 3. The update fast-forwards, but the ref to be updated is not at the
>>    expected place; or
>
> is important to consider. The point of --lockref is to avoid data loss,
> but if the push is fast-forward, there is no data loss.
>
>> If that is the semantics you are proposing, then I think it makes
>> sense to make "--force" the big red button that lets anything go.

I have a reroll that goes in that direction.
