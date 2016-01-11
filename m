From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Adding a commit to the front of my branch?
Date: Mon, 11 Jan 2016 07:36:25 -0600
Message-ID: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 14:36:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIceB-0002Dp-50
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 14:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990AbcAKNg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 08:36:26 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36640 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954AbcAKNgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 08:36:25 -0500
Received: by mail-io0-f174.google.com with SMTP id g73so152048932ioe.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=yPX/CuUbcUEN4RQ2TwnLBolloChQcpNU/gkbUvX7dIw=;
        b=fKy3Ng/Ps7s5xQHxC9tBJGGQz25hBwzI99DE4lt6aHoAaoT4rl1MNKOEkUgzwbc6iG
         kSJXWmxhSOfMaRbwMJ4hJoJMNRy+39ELKA3KBaK54BtIAS5Rh73j6kEhbIs4iw8yq6z1
         ynRqxqF9RmFREDEwIHy8tLebxwRMmrMZu8UE2oRlEHKFGnMGTyK9WdhbsU2AVz5gP6F5
         UzFq1riDMUISqHz8HxCkzLWjFh8bof/bnDVkuGcISgXxNKT0PO8i9Pd1mpQjmVdj+WUA
         wmkz4ZiPbDACUGuQED887+dxK/aiZarWAa5tglBJt7BL2Pfja3O0EBYh0qGP8UQfWEhN
         gleg==
X-Received: by 10.107.128.133 with SMTP id k5mr108846911ioi.26.1452519385156;
 Mon, 11 Jan 2016 05:36:25 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.83.83 with HTTP; Mon, 11 Jan 2016 05:36:25 -0800 (PST)
X-Google-Sender-Auth: OHKEqIJaMYXODPkEYbKPYp23v68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283650>

Normally to add commits on my branch, I perform an interactive rebase:

$ git rebase -i origin/master

I mark the commit I want to put the new commit on top of as 'edit'.
However, if I want to add a commit to the front of my branch, I don't
really have a commit to mark as "edit". I tried to be tricky with
this, and did:

$ git rebase -i origin/master^

However this doesn't work if my merge-base is a merge commit. I get a
ton of superfluous commits in my TODO file.

Is there a built-in mechanism I can use, with relative ease, to
accomplish this goal? At the moment I have to run a series of a couple
of commands to do this, namely mark the oldest commit on my branch as
'edit', reset it, stash it, add new commit, pop stash, commit again,
etc.

Normally I'd add a new tip commit and reorder it to accomplish this,
however commits on my branch already alter this code and I don't want
to create unnecessary conflicts during rebase. The patch needs to be
based on merge-base.

Any advice is greatly appreciated. I'm using Git for Windows 2.7.0.
