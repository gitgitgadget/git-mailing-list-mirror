From: "Michal Rokos" <michal.rokos@gmail.com>
Subject: index-pack died on pread
Date: Mon, 23 Jul 2007 14:52:48 +0200
Message-ID: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 14:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICxPF-0004Aw-2s
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 14:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbXGWMwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 08:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbXGWMwx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 08:52:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:19663 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbXGWMww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 08:52:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1979455wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 05:52:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iZIcCTYRlyiZh18zEEWCu19x7vSfGdimaUkDZsVyElzL+dKzZkF0DFbwrfEEZYtv6mRPkfpYR8r1BEYktY93NDZ9+bD8cx52T2+J1vqNbLKRe+GD0W8tSl3EWswjCCEftHRi/rgb1w2Gnqe8/N7JzVgmosMReqsXwyx/8SqKrF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uEhYwrYA/jH+gSg3RGCauxl17chLV5ZUueuE/p2pj+xmflJqHHptZjIoLfFMRRQxB5j1y0f5uy0/KK6dnLZp4oP7qsN05Be/BexXEyYVYSEIqyNMhcOaR/wkohBqUrFrOyidA9W8rezQN3GudrIYkPR8lMRreZcwmJcmms0Jkc4=
Received: by 10.114.76.1 with SMTP id y1mr2930376waa.1185195168698;
        Mon, 23 Jul 2007 05:52:48 -0700 (PDT)
Received: by 10.114.150.6 with HTTP; Mon, 23 Jul 2007 05:52:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53434>

Hello,

it's more and more common that I get an index-pack death for pread
that returns 0... Did anybody encountered the same?

Some more details:
# uname -a
HP-UX aa B.11.11 U 9000/800 1009938148 unlimited-user license
# git --version
git version 1.5.2.4
# git-clone git://git.kernel.org/pub/scm/git/git
Initialized empty Git repository in /home/tpiiuser/mr/git/.git/
remote: Generating pack...
remote: Done counting 55910 objects.
remote: Deltifying 55910 objects...
remote:  100% (55910/55910) done
Indexing 55910 objects...
remote: Total 55910 (delta 39003), reused 55304 (delta 38552)
 100% (55910/55910) done
Resolving 39003 deltas...
fatal: cannot pread pack file: No such file or directory (n=0,
errno=2, fd=3, ptr=40452958, len=428, rdy=0, off=123601)
fatal: index-pack died with error code 128
fetch-pack from 'git://git.kernel.org/pub/scm/git/git' failed.

... please note that I added printing details to die() for pread.

HPUX pread manpage seems to be here:
http://modman.unixdev.net/?sektion=2&page=pread&manpath=HP-UX-11.11

Michal

PS: Please CC me.
