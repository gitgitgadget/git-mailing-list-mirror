From: Kevin <ikke@ikke.info>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 10:12:51 +0100
Message-ID: <CAO54GHDPaBqLGV7nNS-fwMZV4t_XCfDA-tAx5w7SrWWsM+YBGA@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
 <20121224073103.GA10793@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 10:25:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn4Hl-0007gi-VC
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 10:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2LXJUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 04:20:23 -0500
Received: from mail-ia0-f178.google.com ([209.85.210.178]:50799 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab2LXJUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 04:20:22 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Dec 2012 04:20:22 EST
Received: by mail-ia0-f178.google.com with SMTP id k25so5870952iah.9
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=LxUrfDz/cVj0M36Er3OtSdhLUcR5WRbT5XwewD449K8=;
        b=ru2sF7E31QemWeTm9IwtRw16Ic0Cf5yQaGZROnPIvGfGId7+/m5VUML6SrmifYrmdC
         kv6D3DM86in8L2NraOmbHMGxZ1JaKvVOmp+K759n4NKE2vpMJDPXvtvfz5NAMVrEyVX8
         Aco9ZqM5VrjuPFGJnVDy/40ZNTf3VOWQedV5FSK7rjT5j72o34mF82b/bIO1d9/GrW2j
         ZDmpSvJ6ghk7sBv0Mx29TPqUa5xHjGS2jbUwNQ/Qm+OdCsj0D+4zsjmFdR8FPQa0DHZa
         dEbxjLqWjkeRpPQiUGu6vO1ImJ+402aEQyfmCZIWPtSX7WfHL9lsOVXwptChqbFdIqlH
         T+1Q==
Received: by 10.50.237.104 with SMTP id vb8mr286106igc.11.1356340391803; Mon,
 24 Dec 2012 01:13:11 -0800 (PST)
Received: by 10.64.38.39 with HTTP; Mon, 24 Dec 2012 01:12:51 -0800 (PST)
In-Reply-To: <20121224073103.GA10793@zuhnb712>
X-Google-Sender-Auth: m9192BE0HTfYUJKJEHzFnPa9SQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212105>

On Mon, Dec 24, 2012 at 8:31 AM, Woody Wu <narkewoody@gmail.com> wrote:
> But thanks anyway, I see you guys's discussions and it's a little hard
> to understand to me at the moment. Currently, I still have to use gitk
> with narrowed outputs.

Each commit refers to it's parent. If you take a branch, and keep
following the first parent of the commits, you will finally reach the
root commit (the first commit made). You don't see any branches, it's
just one straight line. That's why git can't tell you where a branch
started, because it all looks like a single branch to git.

With merge-base, you basically give git two branches, and git finds
the first ancestor that is common to both branches.

See [1] for an example. If you follow the arrows from branch a, you
get from E to A (note that commit C doesn't know about commit F
pointing to it). So it looks like there is only a single branch.

If you do git merge-base a b, git sees both branches have commit C in
common, and reports that as the merge-base.

[1]: http://g.jk.gs/9W.png
