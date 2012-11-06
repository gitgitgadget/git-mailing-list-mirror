From: Samuel Rossille <samuel.rossille@gmail.com>
Subject: [git-svn] [bug report] Index in strange state after git svn rebase
Date: Tue, 6 Nov 2012 15:37:58 -0500
Message-ID: <CANMyAQmJuRpwj67Bwzz1LmoChKVhOjCFOc0mqBHYsc_oQLx0uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Samuel <samuel.rossille@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVpuX-0004h2-1V
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 21:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab2KFUh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 15:37:59 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47793 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab2KFUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 15:37:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1273509iea.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=htfxlFN72MxN3oEuCJQ114cZuSSYRhLlkIFmUHHqnU0=;
        b=y2uvmDoJeAXgBP00O4VXr/KT7l4FdxRjcLiy/CZ9C1yMugeCZMY3W1bcJCiJdCeE22
         U/NuNve+mCF2fx3BRkglAsvHmCL1WfOdyxC7u9yrJjwUseBlvRqkr8d/jzJ1W/66JtDp
         rdfzlKp+shUUXvFQABBZGrq5Mb0r5dvE3UIDURuseJ1dcApf8B+NHPAbGRnE7yZ7xiyf
         CshI6IUwTd8kOm7yK2MrUw2clYwi9XwumqsYcHlyJaI4X57zHrwWjvI9+/4zdbtHTNca
         kl2yxWcdLZsfpjP7KDmgLyy/JTg3cxq7lpnhfUvI7/PCK1zchhvK+egT1dWafiDaHI+u
         vPxg==
Received: by 10.50.213.1 with SMTP id no1mr14486303igc.64.1352234278662; Tue,
 06 Nov 2012 12:37:58 -0800 (PST)
Received: by 10.64.34.33 with HTTP; Tue, 6 Nov 2012 12:37:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209120>

Hi Everybody,

Please Cc: me, I am not subscribed

I'm encountering an issue with "git svn rebase". Included in this
email is a summary of the issue, and it is fully detailed in this
stackoverflow question:
http://stackoverflow.com/questions/13183534/why-does-git-rebase-leave-opposite-sets-of-modifications-in-the-stage-and-the

I and several other people think it's a bug, but I could not find any
reference to it in the mailing list archive.

Some people have the same issue with the same svn repository, which is
quite large.

Unfortunately I have not been able to reproduce it completely from
scratch with a new svn repository. I seems to happen only on large
repository with a lot of history, branches, and files.

Here is the summary:

*What I wanted to do:*

In a branch tracking an svn remote, fetch team's content and rebase my
commit after them.


*What I did:*

Git version: "git version 1.7.10.msysgit.1"
With a clean working copy and empty index, I typed: "git svn rebase"


*What I expected:*

Fetch a couple of commits, then a successful rebase, with at the end
an empty index, and a clean working copy.


*What actually happened:*

Fetch a couple of commits, then a successful rebase, with at the end
an index containing modification that revert my commit, and a working
copy containing the expected content ("the revert of the revert")


Please feel free to contact me directly or via the SO question for any
useful additional information.

Thanks,
Samuel Rossille
