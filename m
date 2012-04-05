From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Thu, 5 Apr 2012 09:43:34 -0700
Message-ID: <CAOeW2eHJYiHswmzJeMnce5cpcA7zFi7kiH9CsZdNcHB7G+CtUA@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
	<CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
	<CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
	<4F7BEA9F.3060805@viscovery.net>
	<CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
	<CAH3AnrrYVNDN4cY7EmFsFyjC50wifuoPj1jSLPTxsSUy5+4aiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFpmp-0001HT-P4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab2DEQng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 12:43:36 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:51722 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab2DEQnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 12:43:35 -0400
Received: by dake40 with SMTP id e40so1821056dak.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tIoQ/IQNByb1F8thqIbQi/oETw0LZo09XQKMe1jbaiU=;
        b=y59lfNjNSehzo/kdlYceB127Dwl0/5tmfVPGXfhBY1qAIk9wVFlhJZdV1c+yKr6FaK
         nvs5qit7zp5jl0tVn+p7Sonz3eMjGoyJnACXn3dHDfysqIlI8JQZ76iOb9Kz3rGxtGo/
         QqugX9MtUU8SV3v76kiI969v4K5TjdIeBq9/AJtwAvjFAKjyeUHAhVWmtFthV/HV023b
         IdzU0IRKBsU1aHSpTXqYd2a14tFMhZ32Us1Gg0+O5BPmpOh5QqH8r/enlwmfVy3TABAA
         wQ66nqCpTHwLhHgMnoYMMn9FVRQbhRz/mOGVYG+Ap1GhIeB9dqQiRKFqYv1zulY+DlsO
         k7Rw==
Received: by 10.50.157.137 with SMTP id wm9mr5650530igb.64.1333644214706; Thu,
 05 Apr 2012 09:43:34 -0700 (PDT)
Received: by 10.68.224.97 with HTTP; Thu, 5 Apr 2012 09:43:34 -0700 (PDT)
In-Reply-To: <CAH3AnrrYVNDN4cY7EmFsFyjC50wifuoPj1jSLPTxsSUy5+4aiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194787>

On Thu, Apr 5, 2012 at 9:33 AM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
>>
>> With this history
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.-e-.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 =C2=A0.-c---d---f
>> =C2=A0 =C2=A0 /
>> a---b---g
>>
>> , "git rebase -p --onto g b f" produces
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.-e'.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 \
>> a---b---g---c'--d'--f'
>>
>
> Perhaps there is a a formatting issue here, but wouldn't the resultin=
g
> history be, instead:
>
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . -e'.
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0=
 =C2=A0 \
> =C2=A0a---b---g---c'--d'--f'

That's how it looked before I pasted it into gmail. Sorry about that
and thanks for clarifying.

> I don't really understand why e' - c' would be different to e-c?

Not "would", but "could", if you're using -i as well and choose the
"edit" action for commit e (or if merge conflict makes it halt while
creating e').
