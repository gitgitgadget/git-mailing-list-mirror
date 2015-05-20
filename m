From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Tue, 19 May 2015 21:10:23 -0700
Message-ID: <20150520041017.GA91560@gmail.com>
References: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
 <1431638653-9356-1-git-send-email-szeder@ira.uka.de>
 <CAHGBnuNvTZ27CCquHHtC5bQFkG2k-+SDYw-6U2TRzzHyFiFwJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 06:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuvKz-0007Q7-P9
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 06:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbbETEK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 00:10:29 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36659 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbETEK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 00:10:28 -0400
Received: by pabts4 with SMTP id ts4so51472591pab.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 21:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9h+LoNjR7qciChAKfSzAFSUH8AVtaDf9fb1qzs4+Xzc=;
        b=VqFDz5xss8guPOkoFrkHoFQGnZ6eOpiKb+GKso/SAXki7q8pQeGrUuBlqY2pnyshs1
         ikLqs/+7MEAnoQIdK1W8N4+f5R0GeaZZ1lCJV8Ccd/Ycm2O/Wi7js6CDLwFHjMz+XTzc
         bgIlQTzjBKfpBMXOKLikg7LxqTtnZKUM5TK4XnS2Yvw6KFuhA2A+OWSksGhOogD8sxPH
         gMLRbiUtxnjb8OxIlO/sxIUfxfaeMSQKhS/kH6IiaPtv0Hyv6+xFWs8ntn41d5hyInZP
         dEUBnuNvHEmPzcMl4DPpUzZhxkWVdAHK6bzfEq7YQVUFmT+WE+KM5C875LuLJ6aTapjP
         F+fA==
X-Received: by 10.68.57.200 with SMTP id k8mr34371385pbq.61.1432095027396;
        Tue, 19 May 2015 21:10:27 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id i1sm4423421pdm.19.2015.05.19.21.10.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 21:10:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHGBnuNvTZ27CCquHHtC5bQFkG2k-+SDYw-6U2TRzzHyFiFwJw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269436>

On Fri, May 15, 2015 at 07:40:53AM +0200, Sebastian Schuberth wrote:
> On Thu, May 14, 2015 at 11:24 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>=20
> >> $ echo "$PROGRAMFILES(X86)"
> >> C:\Program Files (x86)(X86)
> >>
> >> So it seems to resolve only the $PROGRAMFILES part and appending t=
he
> >> literal "(X86)". Not sure how to tell Bash that "(X86)" is part of=
 the
> >> variable name.
> >
> > It would be ${PROGRAMFILES(X86)}, but POSIX says that variable name=
s can
> > only contain alphanumeric characters and underscores, and Bash adhe=
res
> > when it complains about it in Johannes' example above.  Not sure wh=
ether
> > there is a clever escaping that could make it work, I couldn't find=
 any.
>=20
> Right, I did already try that curly-braces-style of quoting, and
> MSYS1/2 both give:
>=20
> $ echo ${PROGRAMFILES(X86)}
> sh.exe": ${PROGRAMFILES(X86)}: bad substitution
>=20
> I couldn't find any other style of quoting that works, either.

How about simply "$PROGRAMFILES (x86)"?

Let the shell handle the programfiles part, and then it'll
concat the (x86).  That's what's on the filesystem anyways, so
it should DTRT.  I'll send this in patch form shortly.
--=20
David
