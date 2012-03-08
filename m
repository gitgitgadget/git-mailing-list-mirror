From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Thu, 8 Mar 2012 16:08:50 -0500
Message-ID: <CABURp0pd4wAw0ax5jjaoOR-bAWUGUQa-k1xby9_Bb_wQwsLk7w@mail.gmail.com>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org> <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
 <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com>
 <7vvcmgkq20.fsf@alter.siamese.dyndns.org> <CABURp0run5zYLBkUsNQEJq3h_1y7bQ44XZb9BPja+RjX8OLyfg@mail.gmail.com>
 <7vr4x3is39.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kaP-00065c-8u
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2CHVJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 16:09:16 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58772 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab2CHVJM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 16:09:12 -0500
Received: by lahj13 with SMTP id j13so963200lah.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 13:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rh3oGanoRCAxL3qxoktSdtE5xBq/QXhaF5RqetF8kIk=;
        b=I6zaT65Dlu4iw42A3xSCg1kZo7m7QREn5VqdjEAdq+jmWNiMCmI6oByt8rH+3KtNkE
         EEFkbKy4ohjGJq4MArz0TuL/A7Fhgt/5ie/1mxnOgvSoFDY8wryK5elaIjHRg17sWh3V
         8ejfnmNP5Jh9m8sc3zHM3eDMrnbYRf6Rc423DzyH3ZBXE3yjW8/+fDlF+zmatVx4ibYI
         Hw2bGIFkx8qS9GLB/K6g0a4FggKyVl0JjtOMdUjBAnN6Z5jnjQIHCE/On56KXsVSO2lv
         YMY3abgjGjlL0PpKL/HgOnDX2WzC/AAzsiCyAr9zr63C7fezERliDrPlo1jq3WKHebUg
         GlBA==
Received: by 10.152.112.100 with SMTP id ip4mr5661076lab.1.1331240950529; Thu,
 08 Mar 2012 13:09:10 -0800 (PST)
Received: by 10.112.8.133 with HTTP; Thu, 8 Mar 2012 13:08:50 -0800 (PST)
In-Reply-To: <7vr4x3is39.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192649>

On Thu, Mar 8, 2012 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>>>> .... 'mergetool' uses this command to
>>>> avoid asking the user to resolve files which git rerere already
>>>> resolved for her.
>>>
>>> Ok, so "Print paths with conflicts that are not resolved." indeed i=
s
>>> sufficient.
>>
>> If you goal is to say as little as possible, then yes. =A0But I had =
to
>> read the related commit messages several times before it dawned on m=
e
>> what the distinction was.
>
> The goal is "Concise, coherent and clear"; "as little as possible"
> never is. =A0We need to elaborate as needed but make sure we do not
> tire readers with irrelevant explanation.
>
> The first problem I had with the patch (go back and re-read the
> patch and its initial review) was "Like 'diff', but...". =A0It is not
> "Like diff" at all (if anything, it is more like "status", but
> "status" in turn is not "Like diff" either). We can first drop that
> part and spend more words to describe what it really is.

No disagreement here.

>> The main problem was that I didn't
>> understand that I was missing 'rerere.autoupdate=3Dtrue' in my confi=
g,
>> or why it mattered. I only know that rerere was letting me down
>> sometimes, and 'rerere remaining' seemed to be missing some
>> clearly-still-unresolved files.
>
> Personally, I think you are being *good* by not using autoupdate.
> Once you let rerere auto-update, it will become hard to notice a
> mismerge when previous resolution is applied when it shouldn't, and
> even harder to correct it ("checkout -m" will not work).

Slightly off-topic, but here's why autoupdate=3Dfalse is a problem, and
why I thought rerere-remaining was broken for the last year.  When I
rebase a branch, git magically plows through dozens of commits and
stops to tell me when there's a merge conflict that needs my
attention.  Not having a GUI means I have to do something (type
commands or parse output) to see what's happened.  But the solution to
"resolve these conflicts" is always the same:  git-mergetool && git
rebase --continue.

Except with rerere enabled.

  $ git rebase origin/master
   Noise, noise, noise
   Resolved 'foo' using previous resolution.
   Failed to merge in the changes.

I reach for my utility belt, but my usual tricks all fail at this point=
:

   $ git mergetool
   No files need merging

   $ git rebase --continue
   foo: needs merge

   $ git diff foo
   diff --cc foo
   index 5716ca5,7601807..0000000
   --- i/foo
   +++ w/foo

The last one looks to me, the uninitiated, like a file with no
changes. I know better now, but I didn't before.  The only thing that
works is this, but I didn't know why:

   $ git add foo

Now I know why, and it just pisses me off.  I thought rerere was
supposed to save me from this drudgery, especially when I am rebasing
the same branch multiple times (part of a migration effort).

I think I know the solution now.  'mergetool' should never have
ignored these files.  Instead, it should tell me about them:

   $ git mergetool
   Merging:
   foo

   Normal merge conflict for 'foo' was resolved using previous resoluti=
on.
   hint: to re-examine the resolution, use "git diff -c foo"
   hint: to accept this resolution, add it to the index with "git add f=
oo"

   No more files need merging.

I didn't know how to spell "diff -c" before, but I also didn't know it
was what I needed

>> Thanks to this proposal, I understand it better now. =A0But not from
>> reading this email thread.
>
> Care to give a crack at it, then?

Yeah, right.  Remember, it took me three tries reading the actual
commit messages to understand what was even going on.  I'm probably
too thick for this.

How's this:

-- >8 --
Subject: [PATCH] rerere: Document 'rerere remaining'

This adds the 'remaining' command to the documentation of
'git rerere'. This command was added in ac49f5ca (Feb 16 2011;
Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>) but
it was never documented.

Touch up the other rerere commands to reduce noise.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
Do you think the touch-ups are overkill?
Also, I think 'rerere diff' could use a rewrite.

 Documentation/git-rerere.txt |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.tx=
t
index a6253ba..b43b7c8 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted me=
rges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
+'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|=
'gc']

 DESCRIPTION
 -----------
@@ -37,30 +37,35 @@ its working state.

 'clear'::

-This resets the metadata used by rerere if a merge resolution is to be
+Reset the metadata used by rerere if a merge resolution is to be
 aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--a=
bort]'
 will automatically invoke this command.

 'forget' <pathspec>::

-This resets the conflict resolutions which rerere has recorded for the=
 current
+Reset the conflict resolutions which rerere has recorded for the curre=
nt
 conflict in <pathspec>.

 'diff'::

-This displays diffs for the current state of the resolution.  It is
+Display diffs for the current state of the resolution.  It is
 useful for tracking what has changed while the user is resolving
 conflicts.  Additional arguments are passed directly to the system
 'diff' command installed in PATH.

 'status'::

-Like 'diff', but this only prints the filenames that will be tracked
-for resolutions.
+Print paths with conflicts whose merge resolution rerere will record.
+
+'remaining'::
+
+Print paths with conflicts that have not been autoresolved by rerere.
+This includes paths whose resolutions cannot be tracked by rerere,
+such as conflicting submodules.

 'gc'::

-This prunes records of conflicted merges that
+Prune records of conflicted merges that
 occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
--=20
1.7.9.3
