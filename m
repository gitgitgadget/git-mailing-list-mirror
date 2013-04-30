From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 15:13:19 -0700
Message-ID: <7v1u9rbrb4.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
	<7vehdrbrvz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>@b-sasl-quonix.pobox.com"@b-sasl-quonix.pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXInf-0007pn-DX
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760917Ab3D3WNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:13:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab3D3WNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:13:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F32D61B8AB;
	Tue, 30 Apr 2013 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/oTLphcix9ZNQBWxUbCrJKzyiYc=; b=B/Lhtv
	Qr4mJ9pPp1/Mg67OXopDBff9X/0UD86VqAvvWFNqFQi+ZGPk9c6G/Ic9aJYOJofA
	DH4pgayugw8NS8q81x8XkRcsZzvwWeUsKHdNhJ3fLPkRPLXvVjCwsfzorFVQHoro
	jN2P7CLON9FdLR7WeiQe9gEd5XzAkxlgqV2tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofLyyHhU/8MuQ/tMyxk9vce070CJEP8h
	9MwZcRe8c0Mtakhh152IqozQPbyIlZXXdlfZoKSA8SuFYuf3EDAeWt9qQ20VB6TX
	aD8C8eIYDQ5d8IW/N+NKsiSfNQFQ9wvKGcGfhFMki/0RWc1mNzj2kmQitbKoW9Bw
	sSY6BJ07gac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81D11B8AA;
	Tue, 30 Apr 2013 22:13:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CD521B8A9;
	Tue, 30 Apr 2013 22:13:21 +0000 (UTC)
In-Reply-To: <CAMP44s3osZJO1P6_KoPVON0cOSAD5D-OZmL=aKGkcWReortiCw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 17:04:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B2C960C-B1E3-11E2-95F8-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223026>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 30, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> What is a Yoda condition?
>
> ---
> Using if (constant == variable) instead of if (variable == constant),
> like if (4 == foo).
>
> Because it's like saying "if blue is the sky" or "if tall is the man".

That is an invalid analogy, as the sentences do not make sense.

A much better explanation I heard on this list is that people do not
say "If 1 is smaller than the number of your wives, you have a big
problem".

I actually was not asking why people find the convention to visually
align comparison with number lines unusual. We discussed this style
long time ago on this list.  I haven't heard the "Yoda condtion"
expression and was asking about the "Yoda" part.
