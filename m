From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Mon, 02 May 2016 11:16:03 -0700
Message-ID: <xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
	<xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
	<a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 02 20:16:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIOD-0008EW-OC
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbcEBSQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 14:16:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754680AbcEBSQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 14:16:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F3481514A;
	Mon,  2 May 2016 14:16:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J+GiV/JirtPk
	NqPc+V+XYws/QHE=; b=Qu6jqmWuR3HhK0aH2ml3Vk+fJ8VZSIvBfr6WL2Qrbm1h
	p3xm6cxXu73T8oun618+OmTN6RED8QaooJEazZMbCCZXLq7UmRtAgBAIlLnVGVB6
	OpOBdDG4gjvMrd/ycFFK1jaP/eEqiTC9bfNGaGPmVw31aL/JmWm9qTBvJVMmWUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nfERNi
	R2ye0HN4Nu6ySZVZ5X/hUhp+bofxtNWd6b7h8jLNl9hKpDjd0nANqD+Z7e0Z3Xdo
	LtUO0/iWtmd6QYTVoALY7Zqi80rGpHcvUuiRlb3HNYMDIzWe+EWI/Y2+C311nyTq
	UB/2uTdJWCbmlK2NWaadtuwfvAd6t7EOWxu8g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68ADF15149;
	Mon,  2 May 2016 14:16:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4366315146;
	Mon,  2 May 2016 14:16:05 -0400 (EDT)
In-Reply-To: <a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 1 May 2016 18:27:05
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF52D8BA-1091-11E6-9E1A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293260>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 29.04.16 23:09, Junio C Hamano wrote:
>
>> Well, didn't I do exactly the above much earlier and discarded it
>> because that breaks the definition of "diff"?  Or is this doing
>> something differently?
>
> Yes, and I try to sneak it in anyway ;-)
>
> I spend some time debugging how to get t6038 passed, and need
> some more time.
>
> If 10/10 is a no-go (and it probably should be),
> does it make sense to keep 1/10..4/10 and discard 5..10 for the momen=
t ?

Earlier patches in the series certainly felt alright.  I do not
remember noticing where it went in a strange direction to be honest.
