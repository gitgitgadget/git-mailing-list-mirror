From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 21:28:26 +1000
Message-ID: <BANLkTikQQNoYf=vZwMwAXPu0-S_2s9Y79w@mail.gmail.com>
References: <20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
	<BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
	<20110509081219.GB6205@sigill.intra.peff.net>
	<BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
	<20110509104446.GB9060@sigill.intra.peff.net>
	<BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
	<20110509112428.GE9060@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Mon May 09 13:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJOdc-0008Vy-UA
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab1EIL22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 07:28:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62122 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1EIL21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 07:28:27 -0400
Received: by vxi39 with SMTP id 39so5645566vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/834g30wzGTqcKsBL9rWcij3aSfvW0bawTc4g15OUMU=;
        b=CWDMtL9NpMGWRebE6YVqFPo9nrfo7jA3p8NDcq/cISfZH7865O1IazBRVDyplNSaWB
         3ZOvERuVZ6RNwiBj643F9lxK4gBbE2AgemIOuyvcLsik/B5X8MEEaqtOQvCyUVgiFfDm
         pC2QdEdR4b3MsnX3VoqkRDOmkoeOorxOXZSAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f0os6bbWR3A6v3PB/uC5Wy9/tcRLtJC4bPQgIs4LPGXITz7zZisxqoKIpdccKoby8P
         SkXq0XlbnTF7TY18n/wh+ChUxIEui3nwZfJeey41rj7dgEePZvBaWMBE9ZixQdxosXSH
         6AzZi0s9whxXFSCrQjABfWmIYJfkO9tGUSF/w=
Received: by 10.52.177.196 with SMTP id cs4mr4223158vdc.279.1304940506588;
 Mon, 09 May 2011 04:28:26 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 04:28:26 -0700 (PDT)
In-Reply-To: <20110509112428.GE9060@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173223>

On Mon, May 9, 2011 at 9:24 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2011 at 09:07:31PM +1000, Jon Seymour wrote:
>
>> > I don't really see any need for git's role in this to be more than=
:
>> >
>> > =C2=A01. Check a set list of directories for extra paths to add to=
 PATH and
>> > =C2=A0 =C2=A0 MANPATH.
>> >
>> > =C2=A02. Tell the packager's script what that set list is, so they=
 can be
>> > =C2=A0 =C2=A0 sure to put their files in the right spot.
>> >
>>
>> The problem with presenting a list of possible directories is that
>> given a list, the choice is ambiguous.
>
> Well, yeah. Though between git and the package script, I think it end=
s
> up being simplified to the --system-extension-dir thing, because out =
of
> the three places I mentioned you might want to install something:
>
> =C2=A01. You definitely don't want to install in the distro location.=
 If you
> =C2=A0 =C2=A0 did, then you would be a distro package, and therefore =
would not
> =C2=A0 =C2=A0 have to be asking git where that location is.
>
> =C2=A02. You do need to know where the locally-installed system path =
is, so
> =C2=A0 =C2=A0 we provide an option to query that.
>
> =C2=A03. You don't need to ask git where the per-user path is. It wil=
l be at
> =C2=A0 =C2=A0 some well-known location like $HOME/.gitplugins.
>
> That being said, I think you are more concerned with not presenting
> too many choices to the user. And that still leaves one choice: syste=
m
> (2) versus user (3) install.
>
> But I don't think there's a way around that. You are going to have us=
ers
> of both types, and you will want to serve them. You can make a guess
> based on something like writability of the system directory, I suppos=
e,
> and let them override via the command-line if they want to.
>
> That strikes me as somewhat flaky and unpredictable, but I am perhaps
> not a representative sample. I have always thought the Windows "if yo=
u
> install as Administrator, it is available to everybody, but otherwise=
 it
> is available only to you" behavior was confusing, and this seems like
> the same thing.
>
>> Sure a decision procedure can be arrived at to choose, but it might =
be
>> hard for the user to predict what decision the procedure will reach.
>> In that case, the user must be prompted for a selection.
>
> I think this is in agreement with what I just wrote above.
>
>> Again, part of the idea is to give the extension installer some degr=
ee
>> of confidence that the selected prefix/bin is, in fact, in the path
>> and to give the user an override in case the compiled in default isn=
't
>> workable for some reason (for example, due to a permissions issue).
>
> So from this, I gather you would like to see something like:
>
> =C2=A0$ cd git-work && ./install
> =C2=A0fatal: unable to write to /usr/local/share/git: permission deni=
ed
> =C2=A0You may install git-work just for the current user with:
>
> =C2=A0 =C2=A0./install --user
>
> I.e., the script has a predictable and sane behavior, but you guide t=
he
> user through overriding it if need be. That doesn't seem unreasonable=
 to
> me.
>
> Anyway, with respect to "core.preferredPluginPath", if you do want to=
 go
> in that direction, I don't think any extra git support is needed. You
> can already just do "git config --path core.preferredPluginPath" to g=
et
> the value (with tilde-expansion, even).
>
> -Peff
>

I still think it would be useful for the git wrapper to add
core.preferredPluginPrefix/bin to
the PATH, so that there is no requirement for the user to do this
separately via mechanisms
that will differ according to platform, shell etc.

jon.
