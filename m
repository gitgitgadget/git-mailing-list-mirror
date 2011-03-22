From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 11:28:01 +0100
Message-ID: <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
 <20110322085027.GF14520@neumann> <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
 <20110322100903.GG14520@neumann>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ypr-0002i9-2F
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 11:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab1CVK3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 06:29:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49965 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab1CVK3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 06:29:03 -0400
Received: by fxm17 with SMTP id 17so6275093fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aw6dGosRYvl6hgLvf7lZfBgaaMzkmc3nuAInthFDgX4=;
        b=bAXZfUGAxpa4yztFIwteLdkkwyyPpFPk/1wbfjz6R/zNDZ8rspXIjiEPZJ0iUHVzHK
         zi5mlahKxke0ogUDVFanBQKUyD2JSpD6GAKKVAA5SJbNX8IeWZzBSH1XTR9lST0eS2kb
         MbYe0d0Z+MWdXFKwW28bsf7TyX+qHUjfYTjrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OoWrz3JQ2SC4r5FxOWG5tBLCH8w1eTWR321um5qfkYQoGwwem2yoQcSa3mo1pRVyec
         Xv8mDRXh0EklBxc8SF9T80MWc2Q4IH+2YUmEflmMbLfs9x3UZiqrV0G0Ua/VinkX6hGD
         ChLjizydxHy3VNZM2AEradsbBIEufVSrxBkbI=
Received: by 10.223.78.138 with SMTP id l10mr3395120fak.106.1300789742001;
 Tue, 22 Mar 2011 03:29:02 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Tue, 22 Mar 2011 03:28:01 -0700 (PDT)
In-Reply-To: <20110322100903.GG14520@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169718>

2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> On Tue, Mar 22, 2011 at 10:16:16AM +0100, Erik Faye-Lund wrote:
>> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>> > On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
>> >> This is a constructive tangent but if we are going to run $(__git=
_aliases)
>> >> every time we run _git_help, perhaps it would want a hack similar=
 to the
>> >> way the value for $__git_all_commands is generated just once?
>> >
>> > I think this is not necessary. =A0We already run __git_aliases() e=
very
>> > time after 'git <TAB>', and it was not an issue so far. =A0And ind=
eed, I
>> > just created 50 aliases, and the time required for __git_aliases()
>> > seems to be negligible:
>> >
>> > =A0$ time __git_aliases
>> > =A0<bunch of aliases>
>> >
>> > =A0real =A0 =A00m0.028s
>> > =A0user =A0 =A00m0.016s
>> > =A0sys =A0 =A0 0m0.004s
>> >
>>
>> Unfortunately, the situation is not quite so good on Windows:
>> $ time __git_aliases
>> <bunch of aliases>
>>
>> real =A0 =A00m0.112s
>> user =A0 =A00m0.030s
>> sys =A0 =A0 0m0.015s
>>
>> This is with 50 aliases, with 0 aliases I get this:
>> $ time __git_aliases
>> test
>>
>> real =A0 =A00m0.063s
>> user =A0 =A00m0.015s
>> sys =A0 =A0 0m0.015s
>
> I see. =A0However, on Windows everything git-related tends to be slow=
,
> so this is nothing new.

That's not the case. Every thing Git-related isn't slow on Windows,
but there are some things in Git that is.

> The question is whether the slowness of a known slow platform would
> justify the regression on all platforms.
>

Windows isn't slow. Get over this way of thinking, it's just wrong.
Windows has some different performance characteristics for some
operations than e.g Linux, but saying that it's slow is just wrong.
However, _Bash for Windows_ is quite slow, much due to Windows' lack
of fork(), which means that some very involved emulation needs to be
performed.

But even so, at least 25% of the git user base is on Windows,
according to the latest Git User Survey. That makes this stuff matter.
