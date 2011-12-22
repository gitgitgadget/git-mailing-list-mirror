From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Wed, 21 Dec 2011 16:20:55 -0800
Message-ID: <7vmxale9so.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <CACBZZX7bgjFz7mvTySPKhR24coqOeVVy8+CsKHVj8Q3LF_-5ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 01:21:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdWPF-0001m6-RT
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 01:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab1LVAVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 19:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436Ab1LVAU6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 19:20:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E4F87219;
	Wed, 21 Dec 2011 19:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DLb2pxW3p/1U
	4rHMRh6WUoAmvRw=; b=MtWboU0jiL/z1Ecl8IQJsludpRraGJatXXOa9yOY3yJJ
	GMhaKyBFfx+6qd28ct4MorQZxxQIfgr5HMm+7eDComALtpxr4pPlAaNdFU4IqPkx
	7VdRzzU3RTUqGrhxed7nv13MekobCQI18yhzkMe9Awu8jzQ6JK4rdyOY3RzjHrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PlQwmF
	WKD/Tmi5qu0erwAsLXlJN4hJAFLLNbfepkel6Xi1CV3Uo1qRTpgEvMqskP2MXNJJ
	VGmIwgF+/CnPLDc4nyL9ADmuNnicXkPDfbcNenph0WwrC2zWz3pbxv6vtGBHrbuO
	BFBN22NmvhBZQIa1Bl/y1c/wdbZ8ByOrY5dwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25ABF7218;
	Wed, 21 Dec 2011 19:20:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC89F7217; Wed, 21 Dec 2011
 19:20:56 -0500 (EST)
In-Reply-To: <CACBZZX7bgjFz7mvTySPKhR24coqOeVVy8+CsKHVj8Q3LF_-5ww@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Dec
 2011 01:14:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D12C8630-2C32-11E1-BE60-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187596>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Dec 22, 2011 at 00:55, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Nice. Thanks for tackling this. I'll no doubt be submitting some of
> these myself once we start getting translations.
>
> This is not a regression, but note that something like this:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, "=
%s%.*s\n", _("hint: "), (int)(np - cp), cp);
>
> Isn't going to cut it for RTL languages like Hebrew and Arabic, since
> for them the "hint: " would effectively be at the end of the line.
>
> I think the easiest way to tackle that sort of thing is to just do:
>
>     _("hint: %.*s\n")
>
> And have a TRANSLATORS comment indicating that the format string
> should be kept, but that translators can move around the "hint", GNU
> gettext also has a msgcheck feature to check that format strings are
> compatible in the translations.

Good point. Thanks.
