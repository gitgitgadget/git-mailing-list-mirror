From: "Kalle Pokki" <kalle.pokki@iki.fi>
Subject: git bisect with history manipulation
Date: Mon, 23 Oct 2006 17:22:41 +0300
Message-ID: <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 16:23:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc0hl-0003qG-PO
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 16:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWJWOWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 10:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWJWOWn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 10:22:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:34937 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964883AbWJWOWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 10:22:42 -0400
Received: by nz-out-0102.google.com with SMTP id z3so549298nzf
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 07:22:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Dbo254BM3hq3AX6P3SOQOLjTT1iK7H6kKZNsik6lPUJqTDIeVd3hX8JG242fu4/RfqbZiJDrVbBRA+t7JUdmtD4pcmOtYwVlCWHQPJQf10xcLiRpqOPCaRwq5UQXjGbpEe00HYOGDzfmILJ2R2ZzflvuD3ZrATj8ni0en1TT73I=
Received: by 10.35.61.17 with SMTP id o17mr6648005pyk;
        Mon, 23 Oct 2006 07:22:41 -0700 (PDT)
Received: by 10.35.89.18 with HTTP; Mon, 23 Oct 2006 07:22:41 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8ab3a67dfd1a8441
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29833>

Hi,

I'm still pretty new with git, and cannot quite figure out how to use
"git bisect" effectively in this special case: I'm running an embedded
powerpc board, to which I need about a dozen platform patches in the
kernel. Originally I made the patches with quilt on top of 2.6.15.4. I
recently started using git, and just applied the patches on top of
v2.6.18. However, the system seems to oops at every boot now. So I did
"git branch downgrade && git reset --hard v2.6.15" and applied my
patches on top of it to create a starting state similar to what I had
previously. There everything is ok.

Wanting to try to bisect the kernel versions, I then merged the master
branch into the downgrade branch. Then I marked my last platform
commit as good, and v2.6.18 as bad. However the bisect algorithm seems
to group the platform patches near v2.6.18 instead of v2.6.15, since I
don't have the platform files in the bisect checkout. And since I
don't have the platform files, I can't compile a kernel that would run
on my board.

So is there any way to insert a few patches to an arbitrary point
backwards in time and start bisecting from that to the present time?
Or am I thinking this somehow all wrong?
