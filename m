From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Fri, 17 Jul 2015 16:52:46 -0400
Message-ID: <CAPig+cQvVA0Cb60AxA=9RAUj6bBN419FQHObM6PARiDwGLiHow@mail.gmail.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
	<xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 22:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGCco-0003no-SM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 22:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbGQUwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 16:52:49 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36160 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbGQUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 16:52:47 -0400
Received: by ykay190 with SMTP id y190so99075384yka.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=npaRFzlV/D45fDUcY89HHQhO6/h/bImEFe4XN8lX+80=;
        b=z4puKfie0YzD9iG/wtIV2CyF4mbW+sgSOzYnWgguIzcoM9jLrLacp1lZjVRu6C4XWu
         8lwrAGTFvZue0U99Nqm6xMYkKC7i4mpKwSMaiOhDFukAtexeTd9Z7XBQqZLsXDVPF31a
         zU8bFToLKs5ssZV4L7vjpaNb3/FE2BM3ZFpSm+sFk2YLhUXMTainTCsL2t/0IEsEvmAl
         b6SaLbjWjGhWa8M6Tyq6Ca2I+WzBli4jAk67r/e10j37LDQG335W9fRUvhf6cYxMn2f2
         Qfop5z9OQFHQS8RDfsODapX6p8k6kTFcGGsrstZ38uEXCWSadap/epMsd4KF5dUDBrOJ
         aKQg==
X-Received: by 10.129.50.140 with SMTP id y134mr17204458ywy.39.1437166366552;
 Fri, 17 Jul 2015 13:52:46 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 17 Jul 2015 13:52:46 -0700 (PDT)
In-Reply-To: <xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: UCQd7FUXkL0PD7VOPI7lU0r1BKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274100>

On Fri, Jul 17, 2015 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> This should have been changed by 93a3649 (Documentation: move linked
>> worktree description from checkout to worktree, 2015-07-06).
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>> @@ -845,7 +845,7 @@ Git so take care if using Cogito etc.
>>       normally in $GIT_DIR will be taken from this path
>>       instead. Worktree-specific files such as HEAD or index are
>>       taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
>> -     the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
>> +     the linkgit:git-worktree[1] for
>>       details. This variable has lower precedence than other path
>>       variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
>
> Thanks.  I have two comments.
>
> "if using Cogito etc.", which is totally outside the topic of this
> patch, is way outdated. Perhaps we would want to remove or replace
> it.

Do you want me to re-roll the current patch to also include the
"Cogito" change as a "while here..." add-on?

Also, I have v3 of "rid git-checkout of too-intimate knowledge of new
worktree"[1] ready to roll. Do you want me to fold the current
patch[2] and its brother [3] into v3?

(I'd actually prefer to keep [2] and [3] out of v3, however, since I'm
not eager to keep piling on more not-particularly-related patches to
that already overly long series -- v3 adds two more patches -- and I
think Duy is waiting for the series to land, as well, since he plans
on adding more tests[4] when fixing the can't-clone-a-linked-worktree
problem.)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274024
[2]: http://article.gmane.org/gmane.comp.version-control.git/274052
[3]: http://article.gmane.org/gmane.comp.version-control.git/274048
[4]: http://article.gmane.org/gmane.comp.version-control.git/273985

> The other one is more heavy.  Do we even want to have and expose
> GIT_COMMON_DIR environment variable?

I'm probably under-qualified to answer in any sort of authoritative
fashion, but your arguments make sense to me. Duy?

> The primary reason why we added GIT_DIR, GIT_OBJECT_DIRECTORY
> etc. in the early days of Git was because we didn't exactly know
> what kind of layout and flexibility was needed from "various SCMs
> that sit on top of Git core", and we wanted to make progress rapidly
> without making decisions back then.  But it is not 2005 anymore.
>
> Suppose a file "gitdir: /home/gitster/w/src/.git/worktrees/rerere"
> (call that $GIT_DIR) is there, and there is $GIT_DIR/commondir. Is
> there any valid reason why somebody may want to use only part of
> that arrangement and have a $GIT_COMMON_DIR that points at a place
> different from $GIT_DIR/commondir points at to override only a part
> of the setting?
>
> Or perhaps there is a plain vanilla $GIT_DIR that does not have
> $GIT_DIR/commondir.  Is there any valid reason why somebody may want
> to reuse only part of that directory as if it were a linked checkout
> and then use $GIT_COMMON_DIR to redirect the access to the meat of
> the repository elsewhere?
>
> The safety that comes from the primary checkout and the secondary
> checkouts all knowing everybody else is lost in such a use case,
> that is the whole point of adding this new feature.  The fact that
> $GIT_COMMON_DIR/worktrees/* and $GIT_DIR/commondir reference each
> other is what gives us object-prune-safety and multi-checkout-safety.
>
> Unless I am mistaken, I think a separate GIT_COMMON_DIR environment
> variable that can be tweaked by end-user is nothing but a source of
> future bugs and user confusion, without giving us any useful
> flexibility.

Removal of GIT_COMMON_DIR looks like it will require more than a few
patches. Even without an actual environment variable, it seems useful
to keep it around in the documentation in some abstract form in order
to properly explain details of git-worktree, gitrepository-layout, and
git-rev-parse.

It also seems to be used by t0060-path-utils, though I haven't
investigated its purpose there.

Other than that, the only consumer of GIT_COMMON_DIR seems to be
setup.c, and, based upon a quick scan, it looks like it can be easily
dropped, thus alleviating your concerns (but hopefully as a series
separate from v3 of [1] which I'd like to see land).
