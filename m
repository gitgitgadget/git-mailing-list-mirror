From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 17:49:27 +1000
Message-ID: <BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
References: <4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 09:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLDp-0007hK-EH
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 09:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1EIHta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 03:49:30 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39070 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1EIHt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 03:49:28 -0400
Received: by vxi39 with SMTP id 39so5472478vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BgjX3Pj0Dv9OniIzdBbGZArxE+iGNhfyFndCg6hPFfI=;
        b=h2ybhdnycGb71vyUsloD734ZWv2RheujdpFoV/Ql9CUAo5/mSNVPSfWCU+ZdVG2tDs
         wkensgzRPnvg6z3WzL/mfLv96+gReaRsd7Mp0lKlarm1toWP3GpbiWqMQx/SexqInHUv
         5vEzhWiqEpt/zpwYP9J4JbiL6vJuG9s8jiV5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wjMzV+UsonG0gPHfLqgPajtZN/m27smVKWHL2S16Ke8WlYnwJXpkLgoCvRYypYADzh
         fVm8jZBdskxU0dL+QG5GL5Z6YrRFQlYK+Qt8duIWMaUxK/BqqmbdovrFJP70PWh4VGno
         4E+l6xRupaoxPJDZGdbofCv+Fho1VSXD3bpa4=
Received: by 10.52.71.148 with SMTP id v20mr4000636vdu.266.1304927368015; Mon,
 09 May 2011 00:49:28 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 00:49:27 -0700 (PDT)
In-Reply-To: <20110509073535.GA5657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173201>

On Mon, May 9, 2011 at 5:35 PM, Jeff King <peff@peff.net> wrote:
> On Sun, May 08, 2011 at 02:44:54PM +1000, Jon Seymour wrote:
>
>> > =C2=A04. Users can set GIT_PLUGIN_PATH in the environment if they =
want to do
>> > =C2=A0 =C2=A0 something fancy (they can also always just set PATH =
and MANPATH
>> > =C2=A0 =C2=A0 manually if they want, too).
>>
>> If the need for multiple plugin directories were accepted, then I
>> wonder if there might not be some advantages for the configuration o=
f
>> this path being in git configuration rather than an environment
>> variable?
>
> I think in general most users would not need to set this (since after
> all, the point of your proposal is to avoid such tweaks), so it may n=
ot
> be worth troubling about. But it is much simpler to tell users to run=
:
>
> =C2=A0git config core.pluginpath /path/to/wherever
>
> than trying to figure out whether they need to use bashrc, cshrc,
> whatever Windows uses, etc.

Yep, that was part of the motivation for the suggestion - something
that works consistently, assuming only a working git installation.

Per one of my other notes, my initial inclination is to provide a
patch that implements support for

     git --system-extensions-dir

which would:
   - provide the caller with location that extensions could be
installed in (assuming the caller can acquire write privileges)
   - provide a guarantee that $(git --system-extensions-dir)/bin will
be on the path set up by the git wrapper and $(git
--system-extensions-dir)/man will be in the MANPATH searched by git
help

Extensions could then use this information, together with git
--html-path to install themselves into these places using whatever
mechanism seems appropriate (either a POSIX shell script or a
make/install script).

The default value of git --system-extensions-dir could be supplied
during the build and might naturally default to the build prefix, but
distributions and other builders could specify an alternative.

An enhancement to this would then allow core.system-extensions-dir to
override the compiled in version.

Anything wrong with this so far?

jon
