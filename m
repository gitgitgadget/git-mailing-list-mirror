From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Fri, 6 Apr 2012 02:33:52 +1000
Message-ID: <CAH3AnrrYVNDN4cY7EmFsFyjC50wifuoPj1jSLPTxsSUy5+4aiQ@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
	<CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
	<CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
	<4F7BEA9F.3060805@viscovery.net>
	<CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Phil Hord <phil.hord@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFpfx-00057r-Ud
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 18:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab2DEQgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 12:36:41 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37418 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2DEQgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 12:36:39 -0400
Received: by wibhj6 with SMTP id hj6so1808262wib.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Q1GhyFeevPaqUO03rhq1nfcHT8B3WyNRUHgfPbG43V8=;
        b=R+8qCykDsvy9+t22zFsxt6pwr+wt29AljKHVdU2S/7XwF+jK4fz9GHLenWGL1dppF+
         981GMOYoCtEYfKz7kv7Mj0DnZIWoyTZJ00nPle2MpFjd5ttDkpLtkZmpE5lwpVqaWZk5
         M+uYUzrLS+KE7gbCpBFeJYbTX+EZLI8DXZMSX4QWFfWI0eDL10pZZtR4XFSRJl4YvHqo
         D0lWcfxLXc6PuOvrtovmwPKpN0d8qE4+WZ2r9S2++QRTNB9bN677zSvdg4Ie/Rv4NSql
         FqYE2OU7OAxacuMye+YJRO/sABfIpgdGO6WHy47nPQbRb2/bgIaxppVJYSZUwjJA3x18
         7gTQ==
Received: by 10.180.100.2 with SMTP id eu2mr6372487wib.1.1333643632589; Thu,
 05 Apr 2012 09:33:52 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Thu, 5 Apr 2012 09:33:52 -0700 (PDT)
In-Reply-To: <CAOeW2eHHW6de1qcnajV7DLzWyiSJyh+ZpMbhQU-1WKnRuSeNhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194785>

>
> With this history
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.-e-.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0.-c---d---f
> =C2=A0 =C2=A0 /
> a---b---g
>
> , "git rebase -p --onto g b f" produces
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.-e'.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 \
> a---b---g---c'--d'--f'
>

Perhaps there is a a formatting issue here, but wouldn't the resulting
history be, instead:

  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0   . -e'.
  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0    / =C2=A0 =C2=A0 \
 a---b---g---c'--d'--f'

I don't really understand why e' - c' would be different to e-c?

jon.
