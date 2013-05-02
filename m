From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/9] t1508 (at-combinations): test branches separately
Date: Thu, 2 May 2013 22:58:25 +0530
Message-ID: <CALkWK0=_zcO8K75YxmQVp9hog0yHJ_vH5QKRwpWN8QMUc2zm_Q@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
 <1367501974-6879-3-git-send-email-artagnon@gmail.com> <CAMP44s3up_xo=oU+5EajoFo7VzA3RDK+hR-maxN9cUw7y=b3Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxJy-0006nv-3a
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761423Ab3EBR3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:29:07 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:59037 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab3EBR3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:29:05 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so951988iec.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tfIqL3II4nLJU1hi+7uqJvAcfu9rxujp6bbhnZ09a/M=;
        b=PFsnumzNtCMPHyVtYMtA2e/nt6UHvXw1RQKemmp/Z9ISpkWwH7mwoE6YDEnJWcIVhQ
         zvpXznkEJRiWJMHMK0h822mabvaeaCihwaMrn4tYFfzsKxc2C0P7yNvcKMecCXokqwb4
         NRPrIQa5tBGYzio7AewZ+lMX79Y6AQ96TwwTe14qs4UcnBELRWYymMnFg2fffR7BXs/c
         +S+32+4QIedCkyMFSer4I4A9G1VBo3pww/QgRBfottXjAbau6kauRPCmJHvYUlXH5S/y
         dOtZ0xdnEkZjdwumc0UrOr3KbhT3JgAGBkbwtk9dRpukYXMoGMxFvBWzC83FiPQRKjaE
         A3+w==
X-Received: by 10.42.27.146 with SMTP id j18mr3555121icc.54.1367515745612;
 Thu, 02 May 2013 10:29:05 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:28:25 -0700 (PDT)
In-Reply-To: <CAMP44s3up_xo=oU+5EajoFo7VzA3RDK+hR-maxN9cUw7y=b3Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223233>

Felipe Contreras wrote:
> I'm not sure about this. If we introduce a check that fails, we would
> have to do:
>
> check HEAD refs/heads/new-branch "" failure
>
> Which doesn't seem clean. Perhaps it makes more sense to always add
> the type of check:
>
> check HEAD ref refs/heads/new-branch

I think you misunderstood.  Failure looks like this:

    check "@@{u}" ref refs/heads/upstream-branch failure

And corresponding success like this:

    check "@@{u}" refs/heads/upstream-branch

We can make the "ref" compulsory if you like.  I thought about it too.
