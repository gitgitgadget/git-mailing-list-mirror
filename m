From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/4] sha1_name: introduce getn_sha1() to take length
Date: Wed, 4 Apr 2012 21:10:16 +0530
Message-ID: <CALkWK0nsO_xeuKpuPp0wvvbdhHnmKnX_JCPr6yapztC-Gq3Ljw@mail.gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
 <1333029495-10034-2-git-send-email-artagnon@gmail.com> <20120403220817.GE19858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFSKA-00055s-Of
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 17:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab2DDPki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 11:40:38 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58208 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab2DDPkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 11:40:37 -0400
Received: by vbbff1 with SMTP id ff1so249942vbb.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=M6OylFckVP29EIr1OAQcZ1fOtyrX/6YT63lKllpgFfc=;
        b=KcY/U2k1vCZLBpLR/LkSx/YfVieujowi2NoiUODNKAHv1r8/IBDayK4tYo2ahg5cv1
         Qe1mvp5bPyhJMKJMagXi99RJlFAa5XsWS0IesCRqv134IOlSePpSjNj2GpVOJF3z65KU
         M5MlMe2LYYiYR2/VNLiTOLfvTZNluNHUROx12SNyAK8ALyHdoIeXzjKOS86h5BjETvXf
         veGGS0RL2fBgMJidLN9kRIebfi08CEUDa3j8zMjvFppg9nbJ9dnA4jm4j9w1btaEU0cG
         UaLqCzVaC2nUVOtICecX3CEr+C1hMO1m2NMD8jY/wkOQP4Y1haVyeMkMA8EwEFPzm11G
         ZtUg==
Received: by 10.52.37.102 with SMTP id x6mr6812085vdj.72.1333554037273; Wed,
 04 Apr 2012 08:40:37 -0700 (PDT)
Received: by 10.52.23.212 with HTTP; Wed, 4 Apr 2012 08:40:16 -0700 (PDT)
In-Reply-To: <20120403220817.GE19858@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194703>

Hi Jonathan,

Jonathan Nieder wrote:
> If I were doing it, I might just ask the maintainer to make the
> decision for me, by making a somewhat funny patch series:
>
> =C2=A01. add "how to use the get_sha1 family" to Documentation/techni=
cal.
> =C2=A02. make get_sha1_with_context_1 static.
> =C2=A03. replace get_sha1_with_mode_1 with simpler die_sha1_not_in_in=
dex
> =C2=A0 =C2=A0function.
> =C2=A04. add namelen argument to die_sha1_not_... and
> =C2=A0 =C2=A0get_sha1_with_context, adjust callers, and make use of
> =C2=A0 =C2=A0get_sha1_with_context with this arg in sequencer code.
> =C2=A05. add namelen arg to get_sha1_with_mode, adjust callers, and
> =C2=A0 =C2=A0make sequencer code use this instead.
> =C2=A06. add namelen arg to get_sha1, adjust callers, and make sequen=
er
> =C2=A0 =C2=A0code use this instead.
>
> That way, the maintainer could take patches 1 - 3 to get the basic AP=
I
> cleanup, patch 4 to get the sequencer enhancement and make a judgemen=
t
> call about whether to take patches 5 and 6 depending on how much of a
> pain the churn would be given other patches in flight.

Makes a lot of sense.  I'll re-roll shortly.

Thanks.

    Ram
