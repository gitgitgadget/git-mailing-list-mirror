From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sun, 8 May 2011 14:44:54 +1000
Message-ID: <BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
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
	<20110506172334.GB16576@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Sun May 08 06:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIvrZ-0003ON-UM
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 06:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab1EHEo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 00:44:56 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36274 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1EHEoz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 00:44:55 -0400
Received: by vxi39 with SMTP id 39so4704874vxi.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/0Dgi7ybLY+T5OEWBJutt7MNxm/4YWDJOynznHZEmyA=;
        b=Bzs1LWRynYqYYCTU+WhMHWHINfdDiyln5+yrFdpaDztvxj7Vg7Ta06ROjxL2FlRz3n
         kOHk4rXTV/4hAT+yfpn/3fnYeo24O30e007ii8YfU630gZacZyi/WNcTHe4lPJByN10P
         Oqbd/Oghweh5H7vYGrRwwtX1Plfb1tAXr1hNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ivmJyjYTxoKVFpc9IGEUElaUvJ9YTramnSN2RHXf8eyvuSBYPVxbUv2OnckjbsvwIn
         ZQvmVgqzgg6BqOz0l/rsKOwEPt1RuToYNdbVqb90zlBeRI9Uyh+LJxhow15/CNH+jwEa
         FJ8MxVIkz3U2GlQn0WnLg943BUzurDynstoFQ=
Received: by 10.52.180.164 with SMTP id dp4mr1317810vdc.119.1304829894414;
 Sat, 07 May 2011 21:44:54 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sat, 7 May 2011 21:44:54 -0700 (PDT)
In-Reply-To: <20110506172334.GB16576@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173073>

On Sat, May 7, 2011 at 3:23 AM, Jeff King <peff@peff.net> wrote:
> On Sat, May 07, 2011 at 12:07:14AM +1000, Jon Seymour wrote:
>
>> I think the problem we are trying to solve is this: how to make it a=
s
>> easy as possible to install, and get operational, an extension to gi=
t.
>>
>> If git supported the concept of a standard place to put extensions,
>> then it could be as simple as:
>>
>> =C2=A0 =C2=A0 unzip -d $(git --plugins-dir) plugin.zip
>>
>> with no need to configure or choose a prefix and no need to edit the
>> an .profile or .bashrc to permanently add a directory to the PATH.
>
> This seems slightly backwards to me. You are asking git "where should
> plugins go?" and then putting them there. But that leaves no room for
> plugins going in _multiple_ places. IOW, the usual hierarchy of:
>
> =C2=A01. distribution-packaged extensions (in /usr/share/git/plugins)
>
> =C2=A02. local system-wide extensions (in /usr/local/share/git/plugin=
s)
>
> =C2=A03. per-user extensions (in $HOME/.gitplugins)
>

Actually, that was part of my RFC - how to let git find places where
plugins may be installed.

Your suggestions seem good to me.

> It seems like we should not be asking git, but _telling_ git about wh=
ere
> our plugins are. I understand that you don't want the user to have to=
 do
> any additional steps, and I think that is a reasonable goal. But can'=
t
> that be easily accomplished by:
>
> =C2=A01. The git wrapper learns to look in a set of plugin paths, som=
ething
> =C2=A0 =C2=A0 like:
>
> =C2=A0 =C2=A0 =C2=A0 foreach path in (list of plugin paths)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 foreach plugin in "path/*"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add plugin/bin to PATH
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add plugin/man to MANPATH
>
> =C2=A02. At compile time, we give some stock system directories like
> =C2=A0 =C2=A0 /usr/share/git/plugins and /usr/local/share/git/plugins=
=2E
> =C2=A0 =C2=A0 Distribution packages of git override as appropriate fo=
r the target
> =C2=A0 =C2=A0 system.
>
> =C2=A03. We always check $HOME/.gitplugins by default.
>

All seems reasonable, assuming that there is a consensus that we need
to do something other than recommend installation into /usr/local (or
the platform equivalent) and I am not sure that is a given at this
point.

> =C2=A04. Users can set GIT_PLUGIN_PATH in the environment if they wan=
t to do
> =C2=A0 =C2=A0 something fancy (they can also always just set PATH and=
 MANPATH
> =C2=A0 =C2=A0 manually if they want, too).
>

If the need for multiple plugin directories were accepted, then I
wonder if there might not be some advantages for the configuration of
this path being in git configuration rather than an environment
variable? Again, assuming only git, this would provide installation
helpers with a standard way to make git aware of such directories that
does not depend on the particulars of the platform on which git is
installed.

> This is how many systems already work. For example, look at how vim
> handles plugins.
>
> Distro-packaged extensions obviously know where to go (the packager
> knows their distro's rules). People with personal extensions don't ha=
ve
> to know anything special; their packages go in $HOME/.gitplugins.
>
> In general I would expect /usr/local/share/git/plugins to be pretty
> standard, and not needing of being repeated for admins who want to
> install something system-wide. But if you want to be really thorough,
> then your "git --plugins-dir" should probably report the "system-wide
> but not distro" directory for that (but I would call it something lik=
e
> "git --system-plugins-dir" or something to make it more clear).
>

I think that your suggestion of --system-plugins-dir is a good one for
the reasons you suggest.

> -Peff
>
