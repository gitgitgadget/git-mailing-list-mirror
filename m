From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 6/6] commit: add a commit.verbose config variable
Date: Wed, 13 Apr 2016 13:44:43 -0400
Message-ID: <CAPig+cQjOq_cKCa7_9CVG0tzd7x1aW9Wg4tZ+UvQUAvkPRWWHA@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60966-e9711378-3b22-4fbb-a2c7-f6876a6fb3c6-000000@eu-west-1.amazonses.com>
	<CAPig+cTcCyGu5Y8aHbE3i6fXh3T_mD0ZiuxPFh=DVHOE38pE5w@mail.gmail.com>
	<CAFZEwPN+N+21CN+P3oegaxEve59BKHabdfyM_c7QdjV+bonpQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:44:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOqR-0007eS-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbcDMRop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:44:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35724 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbcDMRoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:44:44 -0400
Received: by mail-io0-f193.google.com with SMTP id u185so7761552iod.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=hahjBFGKp3dRTzfhvOliMVwdaQZXXRNJxEcrDlIBGJ8=;
        b=s/Wnfv/ELz4UnnibgvPtx1sO+7KALt+4Ujnrqiwx3YCVhpmAB8yZ/xaaB28E4usJeU
         P+RE6LePVpoY+32a1atsipHN2nnM9WW62Sb3NzGf5q8VfjxUmHePJ9pgOfo7s6DjWlaW
         o2OrSEwhAL76a2aovZXsybdM6u9OEQZL521tU9tMN7tG9pRksNhKDR07x+2VC+sFbr+8
         e0cePDfejcxaIWj8jHYvd/r45UJnl6LSfsEOSzc86YohDG4HFA1aAoZLvMOJMLZHsCrw
         cOqh+UAndS+Bir2fDmNSQKbmsHOFUwCPTiLJO9wRrm5GyfO+xZAPxn05hPocl16z3n0N
         Qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hahjBFGKp3dRTzfhvOliMVwdaQZXXRNJxEcrDlIBGJ8=;
        b=ORWM4q23K9NB4sigsSgKC7y4kn5/qj5UVzIWa54silvFs+plmziZGEeftw4b6/yya/
         sauejtS08h/KOisQouuAet+fhoB2rGIZO0RmTnCDII+xwiNcCJwdKgG5YZN9Q+AxQxMH
         1FP00yBM7c4TMLwsijChmW+Fl7x+s3/scjbmDT4hlsifZ0ineGEMFZzH1qGzGKWJXesN
         tzxvsYMnyiSU3NPmownpjwFiDl0HssPwbLQD/fm6BPH4UQp0LqoCMn6MlVhQ9ZiDp033
         UU8P2IJpVwkZrnAzNoE38S1hDU7VvVguNmrKN8GtvzebUi48UgfD03x+oaVte2yoEH/T
         J+zA==
X-Gm-Message-State: AOPr4FVy9Q2ELecmWHfjMZv1qr52TBH5F05JNFd0DP0YIeQE+nTnpHzcmaE8ntNA0gdmlrr+rC3MenaMte+vqw==
X-Received: by 10.107.8.141 with SMTP id h13mr12846361ioi.34.1460569483859;
 Wed, 13 Apr 2016 10:44:43 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Wed, 13 Apr 2016 10:44:43 -0700 (PDT)
In-Reply-To: <CAFZEwPN+N+21CN+P3oegaxEve59BKHabdfyM_c7QdjV+bonpQA@mail.gmail.com>
X-Google-Sender-Auth: tRt9gbahcnagDHO8YzTZqxeZLFY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291468>

On Wed, Apr 13, 2016 at 5:15 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 11:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +test_expect_success 'status does not verbose without --verbose' '
>>> +       git status >actual &&
>>> +       ! grep "^diff --git" actual
>>> +'
>>
>> But what is this test checking?
>
> status is also a consumer of the verbose whose initial value is set to
> -1. This makes it include verbose in status output. This bug was fixed
> by explicitly initializing verbose to 0 if -1. SZEDER pointed out a
> bug[1] which broke some tests in and then when I fixed it, you
> requested me to include tests even in this patch[2] which I found
> convincing enough.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/289730
> [2]: http://article.gmane.org/gmane.comp.version-control.git/289993

Okay, makes sense, but it's not at all obvious from the context of
this patch or its commit message. It probably would have been clearer
had the two git-status tests been added in a separate preparatory test
with a commit message explaining that the tests are to ensure that a
subsequent patch (adding commit.verbose) won't break the existing
behavior of git-status. Having a separate commit explaining that would
also help future readers of the test script who wonder what this test
is doing (since it's not obvious and it's not explained by the current
commit message) when they use git-blame to try to figure out its
purpose. If you do re-roll, you might consider breaking them out to a
new patch or, at the very least, document their purpose in the commit
message of this patch.
