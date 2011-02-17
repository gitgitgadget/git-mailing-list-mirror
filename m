From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Wed, 16 Feb 2011 16:46:04 -0800
Message-ID: <7v8vxfh4j7.fsf@alter.siamese.dyndns.org>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
 <7vipwpxbam.fsf@alter.siamese.dyndns.org>
 <AANLkTi=E0LYWp7ag8SD8LNCKkKopGczJL0QnuOiH2UEu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 01:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pps0o-0000bC-JV
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 01:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1BQAqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 19:46:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732Ab1BQAqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 19:46:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BCC43A35;
	Wed, 16 Feb 2011 19:47:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JIl2YvF+3Zub
	T8RTa3Y0SSV/Zjo=; b=g8ZLN/Ln9k1obbxytKpvvEuNSKgTS7bqoaPnbY43RcYw
	+FSPjsBzjcby63/Ywlj1UWRlwp5CDIE0iltn487mQFpaZLIcXA+POND4kQuE2jo3
	TZOEtrHeqJ72Rl88+23AnbSVjTwRQNTUB4ag0XDdb+gCEMubtKFcAmxOwM9bS1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kAArzQ
	K21+qKrPdxkT3u6rCjUmqOMUyKzLiyfVBmf8GlkSE+EkVa0JwZzqvYhHlrvnk6Wy
	VvobtbyRV+aOr7VvtxW2/T4jRiycUXgnaj2fhmqVbpyBT8x4fj0CkCHoXhhJy6jU
	xCwReV65QRiEYvVdhJXZA9U0IMdMphc1IJSsQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18BF63A34;
	Wed, 16 Feb 2011 19:47:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7691E3A32; Wed, 16 Feb 2011
 19:47:13 -0500 (EST)
In-Reply-To: <AANLkTi=E0LYWp7ag8SD8LNCKkKopGczJL0QnuOiH2UEu@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 17 Feb
 2011 00\:57\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 79167532-3A2F-11E0-82B9-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167025>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Here's a work-in-progress version of this:
> https://github.com/avar/git/compare/master...ab/i18n-c-_-only
>
> I still have to:
>
>  * Add NO_GETTEXT_POISON to more tests, some things have broken due t=
o
>    new strings / changed tests.
>
>  * Squash the !fixup patches in appropriately.
>
> But otherwise does this seem good? I.e. having just those stub macros=
,
> a lot of *.c patches, including gettext.h in cache.h.

I only gave a cursory look to "git diff master..ab/i18n-c-_-only" outpu=
t,
and things looked fine for a yet-to-be-completed WIP (I didn't see the
definition of shell version of gettext and gettext_eval, for example).

Thanks.
