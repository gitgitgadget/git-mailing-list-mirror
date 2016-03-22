From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Tue, 22 Mar 2016 09:47:15 -0700
Message-ID: <CAGZ79kaASKUGs3y9YHUp=QeD=91by4DhJh+tVfj6aNOJSH-3jg@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-5-git-send-email-sbeller@google.com>
	<CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
	<xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:47:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPSj-00052v-SX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbcCVQrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:47:17 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35236 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcCVQrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:47:16 -0400
Received: by mail-yw0-f181.google.com with SMTP id g127so261802198ywf.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=60gG8TGa5fT4ZCR8MCwa8sN7zBeIrYPbQ9c22SLUR4c=;
        b=a/Q2Y4tVE1DomxoOX//qHLSXyVSM1EIsGLeEvRR/lUgl+LviQlxA7SSaNH9B7S2Zr8
         yVo2Exjk5D2O23fq0Yqud69yRbJMAaTPi6h6YZht2d1GSdP38EXQRNwU4oYKb98NVusB
         o5IVSiAm0vP9UyKlLs5+zlng/JGvkEGiLU4+GyilnpYWWMN2qytOIbQIXxR2OmLcQG55
         yk9SzJKVmO3Mh2lMluAXONPQ8/4pc8N/89TxShqiUPuxuEjmA/wm2sy0NVDpfwHNZKiK
         ASMUmaCJvctQFLSo/cEPSmFRYXAGeL8epTCcY6KhvCX8HBxjg4LWTRIJdnYuY01wbrnq
         ga9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=60gG8TGa5fT4ZCR8MCwa8sN7zBeIrYPbQ9c22SLUR4c=;
        b=FUVlT3psHm4RC8l+Juj5q5cw1GrJ+yIYpQW67eWQQPPaJm8QsIwmH+F+wjb90t1+6V
         rGqEAyduyg2y0y08W8xDf/rAmtjVuNFUNj0dFAvJ2VvWBucmLbL+SchQNuID0HG6WmKd
         qGEYzbtPu2i3mW9Vsd1SbMDtd11s0S6qBcRvsCOgX8sofnZ/bjMYW6/BSFAw7hoOp5vj
         BXCBppHFssd4lGImFEgRSVqFVb21+BnBaBgW34uKwmedY5P0xieurw0fuTCiBt61i1KJ
         +xCLncSvYVLKSuW4Vbdnmhze06DvhmCzOvpEHqIwRFOd6LwTLX1qu6WoFUS/JNf4Sth4
         DkjA==
X-Gm-Message-State: AD7BkJK0XHihkAv3g0yk1MawqcC0OefmR9zfkPVcg+5xKBwi7JSElFD/jwOoQ3AFjyC7pjpaf18gchhvZ9M2hm8b
X-Received: by 10.129.4.83 with SMTP id 80mr17250779ywe.44.1458665235771; Tue,
 22 Mar 2016 09:47:15 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 09:47:15 -0700 (PDT)
In-Reply-To: <xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289514>

On Tue, Mar 22, 2016 at 9:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:

My commit message is bad, and I should feel bad. ;)
Quoting from 68b939b2f097b6675 (2013-09-18, clone: send diagnostic
messages to stderr, by Jeff who writes the best commit messages):
    Putting messages like "Cloning into.." and "done" on stdout
    is un-Unix and uselessly clutters the stdout channel. Send
    them to stderr.
    ...
    This should not regress any scripts that try to parse the
    current output, as the output is already internationalized
    and therefore unstable.

Quoting another fbf71645d12d302 (Tue Dec 15 16:04:06 2015,
submodule.c: write "Fetching submodule <foo>" to stderr, by Jonathan)
    The "Pushing submodule <foo>" progress output correctly goes to
    stderr, but "Fetching submodule <foo>" is going to stdout by
    mistake.  Fix it to write to stderr.

>> Just wondering, what's Git's policy on this? This message is neither
>> an error nor a warning, but just purely informational. As such it
>> semantically does not belong to stderr, or?

I think the stance of Git is to write only machine readable stuff to stdout,
and essentially all _(translated) stuff (i.e. human readable) goes to stderr as
some sort of help or progress indication.

>

>
> Some people believe that a clean execution should not give anything
> to stderr (Tcl is one example, IIRC), but I think the core part of
> Git takes the opposite stance (probably unix tradition?).  Anything
> that is not the primary output of the program should go to stdout.
>
> We may not have been very strict in code reviews to enfore it, and
> especially on the fringes of the system it may be easy to find
> violators, though.
>
