From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 17:29:30 +0200
Message-ID: <BANLkTimDLJRSA=o6FNH=kpbKMCKEEF48OA@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinR0F3Pja1DspCGjBsbpgcBhm4=vQ@mail.gmail.com> <20110519151425.GA7570@elie>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Gieschke <rafael@gieschke.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 17:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN5Ai-0001kG-JS
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 17:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab1ESP3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 11:29:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56957 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1ESP3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 11:29:50 -0400
Received: by pvg12 with SMTP id 12so1235713pvg.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LpEbheGc989VVY5zTSSPWvVGH/q+FjrucAhSdn4Eh1Q=;
        b=wWr7HNU0F0qQGL+3A+O+7X7EqJL0UsTXOKaya0deNmXbgj6DYJ+/ZqXqI+72dXzDgl
         bU5kiz0/e6soSng4/sMgQNjbtfrsK1e0m3oFofDpQlqLu3cYNup7SpEzgXNEUGm2QQdj
         nk2HjTae3WSGe8yU3v8Q/B1nEaGhGWMxXcHh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=WeXJFwk991w9hnKjBknvnD32Oi2CgREMTmTxUl4kjRhc+NODE0+/686hP/M1cYD6l/
         +CaU2o/CdjbTNtH2zhUSPnhPbGcc0UcLYMybGlf+CEE3kudGN1WFdWETs+nI0ox+8jqt
         Y0fu9dmchBny7Z9Fm3xTLkxZUOwMvE2+4gCTs=
Received: by 10.68.20.233 with SMTP id q9mr5387263pbe.299.1305818990071; Thu,
 19 May 2011 08:29:50 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 08:29:30 -0700 (PDT)
In-Reply-To: <20110519151425.GA7570@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173963>

On Thu, May 19, 2011 at 5:14 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>> On Thu, May 19, 2011 at 1:37 PM, Rafael Gieschke <rafael@gieschke.de=
> wrote:
>
>>> + * 2. Redistributions in binary form must reproduce the above copy=
right
>>> + * =A0 =A0notice, this list of conditions and the following discla=
imer in the
>>> + * =A0 =A0documentation and/or other materials provided with the d=
istribution.
>>
>> How do we plan to adhere to this clause? I guess all
>> package-maintainers could explicitly add this to their release notes=
 /
>> documentation, but they will have to know that they should. I don't
>> think every package maintainer read every patch in-depth enough to
>> notice this.
>
> The vcs-svn/ directory is also under a two-clause BSD-style license
> for what it's worth. =A0To give a vague summary of requirements from
> different parts of the code base[1]:
>
> =A0. COPYING requires a copy of the GPLv2 to be distributed along wit=
h
> =A0 the binaries and for the corresponding source code to be accessib=
le
> =A0 from the same place (or a written offer under some circumstances,
> =A0 etc)
>
> =A0. xdiff's license requires a copy of the LGPL (version 2.1 or late=
r)
> =A0 to be distributed along with the binaries, unless your copy of th=
e
> =A0 license notice is altered to refer to the GPL. =A0Likewise for
> =A0 compat/fnmatch, compat/regex, and compat/strtok_r.c.
>
> =A0. vcs-svn/LICENSE the license to be distributed along with any
> =A0 binaries. =A0Likewise for compat/inet_ntop.c, compat/inet_pton.c,
> =A0 compat/nedmalloc/*, and contrib/fast-import/git-p4.
>
> Maybe we should provide a file NOTICES with all the required notices?
> I admit I'm happier sticking to the line "Please grep for
> '[Cc]opyright' for detailed distribution terms. =A0If you ship the
> corresponding source code with your binaries, you're probably in the
> clear."

Having a file like NOTICES that contains all explicit copyright
notices required sounds like it will help package maintainers. But it
can also make them lazy and blindly copy the file, which can lead them
in (probably very minor) legal problems if we forget to update it.

This was the first instance I noticed that explicitly require a
copyright notice other than GPL (except for LGPL, which I for some
reason just assumed was covered by the GPL text), which is the reason
why I mentioned it. Examining every single source code before every
single release seems a bit kludgey, but perhaps it's the best thing to
do.

> I suppose based on a strict reading we ought to have a copy
> of the LPGL 2.1 in the source tree, though... =A0Maybe something like
> this can help.
>
> -- >8 --
> Subject: provide a copy of the LGPLv2.1
>

I'm a bit baffled that this is required for a GPL-program. But since
it apparently is, I think this makes sense.
