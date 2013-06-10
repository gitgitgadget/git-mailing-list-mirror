From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 00/15] Towards a more awesome git branch
Date: Mon, 10 Jun 2013 17:38:07 +0530
Message-ID: <CALkWK0kY1P_rLF45L37swzgLhgT7nxmcGpJGjAAhbQheA8pN7Q@mail.gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com> <CACsJy8D8FoiVFT5cNbXyxeAngAUJ1X3AdQOGK41FVWyZyEaSKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 14:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0u5-0006ml-8O
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 14:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab3FJMIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 08:08:49 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41295 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab3FJMIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 08:08:48 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so1448689iec.13
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hXRPmel2j2GwKmn5bP5k4k50hMidQ4RNQ3ADVD4M1PI=;
        b=OKKzqSg6wWdinpDtXmPqHmVsgwYJSI6eC8XsEl6Lq3iCg/2dI/viGkcLCevw0FVWpr
         LImHaEbXyI39d65fjUawaAxrtZjw/R1B/Qjj1k4FEdUmIuLMs+II/zLUaewG41CvHE7v
         7+RlnIxRWwz/qCfUhE8NWM4ZnkoPkepEzmLY0JZkkCAvjBBL1vT9AMq+m6K9YrYkOSH2
         TR7G9vh9aIofAKLWbNQG8ZslemsM8V3QvEPzURJV6UQ4Gua0iVrelPM7uy6GL0zsexBK
         o4fQJW/Zb9n30t190ZuwiS8p19vgELcJK7ZrEgDbm8mTmV9k5siPZ7Y3v7v6h09jt+lz
         qLQA==
X-Received: by 10.50.25.194 with SMTP id e2mr3832770igg.111.1370866128122;
 Mon, 10 Jun 2013 05:08:48 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 05:08:07 -0700 (PDT)
In-Reply-To: <CACsJy8D8FoiVFT5cNbXyxeAngAUJ1X3AdQOGK41FVWyZyEaSKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227276>

[-CC: Duy, since he has left the community]

Junio: since Duy is no longer around to guide us, I will rely on your guidance.

Duy Nguyen wrote:
> I'm starting to think this is a half-baked solution. It hides
> problems, for example commit placeholders should produce empty string,
> not the literal placeholders.

Why should they produce empty strings?  Aren't they equivalent to
invalid placeholders?

> Doing that from a callback is really
> ugly.

Why is the callback ugly?  I thought it was a great way to extend
pretty-formats, without teaching pretty.c about every possible format
that callers could ever want.

> There's also the problem with sorting and quoting (both only
> work with for-each-ref atoms only).

Why would I want to sort by reflog-identity-name (or something) in
for-each-ref?  The sensible fields for sorting in for-each-ref are all
for-each-ref atoms.

On quoting, I agree.  We must move the quoting to pretty.c eventually,
but I don't think it is urgent.

> A better solution may be improving
> pretty.c to the point where it can more or less replace f-e-r's
> --format.

Why would you want to stuff everything into pretty.c?  If any callers
wants to implement one specialized format, the only way to do it is to
stuff it into the One True pretty-formats?

> Even more, I think pretty engine should be easily added to
> cat-file (especially --batch), as a generic way to extract
> information.

Cute theoretical exercise.  As usual, I'm not interested: this topic
is about making git-branch more awesome, not playing with
pretty-formats.
