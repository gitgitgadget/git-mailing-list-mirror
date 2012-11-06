From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Tue, 6 Nov 2012 08:58:35 +0800
Message-ID: <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
 <5097CFCB.7090506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVXbg-0007vo-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 02:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896Ab2KFBFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 20:05:19 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41133 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab2KFBFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 20:05:17 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so4753366lbo.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 17:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QX25jFxQcfZISrlnu2bwZSaz7m1bLGMQWKfdpd3Rp38=;
        b=DoBBwIvWFej9J2zMGCyski/09DIBf0cFKzjjTnO7RTImHaxDDZIF4MTbQl9YPamdTQ
         5PTvNAtfvevRKMYJNe/P0PwcB8Dvc+fvgM3J+82SeeIhvuGdtTzLbmqdPE3E7o2Svb+E
         qghphmdVo9BFppZLjnqlS1wSznqDedchoMy5OeU0gx+HAVqjRI8/K7OoRbGV60OFxZNK
         QGpEYOzbiUILSHf291kwP9Ym7ay7d+QPMc4Ud9LkyuWGSS8VV/FnZ/Sd2Q+TI8rMH0yK
         IAEQAgQxIz/RaYKQ/rqlyBDo05RPa/PI+ds1LsQKVcMKcG5/gTy8stjgAXj9n6yXrk0B
         /ukw==
Received: by 10.152.106.110 with SMTP id gt14mr10729739lab.1.1352163916259;
 Mon, 05 Nov 2012 17:05:16 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Mon, 5 Nov 2012 16:58:35 -0800 (PST)
In-Reply-To: <5097CFCB.7090506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209096>

On Mon, Nov 5, 2012 at 10:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Eric Miao venit, vidit, dixit 05.11.2012 15:12:
>> The problem is, most cases we have no idea of the base rev1, and commit rev2
>> which it's leading up to. E.g. for a single patch which is between
>> commit rev1..rev2,
>> how do we find out rev1 and rev2.
>
> So, then the question is: What do you know/have? Is your patch the
> output of "git format-patch", "git diff", or just some sort of diff
> without any git information?

That doesn't matter, all the info can be obtained from the SHA1 id, the
question is: do we have a mechanism in git (or hopefully we could add)
to record the patchset or series the patch belongs to, without people to
guess heuristically.

E.g. when we merged a series of patches:

  [PATCH 00/08]
  [PATCH 01/08]
  ...
  [PATCH 08/08]

How do we know this whole series after merged when only one of these
commits are known?
