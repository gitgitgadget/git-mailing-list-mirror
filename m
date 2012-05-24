From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] checkout: default to quiet if !isatty(2).
Date: Thu, 24 May 2012 02:12:56 -0400
Message-ID: <CAHqTa-3UAgSXEH3XA7fdJBt+6t33xdbiaPcxAEqiOP_vwgVd3g@mail.gmail.com>
References: <20120524054506.GA3440@sigill.intra.peff.net> <1337839534-7760-1-git-send-email-apenwarr@gmail.com>
 <20120524061000.GA14035@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 08:13:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXRIX-0007hc-EC
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab2EXGNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 02:13:17 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34465 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2EXGNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 02:13:16 -0400
Received: by vbbff1 with SMTP id ff1so5212941vbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wzm+eAoge+wGrXtT/bB6+1jUERECdXvh59wL55eNHZI=;
        b=mVMiyLNxmqFXxdxI8KhfBUJlOiGyBWlDC7vJeB6klJ+XN1kwpneRp/EbJSURXIwkUL
         j8+4iGKTh1yhFSR23IWlxFiWh5/feuV11x6GlXp7mFpxRVCIqfuV8rIPHohBxUxg/OXN
         OFuwfb444I5GT7pgIiBkEh1/ibOC12RjU84XzeMnp6t96q8J42PUTf+ty3VCHv4HM/xe
         vp8qRMQqLWbaxhhO/D9VmG0CB71aZtj56Qlq4alYbu/4RYsYEmPECc3MTIjCWC5xlbql
         zVPgqJDFBRl5rFlm6Kg+6zJ0e1PAk29HC2Ilo4hCjiBbFHnoEJRZ5ZlzNIZ0UmiM1RF3
         pnLA==
Received: by 10.52.65.145 with SMTP id x17mr14553770vds.117.1337839996244;
 Wed, 23 May 2012 23:13:16 -0700 (PDT)
Received: by 10.52.38.200 with HTTP; Wed, 23 May 2012 23:12:56 -0700 (PDT)
In-Reply-To: <20120524061000.GA14035@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198360>

On Thu, May 24, 2012 at 2:10 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 24, 2012 at 02:05:34AM -0400, Avery Pennarun wrote:
>> It would probably be better to have progress.c check isatty(2) all the time,
>> but that wouldn't allow things like 'git push --progress' to force progress
>> reporting to on, so I won't try to solve the general case right now.
>
> This looks better. There is a slight inaccuracy in your subject line,
> though. We are not defaulting to quiet if !isatty(2) in all cases, but
> rather only when we call into unpack_trees, which generates the progress
> output. We will still print the ahead/behind line, detached HEAD info,
> etc.
>
> Which I think is the right behavior, but is not quite what is advertised
> by your commit message.

Good point, fixed.

Thanks!

Avery
