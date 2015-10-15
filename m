From: Tomohiro Koana <kntmhr.1221@gmail.com>
Subject: Re: [PATCH] Falis on commit --amend when already pushed
Date: Thu, 15 Oct 2015 16:49:40 +0900
Message-ID: <CACbztPMagPGhwKT4-eaQ2Ve95sACv=NpYSHixAgKxtGXe-mSCg@mail.gmail.com>
References: <CACbztPOSZBaqLLUERS_yfvAEPmxS2PZs0fYTy7E_9HfLi9UGmA@mail.gmail.com>
	<vpqr3kw636z.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:49:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdIK-0000OV-5z
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 09:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbJOHtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 03:49:42 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36747 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbJOHtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 03:49:40 -0400
Received: by igbif5 with SMTP id if5so37402102igb.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LDLYLSbmUPff3Lz91ys2n9CjV7sTskzvtsxqIYfWg4Q=;
        b=lAOMi225ct/HHGwUmEf5pO5C6idqDz7GuaOQwGda6q5J28RD1fqeh01aoo3ZQcxbxM
         ghKUQNwJiaMuqBAkBlrMUxjAPcBxciDZwHnZMm0tyu6V+OehVQycploZ0Yojb1tM48Vg
         FcMi4AzrZOZplR5u4AOSH/VzCUFnC/rw+LXubWbOetkB4rgnVETdmOtu4NFBcIixzZHP
         VadJiPOPZzPSkNdWXC1YK+mahbwRlo0jfshXHOQab4b3fDQGDhSOnxCZAiud0GB1ruK2
         PnhM5ITZQom1A/TyKiVce3katGMsy5B4HSudpFlhWpJhYbmoSZYGtxndHkwD8TlE6anS
         IPqw==
X-Received: by 10.50.114.33 with SMTP id jd1mr29280763igb.48.1444895380063;
 Thu, 15 Oct 2015 00:49:40 -0700 (PDT)
Received: by 10.79.96.198 with HTTP; Thu, 15 Oct 2015 00:49:40 -0700 (PDT)
In-Reply-To: <vpqr3kw636z.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279646>

Thank you for the reply.

I've taken a look at the list for small project ideas and our idea was
on the list,
which goes to show that what we are working on is reasonable enough :D

We'll read the documentations for git contributions thoroughly and
send a patch again.

As for the test, we're not sure how to write a test because it
involves remote branches, so we'd love to have advice on it.

On Thu, Oct 15, 2015 at 3:44 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Tomohiro Koana <kntmhr.1221@gmail.com> writes:
>
>> Hello all,
>>
>> I'm a third year student at the University of Tokyo and, in our
>> "Diving into open-source software" class, my friends and I decided to
>> work with git. Our final, hopefully, is contributing to git.
>
> Welcome on board :-). I give the same class to my students (in Ensimag,
> Grenoble, France). You can have a look at
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas for a list of
> ideas of things you can do.
>
> The first contact with an open-source community is usually hard (the
> quality expectation is much higher that your usual lab works), but you
> are going to learn a lot!
>
>> One improvement that we thought of was not letting users to amend
>> commit when the commit is already pushed to the remote server.
>
> This is a good introduction, but not a good commit message. The commit
> message is not about what you "thought", but about what the commit is
> doing, and more importantly _why_ it is doing that and doing it this
> way. See it as an argument like "You should accept this patch
> because ...." (even if you won't actually write it like this). Read some
> existing messages ("git log --no-merges") to see what I mean.
>
> Please, read Documentation/SubmittingPatches and
> Documentation/CodingGuidelines in Git's source tree.
>
>> --- a/builtin/commit.c
>>
>> +++ b/builtin/commit.c
>>
>> @@ -32,6 +32,7 @@
>>
>>  #include "sequencer.h"
>>
>>  #include "notes-utils.h"
>>
>>  #include "mailmap.h"
>>
>> +#include "remote.h"
>
> The patch is whitespace-damaged (there are extra blank lines). Use
> either "git send-email" or http://submitgit.herokuapp.com/ to submit
> your patches.
>
>> + stat_tracking_info(branch, &ours, &theirs, &full_base);
>>
>> + if (amend && ours == 0) {
>>
>> + die(_("This commit is already pushed to the remote -- cannot amend."));
>>
>> + }
>
> I don't know the API well enough so I can't say whether this correctly
> detects already pushed branch, but this looks suspiciously simple. Are
> you not just detecting the presence of a remote-tracking branch? What
> you should do is to detect whether the remote-tracking branch contains
> the current commit.
>
> Also, this is clearly not acceptable in its current form: there are many
> valid use-cases to amend an already-pushed commit, so you can't break
> the flow of people using this. It must 1) be configurable, and 2) unless
> you have a really good reason, backward-compatible by default.
>
> Also, it lacks tests.
>
> Actually, the idea you have is far, far more difficult than what you
> probably thought.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
