From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
Date: Sun, 28 Nov 2010 09:00:08 +0100
Message-ID: <AANLkTim+vJuZ9bJnROqbzN8O-K8NVyi8zHYokDNqOjqa@mail.gmail.com>
References: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
 <AANLkTi=qAus_w18sYXP7m+jtQOGtgkNrsxgiNcbHevC7@mail.gmail.com> <alpine.DEB.1.10.1011272002090.26955@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 09:02:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMcCl-0002VQ-6v
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 09:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab0K1IB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 03:01:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35663 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0K1IBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 03:01:25 -0500
Received: by iwn5 with SMTP id 5so616769iwn.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 00:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VCl2wBVAI1V5z6OvNR6u83Pa7DOhz1+QLfImw6aKsVM=;
        b=aeCrITgvi/zYNRKNmCEVtOW1VSyoSJTF3yDOA7p+haYLs3C76A/sQCf+ghLNLOFe2x
         gTyoJMIozEZH/fJq3sFwE5C0yKgzGl0qZ/hkDj0Y5VUtoF0N0TUPDcMYURyXdFfPUkIo
         VxLkhmCrdz1pah+w8Rbp/aLlOH/G8sgYVHNhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wEUxUFSRntwd9k08HuorXEozfmUDw2K5ldUa3zq/pcQ/Q1mLzGrHcfhonds793Nu6g
         tAoDkNSe9OYfJUo2gWgKNDCvloYPOf+qj1wFCSqVL79odN9cNGQfH0WR53SWfaci+Ncf
         qXiJBwORu6IDSJ5axY8otFdSFu32xJYCnbMks=
Received: by 10.231.13.138 with SMTP id c10mr3889851iba.57.1290931281207; Sun,
 28 Nov 2010 00:01:21 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Sun, 28 Nov 2010 00:00:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1011272002090.26955@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162338>

On Sat, Nov 27, 2010 at 8:05 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
>
> On Sun, 28 Nov 2010, Sverre Rabbelier wrote:
>
>> Heya,
>>
>> On Sat, Nov 27, 2010 at 12:15, Giuseppe Bilotta
>> <giuseppe.bilotta@gmail.com> wrote:
>> > =A0-p::
>> > =A0--preserve-merges::
>> > =A0 =A0 =A0 =A0Instead of ignoring merges, try to recreate them.
>> > +
>> > +--signoff::
>> > + =A0 =A0 =A0 This flag is passed to 'git am' to sign off all the =
rebased
>> > + =A0 =A0 =A0 commits (see linkgit:git-am[1]).
>> > + =A0 =A0 =A0 Incompatible with the --interactive option.
>>
>> The one above that does have a shorthand (-p), why should we (not?)
>> give --signoff it's customary -s shorthand here?
>
> The '-s' flag is unfortunately already taken. It is used for
> specifying a merge strategy.

In fact, this is why I was a little skeptical myself about submitting
this patch. What if people start remembering that rebase supports
--signoff and implicity assume that -s is also a valid shortcut? Funky
errors. (I've been bittem myself by similar situations for whitespace
support. Can I pass -b or not? Will it mean --ignore-whitespace?)

--=20
Giuseppe "Oblomov" Bilotta
