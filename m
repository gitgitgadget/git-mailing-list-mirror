From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 17:46:41 +0700
Message-ID: <CACsJy8DaCK3Z4mfVEjkZsALdeNx9LDe=cw=m-qB39a2fmqR80g@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
 <CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com> <xmqqy4j16tqk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 12:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAFYG-0003Rf-Un
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 12:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbbGAKrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 06:47:13 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33849 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbGAKrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 06:47:11 -0400
Received: by iebmu5 with SMTP id mu5so31578626ieb.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lYDvfN6nkVpm7QaOP+d4iUcYmI9hmnERQoRwl9AmK/4=;
        b=U4DJEbfQDBWEQKgf+49R72DEBQN9EDQUePa9LNqigjU4fp5/c2+Y1PAj0lgIbgJwXk
         OSqpaVDvzY8FymmfnJzwZ8iXJ4yJGTQ2ZZU2U65DL82wY+OxaeEel0xVhWv6pNkXrcPd
         NYE6LP69SWSGjLXPnl7ZLVCHp3ciWX3B4g43SLkoNYGBRl5aKuN+PzDQ2gIZekhT2C3i
         x4cCdZyxLqt7sEti9Q53HWhLKkmuALzOfD8t/ClROZDbKO74RdY8sEopLHMrBnZQmeg4
         Md4lSgEyUiftnLAToDnWhijWCD7rbzUZRnkj4RYD/nhjrCWRc74nm8FjvAhkXxXz8GqK
         y+bw==
X-Received: by 10.107.15.153 with SMTP id 25mr38432346iop.44.1435747630701;
 Wed, 01 Jul 2015 03:47:10 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 1 Jul 2015 03:46:41 -0700 (PDT)
In-Reply-To: <xmqqy4j16tqk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273150>

On Tue, Jun 30, 2015 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I think this is like "git checkout -b" vs "git branch". We pack so
>> many things in 'checkout' that it's a source of both convenience and
>> confusion. I never use "git branch" to create a new branch and if I
>> had a way to tell checkout to "move away and delete previous branch",
>> I would probably stop using "git branch -d/-D" too. "--to" is another
>> "-b" in this sense.
>
> I didn't know "checkout --to" included "create a worktree elsewhere
> and chdir there"; if that "and chdir there" is not something you are
> doing, then I do not think "checkout -b" vs "branch" analogy applies.

Heh.. I do want that "chdir" (even for git-init and git-clone). We
can't issue "cd" command back to the parent shell, but we can spawn a
new shell with new cwd. But because the target dir is usually at the
end of the command line (except for "--to") and "cd !$" is not much to
type, it never bothers me enough to do something more. I think this is
another reason I prefer "git worktree add" to have the target dir at
the end.
-- 
Duy
