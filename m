From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 18:59:43 +0000
Message-ID: <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
	<m38w39mnyd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruce Korb <bruce.korb@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou8pL-0001SO-4r
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 20:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0IJS7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 14:59:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42588 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab0IJS7o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 14:59:44 -0400
Received: by pxi10 with SMTP id 10so1089936pxi.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DRk9ioIrb9iVYwdyTzfCWV8mzBeteK020T3L+CsxyGs=;
        b=r0RHcT/URlcSYZC+8BaCsU+Xiaipl0crZn/4AU0Pjfr9405IGr+HSShd8PPHKwIewF
         ayOKSKEYGCBMff4ubyfiPZyNChD4kaQuWOfBavz6AKkddstfEzCDu/RgLCqXOVLunIbJ
         /8i9mbWHUh8hDYm5fk8150dCUQySj3gaZGojs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HX2TesoulcjnZZ4QMtWiBHrMYYb83JXWB1FDkPqJmhDTagajQTQbuKfNiVRidNbga2
         10kC091K/WBulfzf28Q9omvGjg/oJGLUqIui5hws4sy85RF2+WHhJTvFTDogjADIQMR2
         QK/t0UfLDrKOQLh1pzN5tkjt15ZdRiFzrBU08=
Received: by 10.142.61.39 with SMTP id j39mr1112393wfa.347.1284145183738; Fri,
 10 Sep 2010 11:59:43 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 11:59:43 -0700 (PDT)
In-Reply-To: <m38w39mnyd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155954>

On Fri, Sep 10, 2010 at 18:52, Jakub Narebski <jnareb@gmail.com> wrote:
> Bruce Korb <bruce.korb@gmail.com> writes:
>
>> After trying lots of variations, I found it to be:
>>
>> \#*
>>
>> Not obvious and not easy to look up. =C2=A0Please add it to your
>> .git/info/exclude sample text. =C2=A0Thanks!
>
> Well, it is quite obvious to me, as escaping special characters using
> backslash is typical in Unix tools. =C2=A0But you are right that this=
 needs
> to be documented.
>
> Perhaps something like this? =C2=A0I am not sure about example in
> .git/info/exclude skeleton
>
> -- >8 --
> Subject: [PATCH] Document escaping of special characters in gitignore=
 files
>
> Requested-by: Bruce Korb <bruce.korb@gmail.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> =C2=A0Documentation/gitignore.txt | =C2=A0 =C2=A06 ++++++
> =C2=A0templates/info--exclude =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 7dc2e8b..67ae4d0 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -98,6 +98,12 @@ Patterns have the following format:
> =C2=A0 =C2=A0For example, "/{asterisk}.c" matches "cat-file.c" but no=
t
> =C2=A0 =C2=A0"mozilla-sha1/sha1.c".
>
> + - You can escape special characters using backslash.
> + =C2=A0 For example, "{backslash}#*" matches files beginning in `#`
> + =C2=A0 (otherwise it would be considered comment),
> + =C2=A0 and "{backslash}!*{backslash}?" matches files starting with =
`!`
> + =C2=A0 (negate pattern prefix) and ending with `?` (glob wildcard).
> +

Maybe fix this too in the same manpage:

    A line starting with # serves as a comment.

To:

    A line starting with # serves as a comment. Use \# for a literal #
character. See ...
