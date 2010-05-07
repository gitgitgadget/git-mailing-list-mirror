From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Fri, 7 May 2010 21:52:07 +0200
Message-ID: <AANLkTimziTKL13VKIOcaS1TX1F_xvTVjH8Q398Yx36Us@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <1273180440-8641-1-git-send-email-avarab@gmail.com>
	 <AANLkTik6z4cvUzjfq-q61tgk_MhqWKc_A55i3VauPSQC@mail.gmail.com>
	 <AANLkTinhh8TXY9r9Jf394YKYXDxpU65qjg7MbPcb12Ls@mail.gmail.com>
	 <AANLkTilp0d28QMs_K7cVrfqmkzeqs8FTJbU1oeuUy7V6@mail.gmail.com>
	 <AANLkTilG5OGjQcd1Vd1CdyOibFh4Po6jdfvSRNidrRzh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:52:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATap-0008Tz-SQ
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179Ab0EGTwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:52:11 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51106 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0EGTwJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:52:09 -0400
Received: by gyg13 with SMTP id 13so852199gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n9frck5VSVGutgSwnzCqU5hb5xDMWerF4y1KrjFuTaY=;
        b=nx7+txhybGy2TxHRHeYLBiXsp4wn0YgsR687JAZXAeN4tQzVMcyfFo5thRf3sj9Cp/
         /7JwI26fuZSZey6PeKRJTPCUHej0pTOmgjjoH4fzPrNCRz/wZnkINR1cWaW3WZlEWW9G
         Kwjtv1vJjxcOu3suk5TqyW/TZIChAxwmb4Fps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DbPKnWzGDW4Jk6tKZyXACGYYQsFLObu6Edt6M93jpO6qzxkOyZBS8himh4n0orvjRL
         rmXqz3mn7BVyWUqGa8qBXX0Wrt9bxdrmCVuxnoEcE9fWbWnv2BYz7SnAzhSkgSc80mqr
         bZUvVrFz7aeGoj2Skz9cvN6oqc8y3tT8jIVGY=
Received: by 10.231.191.68 with SMTP id dl4mr164663ibb.75.1273261927650; Fri, 
	07 May 2010 12:52:07 -0700 (PDT)
Received: by 10.231.39.205 with HTTP; Fri, 7 May 2010 12:52:07 -0700 (PDT)
In-Reply-To: <AANLkTilG5OGjQcd1Vd1CdyOibFh4Po6jdfvSRNidrRzh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146575>

On Fri, May 7, 2010 at 20:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Fri, May 7, 2010 at 18:29, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> On Fri, May 7, 2010 at 18:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>>> On Fri, May 7, 2010 at 06:00, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>>>> On Thu, May 6, 2010 at 23:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>>>>>
>>>>> Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>
>>>>
>>>> So you don't agree to the Developer's Certificate of Origin, don't=
 you?
>>>
>>> Signed-off-by is for "if you want your work included in git.git"
>>> (according to Documentation/SubmittingPatches). I don't think this
>>> patch is ready for inclusion as-is, but I wanted to solicit comment=
s
>>> on the general approach.
>>>
>>
>> Can you please quote SubmittingPatches for your argumentation.
>
> I already did, but here's the full paragraph I quoted from, for
> reference:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- if you want your work included in git.gi=
t, add a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Signed-off-by: Your Name <you@exam=
ple.com>" line to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit message (or just use the opt=
ion "-s" when
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0committing) to confirm that you agr=
ee to the Developer's
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Certificate of Origin
>

But where does the Developer's Certificate of Origin talks about
non-legal aspects of patch submitting? E.g. correctness, quality, ...

I think the part "if you want your work included in git.git" is very
misleading in this paragraph, and I propose to remove it.

> I'm not seeking to include this work as-is in Git, so I added a
> Not-signed-off-by line to make that clear (as if all the bugs didn't
> do that already).
>
> I do agree to the Developer's Certificate of Origin, but just read th=
e
> "Not-signed-off-by" as "you really don't want to apply this in its
> current state". I'm asking for comments so that I can produce an
> appliable patch, that one will have a Signed-off-by line.
>

And thats exactly where you mixed legal and technical aspects of patch
submitting, and others may not (especially me, obviously). The S-o-b
line has nothing to do with the technical aspect, or the quality, of
the patch. Adding "Not-signed-off-by" (or even worse: changing it
later to Signed-off-by) could actually mean that you stole the code
from someone else.

Bert
