From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/5] merge-recursive: porcelain messages for checkout
Date: Mon, 9 Aug 2010 21:15:00 +0000
Message-ID: <AANLkTikQAduZ3=1U6ObzLKdY0pomMBm2BGbq+Xyfmggh@mail.gmail.com>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
	<1281363602-27856-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vhbj34kz8.fsf@alter.siamese.dyndns.org>
	<vpq4of3se4v.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 23:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZgb-0004tD-P7
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 23:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab0HIVPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 17:15:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33434 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab0HIVPB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 17:15:01 -0400
Received: by iwn33 with SMTP id 33so3814674iwn.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OP4h0ypCyeOaBVQiZCy3bxh9Atwdtuy/W6vhH1uNdnk=;
        b=PQRC2G1i6qb6d8Z35RbkYIrwfbnFyacQ44shAGj0mizZgQnJs6nESTy7X0QX2Axds6
         ZyMhLm6p5A1JUfQBMveQT+q+qjPb4FkEdByvLzLVshXZk4LrSmdeX+Rb+wdzkH8uaslr
         zrYWUD6Qb3hoPqIcjvSM2uVJGHPBk96JosE4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nWaWVfRRlVkey47QHDrt6YOSg4RqCGzYG4j35mse41CKy1VY/RpoO0xh6ilgUkzaFD
         Siy/2i1ThoIW9ooQXo0S5+7qX8CWanpgGeBfu+ACQiFcMqEhdmmr3lhRLyIhG64J01Qj
         wti0xL1v9wT7ftFJmsqnURI99WDbodpuuRIyQ=
Received: by 10.231.160.17 with SMTP id l17mr19636976ibx.102.1281388500575; 
	Mon, 09 Aug 2010 14:15:00 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 14:15:00 -0700 (PDT)
In-Reply-To: <vpq4of3se4v.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153026>

On Mon, Aug 9, 2010 at 20:52, Matthieu Moy <Matthieu.Moy@grenoble-inp.f=
r> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> +void set_porcelain_error_msgs(const char **msgs, const char *cmd)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0const char *msg;
>>> + =C2=A0 =C2=A0char *tmp;
>>> + =C2=A0 =C2=A0const char *cmd2 =3D strcmp(cmd, "checkout") ? cmd :=
 "switch branches";
>>
>> This may have implications to the later i18n effort, but lets ignore=
 it
>> for now. =C2=A0I don't think it will be too bad.
>
> Note that the ? : construct just allows factoring out two messages,
> but one can easily distinguish all cases and give the complete error
> message in the source (we don't care about performance/memory here,
> it's a one-time thing).
>
> So, yes, that's easily fixable later if it causes problems to i18n.

Yeah, this is a drop in the lego ocean that is Git's source
code. Don't worry about it, it can be fixed later.

You can stop reading at this point.

=46WIW "lego" is the i18n term used for printf("messages %s assembled
like this", "that are"). E.g.:

    printf(_("It's a nice %s"), is_evening() ? _("evening") : _("day"))=
;

Things like that will cause trouble for e.g. French where it's "C'est
un soir=C3=A9e formidable." or "C'est un jour formidable." (I hope I go=
t
that right). You can move the %s around, but it's still hard to
translate stuff like that, especially as translation programs often
display strings independently.

It's better to have independent strings like _("It's a nice evening")
and _("It's a nice day") instead, even if it leads to duplication.

I'll be submitting a lot of patches to fix things like this once the
i18n series gets merged.

Have fun.
