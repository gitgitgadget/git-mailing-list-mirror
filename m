From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Reusing changes after renaming a file (Re: [PATCH 5/6] sequencer:
 Expose API to cherry-picking machinery)
Date: Sat, 13 Aug 2011 23:50:42 +0530
Message-ID: <CALkWK0mDdYTahhDx9_7-4AP8iuvkWMu1wHhQnmUcatEXiDiuTA@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com> <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
 <alpine.LNX.2.00.1108131215170.2056@iabervon.org> <CALkWK0=seEY+O8qmNKoPyYPW-QT9zpwGsh8SB89qcd6kUQRdKg@mail.gmail.com>
 <20110813175012.GD1494@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 20:21:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsIpa-0006s7-SB
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 20:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab1HMSVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 14:21:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64160 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1HMSVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 14:21:03 -0400
Received: by wwf5 with SMTP id 5so3772482wwf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4r5F2IH3PzyT7k6/kLI75DWyTUycIeI+p39uhzlsFZk=;
        b=JaaooX44x5MgStAX8Fl07Th7IDXqV4Qf9xU1174NYO3zIxWH9oj3y8P2f70Owmf+6I
         jMp/8K05sqojdRjmwVBdWbU5tChl6FGY2z0Wl+xFmN0oIhJUwfyDEv6SZVv2ESqNC29Y
         BTAtLYBAjj3SsJ7trCDJ35hU4MeqXon+KY8cY=
Received: by 10.216.175.130 with SMTP id z2mr1438193wel.63.1313259662064; Sat,
 13 Aug 2011 11:21:02 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 11:20:42 -0700 (PDT)
In-Reply-To: <20110813175012.GD1494@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179287>

Hi Jonathan,

Disclaimer: I'm sorry if I sound incredibly stupid.  I know nothing
about how the diffing algorithm works.

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Hm, I was actually thinking of a much less ambitious helper that wou=
ld
>> kick in when the heuristic correlation between two files is above a
>> certain threshold.
>
> Doesn't that already work? =C2=A0For example:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick -Xrename-threshold=3D50 fo=
o

Okay, I'm still trying to figure out what this does.  It's supposed to
"influence the rename detection" according to the 1.7.4 release notes.
 I tried:

$ git cherry-pick -Xrename-threshold=3D90 sequencer~1
[test 7400609] sequencer: Expose API to cherry-picking machinery
 3 files changed, 256 insertions(+), 1247 deletions(-)
 rewrite builtin/revert.c (81%)
 rename builtin/revert.c =3D> sequencer.c (81%)

Is it supposed to influence the diffstat?  I don't see any conflict
markers in sequencer.c.  I can see lots of unintelligent (and useless)
conflict markers in builtin/revert.c.  What am I supposed to be
looking at?

-- Ram
