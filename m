From: Scott Johnson <jaywir3@gmail.com>
Subject: Feature Proposal: Track all branches from a given remote
Date: Sat, 25 Oct 2014 16:34:30 -0700
Message-ID: <CAEFop41rvXCAawW7zWGzT251zWyyoMhQbg=5vtHzQrbk4W6D_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 01:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiAqy-0001eg-6m
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 01:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbaJYXec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 19:34:32 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:46877 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbaJYXeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 19:34:31 -0400
Received: by mail-yh0-f47.google.com with SMTP id c41so2869443yho.20
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cFw6dKwet7Al/NqvvapR6c5TYuqjDILL2DvrInmH8z8=;
        b=TDxsuZVlY9+B+kGxFw9dihNxmqZM81S7onEr4gIoW96S2bSnmGWXYlWHdufGpC/4c3
         Jcv1z7ccKFHF5UxjSHYCsKsIMR4O5uMp6SaiUqrdwYlac/LK47PR6SjkjEmmEXjdB4Ei
         zYmtlqpX2ufDGzmMs8OjGteUgJQKUVlVqbWgEv0VScJLa2Xcxi3UzRI1/fAoAk7kQRfA
         9aOCi9FLrJunpzKb3z0U1Dh/uEDsl2a+vQt2knM6NU82DKBpPacpVDE8J6muwJ6AD4bK
         Siay9ruXKbfGFaKu17eEqccTPKdR97W1z0DLRRbkOte2EJNWutRiRWVCkVY+6TlDywBi
         HeUQ==
X-Received: by 10.170.194.78 with SMTP id l75mr16218735yke.27.1414280070871;
 Sat, 25 Oct 2014 16:34:30 -0700 (PDT)
Received: by 10.170.132.210 with HTTP; Sat, 25 Oct 2014 16:34:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git experts:

Recently, I've encountered the problem where I would like to set my
local repository copy to track all branches on a given remote. There
does not appear to be a switch for this in the git-branch command
currently, however, I will admit that my somewhat limited
understanding of the git-branch manpage might be causing me simply not
to see it.

It seems as though this is a use case that some users of git encounter
now and then, as illustrated by this post:

http://stackoverflow.com/a/6300386/281460

I was thinking that it might be useful to add a new option to git
branch, perhaps something like:

git-branch --track-remote <remotename>

Where <remotename> specifies a given remote, and the command will
track all branches remotes/<remotename>/* to refs/heads/*.

So, for example, if I were to run:

git-branch --track-remote origin

and I had two branches on origin, master and maint, respectively,
after the command finishes, my local repo would now have two branches,
master (set up to track origin/master), and maint (setup to track
origin/maint).

I'm not entirely sure how to handle naming conflicts, for example if
'maint' already existed on another remote, and was set up to track
from that remote previous to this invocation of the command.

If I were to start work on a patch, would there be any interest in
this feature, or are there reasons why it isn't currently implemented?

Thank you,

~Scott Johnson
