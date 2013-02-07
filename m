From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Proposal: branch.<name>.remotepush
Date: Thu, 7 Feb 2013 21:44:59 +0530
Message-ID: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:15:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3U8W-0005My-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 17:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab3BGQPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 11:15:22 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:57402 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3BGQPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 11:15:21 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so2837073obc.41
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Qhga1eTSstvtqYtrsBdBdsHUAklJBqi7N2nLHa87BRA=;
        b=Pf13vpvHzxNOgR9e0vo+1XbHTxreRKHK1giQ0oyQUNKn5MmD9peNyl6psRu91YDH5U
         7HtK6I0a8BRWRIrbPp2eVfFwgrqXYu9+fDv1pLCWaTcYwGUT2rwh3hscL9AGavUkjeb9
         yPCRaZuA6RmYe5HMrnub1ZUoLH/vYUNbYOTCvXvcBEON4KVp4YN3rjmfcAFf3E22sgOq
         r8HerMdxv8pJv3gfsOSWGpPrtszj7zFu+QGdx1BJYHl7WgER3nqMVYCYXv3dTxI9Ixdx
         QSzfWv/SRe+mCNxw/ZXfyuz/uI3i7pZcbn3odB/Tv61P3ZtZRVL0xnMCdY/qQtVlSCwa
         A/xQ==
X-Received: by 10.60.19.36 with SMTP id b4mr1540899oee.44.1360253720480; Thu,
 07 Feb 2013 08:15:20 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Thu, 7 Feb 2013 08:14:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215702>

Hi,

This has been annoying me for a really long time, but I never really
got around to scratching this particular itch.  I have a very common
scenario where I fork a project on GitHub.  I have two configured
remotes: origin which points to "git://upstream" and mine which points
to "ssh://mine".  By default, I always want to pull `master` from
origin and push to mine.  Unfortunately, there's only a
branch.<name>.remote which specifies which remote to use for both
pulling and pushing.  There's also a remote.<name>.pushurl, but I get
the feeling that this exists for an entirely different reason: when I
have a server with a highly-available read-only mirror of the
repository at git://anongit.*, and a less-available committer-only
mirror at ssh://*.

How about a branch.<name>.remotepush that specifies a special remote
for pushing, falling back to branch.<name>.remote?

Ram
