From: Gary Fixler <gfixler@gmail.com>
Subject: `git log --graph` with multiple roots is confusing
Date: Sun, 29 Jun 2014 23:40:40 -0700
Message-ID: <CALygMcDXjMUcq=8ERVTES+5qNjLMe_OFPbmeqAosU7qmk=QuUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1VGf-0005CH-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaF3Gkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:40:42 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:47461 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaF3Gkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:40:41 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so7487020wes.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=fjz21MPnwdg58XNOyW7EQr8GmwrX8U5y9S3Xd64/OVE=;
        b=kpWQ0JZGudSCikDDHzwwdCrRXgsYdbUis8oNgFu5YGUsDYLfZp+q4uY40yNDNri17b
         6wxPYrBnWr/0Mc5hYKOm08yCsoIax5XE/wJy6xtUnw08s8fTYBiGZly2MqH6vLZ+NOJf
         w9pulzni5wh+PLhECZc5WiquR7il3BmbK8HS16IdEEDdH591iptYcCpy+2a9Kd2HLYe1
         ixJALvdN5dUCZJXcGFoO5lzcSurV7rceoHt5J2UxDLpFzHdmMB8k0PKce9+Lm357bH0j
         D6eBj0M1c3YiI2VungpeM1c/KJtaTrGpRIc1kW4DLIqSL60JmB0vSsFeTOZGz8pgS6t1
         EQCw==
X-Received: by 10.194.48.103 with SMTP id k7mr41469552wjn.68.1404110440492;
 Sun, 29 Jun 2014 23:40:40 -0700 (PDT)
Received: by 10.194.108.5 with HTTP; Sun, 29 Jun 2014 23:40:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252657>

I sometimes pull things in from unrelated repositories to rebase or
cherry-pick items from a different line of development. I've done this
to bring isolated features into a project in their own feature
branches with their full development histories, and also to extract
lines of development out to their own project, with their histories
intact. These are usually not connected commits, but things I have to
track down across time with `git log -S` and friends.

When I `git remote add otherrepo <url>`, then view things with my
aliased `git log --oneline --all --graph --decorate` alias, I'm
usually immediately straining to figure out what's what, as the two
trees stack onto each other with no separation. It would be nice if
root commits used something other than *, and/or if they could be
colored differently by default, or via some option to make them stand
out as parent-less commits.

Is this feasible, or already possible?
