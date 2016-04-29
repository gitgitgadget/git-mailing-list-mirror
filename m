From: Andrew J <andj2223@gmail.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 19:11:51 -0700
Message-ID: <CAH6n4TdYOKT_e4MziZ1qwAX+xZ_3NJEHcKgTRK1BqAUd_mvYOQ@mail.gmail.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
	<xmqqtwil65nx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 04:12:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avxuS-0001d0-W1
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 04:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcD2CLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 22:11:53 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33686 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcD2CLw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 22:11:52 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so996292igc.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=VQWBoRIFQcLU4myg491HEKxFu2cSCnrTvFavJCxf3N0=;
        b=nIYBB8MKY1hL2qGX5GeXtd7o/kAI207X5I+CDSFwUuav/7iKegQ/NKyNIU8biB5vSV
         LetkiU6rFTx7PnCx3o81u/+hYYh+Unio8E70o71Rdy4IXQdeZ76pgEUqhFPFveFu3N0B
         FVYaxRyq/n0BRUKoMezY5mY55iGds4nY/7jZwQEBlO1I7UG1H0qLgcaD5egDpYdckwiu
         oywqAk31PmYS11/YnQ81jFBM6zEW703R5SLRTHA3rCYRdvjjSo4pqMwV9rJw3cJybEPK
         xAe0sUQEO40vDRmTD58hq2ezgYldv6I/aZl0W9vyoavX+ftBnZy67lLvQarMET2tiat5
         Y1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=VQWBoRIFQcLU4myg491HEKxFu2cSCnrTvFavJCxf3N0=;
        b=XiCmJCcdHpDeqvd4ps7L+rZ/lw7qhMzOjWKx2RJ6Z/HsFL7cOWSR4FJx3J2XR9TX11
         NpvPVgCCkyPPVtJLW1sj/y0sHs+F6boxGBn4XvPRVvhzBzUPtNeIAPjvinNmOAVyzrgE
         aTcNPPPW2exRoQC3JtX5TGLT583Mm0vGPLlGGBjOhXjBn9ECebl2W6Bnh/ZNObimbHnc
         iPcpRxZxSCP+Qq/+kdXgWllfGMih+UfKUOundNaSp2nE3bqcFEeYVaYW8HXf7P1FOvBk
         gxzie/2KarcGKvm6nCZjZe1Xv7dHJwspDSqz4R2jHPucx9i0ppN8DdkbU0P4VMhU5VN3
         vB9A==
X-Gm-Message-State: AOPr4FUiBx3HcAON1qnY1YJK4+YU0wqUJOp1Zz2dTNQehSQEJdc2se7vM7a3k/uX97FZLg/I2yl3pe1/X73I9g==
X-Received: by 10.50.22.65 with SMTP id b1mr1298173igf.39.1461895911389; Thu,
 28 Apr 2016 19:11:51 -0700 (PDT)
Received: by 10.107.10.219 with HTTP; Thu, 28 Apr 2016 19:11:51 -0700 (PDT)
In-Reply-To: <xmqqtwil65nx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292966>

On Thu, Apr 28, 2016 at 9:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> When given multiple paths, e.g. "git add A/B/C A/D", it tries to
> "optimize" things by first finding common leading directory (in this
> case "A/") and doing something slightly different, and I think the
> bug Andrew saw lies in that codepath.  It is likely that the code is
> forgetting to make sure that there is no top of enclosed working
> tree in the common leading directory part of the path.

Actually, the very simplest case succeeds in adding a file from a nested repo:
==
$ mkdir parent
$ cd parent
$ git init
Initialized empty Git repository in /home/ajohnson/parent/.git/
$ mkdir subrepo
$ cd subrepo
$ git init
Initialized empty Git repository in /home/ajohnson/parent/subrepo/.git/
$ touch subfile
$ git add subfile
$ git commit -m test
[master (root-commit) 7480a2f] test
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 subfile
$ cd ..
$ git add subrepo/subfile
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   subrepo/subfile
==

It is this more complex case that fails to add the file from the nested repo:
==
$ mkdir parent
$ cd parent
$ git init
Initialized empty Git repository in /home/ajohnson/parent/.git/
$ mkdir subrepo
$ cd subrepo
$ git init
Initialized empty Git repository in /home/ajohnson/parent/subrepo/.git/
$ touch subfile
$ git add subfile
$ git commit -m test
[master (root-commit) 36adec4] test
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 subfile
$ cd ..
$ touch parentfile
$ git add parentfile subrepo/subfile
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   parentfile

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        subrepo/
==

Given that the very simplest case of adding a single nested file
succeeds, I had assumed that the intended world order was to be able
to add files from nested repos, and that the more edgy case of adding
a mixture of files from the parent and nested repos failing was the
bug.

For my part, I'd *much* prefer to be able to add files from nested
repos, so all this "adding any files from nested repos is a bug" talk
is bumming me out!

Thanks,

Andrew
