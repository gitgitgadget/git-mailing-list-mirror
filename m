From: John Tapsell <johnflux@gmail.com>
Subject: RFC: Very useful script to SVG graph the git commits from a file
 orientated view
Date: Thu, 4 Apr 2013 13:36:36 +0100
Message-ID: <CAHQ6N+qLbrBKWhq8OGKco+JxiiLVOQvW09j3rLeZw265POZuMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 14:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNjPy-0004Nm-AH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 14:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759788Ab3DDMg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 08:36:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51321 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526Ab3DDMg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 08:36:57 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so2948367iec.33
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=0wJb3+PaXohovUflCcOJq3eKQMuIp4SZZ0YbBqTGZc4=;
        b=vKkco/mQ0dxOgyFo0E9vNfvz/3XUiuQUymNeoiXyDFMFFQi6dM6BJFKKgGYYKyoTE9
         TrwgVAy1a6ueEeOrALXZMJYxhJ0Q2+szZo6dhJQVd8OYXxGiRHiwD0iVVh82rpFPyxLC
         WMpnSk9TIdjLlX4j9j4DSOl5maEip1OTmLHkAq7FYbIqf3rrkfZzIvpJIpwY4GU8KZ5S
         LkVKcmurBd5XLrJe1+5fLHYOUxL7dVew71GWZ3lRdV73msZUOfNHMX+eh3RpCC10EIEJ
         wvGJLHq6r6rxdAUjyj4Xx60KwKAXD9Z1jQ0ZVPtMvubEygvBpSknG7MX3qJfsrCI7lHn
         d2JQ==
X-Received: by 10.50.184.132 with SMTP id eu4mr9832051igc.19.1365079016779;
 Thu, 04 Apr 2013 05:36:56 -0700 (PDT)
Received: by 10.64.18.168 with HTTP; Thu, 4 Apr 2013 05:36:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219997>

Hi,
  I made this script to help me see the logical connections between
commits.  It produces a .svg graph showing the commits that affected a
file.

For example, say you have the commits:

commit1 - modify hello.c
commit2 - modify goodbye.c
commit3 - modify hello.c and goodbye.c

It will draw a graph showing the first two commits as siblings, and
commit3 as a child of commit1 and commit2.

I have found this very useful when squashing and rebasing development
branches that have got a lot of "fix typo" and "fix"  type commit
messages.  From the graph you can quickly see which commit they were
fixing (the parent, in the graph).

Here is an example output, running it on kwin for the last 100 commits:

$ graph_git.pl --nofiles -100

http://imagebin.org/252754

And again with files for the last 10 commits:

$ graph_git.pl -10

http://imagebin.org/252756

(Note that it has tooltips)

JohnFlux
