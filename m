From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Wed, 12 Sep 2012 16:05:19 -0700
Message-ID: <7v4nn2c05s.fsf@alter.siamese.dyndns.org>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
 <1347473304-21418-1-git-send-email-pjones@redhat.com>
 <7vtxv3atvu.fsf@alter.siamese.dyndns.org>
 <1347482918.21933.5.camel@eddie.install.bos.redhat.com>
 <7vpq5raqiq.fsf@alter.siamese.dyndns.org>
 <CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com>
 <7vhar2c29s.fsf@alter.siamese.dyndns.org>
 <CAPBPrntXCDHwWkYV3pnj3+d8FCZCmEVPHkSxyVg0Jzd0tzZsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 01:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvzv-0003PS-84
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 01:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab2ILXFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 19:05:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958Ab2ILXFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 19:05:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3B691C2;
	Wed, 12 Sep 2012 19:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1+1oBvAm2xFBFCusZDXRv8DlsBQ=; b=lGPOb5
	JAXmz7dBo51MEnVw41GyH4xFyXyPJMfptDbC3LFxR4QkKlXT1M/H/MKdgC2fYA+k
	fzNQZ3pxNEZPZnT2fbZDirlanx9IgigeZlrLi2WIOR1EfhbEdbcE9o/eUIts7mxu
	smee6k99R9iOngXiPwC7wtQ3DiQl6KZqR0UE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VmktSQoIDsL01hAJNZ2KjcIXp9lgbVvx
	FpK6rdeRWOZwtXTsPKiM34doWBwP1hoHPuVR+XA6xG4LLMDc7DuJhJWps7j1YPqT
	OzpzGWaqLSpU0Mdlu2u4FztO/G2+d9MiSjHgy7EayVglzXbl4OF0aVNFbPkaREOz
	QsVS38NyLM4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 670B491C1;
	Wed, 12 Sep 2012 19:05:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B680F91C0; Wed, 12 Sep 2012
 19:05:20 -0400 (EDT)
In-Reply-To: <CAPBPrntXCDHwWkYV3pnj3+d8FCZCmEVPHkSxyVg0Jzd0tzZsGA@mail.gmail.com> (Dan
 Johnson's message of "Wed, 12 Sep 2012 18:31:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53694CC4-FD2E-11E1-91BA-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205351>

Dan Johnson <computerdruid@gmail.com> writes:

> I was assuming Peter would accept the patch, and reply with a "in the
> future, please submit the output of format-patch", thus correcting the
> submitter's behavior. This warning would serve someone who did not
> know that they wanted the output of format-patch, and hopefully teach
> them to send such a reply message.

"Next time, please do this" rarely has worked in practice.  This is
because the moment you accepted the current patch, you have already
lost the "carrot" ;-)
