From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-trace.txt: fix typo
Date: Tue, 05 Apr 2016 13:49:25 -0700
Message-ID: <xmqqvb3v233e.fsf@gitster.mtv.corp.google.com>
References: <1459850723-46974-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cRO22wVRkrMicxLe=Gw4905QMxnnxM8kvtsMJaFv76Yrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 22:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anXum-0006io-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 22:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbcDEUt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 16:49:29 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760009AbcDEUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 16:49:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B7E253172;
	Tue,  5 Apr 2016 16:49:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5veYfKKztJPxAVXzYR+RGPTMn2o=; b=a0yhDH
	V/sEue3bPoNDgU2jPmBs7vZGz1JDOtq4H9laN2qVX/EYc4eo8anaOzqWWzX6VdRJ
	2XMY9ZI3rehYssfcGhAWud7s5Fg5nQV6vl595SjhyE3OkrfK1gwFTx/yk8DfLeZ5
	ZRm3srT8OPG1A7UBbd4Rk5+WSUeYOoUPtvUU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9277nyO2yDxpdOC+5OUcRGiT8FjV3sM
	w3dm1htN6a9MR4l96DK1LnXtoSkWWpWxFB2VTGnN3dKiLLoesTHdrCbXZvOiB9LK
	iW009B4GaJ+UdRA1nOIbaf0nfFGQdsAvsYlHoFTemm55Noer1hadqI2XpXy/sSAc
	h0O9kvcky+Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8389153171;
	Tue,  5 Apr 2016 16:49:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECADB53170;
	Tue,  5 Apr 2016 16:49:26 -0400 (EDT)
In-Reply-To: <CAPig+cRO22wVRkrMicxLe=Gw4905QMxnnxM8kvtsMJaFv76Yrg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 5 Apr 2016 13:15:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2CF12F2-FB6F-11E5-BC8F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290808>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 5, 2016 at 6:05 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> The correct api is trace_printf_key
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
>> @@ -28,7 +28,7 @@ static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
>>  static void trace_print_foo(const char *message)
>>  {
>> -       trace_print_key(&trace_foo, message);
>> +       trace_printf_key(&trace_foo, message);
>>  }
>
> Since you're touching this already, I wonder if it would make sense to
> rewrite this example to avoid the dangerous sending of an arbitrary
> string (which might contain %) to a printf-like function. Like this,
> for example:
>
>     trace_printf_key(&trace_foo, "%s", message);

Thanks, will squash in.
