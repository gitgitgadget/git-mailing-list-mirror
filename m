From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s"
 as for "ln" / "cp"
Date: Thu, 5 Feb 2015 21:52:44 +0100
Message-ID: <CAHGBnuM0uTDxRB1NZm0fxe2yLs-QoU1J+Txb8_o7zVdYahAdow@mail.gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
	<D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
	<xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
	<20150205195143.GB15326@peff.net>
	<CAHGBnuPL7NN9J+4xd7xifsmbSPcC5V2ze05ji7P_qnvWHPGV+A@mail.gmail.com>
	<20150205204534.GE15326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:52:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTPu-0008Mw-PM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbbBEUwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2015 15:52:46 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:62118 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbBEUwp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2015 15:52:45 -0500
Received: by mail-yk0-f173.google.com with SMTP id 142so4221011ykq.4
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TdMMCx3J3DjWDh22Tfyg8i99ULKaYGJPk0BiOcepPRs=;
        b=xlZB5HS+RRKeuwpmjvt3N7Mxvmdg+qWerDihgmsb9tQNOrd4YPS1YBQFKJYelKbTef
         DjYgfZYsbrHb4nuXSt7e5FxXEGLD/jfsYRW0676YKHWTpK6FP4YeLo1gYJiHbjJRcOpB
         ylWsis3HWmGi+TFdWurRnsL7/l8ICQDJ+uNOh07PrR0PVVeKfMIKvyxdTUkCKtI9DvJj
         rWVpA8dPGgLwj5JPHibykxXDU2Ow4BDFcbJJXS1ZQYKYuwMZNWtcgqtPovH9itMDS5Sd
         eZNLusxe0+UCIWVU9+epTOcSbJgk/XJS+j1Ks0i5vmh9U20iA3d/5en/LEOkTbX3UvJZ
         M9NQ==
X-Received: by 10.170.45.151 with SMTP id 145mr21897ykn.10.1423169564828; Thu,
 05 Feb 2015 12:52:44 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 12:52:44 -0800 (PST)
In-Reply-To: <20150205204534.GE15326@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263403>

On Thu, Feb 5, 2015 at 9:45 PM, Jeff King <peff@peff.net> wrote:

>>  endif
>>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7$(RM)=C2=B7"$$execd=
ir/$$p"=C2=B7&&=C2=B7\
>>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7test=C2=B7-z=C2=B7"=
$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)"=C2=B7&&=C2=B7\
>>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7"$$bindir/$=
$p"=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
>> +=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7-s=C2=B7"..=
/$$p"=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
>>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7cp=C2=B7"$$bindir/$=
$p"=C2=B7"$$execdir/$$p"=C2=B7||=C2=B7exit;=C2=B7\
>>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7done;=C2=B7\
>>  =C2=B7=C2=B7=C2=B7=C2=B7}=C2=B7&&=C2=B7\
>> --=C2=B7
>>
>> does not seem to be correct in all cases.
>
> Ah, I see. Yeah, you'd have to calculate that relative path between
> $bindir and $execdir. We have C code already to do that (see
> relative_path() in path.c), so in theory you could build a wrapper
> during the build phase and then run:
>
>   ln -s $(./my-wrapper "$bindir" "$execdir")/$p $execdir/$p
>
> or something during the install phase.

Thanks for pointing out the C code to do that. But IMO creating and
using such a wrapper is not worth the effort.

--=20
Sebastian Schuberth
