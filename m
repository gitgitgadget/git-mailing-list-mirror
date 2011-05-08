From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sun, 8 May 2011 23:13:35 +1000
Message-ID: <BANLkTinhN0=2NETtOjG_yvubHiZagGB0Wg@mail.gmail.com>
References: <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 15:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ3nw-0008Ay-8a
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 15:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab1EHNNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 09:13:38 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62571 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1EHNNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 09:13:36 -0400
Received: by vxi39 with SMTP id 39so4888237vxi.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r5O2Tj//PtlN0oBveVou6+h7J59LAFRtOoSekM0zdT4=;
        b=aX5S1VwlUbjv289LIci4Wu4Q/l234etPUwgTinti4jdxUUH8pYu+o4Gv+ZjG+MtN/C
         o9RL0FHsEhhvmvJA9hfwRQQLyMhta0Y6/B2e0Zvc2jWpfwIlH53qfxLPa1DYOPKyzlUc
         mwXrue555liSbG2X9tzmmGfkMxhzPukSWh9r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rdqng+Eq0CSM6+x1uZxf7gYFv00rTQPmvBufg4YEKSykZvPItXWIc4WoACaa5Q/MiM
         f9mKH/Ic6u34GHKr8lW8UFa8KyYEf4T5aF+/orXFKPbMotq0eEpUT+DWS8AVydCv9Pm5
         vNt3ofaf2yrSXTRSoIsvikHZgWR4D2zLIUzg0=
Received: by 10.52.94.170 with SMTP id dd10mr1723783vdb.159.1304860415808;
 Sun, 08 May 2011 06:13:35 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 8 May 2011 06:13:35 -0700 (PDT)
In-Reply-To: <20110506065601.GB13351@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173156>

On Fri, May 6, 2011 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>
> But now I am less sure. =C2=A0The motivating example has less than 10
> commands; that doesn't seem worth all the fuss at all. =C2=A0Why not =
just
> install the command on the $PATH? =C2=A0"git help work" _would_ work =
on all
> the systems I have easy access to. =C2=A0For example, if I write:
>

An aspect of the motivational example that I would welcome your
feedback on is this.

git-work is an example of an extension that depends on 3 other
extensions (git-base, git-atomic and git-test).

Similarly:

   git-base depends on git-test.
   git-atomic depends on git-test

It seems that if I am to represent these dependencies, I need to
create 4 * N packages, where N is the number of packaging systems I
want to support.

It is unclear how I make:

    make install prefix=3D/usr/local

work unless the 3 other dependencies have been installed first. If I
need to explain that these 3 other dependencies need to be installed,
then my installation instructions have just become longer.

This seems a shame, since each extension has a dependency only on
other git extensions and git itself. Yet, to provide a workable
installation from source option for my users, I need to either get
them to fetch and build all 4 packages from source, or I need to build
packages for N different distribution managers.

[ FWIW: I recognise that my current proposals for a simple git
--system-extensions-dir don't make this problem any easier to solve,
but I wanted to use the example to demonstrate why a simple make
install script isn't the silver bullet to every installation scenario
].

jon.
