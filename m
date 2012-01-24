From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC 3/2] i18n: do not use gettext.sh by default when
 NO_GETTEXT is set
Date: Tue, 24 Jan 2012 21:06:13 +0100
Message-ID: <CALxABCahouHey0Q7VHm1EQVvpP_ROnOhtW=FcnZOS1UJ2KHEJA@mail.gmail.com>
References: <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org> <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino> <7vehuq6ote.fsf@alter.siamese.dyndns.org> <20120124003109.GB26980@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpmdb-00085R-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab2AXUGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 15:06:35 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:38813 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755931Ab2AXUGe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:06:34 -0500
Received: by obcva7 with SMTP id va7so4691735obc.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 12:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RXtSX0fbVoCbKoMjp//15C8V2VzmyNN1waLiqreKxAo=;
        b=TvWwhgNDkYsrIw5OjVbpTPlh//N0Hbn+me2rfL797BIm6uPCqhVpqDn6oogkrF08Uq
         PxlW1agM5zEL7ehKoO9Ke9exfx2d1NvgmSS6yqa+88oBpM8HryWfbEai6fJnpGBP6C+C
         N4znylG6dNFj4swb6sym2I9JiWKC+bQX4ycUY=
Received: by 10.182.117.8 with SMTP id ka8mr12930682obb.73.1327435594346; Tue,
 24 Jan 2012 12:06:34 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Tue, 24 Jan 2012 12:06:13 -0800 (PST)
In-Reply-To: <20120124003109.GB26980@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189063>

On Tue, Jan 24, 2012 at 01:31, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 ifndef USE_GETTEXT_SCHEME
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 USE_GETTEXT_SCHEME=
 =3D fallthrough
> + =C2=A0 =C2=A0 =C2=A0 endif

We already use GNU make features (+=3D), so this can be just

USE_GETTEXT_SCHEME ?=3D fallthrough

I think...
