From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 11:36:13 +0200
Message-ID: <BANLkTi=5koa_f_xqaGvKPrEnKMh7ziOT0g@mail.gmail.com>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
	<4DDCA0D2.2070604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 25 11:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPAVp-0001lE-9D
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 11:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab1EYJgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 05:36:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38944 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab1EYJgO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 05:36:14 -0400
Received: by fxm17 with SMTP id 17so5220049fxm.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=86H0p/Wl52OzXY/keZ0T9yx7iU2vFCB18DBEEPSnbO0=;
        b=mY8HNRRBQtl97xPao3VZMw9+JXuN8XYgf1ZOOgmJ54EQ3xwjsol7+gV1dXXRx4hDKt
         s5W3eaMJI8orpTct996WPhgUyYsqaqpSgbptMT/WjYWaRfFVBN86d5WXSNl72QlqV9j5
         +aFw6zy3bRpEMF/38TCDPz38zOMgLac/JReXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xvknKwK55Re0Wva/ZISQeyKmwyzeR7zsopNEhjOYxUx/m2vQvJoSmlOODDOsVeBR4j
         lOkhHcTqEQPQ9R0U1V3f+gvvC4zVhUa5rZq+Ygz+A/+yUcnvh8XotYpNBj0n3Oqr0eoV
         0d67t7CV5YSbgbstoSfz2jW3iNtn9GUB5KVB8=
Received: by 10.223.77.92 with SMTP id f28mr4763733fak.37.1306316173523; Wed,
 25 May 2011 02:36:13 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Wed, 25 May 2011 02:36:13 -0700 (PDT)
In-Reply-To: <4DDCA0D2.2070604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174376>

On Wed, May 25, 2011 at 08:25, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 5/24/2011 23:45, schrieb Junio C Hamano:
>> * ab/i18n-scripts (2011-05-21) 48 commits
>> =C2=A0 (merged to 'next' on 2011-05-23 at 69164a3)
>> =C2=A0...
>>
>> Rerolled.
>
> I see you promoted ab/i18n-scripts-basic to master. What are your pla=
ns
> with this topic? In its current form, git-submodule breaks in an obvi=
ous
> way on Windows, and other pitfalls may hide elsewhere.

Aren't you confusing ab/i18n-scripts-basic with ab/i18n-scripts? The
former just adds the infrastructure, the latter adds some eval_gettext
invocations that break on Windows while I haven't submitted some fixup
patches for what's now in *next*, not master.

If anything's breaking on Windows in master it would be the
t/t0201-gettext-fallbacks.sh test which uses some eval_gettext()
calls, but nothing else uses it currently.

> I don't have enough energy to help out with this issue, particularly
> because i18n is not exactly my own itch. Personally, I wouldn't mind =
the
> fate of the topic if there were a NO_GETTEXT switch that simply avoid=
s all
> the problems on Windows. Is there such a switch?

There isn't and can't be without major re-organizations because
shellscripts don't have something like the C preprocessor.

But I'll just fix the Windows issue soon and submit a new series for
inclusion in next.
