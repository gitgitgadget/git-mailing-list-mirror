From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git push tags
Date: Sun, 28 Oct 2012 19:15:04 +0100
Message-ID: <508D7628.10509@kdbg.org>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 19:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSXOx-0005Hy-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 19:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab2J1SP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 14:15:27 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:22470 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750931Ab2J1SP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 14:15:27 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 7FD87CE87F
	for <git@vger.kernel.org>; Sun, 28 Oct 2012 19:15:25 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 59C2313004A;
	Sun, 28 Oct 2012 19:15:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3033619F3B3;
	Sun, 28 Oct 2012 19:15:05 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208560>

Am 25.10.2012 08:58, schrieb Angelo Borsotti:
> Hello,
> 
> git push tag updates silently the specified tag. E.g.
> 
> git init --bare release.git
> git clone release.git integrator
> cd integrator
> git branch -avv
> touch f1; git add f1; git commit -m A
> git tag v1
> git push origin tag v1
> touch f2; git add f2; git commit -m B
> git tag -f v1
> git push origin tag v1
> 
> the second git push updates the tag in the remote repository. This is
> somehow counterintuitive because tags normally do not move (unless
> forced to that), and is not documented.

Tags are refs, just like branches. "Tags don't move" is just a
convention, and git doesn't even respect it (except possibly in one
place[1]). You can't reseat tags unless you use -f, which is exactly the
same with branches, which you can't reseat unless you use -f.

[1] By default, git fetch does not fetch tags that it already has.

> This is also harmful because it allows to change silently something
> (tags) that normally must not change.

You asked git push to push a tag, and the tag was pushed. What's wrong?

-- Hannes
