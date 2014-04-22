From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: How to trim the fat on my log graphs
Date: Tue, 22 Apr 2014 15:50:37 -0500
Message-ID: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:50:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcheT-0003VE-6W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 22:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbaDVUul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 16:50:41 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:61739 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715AbaDVUui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 16:50:38 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so31459veb.14
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=szkrbLgmGId4pKoL/cz5zfli5l4BrcRT2OvszrYUrzQ=;
        b=fnAXU4hFYW8923HZUHW+0ixwWUqY0Lxp7bqUpH8mKERFVsR381qnQ/vcsMTot6mL4c
         aYEyrB2Vdm8kx49/404442nj6JvCQ6ohorMtNf17wOX5UdeFY0De3E+VvAsMfOlIPFkX
         ulte6xgKil2t16QJYnVJnmR99WosmxVTDrF6hVIsZ4Iq0znm8J++OATcDEhY4IckXAzz
         fMo9PUXxpnmXe8oHw9HvyCqLnMYeDExd4Sas8A3JVVB23GNgvuv5TbOw8ielio7pj8DC
         jBlO3v3hRCYaD1EyovEnPCKLHMAZS6k9lLjrjLxfCWt7zVob1qB2e8ruQMs+6yaPF4/S
         GL/g==
X-Received: by 10.58.49.10 with SMTP id q10mr41027852ven.5.1398199838021; Tue,
 22 Apr 2014 13:50:38 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Tue, 22 Apr 2014 13:50:37 -0700 (PDT)
X-Google-Sender-Auth: wBAWMQG1bjFzDp0cC5wQ41AyPFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246783>

My log graphs are pretty insane sometimes because we converted our
repo from SVN and haven't had a chance to delete all of the remote
branches. We still have quite a few (maybe 20).

When I do `git log`, I am shown about 10-15 vertical lines and the
branch I currently have checked out isn't even at the top of the
graph, it's burried somewhere one or two pages down. I think this is
really confusing and makes my log virtually useless. Here is my log
command:

git log log --graph --abbrev-commit --decorate --date=relative
--format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes

I realize the `git log` documentation has a whole section on trimming
history so it is more useful, but after reading that section I am left
completely confused and I have no idea which additional options I can
add to trim the fat on my logs.

Ideally what I want, for starters:
- The branch I'm on should be at the top of the graph (first commit in
the log graph should be the tip of my checked out branch).
- Commits in other branches that are not ancestors of the current
branch should not be shown.
- Merges *into* my branch from other branches should show the graph
line for that branch but allow me to specify a "depth", meaning for
example that ancestors that are 3 "parents" away
(great-grandchildren?) will not be rendered (the 3 is an example, I
could specify any number)

The goal is to weed out the really distant and irrelevant commits. I
really just want to see the commits that are closely related to my
current branch. Thanks in advance.
