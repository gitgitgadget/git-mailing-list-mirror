From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Accept-language test fails on Mac OS
Date: Mon, 8 Dec 2014 16:51:39 +0100
Message-ID: <CAP8UFD0TSqXMRSpisaQG92_xAizswGKvFV-_N6fdjqbAh8vejA@mail.gmail.com>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
	<xmqqppbxogli.fsf@gitster.dls.corp.google.com>
	<CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
	<5482D180.9010002@web.de>
	<CAFT+Tg_4EJ15CmujDtcubfw+0rr2J=pbjccqSSs9tmj-rz6+eQ@mail.gmail.com>
	<54836F46.9080009@web.de>
	<20141207071827.GA31014@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	semtlenori@gmail.com, Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 16:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0bC-0008Ey-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbaLHPvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 10:51:40 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38411 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbaLHPvk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 10:51:40 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so4730211iec.30
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eh97KDyFCmORGeIdr4kLROAqcpIg0OmfIivJodw+LCA=;
        b=aT+Yhe9/cPkHC7pobveUcPMyYcHwf3QIREW6PfOWtoGz13861UeJMylwJPPX1cP9Gk
         gWAJEQq9Mwx1u0dri0qNKHkNWBudkb0bwxlBWfMLeF5XJWrmeWI5B5JG5ee/SYIEmomJ
         dZei2QDo3zx16m2ixiXAigs33elBUwPecikJ/0mCeQ0Hb8BhUyeoEi1PEc0cN1k5dTpO
         Fg3C5MrQWboWGkwzXRmm232/4VxrrjfpIz46SZT3drf9EFzcTvwljh5pRjJmspgC+uLH
         TCPsxjz9gH8SqZQZrRLmBBtOafRYfeH0R1xixk7wW1qtlZpnIijKin+3zqtkqn5DwdFU
         Bf+Q==
X-Received: by 10.107.128.138 with SMTP id k10mr11388826ioi.69.1418053899410;
 Mon, 08 Dec 2014 07:51:39 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Mon, 8 Dec 2014 07:51:39 -0800 (PST)
In-Reply-To: <20141207071827.GA31014@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261050>

On Sun, Dec 7, 2014 at 8:18 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Dec 06, 2014 at 10:04:06PM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> I get this:
>>
>>
>> expecting success:
>>         check_language "ko-KR, *;q=3D0.1" ko_KR.UTF-8 de_DE.UTF-8 ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "de-DE, *;q=3D0.1" ""          de_DE.UTF-8 ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "ja-JP, *;q=3D0.1" ""          ""          ja=
_JP.UTF-8 en_US.UTF-8 &&
>>         check_language "en-US, *;q=3D0.1" ""          ""          ""=
          en_US.UTF-8
>>
>> --- expect      2014-12-06 21:00:59.000000000 +0000
>> +++ actual      2014-12-06 21:00:59.000000000 +0000
>> @@ -1 +0,0 @@
>> -Accept-Language: de-DE, *;q=3D0.1
>> not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_A=
LL, LC_MESSAGES and LANG
>
> I can reproduce the same problem here (Debian unstable). I actually r=
an
> into three issues (aside from needing to use Junio's SQUASH commit, t=
o
> avoid the "\r" bash-ism):
>
>   1. I couldn't build without including locale.h, for the
>      definition of setlocale() and the LC_MESSAGES constant (both use=
d
>      in get_preferred_languages).
>
>      I'm not sure what portability issues there are with including it
>      unconditionally. Should this possibly be tied into gettext.c, wh=
ich
>      already uses setlocale?

Yeah, pu build is broken on Ubuntu 14.04 too, because of
7567fad2431eb38291fd74a70f603e5746c6f728 (http: send Accept-Language
header if possible).

Thanks,
Christian.
