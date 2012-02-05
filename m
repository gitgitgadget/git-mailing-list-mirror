From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 5 Feb 2012 23:20:03 +0200
Message-ID: <CAMP44s1NrGkz7sKz2CTF2XV9uGUfethg2+pcybPe2KBY02cnwA@mail.gmail.com>
References: <1328368255-10591-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0xfbxLs_r81ppO9hYf3ML_gaYCaW3TKpLM=BjfaM8vHg@mail.gmail.com>
	<7v4nv5gf2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:20:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9Vp-00051M-6B
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2BEVUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:20:06 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49667 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752277Ab2BEVUF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:20:05 -0500
Received: by lagu2 with SMTP id u2so2658210lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hp+k4L+GIgs7kY69KbxKrHrQFNSSUgdqz38C0CPXGJM=;
        b=Gh3WXolXk0f2CJVTeHMukMs7YnzEMLGO1k7IRgmmxg/wpkiZtn8ch3pDPNV6i14YZI
         07OtPZyQWz246Z2XFrSHPmifPYoo3igl5Bdz3xsJDxyH9RdyF2zjeOjYyXLPnUo1fQHQ
         jV+H7A6Jg4iXabYlvS6MzQRCvSbzNEBlUDUP0=
Received: by 10.112.101.34 with SMTP id fd2mr4029686lbb.16.1328476803734; Sun,
 05 Feb 2012 13:20:03 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 13:20:03 -0800 (PST)
In-Reply-To: <7v4nv5gf2n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189965>

On Sun, Feb 5, 2012 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sat, Feb 4, 2012 at 5:10 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Otherwise, 'git send-email' would be happy to do:
>>>
>>> =C2=A0% git send-email --to '<foo@bar.com>>'
>>>
>>> And use '<foo@bar.com>>' in the headers.
>>
>> Er, actually that's not correct: '<foo@bar.com>>' will remain the
>> same, but 'Foo <foo@bar.com>>' will be sanitized.
>
> I suspect that this "Er" is merely a sympotom of a larger issue in th=
e
> approach taken by this patch. =C2=A0The code takes a potentially malf=
ormed
> input, and applies a rewrite logic without telling the user what it i=
s
> doing.

That's what the function is doing already: sanitizing the address.

> Wouldn't a better approach to detect problem on the input side and re=
ject
> a wrong one by erroring out, so that the user has a chance to fix?

Perhaps, but the code is not prepared for that. Anyway, feel free to
drop it, I am not interested in pursing this.

Cheers.

--=20
=46elipe Contreras
