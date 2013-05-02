From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 11:45:57 -0500
Message-ID: <CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
	<CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
	<CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
	<CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 18:46:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwdy-0000E2-5x
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760674Ab3EBQqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 12:46:00 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:47574 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab3EBQp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 12:45:59 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so730637lab.9
        for <git@vger.kernel.org>; Thu, 02 May 2013 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8CpEfTpzNqQPjT172kf5kgFKurFeOe2y6CMwA4kSbEE=;
        b=trOZoAec7lt2yxzwzr7up4Aa77BmDkyllrJKlbUnMBhZsLExGQuoWota2dr3zyV6s5
         zh2kmYVDbgn/jbfgfnbBzidgiKFxrQ6uDt4Io4XswaKf44TXmIZqKmkBc7AGGZwOWbah
         AUoKSYGoxkwJ4vhw9VfXFSFwEJRSLrrVliKY78rVkgQa22QrYzP10tkVVzzFqaka1TZM
         rYBP7a43+H0Vtj/yPj+M2nF3ta+3bRlTyfi6cilT3I44YeUPYSEi0ADRm+XN1QISvgAv
         DIgyhsD/CeKolTymXkTrZmwb5z3RdEMxxLybbjZCPDe17yhKo9QPt7UBZ6KdG0O6JJGV
         5nSQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr2951990lbb.88.1367513158124;
 Thu, 02 May 2013 09:45:58 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 09:45:57 -0700 (PDT)
In-Reply-To: <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223219>

On Thu, May 2, 2013 at 6:03 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> But HEAD is special, @ is not. HEAD is documented, @ is not.
>
> Your point being?  That we should document @?  Yes, I agree.

Where?

>> Where is it documented that @ points to HEAD? Where is it documented
>> that 'branch -u foo @' would replace @ with HEAD?
>> Documentation/revisions.txt? Sorry, 'git branch -u foo' does not parse
>> revisions, so that's not the answer. And there's many other places
>> that don't do revision parsing either.
>
> You're confusing parsing revisions with parsing symbolic-refs.  I've
> documented @ right next to HEAD, FETCH_HEAD and the other symbolic
> refs in revisions.txt.  Yes, we have to update the documentation of
> commands like 'git branch -u foo' to make it clear that they can
> operate on symbolic-refs (not just "HEAD") that point to branches, not
> just plain branch refs.

FETCH_HEAD is not a symbolic ref, there's no other special symbolic
ref, HEAD is the only one.

> Maybe even a fresh page on symbolic refs?

Just for '@'? Then what? Are you going to manually inspect the whole
code-base to find in which instances is '@' going to be resoled, and
link the documentation of that command to this new symbolic ref?

Go ahead, let's see what you come up with.

>> Your approach is more like a hack,
>
> Now you're just saying rubbish.  Neither of the approaches is more of
> a "hack" than the other.  You've implemented @ as a revision, while
> I've implemented it as a symbolic-ref.

The former has precedents, the later doesn't. The former can be easily
documented, the later can't. The former is a simple single patch, the
later is bound to dubious changes. The former has no unintended
consequences, the later can have many.

So yeah, I'd say the later is a hack.

> Your approach requires less effort to document,

Your approach can NOT be documented.

> and my approach yields
> an implementation that is almost trivial.

No, it requires multiple changes, THIS is trivial:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1025,6 +1025,13 @@ int interpret_branch_name(const char *name,
struct strbuf *buf)
        cp = strchr(name, '@');
        if (!cp)
                return -1;
+
+       if (cp == name && name[1] != '{') {
+               strbuf_reset(buf);
+               strbuf_add(buf, "HEAD", 4);
+               return reinterpret(name, namelen, 1, buf);
+       }
+
        tmp_len = upstream_mark(cp, namelen - (cp - name));
        if (!tmp_len)
                return -1;

That's it, that's the whole patch that implements my approach.

> That is not the basis for
> determining which approach is "better".

Yes it is. If it can be easily documented it's a sign that you are
doing it in the right place. If it's *impossible* to document, it's a
sign that what you are doing is a hack.

If you need multiple changes all over the place it's a sign that what
you are doing is not a natural extension of anything. If it follows
naturally from what people have done in the past, it's a sign that it
is a natural extension.

>> it has the consequences we want,
>> but it has many other unintentional and undocumented consequences.
>
> Who said it wasn't intentional?  Yes, I agree with your criticism
> about it being undocumented: please help fixing this.

Why? Why document a hack all over the place? Especially when we do NOT
have to. We don't need this hack.

> It's very much intentional.  I _want_ these to work:
>
> % git symbolic-ref M refs/heads/master
> % git show M@{u}
> % git branch -u ram/master M
>
> In other words, I want commands that operate on "HEAD" to also operate
> on other symbolic refs similarly.  Is this an unreasonable request?

That has absolutely nothing to do with the '@' shortcut. Nothing at all.

The mere fact that we are discussing about random symbolic refs is
proof that you can't focus on the issue at hand.

>> If I find a single place where 'HEAD' is hard-coded, and your patch
>> doesn't replace '@' correctly, would you then accept that there are
>> unintentional consequences, and that this approach is no the best
>> precisely for that reason?
>
> You'd have found a bug then, and we must fix it.

So that's it. There's absolutely no way to convince you that your
approach is the wrong one. No amount of evidence to the contrary will
change your mind.

There's no point in discussing then.

> Why are you throwing
> useful features out the window simply because of difficulty of
> documentation/ historical inertia?

I'm not throwing any useful features, I'm implementing them correctly.

>> Ramkumar Ramachandra wrote:
>>> git branch X <any
>>> expression with or without a symbolic ref> works fine, and it has
>>> nothing to do with my series.
>>
>> No, it doesn't.
>>
>> % git symbolic-ref TEST refs/heads/master
>> % git branch -u origin/master TEST
>> fatal: branch 'TEST' does not exist
>> % git branch --edit-description TEST
>> error: No branch named 'TEST'.
>
> Are you reading what you're responding to?  I said:
>
> % git branch X @{-1}
> % git branch X HEAD
> % git symbolic-ref M refs/heads/master
> % git branch X M
>
> Will work with or without my patch.  This is because git branch <1>
> <2> runs <2> through the revision parser.

The branch commands that run through the revision parser are
irrelevant. 'git branch foo @' will work with my patch too.

> This will work with my patch:
>
> % git symbolic-ref M refs/heads/master
> % git branch -u origin/master M

Which is irrelevant to the discussion about '@'.

> precisely because:
>
> % git branch -u origin/master HEAD
>
> works.  And precisely because this does not:
>
> % git branch -u origin/master @{-1}
>
> In other words, git branch -u <1> <2> expects <2> to be a ref or
> symbolic-ref (currently limited to "HEAD"), not a revision.  It
> doesn't run <2> through the revision parser to check if it resolves to
> a ref.
>
> The following will not work:
>
> % git symbolic-ref M refs/heads/master
> % git branch --edit-description M
>
> precisely because:
>
> % git branch --edit-description HEAD
>
> does not work.  This is because git branch --edit-description <1>
> expects <1> to be a non-symbolic ref.  It doesn't even hard-code
> "HEAD".
>
> Why are you blaming my patch for existing inconsistencies in the UI?

Your patch is introducing more, and you can NOT document all the
changes you are introducing.

> There is one limitation worth nothing: a symbolic-ref can only point
> to a ref (or another symbolic ref).  The revision parser doesn't kick
> in at the resolve_ref_unsafe() stage.  So, it's quite non-trivial to
> implement what Thomas asked for (git symbolic-ref U @{u}).  However, I
> think my series is one step in the right direction.  I'd really love
> symbolic refs I can take along with me (so M -> master can be in my
> .gitconfig): we have to hook resolve_ref_unsafe() to the config API to
> achieve this.
>
> In other words, I'm thinking about the future of symbolic refs.

That has absolutely nothing to do with the '@' shortcut.

Since you can't talk about the issue of the '@' without mentioning
other random symlinks, it's basically impossible to have a fruitful
discussion.

And since there's absolutely no evidence or logical argument that
would convince you that your approach is not the right one, there is
no point in discussing.

-- 
Felipe Contreras
