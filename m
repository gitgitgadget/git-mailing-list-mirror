From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Sat, 03 Jul 2010 00:59:24 -0700 (PDT)
Message-ID: <m3wrtdm1y9.fsf@localhost.localdomain>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
	<20100702192102.GA6585@burratino>
	<AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 09:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUxdM-000061-T2
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 09:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab0GCH71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 03:59:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55971 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab0GCH70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 03:59:26 -0400
Received: by fxm14 with SMTP id 14so2804358fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=5p9Xi3UYUwU7Dsj+yJOyx0DBDTPu7ZYweODh3rxeut8=;
        b=ZF/Jg04QmlERmMw4dIK3GQRFxBgl7+GZSZ5m1UTJ4h/bTgZ6sVvMl+kXrJ0sy/W2qr
         qWS4hVjSK1uArc47gf7pQowU23VWuZxehIm/3EiiKhAw+0Qz2tCgsQ7DyBO12o2WRbNy
         gB+7XGAM3wqqx83LWEwiJQq5UgrpJ8ajLWGyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=ieDGSfo0t5vlNOPcknYs/Wezjm2AWPlphuiS37+MwkdX6M0H6+gd6IpGCVDWJ5XHHO
         YWAqrx0qxHHU88QkV/aoopjI1eu5/ZxlfwgO0rLeuDFioc/oyfh998RbMYpzxlEYaM1R
         5gaUx+qPgTBfkEyIc/+uMYykSotqQ2/3HbI98=
Received: by 10.223.105.14 with SMTP id r14mr1685551fao.78.1278143965235;
        Sat, 03 Jul 2010 00:59:25 -0700 (PDT)
Received: from localhost.localdomain (abwh100.neoplus.adsl.tpnet.pl [83.8.231.100])
        by mx.google.com with ESMTPS id x11sm3457435fal.41.2010.07.03.00.59.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 00:59:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o637wi8F008800;
	Sat, 3 Jul 2010 09:58:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o637wM95008748;
	Sat, 3 Jul 2010 09:58:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150179>

Nazri Ramliy <ayiehere@gmail.com> writes:
=20
> Something like the following will do (I'm doing this in gmail so sorr=
y
> for any tabs<->space conversion):
>=20
> test_expect_success 'copes with color.ui' '
>  =A0 =A0 =A0 rm -f actual &&
>  =A0 =A0 =A0 echo grep.h >expect &&
>  =A0 =A0 =A0 git config color.ui always &&
>        git config color.grep.filename yellow &&
>  =A0 =A0 =A0 test_when_finished "git config --unset color.ui" &&
>        test_when_finished "git config --unset color.grep.filename" &&
>  =A0 =A0 =A0 git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
>  =A0 =A0 =A0 test_cmp expect actual
> '

Sidenote: test_when_finished, introduced by Jonathan Nieder in 3bf7886
(test-lib: Let tests specify commands to be run at end of test,
2010-05-02) is not documented in t/README.  Also, shouldn't it be
named 'when_finished_test' rather than 'test_when_finished'?

Currently 'test_when_finished' / 'when_finished_test' is used only in
t0000-basic and t7509-commit.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
