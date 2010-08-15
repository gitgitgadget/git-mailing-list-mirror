From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Update compat/regex
Date: Sun, 15 Aug 2010 11:08:01 +0000
Message-ID: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
	<20100715220059.GA3312@burratino>
	<AANLkTimQZDT3PuiLDdjPXzWlLiEI5Iv1zy5iFPlRswyC@mail.gmail.com>
	<m2630fqzn1.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Aug 15 18:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkgGD-0008Cs-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 18:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601Ab0HOQkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 12:40:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57778 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab0HOQka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 12:40:30 -0400
Received: by iwn7 with SMTP id 7so794052iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ao18kfYkO//MXQ21xIWFlbeTcPJcvn65uQwmvJbmxU=;
        b=fQsQ8Fec+EpPwJyvsF7wvqlmibHT5oA27F8KyutKf1JTMgvYqy4w2stkyG+Yf4Dyg7
         X/t6xTM0P5FXmEg28d/MZocwo7zhj09lbHg0kezcvxnUQ5OLSE2M/v2z4TgT2pmLJviw
         RzpW6EEghZr13eieclf3B9ZZAoRhP9/kSTa/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JMXpV7OD9jXIQ214QUc0E7WKL1um3PaGGrkTl+iBvuoLOjMp7jGhoge5xQG+MZt5PV
         QnKCJ4wsZPOLw3w9Hv/A4AoITbQHgqcLTgrZOlsG5GhXb7vT7x8kSwcLhAxGJsdjEM/s
         pobkNzXygkKp8olS10uPSVpJGr0igo9J1tizk=
Received: by 10.231.12.77 with SMTP id w13mr4099201ibw.129.1281870481774; Sun,
 15 Aug 2010 04:08:01 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 04:08:01 -0700 (PDT)
In-Reply-To: <m2630fqzn1.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153611>

On Fri, Jul 16, 2010 at 14:17, Andreas Schwab <schwab@linux-m68k.org> w=
rote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This patch has all the glibc-specific stuff that makes it break hard
>> if you don't have the GNU C library. Writing macros/definitions to f=
ix all that
>> stuff up was the "easier said than done" part I was referring to.
>
> You might want to try out the gnulib version instead.

I fiddled a bit with gnulib for both the regex engine and libintl, but
I can't get it to do what I want.

The assumption with gnulib seems to be that you're including the
libraries in a GNU program that only uses the autotools, it seems to
be about as easy to just copy/paste things from glibc if you're adding
libraries to a program like Git that uses its own build system.
