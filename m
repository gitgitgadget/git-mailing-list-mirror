From: "Mark Desnoyer" <mdesnoyer@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Mon, 21 Jan 2008 16:45:40 -0500
Message-ID: <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com>
	 <20080121212015.GB5263@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4T8-0000cK-Tz
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229AbYAUVpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYAUVpo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:45:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:9229 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbYAUVpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:45:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3966504wah.23
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 13:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WS19wBLTHni7cWSBo3c6vroGxVN23Rx/FxE6dj7hM7w=;
        b=dc/pyE4Xs0pHqGiyyW0Xtd6gWkf0q+3d6xp6vbJcFlGE808wxPUR7yVZpWDM9r5OCNvAW1hfjv771TBqxpe/D85tQhQzzJwuT0M43PCeacEswZ1GeIlPC03efsNMTDPP2q1Ev7Nx2u5w1VajZ4pWZ2Bblp4DVRQ/XntjB0xPOm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kEz+tjNFjkuIWCqq6nLsSZ4tBIQ1745Mhy+okdg4A9IvekRoQWB2jeJLRKjoT/MqTwuKEnqyXHbmkOKbzXYyAXMWFU8sTgmvRe5OQpL7H/4j+GUoSfjX2s2NY/pQE2BzkzBoHIMSMOb72AqGXCgSmClOpM7NYCozZEoFuCAXy4s=
Received: by 10.114.53.1 with SMTP id b1mr5755493waa.134.1200951940717;
        Mon, 21 Jan 2008 13:45:40 -0800 (PST)
Received: by 10.114.174.11 with HTTP; Mon, 21 Jan 2008 13:45:40 -0800 (PST)
In-Reply-To: <20080121212015.GB5263@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71352>

Alex,

The directory did not have any untracked files in it. Looking a little
more carefully, I realized that there were subdirectories in foo/bar/.
All the files in foo/bar and its subdirectories were deleted
correctly, but the actual directory structure still exists.

-Mark

On Jan 21, 2008 4:20 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Mark Desnoyer, Mon, Jan 21, 2008 20:45:07 +0100:
>
> > Hi,
> >
> > I've run across a small problem and I was wondering if I could get
> > some help. I have two users A and B. They are both git-cloned from a
> > common repository on a different server.
> >
> > User A moves a directory:
> > foo/bar/ ==> bar
> > using:
> > git mv foo/bar bar
> > git commit
> > git push
> >
> > Meanwhile, user B is doing some other changes that are completely
> > unrelated and has a few local commits. Now, when user B pulls from the
> > repository (git pull), and returns no errors merging, the directory
> > "bar" is created, but "foo/bar" is not deleted, although, it becomes
> > untracked.
>
> Directories are never tracked. It should have been deleted though.
> Did it have (or still has) some untracked files in it?
>
>
