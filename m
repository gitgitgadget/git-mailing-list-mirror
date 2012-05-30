From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Wed, 30 May 2012 18:52:15 +0200
Message-ID: <CAMP44s3pKo-Dzg6bTKNmjFsLSYvUfhXfk9NQJxOBTvFekqgrFA@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 18:52:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZm8U-0003gv-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2E3QwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 12:52:18 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54515 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab2E3QwQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 12:52:16 -0400
Received: by lahd3 with SMTP id d3so20368lah.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=I+t2dsUdkvzgJtVO3AM9qXEWqc5+W+QBTa7aK4MdH/g=;
        b=vyqF1Au+vFQM12TVhc0BT6oI/+j9ExLJpssfHHsgOeZVNtac5NkmD/CTTm4TYdUHgj
         9c0RrFIOT4SipW2ZPpkhYd0uQY35GCm1dEIqV9M9OsIe66qwggIQy5QiEkZNtNmD+oTv
         nXRGOZBZ1lbudjUCQRMX1OB3Bf33ucv8vCKSaHXEw6GqqxeoB5K1saOptKrR/LG5HdAb
         srvhMCeA4X+KjnGBqKLABnRpNs0EUh94chYK1k2s1AUJWKqzhq5kPxB+SzlyLUhANyNa
         EFy0dOz2qFDeqXfyyIqWQnH7/GvgICFC2INO1+sauK0vRXRQ21hkC9LDd9+DCGP/F7QM
         ITVw==
Received: by 10.152.125.116 with SMTP id mp20mr16253350lab.19.1338396735195;
 Wed, 30 May 2012 09:52:15 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 30 May 2012 09:52:15 -0700 (PDT)
In-Reply-To: <20120528062026.GB11174@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198817>

On Mon, May 28, 2012 at 8:20 AM, Jeff King <peff@peff.net> wrote:

> There are also even more complex cases. It doesn't make much sense to
> ask about where branch Y split from master, since it actually came fr=
om
> branch X in the above example. But let's say we branched straight fro=
m
> master, merged our result to X, which got merged to master, and then =
we
> built some more commits on Y and merged them to master. Like:
>
> --X--A--B--C--D----E--F (master)
> =C2=A0 =C2=A0 |\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 | \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 =C2=A0\ G--H----I =C2=A0/ =C2=A0(branch X)
> =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 / =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L--M--O =C2=A0(branch Y)
>
> The only merge between master and X is F, but its merge base is M. We
> missed the earlier merge to master because it actually happened acros=
s
> two different commits.

I assume you mean the merge between master and Y.

--=20
=46elipe Contreras
