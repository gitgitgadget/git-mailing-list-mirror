From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git filter-branch --directory-filter oddity
Date: Tue, 3 Dec 2013 17:44:40 -0500
Message-ID: <CACPiFC+nCj8VMqb+aK-C5gMyX6R0dDba1U1U49KTktF3WDQ9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 03 23:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnyiJ-0002LS-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 23:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab3LCWpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 17:45:03 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:61391 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3LCWpC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 17:45:02 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so10380773vcb.23
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 14:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LzgiEoW1+wbJwHJcAs9IJIOQJQRMjBL898p8hBEh2Dc=;
        b=n2Zc9eGWi7aWoNNu+9ObNdWwdvO7cInH+xQ6mTq1Ajfb/ssmOwxs8nLOPav57CSt9P
         1CUsL816Eme+dX4a1p46CeztmqEAnDIQdJCds1Lz3Y2zQtmEmFXsWlz76gDDIb9VGdRz
         odf4U5+XIe0IHkg4a7lm++YUqbTnbjL40j6ShLs6BeyU3aFC3M+dN/lDoZfmq5gWqsdl
         nD3J5h1hWkLjNupLlOFi/GTFs0y0rn7OjC/EXnPvy7NuZ36RI1wxbbiM6GBb0aLiSD3A
         OFyIGTP4D52KXBhaewwjXpld3o7iGxlFM3513V+LThv3HTKKkuo3M6G5FJQrCyW/1rR1
         H0DA==
X-Received: by 10.52.233.2 with SMTP id ts2mr348637vdc.44.1386110700751; Tue,
 03 Dec 2013 14:45:00 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Tue, 3 Dec 2013 14:44:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238742>

When using git filter-branch --prune-empty --directory-filter foo/bar
to extract the history of the foo/bar directory, I am getting a very
strange result.

Directory foo/bar is "slow moving". Say, 22 commits out of several
thousand. I would like to extract just those 22 commits.

Instead, I get ~1500 commits, which seem to have not been skipped
because they are merge commits. Merges completely immaterial to this
directory.

As they have not been skipped, they are fully fleshed out. By this, I
mean that we have the whole tree in place. So these 22 commits appear
with foo/bar pulled out to the root of the project, in the midst of
1500 commits with a full tree.

The commit diffs make no sense what-so-ever.

Am I doing it wrong?



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
