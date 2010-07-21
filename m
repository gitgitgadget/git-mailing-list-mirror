From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Wed, 21 Jul 2010 00:34:38 +0000
Message-ID: <AANLkTil8gyaOcjHGm0tLTdYDdTT4VckUr9nELNiBlKNa@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
	<AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
	<20100721000101.GB4282@burratino>
	<AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
	<20100721001402.GE4282@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 02:34:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObNGo-0001pM-LS
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 02:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0GUAel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 20:34:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39627 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab0GUAek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 20:34:40 -0400
Received: by fxm14 with SMTP id 14so3211131fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P+iwLmqp6GrcwrZfTigLpgWldUvA5N2NcYfvV23iXYE=;
        b=ECjuDDxqHqwS5kDD5J4x+qnjio5U1+lBP2Crf359I4cBey/YS7P0RCiZztCsl/Pb/w
         pMRfh23uj6mlzx2rcMAoW4azlqO5cvzgWMtnV6SsHYkK8iiGJ51I5/9lNx2kN9tzKrmk
         VWcEQCM5zhtcvLZicE0Wv0kdNZy/A/YM8ySAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ACk1dsXwnIrkFA9c2pmX5Gz8KXBqzz4xwpk27wBEV7kjVClWvhrqAodBDwOCMOw0Fc
         eg1tAzYIwndQnTRjtf6WB7e+BureCzbdVxZV8bSiJ8NsMyWP6L8w1cNkOAxHFFxeLD5Q
         8IuWFOO0Cd3Gyyna2OohuHN2HMNVr+U5xLBaI=
Received: by 10.223.106.132 with SMTP id x4mr6102490fao.15.1279672478463; Tue, 
	20 Jul 2010 17:34:38 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Tue, 20 Jul 2010 17:34:38 -0700 (PDT)
In-Reply-To: <20100721001402.GE4282@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151381>

On Wed, Jul 21, 2010 at 00:14, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> We should have examples for both export and unset
>
> What is unportable for =E2=80=9Cexport=E2=80=9D is the effect of expo=
rting an unset
> variable. =C2=A0I am not even sure whether the return value is unport=
able,
> but it doesn=E2=80=99t matter; that is an example of a =E2=80=9CDon=E2=
=80=99t=E2=80=9D rather than a
> =E2=80=9CDo it this way=E2=80=9D.

I didn't know that. It'd be good if it were mentioned in the docs. I
thought it was just export in general.

> See v1.5.6-rc0~61 (filter-branch: fix variable export logic,
> 2008-05-13) for an example.

As an aside, how do you make these 61-commits-after-rc0 commit ids. Is
there a sha1->that tool that I haven't spotted?

>> but the prose
>> should mention both IMO
>
> Yes, thanks for putting this portability guide together.

Thanks for improving it, this change is a definite improvement, I just
had a "wait, what's the export doing there then?" question when
reading it.
