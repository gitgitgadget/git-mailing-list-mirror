From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 9/9] diffcore-pickaxe: support case insensitive match
 on non-ascii
Date: Thu, 9 Jul 2015 18:55:08 -0400
Message-ID: <CAPig+cTuTAHWwPDrbpOovN6HBvZRKHLGM-FPpEU3ZxXpH-aSCw@mail.gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
	<1436351919-2520-1-git-send-email-pclouds@gmail.com>
	<1436351919-2520-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, plamen.totev@abv.bg,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKip-00019L-EN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbbGIWzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2015 18:55:11 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36191 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbGIWzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 18:55:09 -0400
Received: by ykey15 with SMTP id y15so52740807yke.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=llSFKZdcyaLVorLxDrYg/xh32a37xP/3EIGrueFMYy0=;
        b=KL78FnbU9mqUd+1dzEsX/y/PqcNGJfdCd/w2ksTmyC3ur5dVD44JT2M32/ycDaE6rj
         xwe3gheXMakBJXIPipZmcL1FXU7eyYh1i6vJcZG/DAZzyDEDrizjHtctyddh4FNGvSRM
         sN1bejue0+Cqix0Uj5So1G2IjL98hGrrgh1r923wdZBXZhHzsAitPUPoBGKDy6irhmUd
         2k0mjaShjoQ5gONphUuV7s9VgAGTD53jZiS/zMLWnEMNuoxyIZprr1qlyHeXHx5Zottb
         jQNrW9u2D58EcquK9ifM2T7eDEt254CPqGIpbpQOwRBOUIlo7gNP00VGL4YGolL8hwCZ
         QH7A==
X-Received: by 10.170.220.214 with SMTP id m205mr20074079ykf.13.1436482508757;
 Thu, 09 Jul 2015 15:55:08 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 9 Jul 2015 15:55:08 -0700 (PDT)
In-Reply-To: <1436351919-2520-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: TZAarzbnDdGDajuSk5tD8uDxZzw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273794>

On Wed, Jul 8, 2015 at 6:38 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Similar to the "grep -F -i" case, we can't use kws on icase search
> outside ascii range, quote we quote the string and pass it to regcomp

s/quote we quote/so we quote/

(or something)

> as a basic regexp and let regex engine deal with case sensitivity.
>
> The new test is put in t7812 instead of t4209-log-pickaxe because
> lib-gettext.sh might cause problems elsewhere, probably..
>
> Noticed-by: Plamen Totev <plamen.totev@abv.bg>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
