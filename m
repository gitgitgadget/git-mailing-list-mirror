From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 14:14:56 +0530
Message-ID: <CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org> <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
 <7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 10:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unm7C-0000Po-Lx
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 10:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab3FOIpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 04:45:38 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59035 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab3FOIpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 04:45:36 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so3120183iea.25
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XgWaMPCWEWKSrBv378s8VySt0geTt5yFAIdcKYB9E8w=;
        b=zVz1TFdu7EMD4vYz0OLM69Hr+uJCnz9S43fCJcfFVSUTH/cgi6CxPdVsknfrL8/3FQ
         F97iLM3/dM+tjmoIMXlb2vSnliFXDQ2wQzXZqrylLtUhBLKqVmy+oXSg9AOjxh7Rqn+t
         Tj/iq8dDxirZSPDKqVtFyCbi8CmpTi700ADhPeclwlUikH4qffdZagt/pOwUASEICDvu
         9G2F9P7t/L+xO+dmqAvbWePMDUJdRWgUw4wKeMKqgh/+FecvI/KQbanUvFPPHVR54LX7
         M7OY7413Zczildp49rICiizjgXkf1baSgWPZLUaZscP7z8msfwT10BqnsjO+hT/su80s
         rnqg==
X-Received: by 10.50.18.80 with SMTP id u16mr669408igd.13.1371285936280; Sat,
 15 Jun 2013 01:45:36 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 01:44:56 -0700 (PDT)
In-Reply-To: <7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227936>

Junio C Hamano wrote:
> I am only saying that the last test the commit adds must be kept
> unbroken.  I am also saying that, even though that commit did not
> add a test for "detached from" case, we should add something like
> the attached to protect the behaviour.  These two are sacred.
>
> What happens to be shown during a stopped "git rebase" is not.
>
> I have been assuming the "main" thing Duy wanted to do was the last
> test (and the one below), but was this meant as an improvement for
> "git status" output during that state?

On what basis are you making that assumption?  b397ea4 did not add a
test for "detached HEAD from", and there is no evidence of what the
author wanted in the commit message.  What has happened has happened;
the question is: what do _you_ want now?

Read the various "HEAD detached from/to" messages in the rebase tests
in t/status-help and tell me that they make some sense.  It does _not_
show a constant "HEAD detached from $onto", contrary to your
assumption (evidenced by your patch in the later email).  Look at these
hunk added by b397ea4, and tell me that it's not a monkey-patch:

@@ -187,9 +187,10 @@ test_expect_success 'status when rebasing -i in
edit mode' '
        export FAKE_LINES &&
        test_when_finished "git rebase --abort" &&
        ONTO=$(git rev-parse --short HEAD~2) &&
+       TGT=$(git rev-parse --short two_rebase_i) &&
        git rebase -i HEAD~2 &&
        cat >expected <<-EOF &&
-       # Not currently on any branch.
+       # HEAD detached from $TGT
        # You are currently editing a commit while rebasing branch
'\''rebase_i_edit'\'' on '\''$ONTO'\''.
        #   (use "git commit --amend" to amend the current commit)
        #   (use "git rebase --continue" once you are satisfied with
your changes)
@@ -214,8 +215,9 @@ test_expect_success 'status when splitting a commit' '
        ONTO=$(git rev-parse --short HEAD~3) &&
        git rebase -i HEAD~3 &&
        git reset HEAD^ &&
+       TGT=$(git rev-parse --short HEAD) &&
        cat >expected <<-EOF &&
-       # Not currently on any branch.
+       # HEAD detached at $TGT
        # You are currently splitting a commit while rebasing branch
'\''split_commit'\'' on '\''$ONTO'\''.
        #   (Once your working directory is clean, run "git rebase --continue")
        #
@@ -243,10 +245,11 @@ test_expect_success 'status after editing the
last commit with --amend during a
        export FAKE_LINES &&
        test_when_finished "git rebase --abort" &&
        ONTO=$(git rev-parse --short HEAD~3) &&
+       TGT=$(git rev-parse --short three_amend) &&
        git rebase -i HEAD~3 &&
        git commit --amend -m "foo" &&
        cat >expected <<-EOF &&
-       # Not currently on any branch.
+       # HEAD detached from $TGT
        # You are currently editing a commit while rebasing branch
'\''amend_last'\'' on '\''$ONTO'\''.
        #   (use "git commit --amend" to amend the current commit)
        #   (use "git rebase --continue" once you are satisfied with
your changes)


> Showing $ONTO certainly
> makes some sense, and from that point of view, the change we are
> discussing _will_ be a regression if it just shows a random thing.

If showing $ONTO were the intent of the patch, this is no way to go
about it.  Reliable information is readily available in
.git/rebase-apply; no parsing is required, and it is ready for
consumption.

Your argument now is: because the patch _incidentally_ shows $ONTO in
many cases (as evidenced by the hunks above), the objective of the
patch _must_ have been to show $ONTO.  Should I laugh or cry?

> If you want to avoid regression, the codepath in wt-status.c should
> compensate for the change to "rebase" so that it checks $dotest/onto
> and show what is recorded in there.

Now you want to achieve the exact same accidental behavior after
patching rebase/checkout.  This is a never-ending nightmare.

> You are misreading me.  I am not defending every bit at all.

I am not misreading anything.  Despite me having repeatedly shown that
b397ea4 is poorly done with far-reaching unintended consequences, you
are unwilling to admit it.  Instead, you are trying to somehow
preserve this accidental behavior.  And you still haven't been able to
show me how to do that.  As a result, checkout-dash is stalled.
