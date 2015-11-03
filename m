From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Tue, 03 Nov 2015 11:46:54 -0800
Message-ID: <xmqqr3k6dfwx.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-2-git-send-email-k.franke@science-computing.de>
	<xmqqfv0odnoc.fsf@gitster.mtv.corp.google.com>
	<20151103090724.GA6354@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZthYY-0004dz-KV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 20:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbbKCTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 14:47:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932457AbbKCTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 14:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C02029C28;
	Tue,  3 Nov 2015 14:46:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DqXhW3ut/qOdZsOx324Qi7Ii7Tw=; b=k+eT3T
	7NpwD1gnUgLcugYLZK8WnJuAbWHkEbGd8v9V6+qtt7YsVQeezkVdHNhrbehcjXNB
	hSX+r1A0uKysDY9M/zZXt9yUFTR1P5kSvylExBWj3PPL64sBV01ESKLOE4Es9mWq
	vwOeYcubbZhBWM86Ai14aUnCVFLQYlZFfPn64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nN5hdjxw82CNAniXDNhx1c6SPTxsOfWE
	/4wKvT/EfQmlthVVh20HVtCZw45JxJWlkXLJdV5GSBXhy1gO7848TVYcwxxV0QCX
	3pEbTDqovkZZLN00G9DCrqBe6heONWxUCsoY2NbkP2L+DnGlSGMFqDN+92jLDCOT
	FTqPJwWt7f0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 849BA29C27;
	Tue,  3 Nov 2015 14:46:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0B01B29C26;
	Tue,  3 Nov 2015 14:46:55 -0500 (EST)
In-Reply-To: <20151103090724.GA6354@science-computing.de> (Knut Franke's
	message of "Tue, 3 Nov 2015 10:07:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3785616-8263-11E5-B793-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280811>

Knut Franke <k.franke@science-computing.de> writes:

> On 2015-11-02 14:46, Junio C Hamano wrote:
>> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
>> > Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>> 
>> Please add these only when you are doing the final submission,
>> sending the same version reviewed by these people after they said
>> the patch(es) look good.  To credit others for helping you to polish
>> your patch, Helped-by: would be more appropriate.
>
> Sorry about that.
>
> However, may I suggest that Documentation/SubmittingPatches could do with a
> little rewording in this respect?
>
>> Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
>> "Tested-by:" lines as necessary to credit people who helped your
>> patch.
>
> "Helped-by:" isn't even mentioned.

That is because it is not actively encouraged.

The only thing I care about is that people do not incorrectly use
Reviewed/Acked-by when reviewers did not say "this version looks
good"; that would mislead the maintainer to think "ah, if that
reviewer said this is good, whose judgment I can trust, then I do
not have to read it carefully myself."
