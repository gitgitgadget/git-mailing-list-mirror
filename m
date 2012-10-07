From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Applying git technology to fix the locate command
Date: Sun, 7 Oct 2012 14:39:57 -0400
Message-ID: <CAKON4OzyAt-e0Ygj=7+Ze7ywU+RNTsi-Nn5huCnEWy8o=a-EUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 20:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKvlz-0001sz-Ok
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 20:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2JGSkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 14:40:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48520 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab2JGSj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 14:39:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7619590iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jFxBNCgqLwJVeby0Ps6j3AHAQVLV7u6rimjIkwWpq/8=;
        b=TGlklqFjZl+doRb6AuUXmvUvlJZC6kd8YZvytrrCEB3uwDq6hi3UyT0H4s93iY+zK1
         GHCGXBJkyPJSVZkUTz1W8YvUFi8+PwETxVMywb+V2tQ12Bkh8g/9PkhRpomynp37wp6m
         BntNdT6brCCsis6ZtL/aCcNCt84OuFIeWGtsS9JVg0EDbsZ9ycimPl7j8iQ3PWonxFxe
         WsbCkKcgdAl5+qO4FXH/oQImF7b9JYE8ljzFoIh8u52kADG4Y8i+YnrDQk4L0jqY40F4
         xG8gwZkX4bOjjXyFgxBHa2QzBJ9dkYd1oLF8dS5vVUNngrwvueWIOrlMxaXAB49rqzmG
         CrfQ==
Received: by 10.50.13.133 with SMTP id h5mr6261522igc.2.1349635197952; Sun, 07
 Oct 2012 11:39:57 -0700 (PDT)
Received: by 10.64.55.234 with HTTP; Sun, 7 Oct 2012 11:39:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207186>

I've been using the Dash HUD in Ubuntu and it's performance is
terrible to the point of being unusable. So I started top and noticed
that it was forking 'locate' and locate was pegging my CPU at 100%
while I tried typing into their incremental search.

Next I looked at the mlocate database. It is 350MB on my desktop and
indexing 10,388,379 files. Not quite sure why I have 10M files on my
desktop - probably because links are making files appear multiple
times.

Typing a non-existent string into locate takes over 10s to respond and
that's with the db cached in RAM.

jonsmirl@terra:/$ time locate lelelekddmd
real	0m10.645s
user	0m10.537s
sys	0m0.064s

Git has to deal with similar path compression and it responds pretty
much instantly. I'm wondering if any of you git gurus could apply some
knowledge from git and use it to fix locate?

-- 
Jon Smirl
jonsmirl@gmail.com
