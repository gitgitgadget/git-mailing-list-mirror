From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Tests and fixes for merge-recursive rename options
Date: Mon, 22 Feb 2016 14:29:39 -0800
Message-ID: <xmqqwppw4bvw.fsf@gitster.mtv.corp.google.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
	<xmqqpovo5ul2.fsf@gitster.mtv.corp.google.com>
	<CALMa68qmGie+AHOWZ=BKHZOeSK9K4djiHRuooCz2h72rNZg7_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:34:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXz3r-0005fN-0m
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbcBVWeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 17:34:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756239AbcBVW3m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 17:29:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC27547D16;
	Mon, 22 Feb 2016 17:29:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F/TT8GCDzIqR
	LpStSw2W3TOwD3Y=; b=sZZG3KckdmsD9HBO+/uzurOmzO7iMM8lduJqralIv2uD
	947hUKOdr+Buy5MyjLx8rSwAN+P8GI5CLtGXakP9hPxR8tVrGIq5b2QbfenFrKf3
	KzvNB9E3bZBC6leHTsr08VIk8anFwlGKlkP79CB6+bgYRJBpCssQR9+OiPKtvCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tB6PVK
	2Jl2m2XU8CZeCrBG+ZY5qTDDZLf5SL0aV0A9DGf5Opvv+RhXIuwl9RSaBUUw+4EF
	v+7R7GiVedmfj73e+6MJ2XG047TFPPDKF9uVJo9bIUV/I9zVRAIzrLmJ/SyrBzGD
	2yTekQQjvKFuWPvaDe0pe85ubMUVEFbxGndww=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2E9847D14;
	Mon, 22 Feb 2016 17:29:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1DBAD47D13;
	Mon, 22 Feb 2016 17:29:41 -0500 (EST)
In-Reply-To: <CALMa68qmGie+AHOWZ=BKHZOeSK9K4djiHRuooCz2h72rNZg7_A@mail.gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Mon, 22 Feb 2016
 19:16:09
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3C2FF1E-D9B3-11E5-86DC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286965>

=46elipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:

>> As I said, I am reluctant to take the 25%/50%/75% tests in their
>> current form.  Let me take the first one and a half of the last one
>> (i.e. excluding the test) for now.
>>
>> Thanks.
>
> Ok, should I post a new version of the patch without the tests while =
I
> rework them or does that mean that you have already filtered them out
> locally?

I already have and queued them tentatively as=20

    c443d39 merge-recursive: find-renames resets threshold
    83837ec merge-strategies.txt: fix typo

but they haven't been merged to 'next', so it is up to you whether
you rebuild the remainder on top of c443d39 or redo these 5 patches
altogether (just tell me to drop these two if you go the latter
route).

Thanks.
