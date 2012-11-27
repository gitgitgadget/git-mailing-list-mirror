From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 02:38:01 +0530
Message-ID: <CAMK1S_g-1oqjXAekXyBy6UBxbo-LHWtG_49YHSVsKJKezcLR_w@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
	<20121127183530.GB11845@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 22:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSOC-0008SQ-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab2K0VIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 16:08:04 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50535 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2K0VID convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 16:08:03 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so7039594lbb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Nz2Qqn3U6TRCq3p/Xehz3Ul/rhMleP6+EPtzu8skEl0=;
        b=RuAYaUoiHwyfkyHxf1iyyXNHFVyy5aOZcMp7bTuabUJVAMfcj/oE9e9dpj1GJXhRqL
         DNyUkp1sL2v+1K4Uof5BuKrkFAQSl8ZcPFWkk5asFzq8FMiBCAbDrqEq31BNkvQipz4N
         jn48EqMMONy3cD9hqxgwsfAaYrs+Wcp9GCmd2/di6oXVi+8wlafl4LpCLNLUfKLb5RZr
         j8JfOe5IuQkvSdjxQTdLk13RkgamD/RT6z9OBWNnp0UxfTovEZoPImGyuLC4BSWuFiT9
         y0za1cYhSxlPERfpMUfctQeebVyajHLX1QF/R3PQMVTTfjXczOYHlMg30KmP1FdzstrM
         v96w==
Received: by 10.152.104.50 with SMTP id gb18mr16269750lab.9.1354050481930;
 Tue, 27 Nov 2012 13:08:01 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Tue, 27 Nov 2012 13:08:01 -0800 (PST)
In-Reply-To: <20121127183530.GB11845@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210596>

On Wed, Nov 28, 2012 at 12:05 AM, Eric S. Raymond <esr@thyrsus.com> wro=
te:
> Magnus B=C3=A4ck <baeck@google.com>:
>> While "constant traffic" probably overstates the issue, these are no=
t
>> theoretical problems. I recall at least three cases in the last year
>> or so where Git has seen breakage with Solaris or Mac OS X because
>> of sed or tr incompatibilities, and I don't even read this list that
>> thoroughly.
>
> This is exactly the sort of of pain experience would lead me to
> expect.
>
> OK, this is where I assume the full Old Fart position (30-year
> old-school Unix guy, author of "The Art of Unix Programming", can
> remember the years before Perl and still has sh idioms in his
> fingertips) and say "Get with the 21st century, people! Or at least
> 1990..."
>
> As a general scripting language shell sucks *really badly* compared t=
o
> anything new-school. Performance, portability, you name it, it's a
> mess.  It's not so much the shell interpreters itself that are the
> portabilty problem, but (as Magnus implicitly points out) all those
> userland dependencies on sed and tr and awk and even variants of
> expr(!) that get dragged in the second you try to get any actual work
> done.

Not always.  There are several situations where a shell script that
makes good use of grep, cut, etc., is definitely much cleaner and more
elegant than anything you can do in a "propah" programming language.

If the price of doing that is sticking to a base set of primitives,
it's a small price to pay, not much different from sticking to python
2.7 or perl 5.8 or whatever.

Shell *is* the universal scripting language, not perl (even though we
all know it is what God himself used to create the world -- see xkcd
224 if you don't believe me!), not python, not Ruby.

--=20
sitaram
