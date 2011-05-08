From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sun, 8 May 2011 17:42:23 +1000
Message-ID: <BANLkTimEMkpm9HFGmdvK4-3Pp=AKbXNRrw@mail.gmail.com>
References: <7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506141719.GA2991@elie>
	<BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
	<20110506145036.GB2991@elie>
	<BANLkTimdS7vs71vEVTxutvyp3rC4KxPjMA@mail.gmail.com>
	<20110508064902.GA12868@elie>
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
X-From: git-owner@vger.kernel.org Sun May 08 09:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIydK-0007NS-LF
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 09:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab1EHHmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 03:42:25 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35274 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1EHHmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 03:42:24 -0400
Received: by vxi39 with SMTP id 39so4760358vxi.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M4Ub5z1ddvA+hYEx+oEbqABcsvkxmHHZUChu/n1DJnQ=;
        b=DcE0voQ0sjoKfC7OKPyrawS4atNoOXkYBwnVXEa63HaJesqrIYWiPOAEQmjMOXiaUI
         M+fja8mhojHL04ybVmDK/yaSGNMsz0wUr7DDEocGlIQrLzpPgeejUhL515GiDaXTVAoL
         VI6KRb/YUj60RuvfGZPk708eVQ5oKvLYDIWiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HUOIj74kaMgLJdt8JibU5rujvn1wH5pcNGamMGib8GF8yNH01tekESbseeJBhcbmlU
         ZQ5VGj/0uTYv7SBQ8OC9nByx68qRh0gJH8P+aH2XveihS4+SVKSZOSqeGFT/b97AdsNo
         dLNsnRKPLRVTZ1RXBA3a/OHnQ8zi4pz6jO8v8=
Received: by 10.52.169.135 with SMTP id ae7mr1922189vdc.79.1304840543524; Sun,
 08 May 2011 00:42:23 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 8 May 2011 00:42:23 -0700 (PDT)
In-Reply-To: <20110508064902.GA12868@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173078>

On Sun, May 8, 2011 at 4:49 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Jon Seymour wrote:
>
>> The idea isn't to replace standard operating system facilities for
>> application installation. The idea is to provide a uniform interface
>> for accomplishing the rather limited task of extending git that can
>> work the same way, irrespective of platform, irrespective of file
>> system layouts, irrespective of assumptions about which directories
>> are already in the user's paths.
> [...]
>> If at the end of the day, we say make and install are the way to do
>> it, then fine. However, this makes the dependencies for a successful
>> install strictly greater than the existence of git and a POSIX shell
>> which we can assume if git is already installed.
>
> Thanks for explaining, and sorry to have given so much grief by not
> understanding.
>
> If this whole conversation were about how to add a new menu item to
> git gui, I would have understood completely. =C2=A0Having to figure o=
ut how
> to get something in a directory listed in PATH would be undue
> complication.
>
> After going in circles a few times, I think you're saying there are
> also some people using git on the command line for whom "make
> prefix=3D<whereever> install" won't cut it. =C2=A0With such a person =
in mind,
> what you're trying to do makes sense --- and why not do it, when it
> will bring some other benefits as a side-effect, like the ability to
> add new commands without them showing up in git-<TAB> tab completion?
> So I'll be quiet now.
>

Admittedly, I think there might be concrete advantages in making at
hard as possible for such users to get anywhere near a git command
line, but hey, I work in an environment where ClearCase looks like a
reasonable option to some people :-)

Your point about support for extension supplied HTML is an interesting
one, that I don't think I have an answer for other than an
installation script that is aware of git --html-path. The reason is,
you want links to descriptions of core git commands to just work in
such html, and the only way you can get that to happen reliably is to
install in some directory that is strictly relative to the location
that git's own HTML is stored in.

So, in the end, I think I would be happy with a solution like:

    git --system-extensions-prefix

which answers the recommended prefix for the installation of
extensions. This might default git's own prefix, but may be configured
differently by distribution or builder preference. If we did allow it
to be different to the git prefix, then I think the git runtime would
need to be extended to allow $(git --system-plugins-prefix)/bin to
appear in the path, and then use the existing gt help mechanisms to
find the
man pages.

Would a patch along these lines be acceptable, do you think?

jon seymour.
