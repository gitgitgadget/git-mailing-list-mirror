From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Mon, 2 Jun 2014 19:59:53 -0700
Message-ID: <CA+55aFyEce-48tcguL4GvvbomivZrnOYptzOenCrGTiQxxhHTg@mail.gmail.com>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
	<20140603120832.7235c706@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: NeilBrown <neilb@suse.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 05:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrexG-0006bw-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 05:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaFCC74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 22:59:56 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:62119 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaFCC7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 22:59:55 -0400
Received: by mail-vc0-f181.google.com with SMTP id hq11so4099511vcb.40
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gcT8hqzaW4bLlkMfrXy+w7Y9jxqfJ2DsclHCCJ3gvKY=;
        b=SWQSgAPF5iv6USF3rtXj5YRKrzx+SkDZ9xJx2qLZzyqecUhbmflpJ0IIyLf+TB1O7u
         rbOvMOaJR/ZxlGdvWB0nv9KvPurYG8LjA11R4Q3JypAbhKvteQs36nJIYA+TUjW8yJ9x
         LHaZgkf7d6OYDMk67A+jUS4zufa6r+9mHyb3dGOsYE6SXdu4Y7gGEZ3f4MS5/LnUsOah
         ggGSYTyb7IzxPqgxpwfGuNYsFUE6dlOHLSvpvj/H64/5VYLjlFXbfD+85XEY6NgmRlk4
         qq48cR0zvQ9OXLTwAS04yLy3YbA3iWFn0jXVuYx9IEbJ1+RHlSXL2zRNsscyo1Kvs3IF
         1+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gcT8hqzaW4bLlkMfrXy+w7Y9jxqfJ2DsclHCCJ3gvKY=;
        b=I4Nbyf5XOiC6G2ONDnOnHUkuG5IKV053mwZZhjjjE+yDZayOSpNoVJa3QZGYJUAFUv
         Q1+OwJlLSrrOCHPMMMR8+R2WPMINvgLR5VSufod6nASLuJUGpAgPf31VI+gzJc1wjMZH
         NrEn9kTHnoXCrfqRrRedI0HBMIKjeAe6oWnH8=
X-Received: by 10.221.24.207 with SMTP id rf15mr33970881vcb.17.1401764394046;
 Mon, 02 Jun 2014 19:59:54 -0700 (PDT)
Received: by 10.220.13.16 with HTTP; Mon, 2 Jun 2014 19:59:53 -0700 (PDT)
In-Reply-To: <20140603120832.7235c706@notabene.brown>
X-Google-Sender-Auth: lMxi1dAQwF1fdsnyiUeks-JJKzU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250610>

On Mon, Jun 2, 2014 at 7:08 PM, NeilBrown <neilb@suse.de> wrote:
>
>   git request-pull master git://neil.brown.name/md
>
> after tagging the current commit as "md/3.15-fixes" and pushing out the tag

You should *tell* "git request-pull" what you're actually requesting to pull.

The old "let's guess based on the commit at the top of your tree" may
have worked for you (because you only ever had one matching thing),
but it did not work in general.

So the new "git request-pull" does not guess. If you want to request a
tag to be pulled, you name it.  Because if you don't name it, it now
defaults to HEAD (like all other git log commands) rather than
guessing. So please write it as

   git request-pull master git://neil.brown.name/md md/3.15-fixes

I guess the man-page should be made more explicit about this too.

              Linus
