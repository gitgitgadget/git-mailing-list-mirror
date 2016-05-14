From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Sat, 14 May 2016 12:17:32 +0100
Message-ID: <20160514111732.GF2345@dinwoodie.org>
References: <20160513134953.GE2345@dinwoodie.org>
 <xmqqinyhaoxn.fsf@gitster.mtv.corp.google.com>
 <998a4fcd-ecd8-7e0c-860e-7f12ec02b1f9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 14 13:18:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1XaG-0002DF-41
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 13:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcENLRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 07:17:37 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35185 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcENLRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 07:17:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id e201so49621596wme.0
        for <git@vger.kernel.org>; Sat, 14 May 2016 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FXfZW3+iNKi7iKL0mL/0IRSZNWWvDRECe6F7Ed2kvvw=;
        b=tPbhzIkrZc7gGDPRY14Sb0Bg78b8JAb697MUAOp5WKO1mwJ20mhqXWdakS9daNYQjg
         r6+JRbWb5oVyDvPft7kojIwjyyiy4tj+cTuW0KcbFBYRLAvHFF+bsHIxkPdGI7O+RY2X
         55AOWX5NasfpJeMmoIgvJQ+Go1yDLkS0LFnW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FXfZW3+iNKi7iKL0mL/0IRSZNWWvDRECe6F7Ed2kvvw=;
        b=UPcKSS3r5CsnTlLfXZMBWv2QZ2Rz1ai7C4XT6R1cpKfwUoR6Im56bzuTBqrCdnnCVh
         aEDAN87GeqQKzkKqodgnoKQFMf1Ii5LlGgPBwCjgnrqRi09aeac2Ct4AfAKFzF0zqRRE
         G7ZmydYZWKAyEoAjcjZb+BKOLnIYYwnOBi8DCElV3lCafAa2UlKg8IfZ5HTzwkRXvsGS
         3X60/I9BOOgrjplr8fCnTfrRyKMY3DNgqn77FOgX4fYp8BpI0kobUSx/3WSHvdswbjGf
         hkWiLJF12pyQ3d20q1s4DFMvj7NbQBDfXVFeTcuMvdNmtlJnVftzEEJqTvQrXQoFapIC
         9aHw==
X-Gm-Message-State: AOPr4FVQMaBjDcSo3f+yi1TgBKL98ugYT7MigPe+Sf/wR06zRCMrho9NsrsRIhCUmQ1apA==
X-Received: by 10.28.102.8 with SMTP id a8mr8501853wmc.54.1463224655302;
        Sat, 14 May 2016 04:17:35 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id i1sm20122562wjm.12.2016.05.14.04.17.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 14 May 2016 04:17:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <998a4fcd-ecd8-7e0c-860e-7f12ec02b1f9@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294607>

On Sat, May 14, 2016 at 07:40:11AM +0200, Torsten B=F6gershausen wrote:
> On 13.05.16 18:43, Junio C Hamano wrote:
> > Adam Dinwoodie <adam@dinwoodie.org> writes:
> >=20
> >> If you use .gitattributes to enable CRLF->LF rewriting, then commi=
t a
> >> file that would have its line endings rewritten, the "CRLF will be
> >> replaced by LF" warning is printed several times over; I'd expect =
it to
> >> be printed only once.
> >>
> >> There's a test case in t0020 -- "safecrlf: print warning only once=
" --
> >> that checks the warning is only printed once when using `git add`,=
 but
> >> nothing that seems to check the same thing on `git commit`.  The
> >> unnecessary multiple warnings seem to have existed since at least =
v1.6.0
> >> (the warnings appear to have been added in v1.5.5 in 21e5ad5, but =
I
> >> couldn't get that to build on my current box), and I'm seeing them=
 on my
> >> Cygwin box's build of the current next branch (d10caa2) and on my =
CentOS
> >> box's v2.8.1 release.
> >=20
> > Torsten, I know you are not heavily invested in "commit" codepath,
> > but since you've been actively touching the CRLF area, I wonder
> > perhaps you might be interested in taking a look?
> >=20
> I have seen this double warning as well, but never digged further,
> as it is most probably in the code outside convert.c
>=20
> I can put it on the TODO list, and I think it would make sense to add
> a TC in t0020, which is marked as test_expect_failure.

Grand.  I'll submit the test patch now.
