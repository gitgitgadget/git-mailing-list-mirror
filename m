From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Sat, 2 Jun 2012 17:55:55 +0700
Message-ID: <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:57:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sam12-0005ei-H9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 12:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965356Ab2FBK42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 06:56:28 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43625 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760368Ab2FBK41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 06:56:27 -0400
Received: by wgbdr13 with SMTP id dr13so2653151wgb.1
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=chk0ImdXIIo+wmNXLb+LAfF/U/8i3OgA61PAGvzTYeQ=;
        b=0I65E2/U7n9WQyky2sr+pQivj9rQWl3Mg3tp5E9ITnnyI/p+Jfx7gqG3R58vPDPzEb
         2f+u5d4j0pvnD4qH6BsZUY9UDNZHa0Ds7Muj+SNZsGhPGDU1Xuz5cw5Ykofid8kVaLtH
         ZCo7DL4kQuc391N6lmA/CSa8z7UtG4e5BRe/RZb4/yptFQS7aTG32jFW9OUq9C1Hge5f
         KQU6l6D9c/Q351eT00aisnZYG8w/3L2NW8ndO2sMXH/9wpR6C8lxuVucQupudVJyhy3f
         ta9jTOC+yF6WKJECtOHEDoMBs4IR2kY9T1d6MKgdhIH7UGPvZ/hwDNFNopdJaUMEOnjZ
         bkVA==
Received: by 10.216.212.157 with SMTP id y29mr4930731weo.146.1338634586280;
 Sat, 02 Jun 2012 03:56:26 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 2 Jun 2012 03:55:55 -0700 (PDT)
In-Reply-To: <20120529203759.GC22151@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199038>

On Wed, May 30, 2012 at 3:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>
>>> --- a/archive.c
>>> +++ b/archive.c
>>> @@ -7,10 +7,10 @@
>>> =C2=A0#include "unpack-trees.h"
>>>
>>> =C2=A0static char const * const archive_usage[] =3D {
>>> - =C2=A0 =C2=A0"git archive [options] <tree-ish> [<path>...]",
>>> - =C2=A0 =C2=A0"git archive --list",
>>> - =C2=A0 =C2=A0"git archive --remote <repo> [--exec <cmd>] [options=
] <tree-ish> [<path>...]",
>>> - =C2=A0 =C2=A0"git archive --remote <repo> [--exec <cmd>] --list",
>>> + =C2=A0 =C2=A0N_("git archive [options] <tree-ish> [<path>...]"),
>>> + =C2=A0 =C2=A0N_("git archive --list"),
>>> + =C2=A0 =C2=A0N_("git archive --remote <repo> [--exec <cmd>] [opti=
ons] <tree-ish> [<path>...]"),
>>> + =C2=A0 =C2=A0N_("git archive --remote <repo> [--exec <cmd>] --lis=
t"),
>>> =C2=A0 =C2=A0 =C2=A0NULL
>>> =C2=A0};
>>
>> I can understand the "help" text member of OPT_BLAH() construct, but
>> do we really want to translate the above?
>
> ...
>
> At least "git archive --list" should probably be kept untranslated
> to lessen the translator workload a bit. =C2=A0Good catch.

Should it? On one hand, it's like 10 strings less for translator (I
fixed the series) but then we want to catch unmarked strings. _() will
always be called on "git archive --list" and will give fault positive
here. I intend to make "make test" warn every time it sees unmarked
strings, fault positives will be annoying.

Unless we have a notion to say "this string is deliberately kept
unstranslated", I think we better just mark them all.
--=20
Duy
