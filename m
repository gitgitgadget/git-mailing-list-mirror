From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 05:00:03 +0200
Message-ID: <CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net> <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net> <20150825185414.GA10895@sigill.intra.peff.net>
 <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
 <20150826021517.GA20292@sigill.intra.peff.net> <CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
 <CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com> <CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 05:00:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVsrM-00088d-0b
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 05:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbH3DAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2015 23:00:25 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35580 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbbH3DAZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2015 23:00:25 -0400
Received: by wicne3 with SMTP id ne3so46335642wic.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 20:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=K96pL0mhl2OGIry6wQdK5n6sR8I0m5Hvb0+p87bLHVY=;
        b=DPNJFV6pGDkiyczhmMTIRn65AWY5O6oGW/jVUe2r8J9SGP6rSSx1EBIwoFG8R0fpHr
         b3htdQmqJ+suM+Im4NgnPYSQWJU8hbwH6Rb2oMeY+5b3M8USUnF+9NcWapq/zp3rashY
         5spoZKstetOVCiAOTh5mzipJR5MbzJzXSS4b8Vv8WXrLJ1Rl9wiaI7EZLyLr8L2kuXIa
         gHIXg+s+qJr7NUyqX70cg+a4rsmazs+J192qQNjzg38o9kDLGMZl1dzW0eURT3XEwWxo
         2vI3fPoL05sTG0d6i2GgFJN7ERvExfRcwya56REF2Xt59tK30um240hp+cMazKbcCHCL
         HAPQ==
X-Received: by 10.194.173.35 with SMTP id bh3mr13582169wjc.88.1440903623577;
 Sat, 29 Aug 2015 20:00:23 -0700 (PDT)
Received: by 10.194.192.201 with HTTP; Sat, 29 Aug 2015 20:00:03 -0700 (PDT)
In-Reply-To: <CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
X-Google-Sender-Auth: D0UsCMty1acTnY_QGklA2dFp85M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276796>

Reading after it, I think the most close we can get with this is, awk
'BEGIN { print strftime("%c", 1271603087); }; and just ignore setting
this value (and avoid displaying it) if that fails too. Do you agree?
Bern=C3=A1t G=C3=81BOR


On Sun, Aug 30, 2015 at 3:20 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sat, Aug 29, 2015 at 9:29 AM, Gabor Bernat <bernat@primeranks.net>=
 wrote:
>> Amended, the latest version is at https://github.com/gaborbernat/git=
/commit/ :)
>> Does this looks okay, should I create a patch from this?
>
> Excerpt:
>
>     now=3D$(date +%s)
>     elapsed=3D$(($now - $start))
>     remaining_second=3D$((...))
>     eta=3D$(($now + $remaining_second))
>     finish_by=3D$(date -d "@$eta")
>
> Unfortunately, -d is not portable. On Mac OS X and FreeBSD, -d sets
> the kernel's value for Daylight Saving Time, rather than displaying
> the specified time as in Linux.
