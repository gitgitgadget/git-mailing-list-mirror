From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional argument
Date: Tue, 15 May 2012 21:15:21 +1000
Message-ID: <CAH3Anrr11eLiHkasdLxAWD9--B6QNq5-kFfO+Xg1F5xTDS56zg@mail.gmail.com>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
	<CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
	<7vr4umivr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, normalperson@yhbt.net, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 13:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUFiy-0004RI-LP
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 13:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025Ab2EOLPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 07:15:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60928 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2EOLPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 07:15:22 -0400
Received: by weyu7 with SMTP id u7so2398918wey.19
        for <git@vger.kernel.org>; Tue, 15 May 2012 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g0EHSaEVW+652N1uHkMlNIx6XrzSjbcBEXIsfGZLVkQ=;
        b=MmJWnW7dH7LMS+sG0a1x9MnF8FGBjv2cCg02Xz4NaZRyPH+5/rJCzCH2P21ZLXaFPw
         ZF/rMMgY7D1bqmHHWLWo/l1tTV0tzWkudQEKqe1qqQwS3RSLVBqLwi52igP6wRYtfY3i
         sWl9/7WW3+A/9i4GQorS7SG7tjDLhzqsKdQ6UcUexgsTrjWS+/o2hzUPJCFyXyV5PZm5
         Zgb5UWQe6m5pLbg1zkxu4KuffUURq7HMsANe54QX9n6VvMOJNFG9nb/3TWqSaLbtkGRK
         o9IOJ/IZXb0MyxBL2HfOJefexOe4DblqNzN2cJE7TxnAIdtoAnQ8pj7rpkoKxDiFZpsd
         Ca+Q==
Received: by 10.216.131.97 with SMTP id l75mr7576273wei.21.1337080521219; Tue,
 15 May 2012 04:15:21 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Tue, 15 May 2012 04:15:21 -0700 (PDT)
In-Reply-To: <7vr4umivr2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197825>

On Tue, May 15, 2012 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The only reason why the original is not ordered that way, as far as I can
> tell, is because "It is recommended that" was part of an existing paragraph
> when dd31da2 (git-svn: allow dcommit to take an alternate head, 2006-12-12)
> added "An optional ...", so it was tucked after existing paragraph without
> reading the resulting whole to see if "at the very end" was the best place.

Re-reading this, I don't think the advice:

    "It is recommended that you run 'git svn' fetch and rebase (not
    pull or merge) your commits against the latest changes in the =C2=A0SVN
    repository."

really belongs in the description of dcommit at all.

My proposed rewording for dcommit is:

"Commit each diff from the current branch directly to the SVN
repository, and then rebase or reset (depending on whether or not
there is a diff between SVN and head). This will create a revision in
SVN for each commit in git.

When an optional git branch name (or a git commit object name) is
specified as an argument, the subcommand works on the specified
branch, not on the current branch.

Use of dcommit is preferred to set-tree (below)."

There is a section in "REBASE VS. PULL/MERGE" which perhaps could be
reworded to include any points in the text I propose to omit from
'dcommit' which aren't already covered there.

jon.
