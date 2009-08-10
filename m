From: Lucian Adrian Grijincu <lucian.grijincu@gmail.com>
Subject: give a hint/solution for "It looks like git-am is in progress. Cannot 
	rebase."
Date: Mon, 10 Aug 2009 17:34:04 +0300
Message-ID: <acf3f2e60908100734l6388d9a8k90ed835304a69918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 16:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVxI-00012W-W3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbZHJOeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbZHJOeY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:34:24 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:49536 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZHJOeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:34:24 -0400
Received: by fxm28 with SMTP id 28so949293fxm.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=UwQfyCpy+EeXK0UkJw3qaJIVMWzcOQatO2Jp7iRLmeE=;
        b=JBT5i2bNIutD2UAYlvTsOGC4bQQxSa45zKRLEi4Fo4RD0lhAVxC8qYQXKDpAH2qL96
         BhIajfZcJRsGi020ZytBPdfhkM4szOR7qF7Hyd2LGEx9nBty68Ip0UhjJb81kt4MyBv5
         OmbEERNmTLByxoSEcq7jmfZ4vyP4qyXWyAi9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=M+ooVj8oFRJ59wKglnk6+O0kZhjQQH/Bhf3wNo1X4lGdm52holuHDKZBr7YL9PEmZb
         RH8Ff1zmsmsBTcclrwiS5/Nn86G0zXGG9Ah0IzPI6l/ZhO/mMXKNx0GqWCW4c56puCNV
         fY2O5u54tI9g9sR4fCOqAMXMvP0Y7FCOvV2yo=
Received: by 10.103.240.15 with SMTP id s15mr1904574mur.45.1249914864198; Mon, 
	10 Aug 2009 07:34:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125450>

Hi,

I ran git-am instead of git-apply on my repo. The git-am complained
about the input data, I completely ignored it because I never use
git-am (except on typos + tab-completions like today).

Later, after a few commits I wanted to rebase (interactively) my tree
to merge a few commits.
  $ git rebase -i HEAD~4
  It looks like git-am is in progress. Cannot rebase.

Ok, the message is nice, it tells me it can't do something, but I'm
stupid enough not to know how to proceed.
I see that this message is the same in HEAD (master and next).

It would be nice if git would output one or two hints. For example:
* run "git cancel-a-git-am-in-progress" to cancel a git-am in progress
* run "git commit-the-git-am-in-progress" to commit the git-am in progress

Of course, the commands need to be replaced with some valid git
commands, but I don't know which those commands are :)

The message is generated in git-rebase.sh by this code:
  test -f "$GIT_DIR"/rebase-apply/applying &&
  die 'It looks like git-am is in progress. Cannot rebase.'

For now I think I'll `rm -rf .git/rebase-apply` (and hopefully not
break anything).

-- 
 .
..: Lucian
