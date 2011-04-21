From: Victor Engmark <victor.engmark@gmail.com>
Subject: git-gui push hangs
Date: Thu, 21 Apr 2011 11:42:17 +0200
Message-ID: <BANLkTimyQ6mmE90x+nZJG4A1wcT==MoFxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:42:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCqP3-0002XK-Ai
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 11:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891Ab1DUJmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 05:42:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51098 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab1DUJmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 05:42:19 -0400
Received: by bwz15 with SMTP id 15so1276730bwz.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=BqZAsh4YLFhuhpMQLbmJV1kqP1ebLKf0ibWCtOo6SvQ=;
        b=mI4yaR72zyl7Epe8GMmncGuIt9swFsYBzLS56vD8Rk8K82YNWjX2vvf/1jjbgJmh2P
         6NSJLkw8bI+Vm9aC2ymJvU5cBByryjIO9iIeJ+yLWm8kbY0MQipu0kIkjVeWU+JWwWJk
         Z8sW4duVhqa+VFe9DlIvwggzv2yg0v+l/Ac+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lPM9j02AtIsxFTymdbEI9XJg5EtV3ZNTab/fS50JM72Y6+nGsWbTHMGUIv9I0TDP9a
         idBZpg+F6hpT5qLyrfJwQKGqwW+q8UOHD2D/cWJp8YQo3iYEJ05A3LqJ57udR0kqCSEn
         gLHKt4X086bjAEh8jzuHV4+i2xiJ0TFTW2iiY=
Received: by 10.204.29.21 with SMTP id o21mr84770bkc.97.1303378937577; Thu, 21
 Apr 2011 02:42:17 -0700 (PDT)
Received: by 10.204.48.143 with HTTP; Thu, 21 Apr 2011 02:42:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171896>

Hi,

My normal procedure to communicate with GitHub from work is to use
HTTPS. This has always worked fine with the command-line interface:

$ git push
Password: [clickety-clack]
Counting objects: ...

While demonstrating git-gui to a colleague, I added a two-line change,
committed, and clicked Push. I left all the default options (Source
Branch "master" (the only branch), Remote "origin" (the only remote),
and none of the Transfer Options were checked. After clicking Push in
the popup window it was replaced by another window with the expected
"Please wait" message. No password prompt, no new messages, and it
hung for about a minute (CLI feedback is near-instant) before I had to
`kill -KILL` it. It wasn't responding to `kill -TERM`.

After falling back to the CLI and pushing the commit successfully
there, I tried to repeat the GUI operation to see if it would still
fail. Now it got even worse: After clicking Push in the popup window a
new window came up, but the contents were gray and stayed gray.
Another `kill -KILL`, and another try, and this time the second window
didn't even show up. The Push window was closed but git-gui hangs.
Repeated tries get the same result as the last.

git-gui version 0.12.0.64.g89d6
git version 1.7.1

Tcl/Tk version 8.4.19
Aspell 0.60.6, en_US

-- 
Victor Engmark
