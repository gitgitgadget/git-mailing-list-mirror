From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: git-svn clone repeatedly fetch revisions?
Date: Mon, 20 Jun 2011 21:37:10 +0800
Message-ID: <BANLkTi=Lp6tunX4fRWkD_hGGJo9Fqvm9=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 15:37:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYefY-0006qU-TW
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 15:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab1FTNhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 09:37:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56032 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178Ab1FTNha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 09:37:30 -0400
Received: by yxi11 with SMTP id 11so2073732yxi.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=iUftYtwrdGJJc3pacnb/WPL4X21nrcAM7WRJvdGxMGg=;
        b=imsvoruV33QryIK2C1zYwCwYoyddmCYJ7zarJIuWvc32Y17II20IuBwrEy58Imnu+Q
         q5AcNTwZGE66gU867+QDtvT/sDcX5x2LshrLzavGnOaDJK1qjfYncBt0HMCRnOO0RsJN
         lRHy3DFl8r4DqvUXssVn2EDLypMHWlnxpYKIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=w87fjCYilO6gl/C6ujnJCXhfqSlo3vBtmoWMYYRq+jYHmWmJ0gBkeBBmLwy2fg1upL
         rDm6tAa64jQ7y4vvbkD0ee6GhfjF9f4gOyp8NKCYEo4yN5fWqbMi6a0LgmFBjzGbFvpH
         SBctOkBH9iIzjH1N4ueFtlK/QFULvyO4+aT4M=
Received: by 10.101.139.38 with SMTP id r38mr5525772ann.109.1308577050147;
 Mon, 20 Jun 2011 06:37:30 -0700 (PDT)
Received: by 10.100.250.20 with HTTP; Mon, 20 Jun 2011 06:37:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176067>

I'm cloning an svn repository which contains 10+ branches and a lot of tags.

looks like git-svn fetches branch by branch, and for each branch it
fetches all revisions, the problem I observed from its stdout is,  if
the branches contain common revisions between them, then those common
revisions will be fetched once for each branch, so if 10 branches all
have a certain revision, then this revision will be fetch 10 times, in
my understanding such revision should be fetched only once, right?
