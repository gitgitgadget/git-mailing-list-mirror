From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] i18n: keep the last \n even when text is poisoned
Date: Fri, 9 Mar 2012 08:11:39 +0700
Message-ID: <CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-2-git-send-email-pclouds@gmail.com> <20120308220131.GA10122@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 02:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5oUk-0008Ab-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 02:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab2CIBTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 20:19:41 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33696 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2CIBTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 20:19:41 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 20:19:40 EST
Received: by wibhj6 with SMTP id hj6so35017wib.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KDgakC9ttvcritIY1odeFiStsPz04Ap+8aRUw7BOVeI=;
        b=g1ZjE3fkfUSqjv36ASkW9lkFwyE69fu32lZ/MYqvA10G7/tWGeGycHrXvpZyHc/Kl/
         iFxgsv3lRBMGrqE4LPCHTiSveA5Un6j236HTZnuRPJF5POxFvzIu3hswfuBMekO4YOoj
         rE7NA/i18vLnzJ3OljCYaCm2CIHQusWW9BU20Au/+Ykm8DZ6njjKsw8n1WlKIUzMdnEa
         gH3FoSm+bIPIuMiThvaAYfjBw/Ewrtf68+b5ehiTPkiVgYWtXHkxvFsqawCn5Frd2/dr
         B9ny4LZjQTUTiTQBT3iyeP+ueEJ1x2/OxVEmaLhsJ6C0XTJidGyUGTsFKsyi2XNoddgA
         i0Lw==
Received: by 10.180.91.10 with SMTP id ca10mr11276221wib.17.1331255529399;
 Thu, 08 Mar 2012 17:12:09 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Thu, 8 Mar 2012 17:11:39 -0800 (PST)
In-Reply-To: <20120308220131.GA10122@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192668>

2012/3/9 Jonathan Nieder <jrnieder@gmail.com>:
> I realize this was not the motivation behind the above patch, but if
> the translation of some message has to end with a newline for git to
> function correctly, would we consider that a bug?
>
> I am of two minds on that:
>
> =C2=A0- on one hand, translators tend to be trustworthy, reasonable f=
olks

We trust msgfmt and it does check \n in msgstr if there is in msgid.

> =C2=A0- on the other hand, anything we can do to make the translation
> =C2=A0 process less fussy seems like time well spent

That's at the cost of more code to split \n out of the strings, and
there are 113 of them (some not published yet).

> The latter wins out for me, so I would prefer not to have this patch
> so the test suite can detect important newlines that should be not be
> part of the translatable string.

It's the former for me, but that's probably because I'm also a
translator :) Anyway for tricky cases where msgfmt fails to detect,
there's the role of l10n coordinators, who should review translation
and catch these errors.

> Just my two cents,
> Jonathan
--=20
Duy
