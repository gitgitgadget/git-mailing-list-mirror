From: Allan Caffee <allan.caffee@gmail.com>
Subject: Is there a way to fetch commits that are detached
Date: Tue, 24 Apr 2012 14:49:28 -0700
Message-ID: <CA+jCPNcmcxQcSN_BNvigQa2uRiaw-c2PK5T-y1yacYNs6Ws4WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 23:49:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMnc6-0002Y6-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 23:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab2DXVt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 17:49:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59786 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab2DXVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 17:49:28 -0400
Received: by iadi9 with SMTP id i9so1532611iad.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=fV0zRQ8g8dH5Cuh901EFayJRa4PezTq08/xya7Bxc1E=;
        b=R8IlwVGoTjwegwYrp1ZuaWN4X8exMHN/wySN3Mr6F+xVkJMcRyHPz+yJP5QLPwRwFK
         Z7XnurUnwO+WPciu7fAEODw2FIoCxL7jdsqOQ4R4aFFb5xiMq1HSTVD2rQQJpWbwvRA9
         KOzgDlPH8VGP+WiUvotH6qdRTYZx0NcnO6Y1Ntd9MXM/ijnxyDs9hqXFihcQqUZyJr7L
         ZH1Z+x5WZZbL8fChttjFk4SWsKz0pfsZIFsDeGKsryx0fAIXqGiDek9MBBIAZMmvVapa
         18+cTR3lDS08k4MPhZonoMzDTqhC6IFI+MKvAYfa1pQbeDPGR8u5JPlkT3MA3wqIfBvO
         Qr1A==
Received: by 10.50.153.134 with SMTP id vg6mr11948390igb.38.1335304168371;
 Tue, 24 Apr 2012 14:49:28 -0700 (PDT)
Received: by 10.231.224.75 with HTTP; Tue, 24 Apr 2012 14:49:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196253>

First some context: I'm trying to use the pre-receive hook to run some tests
on a Hudson server before accepting the updates to a branch. At the moment I'm
trying to have the Hudson job clone the repository (using the "git" protocol)
and checkout the new ref as a detached head e.g.

$ git clone $GIT_REPOSITORY repository
$ cd repository
$ git checkout $GIT_COMMIT

But the checkout fails, apparently because the commit object hasn't been
pulled into the local repository. Only a pack file is present in the local
repository's objects directory which presumably doesn't have the commit.

Is there a way to explicitly fetch whatever objects are necessary to checkout
the commit?

Would I be better off using git-archive to tar up a copy of the source
instead, or some other means of copying the codebase over for testing?

Thanks,
Allan
