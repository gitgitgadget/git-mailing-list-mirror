From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 14:13:21 +0000
Message-ID: <AANLkTimKQ9a4GXA4u2hVW+ECAFRzd5NwuP+9p6htBU1y@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
	<AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
	<20100829204519.GB1890@burratino>
	<AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
	<20100830134136.GA2315@burratino>
	<alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcin Cieslak <saper@saper.info>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq57F-0006pe-4L
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab0H3ONY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:13:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37512 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0H3ONX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:13:23 -0400
Received: by fxm13 with SMTP id 13so3227278fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jS/6+5dm8LJ6JcWRX7J6K06eP54p9UgCjguVE/UVsTg=;
        b=TUYhrs/LV161Tx7+TwftbAIUuXGSRPXWfbWtrHdtjVZVXALdrmxR+HftQkvOXFJovE
         wD1vinAgNcV+SgqjLeXQKWs6mYOu1pgkxEPs9tEDGTHN4Nuau2vXIyZSZtFrE6cks4NN
         vzEDSv7yY0QB2zrASORnLdLiBvnKsvgWNgxJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fgd3+KAeZMw85CQ+nggzdspABNNhbP90Ev4GQ+wQ/nY3ReEVCrAcfphySZYFNUcOiK
         aQYS5tL0TuhC4TWvsYNUhFqtT+ZtW9PHQvuas5EuGjKjyJdv9WtLDpoDYd90RTNrtxyS
         ewRswPlgj89QCfHYD8TSbbc1Vpq219pkKGdBE=
Received: by 10.223.105.76 with SMTP id s12mr3829873fao.107.1283177602009;
 Mon, 30 Aug 2010 07:13:22 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 07:13:21 -0700 (PDT)
In-Reply-To: <alpine.BSF.2.00.1008301353260.95618@x.fncre.vasb>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154808>

On Mon, Aug 30, 2010 at 14:00, Marcin Cieslak <saper@saper.info> wrote:
> On Mon, 30 Aug 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sun, Aug 29, 2010 at 20:45, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> A would be preferred for correctness, and with a fallback BSD printf=
()
>> we can avoid the GNU libc bug, however that'll mean using LC_CTYPE,
>> which'll have some small side-effects for the rest of the code.
>
> The real problem is that you are probably using same functions
> (locale-enable) for the user-facing side as well as for the backend (=
talking
> to repository). Some projects decided to use
> some special encoding internally (like UCS-2 in case of Java
> and Python 2.x, Unicode ordinals in Python 3.x). Otherwise
> you may end up in some incompatibilities in the on-disk on on-network
> format. I don't think you want to keep telling all bug reporters for =
few
> years - "Can you try that again with env LANG=3DC,
> please?" :)

Yeah, those programs can probably get away with it too because they
either implement their own string functions, or don't use setlocale()
at all for their localizations.

> Bringing Unicode onboard means that simple strlen() is no longer
> what you normally think it does.

I'm pretty sure strlen() always gives you the number of
null-terminated bytes regardless of locale settings. wcslen is the
wide-characted equivalent.
