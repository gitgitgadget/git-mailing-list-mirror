From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: add infrastructure for translating Git with gettext
Date: Thu, 17 Nov 2011 11:07:08 +0100
Message-ID: <CACBZZX6AMRra1wf_WOvxuZs8kbOD29kFDU2GwA9aOV2svnDctQ@mail.gmail.com>
References: <1321191835-24062-1-git-send-email-avarab@gmail.com>
 <7vlirhx14x.fsf@alter.siamese.dyndns.org> <CACBZZX4nypBW1agNw6NrC-7LBWbjZ1ycgpn-zvBsg0x4EDBD0g@mail.gmail.com>
 <20111116103319.GB30753@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQysa-0004rK-Ir
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab1KQKHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:07:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47034 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab1KQKHa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:07:30 -0500
Received: by bke11 with SMTP id 11so1761705bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nPKKmU3RHr3cZaXq9Zc2AdngILPeSm9SphLhZTBL8i0=;
        b=xaVKlhjMBy6JvAsBiCRtNy1trXaeORVexhuWCYcaPXr7XzGE0baln+eTelCT94XtMG
         NCvQbgxWGt1XQzvH5Uf4998DMqRvBgVWIS36WZmnoqofgZfH35Xx3BF1w3Kb+kdM/eHS
         OQTD7IKyhl1S2RbJBTx+s8FB2aYSFzWcJsc5w=
Received: by 10.205.120.20 with SMTP id fw20mr33471097bkc.39.1321524449206;
 Thu, 17 Nov 2011 02:07:29 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Thu, 17 Nov 2011 02:07:08 -0800 (PST)
In-Reply-To: <20111116103319.GB30753@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185589>

On Wed, Nov 16, 2011 at 11:33, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Here's what we do with the sharedir currently:
>>
>> =C2=A0* It's used as the gitwebdir already, and is used also as the
>> =C2=A0 =C2=A0localedir with this patch:
>>
>> =C2=A0 =C2=A0 sharedir =3D $(prefix)/share
>> =C2=A0 =C2=A0 gitwebdir =3D $(sharedir)/gitweb
>> =C2=A0 =C2=A0 localedir =3D $(sharedir)/locale
>
> This has $(prefix)/ (e.g., /usr/) at the start.

Yes I'm an idiot. I confused the installation part with stuff we
actually make in the git compilation directory.

The i18n code is indeed the onle thing that uses "share" in the
compilation directory.

Thanks for spotting that.
