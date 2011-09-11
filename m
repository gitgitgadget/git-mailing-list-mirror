From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] obstack.c: Fix some sparse warnings
Date: Sun, 11 Sep 2011 23:56:43 +0200
Message-ID: <CAGdFq_ifU2WWbCpRY_EFY=_hwwtFs0eqMhJ7sRoUhrivABFoFw@mail.gmail.com>
References: <4E6D0B7D.9070602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:57:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2s1p-00017u-Hx
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760406Ab1IKV5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Sep 2011 17:57:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58189 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab1IKV5Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 17:57:24 -0400
Received: by ywb5 with SMTP id 5so308467ywb.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SSp9QEJrdGZ7DRn2Srl2KgtxjI+j9royL0IEBYKBIFg=;
        b=LP23wHmwH2DLC7M3iaDS7GzoED3SktsCoPtLNN0f8awAE3yd9D029SPpDOT4RBQdfT
         ZYIpyp8Yp0lvTu3tnUcpKVJdO0ZZ8/yrx84wSj9+Ae8Mllk7J/HI1gkTtsP6T69bbKIa
         DyolzDTz4P9Q5KhXVkRyBpLnVbLfInxISH6LY=
Received: by 10.68.6.1 with SMTP id w1mr1948954pbw.366.1315778243099; Sun, 11
 Sep 2011 14:57:23 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 11 Sep 2011 14:56:43 -0700 (PDT)
In-Reply-To: <4E6D0B7D.9070602@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181200>

Heya,

On Sun, Sep 11, 2011 at 21:26, Ramsay Jones <ramsay@ramsay1.demon.co.uk=
> wrote:
> =C2=A0 =C2=A0compat/obstack.c:399:1: error: symbol 'print_and_abort' =
redeclared with \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0different type (originally declared at com=
pat/obstack.c:95) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- different modifiers

> @@ -395,7 +395,6 @@ _obstack_memory_used (struct obstack *h)
> =C2=A0# endif
>
> =C2=A0static void
> -__attribute__ ((noreturn))
> =C2=A0print_and_abort (void)
> =C2=A0{
> =C2=A0 /* Don't change any of these strings. =C2=A0Yes, it would be p=
ossible to add

Wouldn't the better solution be to add noreturn to the declaration at
compat/obstack.c:95?

--=20
Cheers,

Sverre Rabbelier
