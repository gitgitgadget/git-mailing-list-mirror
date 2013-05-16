From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 21:53:06 -0700
Message-ID: <7vwqqz8r0t.fsf@alter.siamese.dyndns.org>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
	<1368663120-47102-2-git-send-email-davvid@gmail.com>
	<7v7gizahcn.fsf@alter.siamese.dyndns.org>
	<CAJDDKr7N8xbUxDDzy+BijiJet6C3KV1O-B4tmWRFuZ5odQUuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 06:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcqBo-0001dN-3c
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 06:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab3EPExM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 00:53:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738Ab3EPExK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 00:53:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339201BE89;
	Thu, 16 May 2013 04:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E0MLHa0mCwPiQlZxFG0YOs608/k=; b=emI0vY
	lAZGh19cDbMo6A1BwQxp2XLwBoBEt/ZdCBF8ZePfqLHo/3yih5PMutFb2KxHD5nr
	PWtUrO62pcEcdHw3c4gVkYq7QZCKZLJ7l0QwzsAcHQ617Tnq4laZxcUkuKFbafSX
	JwuWbGA0+WB4mDyN0DcqOOv8054j78dIsk4W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oFtHSeqzieNwmxnQ9N5KF1Oux6W3XDA4
	HfUB7uf3ObtMlasXB7KnccKh6FxxMf7GflZfLKXt5pqOcMnwpdFNnu9sry8g8jMk
	oauGTOwgrXkeIhKC92eGLbTinEuKtpI+bDQic7lJrDqYZsYONoTPFc52RB2rgI2M
	Oy1dMYOiHbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD6B1BE85;
	Thu, 16 May 2013 04:53:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CFE01BE84;
	Thu, 16 May 2013 04:53:08 +0000 (UTC)
In-Reply-To: <CAJDDKr7N8xbUxDDzy+BijiJet6C3KV1O-B4tmWRFuZ5odQUuEQ@mail.gmail.com>
	(David Aguilar's message of "Wed, 15 May 2013 20:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80C98FE0-BDE4-11E2-8D8B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224478>

David Aguilar <davvid@gmail.com> writes:

> On Wed, May 15, 2013 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> Mac OS X 10.8 Mountain Lion warns that HMAC_Init() and friends
>>> are deprecated.  Detect the COMMON_CRYPTO_FOR_OPENSSL definition
>>
>> Ahh, I think you meant to use that name but forgot to adjust the
>> symbol you use in the patch ;-)
>>
>> I'll queue with s/COMMON_DIGEST_FOR_OPENSSL/COMMON_CRYPTO_FOR_OPENSSL/;
>
> The symbol in Apple's header is COMMON_DIGEST_FOR_OPENSSL.

Sigh.
