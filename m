From: David Aguilar <davvid@gmail.com>
Subject: Re: git alias question
Date: Thu, 29 Dec 2011 17:59:58 -0800
Message-ID: <CAJDDKr5a8TB82h4ULWtamLOVu_4Fv+cGw1YfEL987gM3yM4TMg@mail.gmail.com>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
	<CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Horowitz <michael.horowitz@ieee.org>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 30 03:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgRlr-0003Xi-6j
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 03:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab1L3CAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 21:00:00 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54188 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1L3B77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2011 20:59:59 -0500
Received: by yhr47 with SMTP id 47so8350872yhr.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 17:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DzOYwV5tG2nsXvDKuAUIp+SCKCpbifUdjgfRQSH3Wvc=;
        b=pdgDwH4OSAXzpYGXgieVH+Npsids/y61cTrzenroFw5a5U7iO4VGMinpJ7VjBATwN+
         oN4jgzB+XJTLKowemng3QhflIpxTTXrEEzLa1b6mLqYXp8NwG/42quQisxBQh9KW1Uao
         QD4biTLNnRdXHDGvThrXV+A6KVDmGyjodUehU=
Received: by 10.236.181.136 with SMTP id l8mr49092110yhm.103.1325210398990;
 Thu, 29 Dec 2011 17:59:58 -0800 (PST)
Received: by 10.146.243.7 with HTTP; Thu, 29 Dec 2011 17:59:58 -0800 (PST)
In-Reply-To: <CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187790>

On Thu, Dec 29, 2011 at 9:08 AM, Dave Borowitz <dborowitz@google.com> w=
rote:
> On Wed, Dec 28, 2011 at 17:27, Michael Horowitz
> <michael.horowitz@ieee.org> wrote:
>> ldiff =3D "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
>
> FWIW, you can also do this as:
> =C2=A0ldiff =3D log -p -1 --format=3Dformat: --
>
>> ldifft =3D "!git difftool `git rev-list --reverse -n 2 HEAD -- $1` -=
- $1"
>
> I don't know that you can do something equivalent with difftool. I
> suppose you could do the above with "GIT_EXTERNAL_DIFF=3D<some diffto=
ol
> wrapper> git ldiff", but that's not very helpful.

difftool cannot be driven by log right now.  It is something we
thought would be helpful in the past:

http://thread.gmane.org/gmane.comp.version-control.git/114269/focus=3D1=
14367

On 2009-03-23 Junio C Hamano <gitster <at> pobox.com> wrote:
> Perhaps we would want a convenient way for "log -p" or "show -p" to d=
rive
> difftool as a backend?

I think that's exactly it.  difftool wraps diff; a log equivalent
would be quite helpful.

One idea is for difftool to learn a "--log" option to make it wrap log
instead.  I don't know if a diff-like command having a "--log" option
is ideal from a consistency-of-user-interface POV so I'm open to
ideas.  It is convenient, though.  It does seem like difftool would be
a good place to expose this feature.

I'd be interested in the "teach log / show -p about GIT_EXTERNAL_DIFF"
route, if that sounds like a good idea.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
