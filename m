From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Tracking the untracked
Date: Mon, 1 Jun 2009 01:10:13 +0200
Message-ID: <cb7bb73a0905311610g31513df0pb58da08b7d989146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 01 01:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAuAZ-0000Kz-AC
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 01:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbZEaXKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbZEaXKN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 19:10:13 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:64423 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbZEaXKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 19:10:13 -0400
Received: by bwz22 with SMTP id 22so7164648bwz.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=K+dZVMpZR/4kFITXP2SxRjbc1GlIyC7nZDp6ykbyFrs=;
        b=hvNw9YO9eDHN6xOmqM3vyDYCkQFGt3CCsA8J3EF1CgRJjMijyN7+PhfVfBnxd2f42A
         92wsCqpwATElBCN4QgggIO5pzWVYdMFRvmpkOnoAt9n9BH7LI1VWE+wmMOcaXwrA/t8Q
         gR/3Ar+sr0xKAdg4G2U04jvS6zpKT2YLWuVf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=EgoiMsouAQMQUL56ilowxB2oPxGoTdJjzk9HTf5F3tQgdpOyD2IS/y+Kh7p9zFEB1q
         PCIOvpDUpwbHKr2nsjqZ0s0fbwHpyr1pWIbOXrrWHZpVpCT5IbFh6K7lB7ldu4fz40+K
         +gx2VgiPXpimNZw2uMzmJBNemvnbzfVlL0xeA=
Received: by 10.204.118.207 with SMTP id w15mr5033978bkq.126.1243811413568; 
	Sun, 31 May 2009 16:10:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120436>

<shameless plug alert />

On Wednesday 06 May 2009 03:19, Geoff Russell wrote:
> Basically, I'm trying to find a way of having a huge bunch of stuff in
> my repository and
> tracked, but which doesn't get pushed to the central program repository .. which
> has always just been source for us .. I figured I could stick it on a
> branch which doesn't get pushed.
> But that doesn't work for the reason mentioned.
>
> One solution would be to have a class of files that is "unversioned
> but tracked".
>
> Alternatively we could just bite the bullet and track everything.

I do realize I'm a month late in replying to this email, so I guess in
the end you bit the bullet, but I was perusing the mailing list
archive and this post catched my attention because it's a possible use
case for Zit, the single-file Git-based tracker I've been developing
on and off ( http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#Zit
). I have never thought about using Zit this way, but I see no
problem. Create a .zit directory (by default zit tracks each file
using a git dir named .filename.git, but if .zit/ exists it'll use
.zit/filename.git), add that and all tracked but untracked files to
the gitignore file, and you'll be able to track them with no noise in
your standard git repository.

The only possible underside is that with zit each file is tracked
independently, so if you want to track them all together you'll have
to think of something else. Also, zit isn't very rename-friendly
(yet), so it might not be that good a choice for you if you do a lot
of renaming.


-- 
Giuseppe "Oblomov" Bilotta
