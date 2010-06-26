From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 16:50:30 +0000
Message-ID: <AANLkTinOHlHgb1GrHPZrC8Rs0l4XNNf8lqRvhRaWPVPz@mail.gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
	<1277418881-11286-1-git-send-email-avarab@gmail.com>
	<7v1vbvkorf.fsf@alter.siamese.dyndns.org>
	<AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
	<7v1vbukcu8.fsf@alter.siamese.dyndns.org>
	<20100626061305.GB10290@coredump.intra.peff.net>
	<AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
	<20100626164618.GA18517@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 18:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSYaT-0002D4-O6
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 18:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab0FZQud convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 12:50:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab0FZQuc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 12:50:32 -0400
Received: by fxm3 with SMTP id 3so423088fxm.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MIEEijFl9C48Le19cpR+4nS5jHyXFi6f/2ekeLuVz+s=;
        b=POk56Oiw0DVvB/MV5lJW3MpaMFCvL6m5KgfNDwOV4QI3KxbvSD1Rp/MHPcK1i+F4mt
         ImbelATnQfKoHTDKbqcklC5DUwrqEpJp0//p46S1kYSWpW8i58iPnBlJPBu1zwj53dLk
         47Dtm3WiTB0SvbrwQtikjTc8yi10L4lC1vb/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FJL9SOWuXaEZ0vBl/tXqSiGEGjz7yzjGXgFIa2kqZE73XlJb2LVsBE9nkQAh/SsjNs
         tpNnW5ravnJ8T9+rNoJ4mXsCnenT6FwkemiicnmsLEhsyqOBd2QxraonD/kA75Y3kFY1
         5br6JJ9JBZ5W8Oczq0cmK//cZgtNWtjaMtyOM=
Received: by 10.223.18.2 with SMTP id u2mr1857735faa.73.1277571031069; Sat, 26 
	Jun 2010 09:50:31 -0700 (PDT)
Received: by 10.223.103.84 with HTTP; Sat, 26 Jun 2010 09:50:30 -0700 (PDT)
In-Reply-To: <20100626164618.GA18517@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149762>

On Sat, Jun 26, 2010 at 16:46, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 26, 2010 at 12:14:59PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Sat, Jun 26, 2010 at 06:13, Jeff King <peff@peff.net> wrote:
>>
>> > Or even easier: is there a reason that "git fetch -q" would not do=
 what
>> > you (=C3=86var) want?
>>
>> That'd reduce the verbosity level, which'd skip some messages that I
>> might want. E.g.:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (verbosity >=3D =
0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 fprintf(stderr, " x %-*s %-*s -> %s\n",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRANSPORT_SUMMARY_WIDTH, "[deleted]=
",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 REFCOL_WIDTH, "(none)", prettify_re=
fname(ref->name));
>
> Wait, what? Isn't that line also part of the same human-readable stat=
us
> table? What makes the status of a pruned ref any different than the
> status of an updated ref? I don't see how that is an error message, b=
ut
> the other lines are not.

I misread that and picked the wrong example, sorry for the noise.
