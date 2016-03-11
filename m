From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 00/48] Libifying git apply
Date: Fri, 11 Mar 2016 18:34:50 +0100
Message-ID: <CAP8UFD0MEPpfpCHxkX-EKHb2F+xmObqZa4w1Ub=NQ=7W7OVLYw@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Bn1+zbALH347SNgGqSLR0ixCL0acW+DuUZH1g2HRS0ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 18:35:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeQy2-0002yk-Tj
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 18:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbcCKRe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 12:34:56 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35517 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932879AbcCKRex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 12:34:53 -0500
Received: by mail-lb0-f177.google.com with SMTP id bc4so164915389lbc.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=clIa9upt1aiL1LAHdeJj2d2H8KC7dQoTTaWu8RGDiJQ=;
        b=G+f1daGEYAKwVb6Ms6tqoc1Cji0faAX+BM6Anml/zXOY5hGgCLQXxoahLOZCucdobj
         XcKWmiEGvyZgi/yZxiBspZ1soc1grdxDoJrCp3/m9gALhyIKmC4xGeL/eShDUZGLnRPl
         dvcYWqpzfPx4UC12rfT9ifz+xJY98GzCJ2O1Sylg0N7ZsnDyd6JZsrcW53lDcDsetU0f
         IGvaaAowcLc3awnWlT72SDfbdLFc6lfbfsKhowl9rexel0nICKwr5OfLFdsVzlafM4HZ
         GEXOb1yRcRJB3c3zI76p3zV/0M7mUTOUWvXYfXAG5D88Yy1oV/3lNyuiPUFBwhpehBHs
         ZcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=clIa9upt1aiL1LAHdeJj2d2H8KC7dQoTTaWu8RGDiJQ=;
        b=bRZnBA48HrxNIVqSDTsCsTXb2BCFRtSkncG0ESxWKi2L5C2zJuu1yKDgbN/jEO00uj
         4gC4xF4qplooEvHTr/Zj1EBZrrOT/OLPv4u8GE/Nzb9fgxMD4s6+F4/2kFOEUhmHkS9R
         NJzv99u2WuaUMDwJAxX8qW5tJiyEn7ER4wxamM6PCUWrA2eK5OuLKxUJiuaf8zXfYJJh
         PCh6QkIvdcRbHlzI9B5WNqVX9GRJen/RcF8HkIb3Udxqqgdeu5MnlE4RkcTkdI+2NLPJ
         Kt/Tg4jvfYBV7WIgDaOTPVw7i5FZahd8NO4yyaQQvXAoB5qoFY3IvD/pLgF/P6TKDjJn
         ZUKw==
X-Gm-Message-State: AD7BkJIEApMW0L06vuRDyOBuV6gdPj2J8iNsNvc1/K0j9mcUPpDwlOfkoucXSAsPa8r1w1uqATP7GoM3C5Xq9A==
X-Received: by 10.112.64.5 with SMTP id k5mr3678212lbs.133.1457717691048; Fri,
 11 Mar 2016 09:34:51 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Fri, 11 Mar 2016 09:34:50 -0800 (PST)
In-Reply-To: <CACsJy8Bn1+zbALH347SNgGqSLR0ixCL0acW+DuUZH1g2HRS0ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288691>

On Thu, Mar 10, 2016 at 10:26 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 10, 2016 at 12:48 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> This is a patch series about libifying "git apply" functionality, to
>> be able to use this functionality in "git am" without spawning new
>> processes. This should make "git am" and "git rebase" significantly
>> faster.
>>
>> This has been discussed in the following thread:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/287236/
>>
>> This RFC patch series for now just gets rid of the global variables
>> and refactors the code around a bit.
>>
>> As suggested by Junio the global variables in builtin/apply.c are just
>> thrown into a single "apply_state" structure that is passed around the
>> callchain. A new parameter called "state" that is a pointer to the
>> "apply_state" structure comes at the beginning of the helper functions
>> that need it.
>>
>> Before I make further changes to handle erroneous input and make the
>> libified functions not die() and properly clean things up, I'd be
>> happy to get some feedback.
>
> I didn't review individual patches. Instead I redid the whole thing
> (in a slightly different way) and compared my end result to yours. In
> general it looks good but..
>
> 1) I think you should focus the series on moving global vars to struct
> apply_state only. You can save code move patches for the later phase.
> Easier to review.

I am not sure what you mean by "the later phase", but I tend to agree
and that's mostly what I did.
Most of the code move are at the end of the series so after the global
variable related changes.
There are a few exceptions because in a few cases it was difficult to
understand the code without a refactoring.
In such cases I think the refactoring can also actually help the reviewer.

> 2) Given that there are only four local variables shadowing global
> ones, p_value, linenr and options, I think it's ok to drop 1/48 and
> 2/48 and keep the good old names. You just need to mention about them
> and what function they are declared in in the relevant "move global
> ..." patch so the reviewer is aware of it.

About 1/48 (builtin/apply: avoid parameter shadowing 'p_value') this
is discussed in its own thread.
In 2/48 (builtin/apply: avoid parameter shadowing 'linenr'), I change
the "good old name" only twice in a small function, and I don't think
keeping the old name is a big deal there.

> 3) Moving lock_file to struct apply_state, then putting the whole
> struct on stack, could be problematic. I believe there's a global
> linked list keeping references of all lock_file variables until the
> end of time, so we can't destroy lock_file/apply_state until we are
> certain it's safe to do so. We could simply leave lock_file as a
> global var for now (with a note in struct apply_state so we don't
> forget). We can always do fancy stuff like malloc() later on if we
> need to.

Thanks for this information. Though I prefer to do the fancy stuff
right away, that is something like:

diff --git a/builtin/apply.c b/builtin/apply.c
index 4f57bce..6029869 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,12 @@ struct apply_state {
        const char *prefix;
        int prefix_length;

+       /*
+        * Since lockfile.c keeps a linked list of all created
+        * lock_file structures, it isn't safe to free(lock_file).
+        */
+       struct lock_file *lock_file;
+
        int apply;
        int allow_overlap;
        int apply_in_reverse;
@@ -4517,8 +4523,6 @@ static int write_out_results(struct apply_state
*state, struct patch *list)
        return errs;
 }

-static struct lock_file lock_file;
-
 #define INACCURATE_EOF (1<<0)
 #define RECOUNT                (1<<1)

@@ -4566,8 +4570,10 @@ static int apply_patch(struct apply_state *state,
                state->apply = 0;

        state->update_index = state->check_index && state->apply;
-       if (state->update_index && newfd < 0)
-               newfd = hold_locked_index(&lock_file, 1);
+       if (state->update_index && newfd < 0) {
+               state->lock_file = xcalloc(1, sizeof(struct lock_file));
+               newfd = hold_locked_index(state->lock_file, 1);
+       }

        if (state->check_index) {
                if (read_cache() < 0)
@@ -4780,7 +4786,7 @@ static int apply_all_patches(struct apply_state *state,
        }

        if (state->update_index) {
-               if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+               if (write_locked_index(&the_index, state->lock_file,
COMMIT_LOCK))
                        die(_("Unable to write new index file"));
        }

It makes it possible to remove the 'newfd' variable as it is only used
to check if hold_locked_index() has already been called and now
"state->lock_file == NULL" can be used to do that.

By the way I wonder if I should also change "static struct lock_file
lock" in build_fake_ancestor().

> 4) I noticed on the interdiff that there are translatable strings in
> this file but not marked as such. You're going to spend lots of time
> reading this file and are in a very good positioin to determine if a
> string should be translated (i.e. wrap _() around it) or not. So maybe
> you can have a look at this in the next series too. It's absolutely ok
> if you say "no" here.

I will see if I can do that towards the end of the series, but this is
not at all on my radar for now.

> 5) Minor detail, but we can rename prefix_ to prefix in
> init_apply_state(). There trailing underscore was there in cmd_apply
> because there's the global "prefix", but it's gone now.

Yeah, I think this is worth doing, so it is done in my current series:

https://github.com/chriscool/git/commits/libify-apply21

> Looking forward to seeing you double, triple git-rebase's speed.

Thanks for your reviews and comments,
Christian.
