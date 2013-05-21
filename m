From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Tue, 21 May 2013 03:16:46 +0200
Message-ID: <CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 03:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UebCO-0000nD-9x
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 03:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab3EUBQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 21:16:52 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:64250 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab3EUBQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 21:16:51 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UebC6-000LKv-DV
	for git@vger.kernel.org; Tue, 21 May 2013 03:16:50 +0200
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeYe6-000P6W-2f
	for git@vger.kernel.org; Tue, 21 May 2013 00:33:34 +0200
Received: by mail-oa0-f48.google.com with SMTP id i4so93682oah.21
        for <git@vger.kernel.org>; Mon, 20 May 2013 18:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0HWrZvlz0WTe5Bg0cuVVSTwuP4SgYFmevESJH3ERyLc=;
        b=DPVltkYY+Q8EXBgfW96/hUQ0G/1/ZUAIqmTEv+obxzrIL3AyZvLPZZLuFDi2OUErkW
         5CWobxEra1U9McXwPxwdSFX0/6YPtrkWqWw2bZPyJ0jFjKdRRtN/924ElSep0bdORtHa
         uu1gFPMyk0PbWK+dETkCVluRozJBLXsP7kxBKdHW2O2fd/uOfH3Hu+siJc8tP4hdVI7N
         Z0UKgvEE8AODd2VX3OT3P+vvoG4KJCdmAIOQXr0jaLumT4mlmRG7x4wUuKC1PtwutOSI
         44QdUrZ2uN5BZ1ggX/5Wdka8rspZcuXgvFXQnOrxgQAvIRX4HU7uremWMV/S3stZKO9T
         r9dA==
X-Received: by 10.60.132.238 with SMTP id ox14mr41292oeb.102.1369099006797;
 Mon, 20 May 2013 18:16:46 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 18:16:46 -0700 (PDT)
In-Reply-To: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225010>

On Tue, May 21, 2013 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * jh/shorten-refname (2013-05-07) 4 commits
>  - t1514: refname shortening is done after dereferencing symbolic refs
>  - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
>  - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
>  - t1514: Add tests of shortening refnames in strict/loose mode
>
>  When remotes/origin/HEAD is not a symbolic ref, "rev-parse
>  --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
>  "origin/HEAD", which is fixed with this series (if it is a symbolic
>  ref that points at remotes/origin/something, then it should show
>  "origin/something" and it already does).
>
>  I think this is being rerolled using strbuf_expand().

Actually, that was not on my TODO. Sure, my other series ([PATCHv2
00/10] Prepare for alternative remote-tracking branch location) builds
on top of this one, and changes a lot of the same code, but I
considered jh/shorten-refname a good set of changes in its own right,
and I didn't want it to be held up by the much longer (and probably
much longer-running) series.

The strbuf_expand refactoring is nice, but not really necessary until
we start using multi-wildcard patterns.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
