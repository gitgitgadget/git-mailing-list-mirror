From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Coming from SVN world - need help
Date: Thu, 14 Jul 2011 11:38:14 +0530
Message-ID: <CALkWK0nboCCGWhcKMgv6Y4FWgfsdhatEf78sSQCAMcKe2HU0FA@mail.gmail.com>
References: <20110713183056.1cde5b61@shiva.selfip.org> <CABPQNSa1PO6je+4sXMRWLLwLG9sUNTD1a+SMJj=wdPF+_dUPHA@mail.gmail.com>
 <20110714110318.7726251c@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 08:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhF6H-0007Rd-5n
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 08:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab1GNGIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 02:08:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44123 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1GNGIf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 02:08:35 -0400
Received: by wyg8 with SMTP id 8so594459wyg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qkCazqLUCgDniRxV6HUtGbx5nUjVGSOmQ3KqglnMoVs=;
        b=jY7upQgGdlmweKVLcNblfMwUSBvEXn576C8TUo4KIIMPyTG+0XW2aW0bOM7oUN+Lzp
         hto/N7kGyoRIFPXPAvr0KbqYoslUPuiVXXeqX4JFtkdo53Ru5A5Zr7oXJ/cLTXw3FQNT
         fXkDTrpiaik7Qn0WAANOId+AnIaD6e62u4HSs=
Received: by 10.216.62.3 with SMTP id x3mr795170wec.77.1310623714329; Wed, 13
 Jul 2011 23:08:34 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 23:08:14 -0700 (PDT)
In-Reply-To: <20110714110318.7726251c@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177100>

Hi Bakshi,

J. Bakshi writes:
> Actually the practical scenario is different than just a bare repo. The repos should be connected with its working copy located at htdocs directory. So whenever someone commit anything in git the corresponding working directory should be updated accordingly with a post-commit hook. I have done the same in svn but don't know how git will help to achieve this ? The main part, How can I simply map the folder in htdocs with it's master in git repo ? As "git clone" actually creates the parent folder. In svn it was easy with

In the bare repo, set core.worktree to the htdocs directory*, and put
something like this in your hooks/post-receive:
#!/bin/sh
git checkout -f

* For more, read about detached worktrees in Git

-- Ram
