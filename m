From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5541: Bad file descriptor
Date: Wed, 04 May 2011 22:35:13 -0700
Message-ID: <7voc3hbtgu.fsf@alter.siamese.dyndns.org>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu May 05 07:35:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHrDq-0002Ah-QC
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 07:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab1EEFfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 01:35:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1EEFfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 01:35:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9470535D8;
	Thu,  5 May 2011 01:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bLOzvklPuiYKywQ4SdpptKmRf3k=; b=u+Byx0
	hds9iEA1ilb8n6N0WZ1Oa08t/faWhDYb/MuMicmQn+SElD81qQqfksMDG8y/s2+Q
	jnQBTqPCqVSWPBfntug4WlfFkGpRTK8pfP3TsjU04Wf2GTHFsex9uhneR2xzFH9n
	JppeKtFV62FoDMsWSe97DPQ/B6wAFYxBTxNpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KC0MaR1eoXUlY8zMlzgw486ubRTY5HhU
	DIpyu85N665PIGGHEPaXQLi2oN+s19plkBxG3jT8ROaFAbCBR9a/Px3wGcyrrupC
	WwpbfS0BZaD4hVRSqr7mc4JmNXa5Tk5EcYMMF48l2w2Z9m7lnbhdufO9++GeiWmP
	yYmhXfb7cTk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70C3935D5;
	Thu,  5 May 2011 01:37:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9340E35D4; Thu,  5 May 2011
 01:37:18 -0400 (EDT)
In-Reply-To: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu, 5 May 2011 00:49:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF7E7FC4-76D9-11E0-A389-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172796>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> I haven't had a lot of time to track down it down until today, but I've
> been getting failures in t5541-http-push-.sh.  Several tests fail with
> the error "fatal: write error: Bad file descriptor".

A wild guess.

Does it help if you cherry-picked 1e41827 (http: clear POSTFIELDS when
initializing a slot, 2011-04-26) on top of the faulty commit?
