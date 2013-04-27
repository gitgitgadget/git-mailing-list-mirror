From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Making a (quick) commit to another branch
Date: Sat, 27 Apr 2013 16:21:31 +0200
Message-ID: <CALZVap=9Z=0DPM1fNwotn3sN-W7mXMPRSJ2aY5jzkQTBD6v=Kw@mail.gmail.com>
References: <517BDB6D.8040809@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 16:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW60j-0007fc-Aw
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 16:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3D0OVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 10:21:53 -0400
Received: from mail-vb0-f45.google.com ([209.85.212.45]:58380 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab3D0OVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 10:21:52 -0400
Received: by mail-vb0-f45.google.com with SMTP id p14so4270637vbm.18
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=k4oWRIMmO9tuWdvJ3EEM0llBK1xPk68t7WO8JJMnMvY=;
        b=uxxZAfLO6aCteNBjS8Ax4g13Kc/0+38LJEEo/YtppxSY1oS8BSSUZnuDoj4bDc2spK
         QLf8iKckShYrZsz8pC7SPGvsQ/JnEH9sgqPNLJ5nUTAnoSmTqGN+TKEWU9l5VQzXhj3c
         jwZmDw4NRRoZMSPCpwlin9oevoBmaocIp63y0xl1B40XUYlyxB1wQrI724HZR1tGLdyo
         BUgshTrv/WPJF0t7xdGfOaDqDjyxhMJ2sx/K/Z4wBgnsDS+p7yV0ov7HxpfB7eWdaOKm
         OaatJnhcXSxNOQXbvdlRTD3z+u21f3xWY2LSnh4jtRgNCTvjiku3pY4SP1CcNLXZSPwc
         hvRg==
X-Received: by 10.52.75.8 with SMTP id y8mr26018896vdv.2.1367072511641; Sat,
 27 Apr 2013 07:21:51 -0700 (PDT)
Received: by 10.58.196.197 with HTTP; Sat, 27 Apr 2013 07:21:31 -0700 (PDT)
In-Reply-To: <517BDB6D.8040809@cedarsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222653>

2013/4/27 Johannes Schneider <mailings@cedarsoft.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi guys,
>
> I love git. And I use it every day. But there is one minor thing, that
> bugs me a little bit:
> I am implementing something on a feature branch. Now I detect a minor
> typo/bug/whatever that just needs a one line commit.
>
> But of course I don't want to add that commit to my feature branch.
> Instead I'd like to commit that fix directly to another branch (e.g.
> master).
>
> Unfortunately that take a lot of steps to make this happen:
> - - comitting
> - - stashing other changes
> - - changing branch
> - - cherry-picking commit
> - - switching branches back
> - - reverting latest commit
> - - unstashing changes
>
> I'd love to solve this by having an option for git commit that gives
> me the possibility to commit to another branch:
>
>
> git commit thefixedfile.txt -m "fixed a typo" -b master
>
>
>
> Any ideas/hints?
>

I would first recommend you, instead of cherry-picking the commit, you did this:
-- stash
-- go to the master branch
-- fix the line
-- commit the fix
-- got to the feature branch
-- unstash

As when you merge with master, git will carry on with the changes. I
don't see the need to cherry pick that commit.

Javier Domingo
