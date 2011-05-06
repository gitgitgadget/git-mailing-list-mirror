From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sat, 7 May 2011 00:29:58 +1000
Message-ID: <BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
References: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506141719.GA2991@elie>
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
X-From: git-owner@vger.kernel.org Fri May 06 16:30:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIM2f-0000CL-FM
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab1EFO37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 10:29:59 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54410 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1EFO36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 10:29:58 -0400
Received: by ywj3 with SMTP id 3so1176150ywj.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EwX0fw5ULxB2fStfJxln7jjWA1P3jcvadC5CYugdkjE=;
        b=Kjdhip3oVQZyCoJXkb2ESyb80LInrkyjZ70SGUDU5aO65wX2QdbsTl0GqbzQgGIumo
         4UURT9bDDF95aUd7BjAiGD1EpoL8b+CdHSnudLKG1cmUY/eucHk9pLG2OC3oHpI906V6
         tIvknqzYjWUAl1AQ0l7nMVKwaKdYSIOFNzQqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1AAJzUTuit9dMquD3ozYh06rHISwCldgwiwr0FDSZK4XW9nt9PE3fcyP7/V21DGkV
         yJ9BVTh3iZNB/xEFaXxaZym5ixeie5LmsGR/iBhjufxNpUpv76Spz/DkroYT16zu22te
         2wdI+mWKXCFJapgMRKXF5a4hXnmgIF1SUdGG0=
Received: by 10.52.177.196 with SMTP id cs4mr1035129vdc.279.1304692198228;
 Fri, 06 May 2011 07:29:58 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Fri, 6 May 2011 07:29:58 -0700 (PDT)
In-Reply-To: <20110506141719.GA2991@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172977>

On Sat, May 7, 2011 at 12:17 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jon Seymour wrote:
>
>> If git supported the concept of a standard place to put extensions,
>> then it could be as simple as:
>>
>> =C2=A0 =C2=A0 unzip -d $(git --plugins-dir) plugin.zip
>>
>> with no need to configure or choose a prefix and no need to edit the
>> an .profile or .bashrc to permanently add a directory to the PATH.
>
> Why not use "/usr/local" in place of "git --plugins-dir"? =C2=A0(I ca=
n
> think of one answer --- namely root privileges --- but it would apply
> to any system with one standard place to put extensions.)
>

Partly because that is second guessing &/or reverse engineering the
distribution's decisions and
it won't work for a Windows install where there is no /usr/local

Not that I currently, have a need, but Junio did mention the case
where someone wants to enhance an existing git command with a wrapper
of some kind. This could be done more precisely if git itself
controlled the relative order of the path components than if one
relied on /usr/local being in a particular place in the path.


jon.
