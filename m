From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid
 update command
Date: Mon, 6 Jan 2014 18:52:43 +0100
Message-ID: <CALas-iiQO8OwhS_W9u3sNDYuWf_3XnFsF11NZGLnnt_+pDTtVA@mail.gmail.com>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <1388890249-3577-1-git-send-email-ceztko@gmail.com> <20140105204423.GF3156@odin.tremily.us>
 <xmqq7gadkroa.fsf@gitster.dls.corp.google.com> <xmqq8uutj9c9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:53:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0EMP-0006Bk-OA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbaAFRxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jan 2014 12:53:05 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51083 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbaAFRxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 12:53:04 -0500
Received: by mail-ob0-f181.google.com with SMTP id uy5so18278167obc.26
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5jgO/1HvYxxk6IlNcQQIpXGSSrZU7CO2r+IWVk1QMKE=;
        b=ZF0mWumXhLVZkR0LtGIHFjgcsw5sutyhgZu0lVdaa9xlDOcm//C128N5aRPEhKMsk+
         20c5/aKVSAFAZiblfAvZXrCyLnJ0+CrYCePSYEIfftM7Znfj6FGB3Kwd9mM+VUyhBvbV
         QL72GnwA66VYqWB+CyIzuhxWeQVVFv8ApEgl1D3zsv5qN/uGBQgwBfZILK2f9fsP+gA7
         LbGQcOdqVahF/cwQvMxCWyHrF9qIr/KX8Blf4WxhZp1TR9Vr/UA7PhoSfm5HDj73fLHN
         /Gdid4SVUGgLiYusMGEU/LCIwwxMcQQVx6xYLi5lJEzQ0YIqU5hvLdrf9TsJ0biG+Ssf
         gKJg==
X-Received: by 10.182.143.103 with SMTP id sd7mr1342619obb.70.1389030783441;
 Mon, 06 Jan 2014 09:53:03 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 09:52:43 -0800 (PST)
In-Reply-To: <xmqq8uutj9c9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240039>

Ok, applying the suggested modifications and resending shortly.

Thank you,
=46rancesco

2014/1/6 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "W. Trevor King" <wking@tremily.us> writes:
>>
>>> On Sun, Jan 05, 2014 at 03:50:48AM +0100, Francesco Pretto wrote:
>>>> +                   case "$update_module" in
>>>> +                   '')
>>>> +                           ;; # Unset update mode
>>>> +                   checkout | rebase | merge | none)
>>>> +                           ;; # Known update modes
>>>> +                   !*)
>>>> +                           ;; # Custom update command
>>>> +                   *)
>>>> +                           update_module=3D
>>>> +                           echo >&2 "warning: invalid update mode=
 for submodule '$name'"
>>>> +                           ;;
>>>> +                   esac
>>>
>>> I'd prefer `die "=E2=80=A6"` to `echo >&2 "=E2=80=A6"`.  It's hard =
to know if mapping
>>> the user's preferred (unknown) update mechanism to 'checkout' is
>>> serious or not.
>>>
>>> This commit also makes me think that --rebase, --merge, and --check=
out
>>> should be replaced with a single --update=3D{rebase|merge|checkout|=
!=E2=80=A6}
>>> option, but that's probably food for another commit (and a long
>>> finger-breaking deprecation period).
>>
>> All of the above points sound sensible to me.
>
> I'll tentatively queue this on 'pu' (with the suggested "die"
> update), with some rewording of the log message.  The patch needs to
> be signed-off, though.
>
> Thanks.
