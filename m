From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sat, 29 Aug 2015 23:15:49 -0400
Message-ID: <CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 05:16:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVt6G-0007qs-Rn
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 05:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbbH3DPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 23:15:50 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33130 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbH3DPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 23:15:50 -0400
Received: by ykdz80 with SMTP id z80so49840908ykd.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZYh/dp6xUy5o5KC791rdrI9gUQ0RM4aXCKs+69406Yo=;
        b=Ayx0lyiMaZ96/W8dgsDhobd0EszNS3b1MtydzHBZgN6CPvlfXJ10qRvE6tu0Ytl0bQ
         C8iuaYPditJ34uilfGD8rD9bQkvW4dgZnmMt5venT60CBC7kzE/HQeIJ15+YeKNItKwz
         P+0ta6hNWIlqsoTTUSbadIDJ7Vc0Re0PB06Kw2u16t8ZKJZpkhP/s3kjOidk5fWYGMWA
         JHqyB2rkSaZ4+E0o5xqR9Azows223dKzhaPGfxuGrP2GFmGttvcGBaweaRfizyveBnm0
         ZfX6VpxlQ+U/2YepSv0pxIoHi8uxg6qIbPoDenixIFhmgJaAkN9X2sNVoalbCWP6icGx
         Ehhw==
X-Received: by 10.129.76.151 with SMTP id z145mr16014317ywa.17.1440904549315;
 Sat, 29 Aug 2015 20:15:49 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 29 Aug 2015 20:15:49 -0700 (PDT)
In-Reply-To: <CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
X-Google-Sender-Auth: QvPo5x64tyk55WZUuvU7h-MCje4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276797>

(Please don't top-post on this list.)

On Sat, Aug 29, 2015 at 11:00 PM, Gabor Bernat <bernat@primeranks.net> wrote:
> Reading after it, I think the most close we can get with this is, awk
> 'BEGIN { print strftime("%c", 1271603087); }; and just ignore setting
> this value (and avoid displaying it) if that fails too. Do you agree?

strftime() in awk is a GNU-ism. It doesn't exist in awk on Mac OS X or
FreeBSD, or even the default awk on Linux (which is mawk on Linux
installations I've checked).

Most portable likely would be Perl, however, that's probably too
heavyweight inside a loop like this, even if called only once each N
iterations.

> On Sun, Aug 30, 2015 at 3:20 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 29, 2015 at 9:29 AM, Gabor Bernat <bernat@primeranks.net> wrote:
>>> Amended, the latest version is at https://github.com/gaborbernat/git/commit/ :)
>>> Does this looks okay, should I create a patch from this?
>>
>> Excerpt:
>>
>>     now=$(date +%s)
>>     elapsed=$(($now - $start))
>>     remaining_second=$((...))
>>     eta=$(($now + $remaining_second))
>>     finish_by=$(date -d "@$eta")
>>
>> Unfortunately, -d is not portable. On Mac OS X and FreeBSD, -d sets
>> the kernel's value for Daylight Saving Time, rather than displaying
>> the specified time as in Linux.
