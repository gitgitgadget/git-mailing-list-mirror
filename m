From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] transport, send-pack: append period to up-to-date message
Date: Tue, 24 May 2016 14:21:00 -0700
Message-ID: <CAGZ79kayB59-U52oAw=13a2CAhJLsfmoD6JbAURbt0p8g8a8fg@mail.gmail.com>
References: <1464123104-45513-1-git-send-email-junk@humanoriented.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, barkalow@iabervon.org,
	Yong Bakos <ybakos@humanoriented.com>
To: Yong Bakos <junk@humanoriented.com>
X-From: git-owner@vger.kernel.org Tue May 24 23:21:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5JlE-0000hc-DC
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 23:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcEXVVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 17:21:04 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38503 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbcEXVVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 17:21:02 -0400
Received: by mail-ig0-f171.google.com with SMTP id fh2so18244163igd.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCD7cUmrvPt/prG8aQ+QCNhkXtSioGj2PMyZxoWMdxU=;
        b=Wftz4vHtQgRbaYfYrU9m2yB/fUf4DCEIWUGUklCU+rxgAUzIfKAkGW7hAcl71YLmly
         uBHEzN+WbMTp0wiImlnPoW+cg9nBzwgL9JsU8X0OQjd50sJ+BZs0cEBBNVyq9TBj5KKL
         hl1WTxMgn0Jda2UJpdM+oQcYzK/RneDVoh1MJWYcUNrq6oNfhNFAQfKEvyBU2ulbDG+X
         LJF/rZg/bHqo6nqt5jE1rNv631B7WdJqBr70UYuWnJNohOSjVwVK/BXy7S5WeBPjlf47
         3zDOc01oBLV7MVmCP2wpL3QRIHDZhSaoLxl5Nhg5mb/uY9CdOghiOQuFkB0YlTPprlnM
         Ku+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCD7cUmrvPt/prG8aQ+QCNhkXtSioGj2PMyZxoWMdxU=;
        b=DVmjAX2kF5ybVp1l5TB95JlLchdx5ubUXvmDIpK3eCmN4zuu6r2U/AMrXbviKemgH5
         L4VrPWvaHepzeVPIB3IyA/nnRfYks/uvIRKQ0CXg/Vcwfap+uIvlTK047UOFkkesnAIm
         zuvoP7kWnzHUO3JvH+O8Y62T8caPTkBHx3tLh+I+3GjYIc1z7D3L0piWNGLKJV9UyHJo
         Zy9sYRb5EjQd0Y6Za+UuAJw+EYOw5echWa3ysOfidLk2R/xaHGtYfdMInWyppItJdBdr
         JH7yeBKTKvEijjknnUoZdx9GzOKoDg/wyMG6UpxF/a0/DMy6s/VE7ghoJYgrW2zfDTSm
         9VXQ==
X-Gm-Message-State: AOPr4FV0Z8gjjngki0PSyThwZpJWWpl6l4o/nwCbIvb/CzLBFzwxOS3sU5jUUBXXsf+E8Glqve0VEUTGO6nIiZZ4
X-Received: by 10.50.250.165 with SMTP id zd5mr19639862igc.85.1464124860837;
 Tue, 24 May 2016 14:21:00 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Tue, 24 May 2016 14:21:00 -0700 (PDT)
In-Reply-To: <1464123104-45513-1-git-send-email-junk@humanoriented.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295534>

On Tue, May 24, 2016 at 1:51 PM, Yong Bakos <junk@humanoriented.com> wrote:
> Appending a period to "Everything up-to-date" makes the output message
> consistent with similar output in builtin/merge.c.
>
> Signed-off-by: Yong Bakos <ybakos@humanoriented.com>
> ---
>  builtin/send-pack.c | 2 +-
>  transport.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 1ff5a67..67d9304 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c

While consistency is a good idea in general, I wonder how that applies here.
git-send-pack is a low level (i.e. plumbing) command.

       The interface (input, output, set of options and the semantics) to
       these low-level commands are meant to be a lot more stable than
       Porcelain level commands, because these commands are primarily for
       scripted use. The interface to Porcelain commands on the other hand are
       subject to change in order to improve the end user experience.

So if another porcelain exists and compares the output string
exactly, this would be a regression for them. That is why I'd refrain
from updating these strings

However these two strings are only showing up in these 2 places, so
maybe instead
we'd want to see a test documenting existing behavior?

Thanks,
Stefan
