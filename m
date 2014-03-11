From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status merge: guarentee space between msg and path
Date: Tue, 11 Mar 2014 13:26:43 -0700
Message-ID: <xmqqwqg0o518.fsf@gitster.dls.corp.google.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<xmqqeh28pkuu.fsf@gitster.dls.corp.google.com>
	<531F706C.1080901@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:26:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTGH-0001Dc-5L
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820AbaCKU0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 16:26:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617AbaCKU0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 16:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D40174E5E;
	Tue, 11 Mar 2014 16:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D1za/z3XA8yJ
	rfe1Wl9SQxFXrOU=; b=TAksjXd/CSQ+RY0Hb35QYugAB/AgU+9wHktjAZOlB+bD
	weTOafjORI8uU15JUK4MahkvKELTMKDIqXx7ur8mh8QOAq53DB+R8dEB6eQU8Aoz
	ua/jla8srJNtXIHQMGb8x0ZDg2hSNWZwty8MpWhe+71RG+KLmxD9ampQ5vPLf9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MXfnEI
	jFwZqGaZk5YztBYStLrzpOsXoey6XhU4hvTfnul/OuBQp8jD4fzy7cil5NAFCZFB
	qh768d1f74R71Ng/I8sObpEYtEmUmpLM6ZXYVYxpuRRk8S/DbVbV9VmTaKrFH2DJ
	BSRtIUkq/dA4bg6t18bhtedUdurjSu5sfN86A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0494A74E5D;
	Tue, 11 Mar 2014 16:26:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BF0974E5B;
	Tue, 11 Mar 2014 16:26:45 -0400 (EDT)
In-Reply-To: <531F706C.1080901@savoirfairelinux.com> (Sandy Carter's message
	of "Tue, 11 Mar 2014 16:22:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76E6A446-A95B-11E3-8A1F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243893>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> Le 2014-03-11 15:59, Junio C Hamano a =C3=A9crit :
>> Sandy Carter <sandy.carter@savoirfairelinux.com> writes:
>>
>>> diff --git a/wt-status.c b/wt-status.c
>>> index a452407..69e0dfc 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -264,7 +264,7 @@ static void wt_status_print_unmerged_data(struc=
t wt_status *s,
>>>   	case 6: how =3D _("both added:"); break;
>>>   	case 7: how =3D _("both modified:"); break;
>>>   	}
>>> -	status_printf_more(s, c, "%-20s%s\n", how, one);
>>> +	status_printf_more(s, c, "%-19s %s\n", how, one);
>>>   	strbuf_release(&onebuf);
>>>   }
>>
>> Thanks; I have to wonder if we would want to do something similar to
>> what 3651e45c (wt-status: take the alignment burden off translators,
>> 2013-11-05) to the other parts of the output, though.
>>
>
> I could, do this. It would be cleaner, but there's just the issue of
> the colon (:) which requires a space before it in the french
> language[1]. As you can see in po/fr.po, the french translators have
> done a good job at including it [2].
>
> 3651e45c takes the colon out of the control of the translators.

That is a separate bug we would need to address, then.  Duy Cc'ed.

> +       if (status =3D=3D DIFF_STATUS_COPIED || status =3D=3D DIFF_ST=
ATUS_RENAMED)
> +               status_printf_more(s, c, "%s:%.*s%s -> %s",
> +                                  what, len, padding, one, two);
> +       else
> +               status_printf_more(s, c, "%s:%.*s%s",
> +                                  what, len, padding, one);
>
>
> [1] https://en.wikipedia.org/wiki/Colon_%28punctuation%29#Spacing
> [2] https://github.com/git/git/blob/master/po/fr.po#L585
