From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] t1020: cleanup subdirectory tests a little
Date: Mon, 18 May 2015 11:36:49 -0700
Message-ID: <CAGZ79kZjjKD6J3bQ0SWBUO-6bTY1Ld=Y7mRHVbw+RO5AFN+r5A@mail.gmail.com>
References: <1431972817-18178-1-git-send-email-sbeller@google.com>
	<xmqqwq05buz1.fsf@gitster.dls.corp.google.com>
	<xmqqsiatbuwb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens.Lehmann@web.de, "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:37:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPuM-0007UI-AH
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbbERSgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:36:53 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36456 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbbERSgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:36:50 -0400
Received: by iepj10 with SMTP id j10so29578065iep.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=shna5hFh0AcW8QtihN2LQUgq+dFeMM7KvkZNoTaAeG4=;
        b=W9EXNju/MC54tAfeb0H+TBA83NrBlj5Sjr9nHHZ/PkCq8rGSyt7Ljr8G5Hn85cxUbm
         G1iXwIUMHHUye+HbVivNrH9ExWGACRQxnT8g+TzoqaWjBVij6c0SLZ/JuB52P1zlM60g
         LdLbEnxI8/TB+dnwMfsaRZhlRLpqAebBiVMlJZxFUCbzYlxRJRXM9Fs9Cq2qbMKD7KzJ
         au0blxQzsgQOx9HVTMN6sawwmU5GOxVqGb7iA8TezvsZplqzOfkzLht5cmVqpqVDg7mL
         se7t/u4gvMq3LsmWWCO19UzR/M+dHgaeSoOg7f3/CdGuUud9zzZW9TgGhKnzMhhtnFOH
         iYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=shna5hFh0AcW8QtihN2LQUgq+dFeMM7KvkZNoTaAeG4=;
        b=CuPiYrd4jrJeCNW6cjRKEfawo3eL3XR5/xDD8h+JXckV1Gm/rRAN4865pSfYuDBDSk
         TEAATu+4UStDQozAtDtykBF5JRABjZJLCFrcxHEj0X8RoIggzLDhNacBerbShxtvOO+d
         f9x/3WnK0WYN1Wsj1oDD+D4LMyZrxr5U225XKmYkhfsTBYs8TUAO48bTkAT/P/I3Jtk8
         bNlkW4sdU5zrYtSO1zN8r3M9n7fxLHxb3pdob65j//MFjn9f3Rgppoo+pETkyAtZXoiv
         u9xWk6lSj6UhmLg8zE3B6PTQLxIEpSURJH65yOd1ZBQeyaWVtiRsGSNnJYjj8F3WSoIp
         Y07g==
X-Gm-Message-State: ALoCoQmfOzYkyga91oEDg5hPsK/9crbK8PfgYxEJAjpDwY/AW//CUad9dsemCoxEr/Z1ivVVRLIO
X-Received: by 10.107.132.223 with SMTP id o92mr31524936ioi.49.1431974209956;
 Mon, 18 May 2015 11:36:49 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 11:36:49 -0700 (PDT)
In-Reply-To: <xmqqsiatbuwb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269296>

On Mon, May 18, 2015 at 11:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> When looking through existing tests to point out good style I came across
>>> t1020, which has a test commented out and the comment wasn't helping me
>>> either of what the test should accomplish in the future. The code of the
>>> test is the same as the test before except setting GIT_DIR=. explicitly,
>>> so it did not ring a bell for me as well.
>>
>> I think this one should be clear, especially if you did notice the
>> one that sets GIT_DIR=. explicitly.  It is saying that "git show -s
>> HEAD" inside the bare repository should be intelligent enough to
>> realize that it is inside bare repository (hence HEAD cannot be a
>> file in the working tree); the user's asking for "HEAD" therefore
>> must mean "the tip commit", and never "(by default the tip commit)
>> filtered to the pathspec HEAD".
>
> I forgot to conclude that sentence: "... and it should be able to do
> so without the help of an explicit GIT_DIR=."

Not sure I follow you there. So currently there are 2 tests having the same
name, and doing exactly the same thing, apart from setting the GIT_DIR
and one of them being commented out.

So I don't understand, what should be tested *additionally* in the second test,
where GIT_DIR is not set. (The naming doesn't hint at testing explicit GIT_DIR,
so we test the  'no file/rev ambiguity check inside a bare repo' again.)

Maybe this diff is better for review:

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 2edb4f2..4470ede 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -163,24 +163,15 @@ test_expect_success 'no file/rev ambiguity check
inside .git' '
 '

 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
+ test_when_finished "rm -fr foo.git" &&
  git clone -s --bare .git foo.git &&
  (
  cd foo.git &&
  GIT_DIR=. git show -s HEAD
  )
 '

-# This still does not work as it should...
-: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
- git clone -s --bare .git foo.git &&
- (
- cd foo.git &&
- git show -s HEAD
- )
-'
-
 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
- rm -fr foo.git &&
  git clone -s .git another &&
  ln -s another yetanother &&
  (
-- 
2.4.0.194.gc518059



>
>> If it does not still work, shouldn't it be marked as
>> test_expect_failure instead of being commented out?

When commenting in, it doesn't work because
git clone -s --bare .git foo.git fails, as foo.git is already there.

That problem removed it succeeds.
