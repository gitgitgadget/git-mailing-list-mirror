From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 11:45:27 -0700
Message-ID: <CA+55aFxLoi8RAYOZS8ziaGXkbTOdQ=YFbMA0EO0eFpNVgnugKA@mail.gmail.com>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
	<20160422181103.GA5920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:45:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atg57-00010r-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbcDVSp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:45:29 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34719 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcDVSp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:45:28 -0400
Received: by mail-ig0-f193.google.com with SMTP id qu10so3301285igc.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hZU5ooi3sb5PK8AFbvCW2R2K0VAUHFxcOldkCcvUrLc=;
        b=LMseKUxajEW34fhxEtCUB88bV3S6SC59EDd5FnCv071EaL82CHKdtVm2/P6ZiamDok
         wV0busu1Rkc0E3zAtrC07hplu4cfOApFuWdIENJDZw9c2VUq6BUtf6+2771BMHm+XFl4
         j6Cb94x2z/K6D/MZIu4MuTN8N0pnvkT8Gqydh1hhRmBA17agU1y7srnj51ZQVDyw+R99
         OeTcPNh8Qycebuqj+ILaQZGigTT2Tax+AdMLurVgNn3sEy26c2b/VReFN1x9Hs4FmK7p
         WER6BgON2n8usuO3Qh/2f+BqMkqn9bcu6ggwtdnA7bSacPxkrDzWMY8r9IksyRg4QSbj
         nOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hZU5ooi3sb5PK8AFbvCW2R2K0VAUHFxcOldkCcvUrLc=;
        b=Qx7C3uEgbjjXj/VBBy1GbFGzF+3lcMNiiGSMjq0sk/dVSVZ5W1KtFcbU1fTMNBJsLG
         22RCtATLzCp8oCGzHy0lJt39juGGxnHfB2FlVJcNjx3+6/zRdxEndvHfgcO8TjjRy7tK
         jD6nCqhxYWPRX9tkZDxT1bnnhb8+pXr9qlt6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hZU5ooi3sb5PK8AFbvCW2R2K0VAUHFxcOldkCcvUrLc=;
        b=T1cNF+UdmTnIKaHSRRHZIvoXD4igoec52TJcKcfPnrQi4kI8FvoohuRqX2jaDjIqIL
         7gK8dQBENLXBPTv+ERcaIrWOcVREijIxGbeGeTs4Ixr5qcg2Sra1JeC+HCMz8SIf6a2B
         z2INKWLGml09eQWBi1rdSvjW2s9Y4spo/aUjxZb0D5aqdh1ixYIoGp++8kcjnO488rrv
         JsbiN/9VPLuLha3KNsdG7dXy+f7EtwPU8QQmp9PKlEzjXlIHv2Yr2/P3YxuOzfniMA4S
         ttStu5xvT+2U9FK/2Ok8deNrOfEPWnTfNw0+IW+ZKlqat8opbnIwu/rA0t+5bjR0iaj2
         tEFQ==
X-Gm-Message-State: AOPr4FVmaghwPFMTv/kmw6bRhsNqzUWCDH84Cy82RypbS+GT5nfc2XFOtU2DhRYDXavqxdC0YIJ9muc7SA4ZXw==
X-Received: by 10.50.36.195 with SMTP id s3mr6124572igj.25.1461350727683; Fri,
 22 Apr 2016 11:45:27 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Fri, 22 Apr 2016 11:45:27 -0700 (PDT)
In-Reply-To: <20160422181103.GA5920@sigill.intra.peff.net>
X-Google-Sender-Auth: zmgSHXY2Lbju31WtU6tIRH-eRqc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292244>

On Fri, Apr 22, 2016 at 11:11 AM, Jeff King <peff@peff.net> wrote:
>
> I confirmed that it does find the "optimal" tag for the case we've been
> discussing.

Yes. I'm a bit more worried about the date behavior for projects that
merge back stable branches into their development trees (is the
development tag better than the stable tag? the date doesn't really
say much), but I think this is still the simplest model we can use
without trying to really do a topo-sort. And in many ways it's the
simplest one to explain to people too: "we try to use the oldest
reference we can find as a base for the resulting name" is not a
complex or hard concept to explain.

> We could _also_ tweak the merge-weight as Linus's patch did, just
> because 10000 has more basis than 65535. But I think it really matters a
> lot less at this point.

Yes. I still think that my tweak makes more sense than the existing
code, but it's a tiny tweak, compared to the date-based approach.
Unlikely to ever matter much.

            Linus
