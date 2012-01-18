From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Wed, 18 Jan 2012 19:57:18 +0100
Message-ID: <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 19:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnahd-0002OC-9M
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab2ARS5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 13:57:40 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42267 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab2ARS5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 13:57:40 -0500
Received: by ggnb1 with SMTP id b1so411577ggn.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lZDEWAZMyAKsWN6fB5afar6VY6B9J+NbHZB5+208geA=;
        b=BY8VqzN4ZLu2G3q2Jzu2iQBGaFW1kVYJDdcN1cTxTIzBbNShayReJTrSOA9LHUAQuE
         jdlbiH2iiJPifqZxuwafq7tQ5NoW0bTtq6ep6D7Ks4qhY7kf5v09AfKtWGSw1qwp37hv
         bhbxTjRv6efsDMcR9ulWUhaUxluyhE6nbA4WE=
Received: by 10.182.122.71 with SMTP id lq7mr20126953obb.33.1326913059368;
 Wed, 18 Jan 2012 10:57:39 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Wed, 18 Jan 2012 10:57:18 -0800 (PST)
In-Reply-To: <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188757>

On Wed, Jan 18, 2012 at 16:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Tue, Jan 17, 2012 at 14:42, Alex Riesen <raa.lkml@gmail.com> wrote=
:
>> Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
>> It is very unexpected.
>
> So the reason it's like that is that I was assuming that gettext.sh
> wouldn't be FUBAR anywhere, but the translations shouldn't kick in
> since we haven't installed them during "make install".
>
> But I wonder if this negatively affects some systems, now we now:
>
> =C2=A0* Don't use gettext.sh, which means that we're using our fallba=
ck
> =C2=A0 shell function instead of the binary gettext(1), which is prob=
ably
> =C2=A0 faster.
>
> =C2=A0* Use our own eval_gettext() instead of using the system one, w=
hich
> =C2=A0 uses the GNU binary which is more likely to be in the FS cache
> =C2=A0 already since other programs are probably using it.
>
> Which is why I didn't do something like this to begin with.

Well, if I say NO_GETTEXT, I kind of want none of local gettext,
whether it works, or not.
