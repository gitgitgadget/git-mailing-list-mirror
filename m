From: Matus Faro <matusfaro@gmail.com>
Subject: Distributed code review discussion
Date: Sat, 10 Jan 2015 13:05:35 -0500
Message-ID: <CAH5CKOqSc2qLZwhCrafYkXMvLmRxKeA_7OO+WzM2FQwKS9F3cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 19:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA0Pv-0006pJ-SV
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbbAJSFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:05:38 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37601 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbbAJSFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 13:05:36 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so6257437igd.2
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MXwULAVNSdR1UEsqVye4i7Qv/4LyHunOcqFjv6zQdas=;
        b=fmYXwpIsTfqtQ/6Uw2CCnLmhLrW3N44HLAwShCcniaOPtDRni40eGDX4badPYtW03y
         wtdocuUsSc9+xsGv4LzbDTM+qFrzUOZpCz+lincheuq2LHf/tZYhkg+i2jwXkjAfdn7L
         zVIIFvL2OwiwbvEHOp+RCiLmZQHAnbKKn34kEhTLnMg/qGkn7zAd0dB5JU1peKZLolZR
         ldq7MY9YOd0ahdw/bjAUEqaIaIlBRz6Arlxt4Y6Ff7AONRe59K2rIiUze5c1D58jEHpy
         A9AFOk0rxYOMvFvz2J1wD9C8RRSFEEdxb5U0rG96t1rnFr26HKoHHJ4WzMydtOhfe5K/
         m2YQ==
X-Received: by 10.42.161.7 with SMTP id r7mr17423379icx.75.1420913135319; Sat,
 10 Jan 2015 10:05:35 -0800 (PST)
Received: by 10.50.155.136 with HTTP; Sat, 10 Jan 2015 10:05:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262265>

Are there any plans for supporting merge requests and code reviews
natively in git?

What I mean is a distributed code review system where a merge request
along with review comments would be stored within the git repository
and allowed to be pushed and pulled between repository clones. This
would allow users to retain the code review history without relying on
centralized or proprietary third party solutions.

I am debating on creating a plugin for the current git suite starting
with a bash script as a proof of concept and eventually creating a GUI
via Tcl/Tk for best cross-platform support. The idea is to store the
code review metadata as empty commits within a branch. This is for a
number of reasons:
- Ensure backwards compatibility with all current git clients. Classic
git push, pull, merge commands will be able to move the code review
metadata around.
- Easy migration on and off of the distributed code review system. No
leftover metadata stored within the user's repository besides human
readable commits.
- If desired, empty commits can be easily squashed after merge or
summarized into a single commit to retain history.
- Commits can be created outside of the code review plugin.

Example commits:
"## Open refs/heads/distributed-review -> refs/heads/master --
Distributed code review feature"
"## Comment 71a3f9 src/review.c:412 -- Did you even compile this?"
"## Close 71a3f9 -- This feature is horrible, closing..."

Questions:
- Are you interested in adding this sort of functionality to git? I
would be very interested in contributing instead of working alone.
- Am I crazy? Do you see an interest from the community in distributed
code reviews?
- Any other criticism?

Thank you,
Matus Faro
