From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 18:06:58 +0000
Message-ID: <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
References: <20100720163822.GA8492@localhost.localdomain>
	<0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
	<7veieym3sh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:07:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHDf-0001bK-JP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0GTSHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 14:07:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59687 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0GTSG7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 14:06:59 -0400
Received: by iwn7 with SMTP id 7so5890826iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U/e6YESElhXn++EhRAngwVG4hyk3IR7qYweUZaUbHeI=;
        b=Rd4aT+rxoq6ZKNzs3K78omeiyCOXkIqn0S0duVn7h43k4rOgt0j7ts6CstaRnw+Eta
         OZfmiA//jjtoM8fknsiSxbs20QESaaBr3ccEsfWMidiR7gYPVR5LsGrXrbDrGX0RwAmu
         FdSs411xYxhX74M39kpOZ3OgYrEq2uzyxIMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nBaEopHeAXGwO6oyTqusHUdRN+UfeR+5kTGS7tmQdJ/9MmAfMP22KOiUmizYdiWT5q
         WDcdbiNNKG9fEjTjERN9P+IbAdzHcfLGm3TQhpoqDmApdWTw1DdkgoM7NWmn7UUY9iAu
         w5Qkm5suAO7I3Okxur3X2S7MpgP35Lr+TdyVU=
Received: by 10.231.35.77 with SMTP id o13mr1466166ibd.92.1279649218472; Tue, 
	20 Jul 2010 11:06:58 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 11:06:58 -0700 (PDT)
In-Reply-To: <7veieym3sh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151340>

On Tue, Jul 20, 2010 at 18:00, Junio C Hamano <gitster@pobox.com> wrote=
:

> =C2=A0 =C2=A0Run a git command and ensure it fails in a controlled wa=
y. =C2=A0Use
> =C2=A0 =C2=A0this instead of "! <git-command>". =C2=A0When git-comman=
d dies due to a
> =C2=A0 =C2=A0segfault, test_must_fail diagnoses it as an error; "! <g=
it-command>"
> =C2=A0 =C2=A0treats it as just another expected failure. letting such=
 a bug go
> =C2=A0 =C2=A0unnoticed.

To add to that:

    Don't use test_must_fail to negate the return values of commands
    on the system like grep, sed etc. If we can't trust that the core
    utilities won't randomly segfault we might as well die horribly.
