From: Adam Mercer <ramercer@gmail.com>
Subject: post-receive-email hook with custom_showrev
Date: Fri, 22 Feb 2013 14:57:41 -0600
Message-ID: <CA+mfgz1jrSbbZc7+asxfZivemYSvbB3+UxYx4sm3BwLmR0ELEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 22:05:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8znz-0007iQ-Ao
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab3BVVEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:04:54 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:64924 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028Ab3BVVEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:04:53 -0500
Received: by mail-qa0-f45.google.com with SMTP id g10so634038qah.18
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=kr7IAcj9q1A8VJ6zc5RrZX0HBGsfPrK7NOQfJC7kI64=;
        b=wfRHd4myU2mepM501JrBi8gdSW7Ji7/zpcdCEiB+uh3V5v5cagOkpjZgizAhp45Y+j
         4H9YYfZ/E5G0RTPuvax8ZU9aSmIo6Q1Ur5wbPRdA9mH+RnQjhUBGRj0KUGyMScHovhCt
         0XG6ihKjpW6NRSljgf73CICGYfGq+w4bQ0+wcqN28enxJfj3v4mbpvpJp5ntNqzXjVrp
         Gsyy9udRKt7GXcBWs395CAUoxXgtNDiHceT0uM8eje9YXBG30uENLxJ5L1aZnK+eEUfe
         pzi64XdVKXsDyx/fAzqa7xpU81Lzs3qxIX22OkelXzoE9Lx3xWbJHckCZDYxhCirXx3Z
         3MMw==
X-Received: by 10.49.62.129 with SMTP id y1mr1803479qer.28.1361566701868; Fri,
 22 Feb 2013 12:58:21 -0800 (PST)
Received: by 10.49.64.164 with HTTP; Fri, 22 Feb 2013 12:57:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216862>

Hi

I'm trying to setup the post-receive-email hook, from contrib, using a
custom_showrev, from the script I do this by setting hooks.showrev

# hooks.showrev
#   The shell command used to format each revision in the email, with
#   "%s" replaced with the commit id.  Defaults to "git rev-list -1
#   --pretty %s", displaying the commit id, author, date and log
#   message.  To list full patches separated by a blank line, you
#   could set this to "git show -C %s; echo".
#   To list a gitweb/cgit URL *and* a full patch for each change set, use this:
#     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
#   Be careful if "..." contains things that will be expanded by shell "eval"
#   or printf.

in my repositories config I have showrev set to:

[hooks]
        showrev = t=%s; printf
'http://server/cgit/repository/commit/?id=%%s' \$t; echo;echo; git
show -C \$t; echo

But in the emails from the post-receive-email hook I get something like:

This is an automated email from the git hooks/post-receive script. It was
generated because a ref change was pushed to the repository containing
the project "LALSuite".

The branch, master has been updated
       via  10f97dd6db3861e35e517301f6c1dec30be90012 (commit)
      from  8c7dfa89cec5ac0a5b9520967b92a927734611f0 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
-----------------------------------------------------------------------

Summary of changes:
 lal/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

So it seems as if showrev is being ignored? Can anyone see what I'm doing wrong?

Cheers

Adam
