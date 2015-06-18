From: Luke Diamand <luke@diamand.org>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 23:13:25 +0100
Message-ID: <CAE5ih7_ferSqBGnk=08DegqqpgpO7Mq8XWu4k-KAP4ENdxE_rg@mail.gmail.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5i3v-0007Zg-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbbFRWN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:13:27 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33583 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbFRWN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:13:26 -0400
Received: by qkhu186 with SMTP id u186so51765569qkh.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=HH10EiF9JbkVH9RpzR3/Jctk+S6fE0FFXgbv024caAc=;
        b=c1wLG1lSvfCW+5+3rkaxNJ23xc5He29QMnR5ECp9A0oQTjAHRhsNsN8KhQfoFOuZAs
         5Gxgdb4e6q8RW9Uz9VP3allFbhsFPTASgAgdPkyW2BuhtbDLyOlkd842GdaqbiNOw0ys
         PWSBUBR9DqVWZWopb47koSKA4fpcDYsnWa0zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=HH10EiF9JbkVH9RpzR3/Jctk+S6fE0FFXgbv024caAc=;
        b=W/AWfMo9jnU1fFDZNzDbyJQys/BkXMAOvat9M06oLP61o/KAryth6MywXcHQo0AIGq
         WQr1RJ6qEY5aklz5970wnoej7Y8U8m6xl5kUBFb/4LJysvSv+ea44yPz6mxrg00m1Jof
         eJ80DHwnK8ZOJTucnLc2oTmZUuhf3gFslFCXqMz8aYJPO5E85jPYFXEla/mf2GQ5BRmL
         C7wuZm/sWSL1a4hEA5HRpygeG+pDa1kc3sgw3QgHgDZ7HzAg93r64tvtX7U4W2rh/l+2
         UsRlXV17A9I5E07V7xKzp1VxWufWv5qSnZGmALRsOb5TfvRWj6VZ0L6SIyogUA/fmfnx
         i8Zg==
X-Gm-Message-State: ALoCoQk1QZ4X4VuH7ZhnGuhGioAmQb3hmXUiYCiCWSKkxh3LPH5UE3lQKi3T+NOTusQzjqZf7pAX
X-Received: by 10.55.23.195 with SMTP id 64mr13262394qkx.9.1434665605253; Thu,
 18 Jun 2015 15:13:25 -0700 (PDT)
Received: by 10.96.142.7 with HTTP; Thu, 18 Jun 2015 15:13:25 -0700 (PDT)
In-Reply-To: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272086>

The other thing about these files is that they were all deleted a few
weeks ago and have now come back.

On 18 June 2015 at 23:07, Luke Diamand <luke@diamand.org> wrote:
> This is probably user error, but I'm not sure what I'm doing wrong.
> I'm posting here in case anyone else gets the same thing
>
> I'm using 2.4.4.598.gd7bed1d, i.e. 'next' as of today.
>
> I've somehow ended up with history skipping back in time, but git not
> prepared to let let me fix it, or something.
>
> $ git diff upstream/master -- subtree
>  - lots of deltas, which look like I've reverted this back several
> revisions (which I haven't AFAIK)
> $ git checkout upstream/master -- subtree
> $ git diff upstream/master -- subtree
> -- still lots of deltas
> $ git checkout upstream/master -- subtree
> $ git commit -m 'Revert unwanted changes'
> $ git diff upstream/master -- subtree
> -- still lots of deltas
>
> What am I doing wrong? Have I ended up in the middle of some weird
> state (cherry-pick and rebase isn't in progress AFAIK).
