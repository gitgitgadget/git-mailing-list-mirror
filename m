From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 03:02:11 +0300
Message-ID: <CAMP44s2KjEYsHeufyon8aKj=tL+uuJiVBMnrzbYdePOJs1iZ-A@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
	<CAMP44s3-Ji33oG=Os_O9KpxawWzZzmiZ04QMTokQ+K6_x-31MA@mail.gmail.com>
	<7vfwcgzbrd.fsf@alter.siamese.dyndns.org>
	<7vbon4zb89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGJ6f-0001E7-JK
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 02:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab2DGACN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 20:02:13 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51783 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab2DGACM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 20:02:12 -0400
Received: by wgbdr13 with SMTP id dr13so2535780wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3qlbAKxpOFcVD76C3Oy8chkjdpCaOlBuO3T5pysRu04=;
        b=dlQPq9cDE43E4lfXoSuvlTAM40fSL1wDaJZVMyCVWZk4aBcOwr/Uifes0Ax3aKnpXe
         2jP+CHloo69WqWcWrcs+LuZnLv3PvIAdbftYEnv+47yrk2AgmzQwJYtRxtjhy9A6L5lu
         f2ShsFGTVbxYAkyEQ1/JJmAkO55CG8RXPCwoW+4RYeDjwnDQI15libED5HEAYcIsFJxC
         K5QVPuCkM+9jICuFTBWiCIJ5oQ6ePRvYPY730quAIsAgbSzF5XMYYdgGEyjt1Y6P8YGw
         eB99CjBQZmtzlSYIVMYltnnyeArR2RK8zrQe2DEUnoLcJQr1mwHu/YFkPa2cUQLtnsnn
         U0Zg==
Received: by 10.216.138.17 with SMTP id z17mr4869152wei.18.1333756931090; Fri,
 06 Apr 2012 17:02:11 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 17:02:11 -0700 (PDT)
In-Reply-To: <7vbon4zb89.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194927>

On Sat, Apr 7, 2012 at 2:33 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> What about this instead?
>>>
>>> #!/bin/sh
>>>
>>> if type bash >/dev/null 2>&1
>>> then
>>> =C2=A0 =C2=A0 =C2=A0# execute inside bash
>>> =C2=A0 =C2=A0 =C2=A0[ -z "$BASH" ] && exec bash $0
>>> else
>>> =C2=A0 =C2=A0 =C2=A0echo '1..0 #SKIP skipping bash completion tests=
; bash not available'
>>> =C2=A0 =C2=A0 =C2=A0exit 0
>>> fi
>> ...
>> Other than that, it is very much simple and straight-forward. =C2=A0=
I like it.
>
> It probably is even simpler to do it like this.
>
> if test -z "$BASH" && ! exec bash "$0" "$@"

That would exit immediately with an error:

t9902-completion.sh: 6: exec: bash: not found
make: *** [t9902-completion.sh] Error 127

--=20
=46elipe Contreras
