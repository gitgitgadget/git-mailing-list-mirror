From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Linear history *and* share a branch?
Date: Thu, 5 Apr 2012 22:56:39 +0200
Message-ID: <CACBZZX6za0+MXi4nPiV5ZuCKa91cPz0aye6FZG4gGAdqj0GqcA@mail.gmail.com>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtjv-0006AZ-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2DEU5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:57:02 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55005 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2DEU5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:57:01 -0400
Received: by eekc41 with SMTP id c41so562384eek.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=474kyE6qVqyqboRS2Uq+D5tfEMo9oqxUaInj1MOeGuQ=;
        b=pB5KNFK5LRTaRFjpXswbgUNkZH20qEioMDkpG5r9MhwbmXEdfilsEp65uceTYI2Ji9
         er9T/y9/aRd+f7fBBsodPx/11hA+CRI8DkJpRdf8DSd+qiVm4EnwDXf670tVluhuSzc8
         vckovdTLsJ7gvrmGv2X3guzvspR8s4e8VYKYteRfVB6De18ElTJU/EXSpaaAub6sUlir
         /cCnwTHHCJGcfkreFSMfkWrIV5vy7TxnrHAVC0va79NTMJmbH8CzsW5jXZyL1X6zWpVl
         u8OdVK4lJ0hQS1d2dje4w15jzU8A8hVImAE6hN6OZx8wzrC6bvgVD1oSU6hsIUU8WYVP
         kkIg==
Received: by 10.213.26.69 with SMTP id d5mr580969ebc.61.1333659419481; Thu, 05
 Apr 2012 13:56:59 -0700 (PDT)
Received: by 10.213.103.1 with HTTP; Thu, 5 Apr 2012 13:56:39 -0700 (PDT)
In-Reply-To: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194809>

On Thu, Apr 5, 2012 at 22:48, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> Should we simply do "git merge master" instead of "git rebase master"?
> And then do something at the end when we are about to merge the shared
> branch back into master to guarantee linear history? Your thoughts and
> ideas would be greatly appreciated.

Yes, that's the most sensible workflow to have. You create a topic
branch, push/pull it back and forth, do merge commits and never rebase
it, then when you decide if it's finished you can either merge it into
the mainline (with non-linear history), or have someone rebase it and
push it to the mainline.

I use the latter workflow extensively in my work e.g. when peer
programming. We'll both have the same branch set up as a tracking
branch, make a bunch of WIP commits with crappy commit messages for a
day or so, then at the end of the day interactively rebase the branch,
and push it with linear history to the mainline.
