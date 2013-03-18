From: Jon Seymour <jon.seymour@gmail.com>
Subject: Recovering from a loss of sync between git and svn
Date: Mon, 18 Mar 2013 16:03:30 +1100
Message-ID: <CAH3Anrq4y54YA=qeEbO5z1FKB7Adg4G8vf4jmPLzLWa6tky0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 06:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHSEr-0000bU-Df
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 06:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958Ab3CRFDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 01:03:33 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:60644 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3CRFDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 01:03:32 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so5483485lab.23
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 22:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=IGLXunYzOqAvSxPbguSdCqNLXj5T/SYWxD5BSd5DKeU=;
        b=N7YJMZqI9ZHJphdLLHxJEm3UqS6KyZGvreUe6OHAX5p+p0skGOhrOcXM4aNRD+kT8E
         UJHCgnnFfyrfGUU8uN3lNeh5HHPARJPCG4h0jKmsqwRfwNPTw1xkBKEvQ+ZyKWJd6yEi
         YoH84trEBPdnPeiLefWIBqTKQoaHuoemo+5XNfC8Qt5RSNdjIG0YEwXIQzP5n6FudgBH
         59ZqBKfTNroCqM7TxFqGx0ToPUvm4rnWTxCPsNnqbj2CDxoFLb45IzX91FN0cRmqD4IX
         Rnd/lg3txMNqsxnUgwpZ+4cFIKe9qITclNElPy3jjAWcqU5i+fwYPE1vxYC/NNmsTNxj
         l1Qg==
X-Received: by 10.112.27.199 with SMTP id v7mr5651013lbg.44.1363583010873;
 Sun, 17 Mar 2013 22:03:30 -0700 (PDT)
Received: by 10.114.68.74 with HTTP; Sun, 17 Mar 2013 22:03:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218392>

G'day,

I managed to lose sync between the git-svn repo that I am using to
track an svn repo. In particular, the git-svn repo lost the content of
about 5 commits with the net result that the git-svn repo and the svn
repo it tracks have a difference of opinion about what the contents of
trunk are for the files involved in the missing commits.

The situation arose because I used --ignore-paths trunk on a
git-svn-fetch when I was trying to deal with an SVN user that had
copied trunk into the same SVN tag twice (which caused the source tree
to be duplicated under the trunk directory of the SVN tag).

I was hoping that --ignore-paths trunk would cause the git-svn copy of
the tag to exclude the unwanted copy of the trunk directory in the
tag. Instead, it appears to have caused my fetches of subsequent
commits to SVN trunk to be empty, resulting in divergence between by
git-svn repo and the SVN repo itself.

Does anyone have any tips about how I can fix this other than pulling
the entire SVN repo again?

jon.
