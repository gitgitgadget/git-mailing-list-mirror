From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git-log --parents broken post v1.3.0
Date: Wed, 3 May 2006 23:56:16 +1200
Message-ID: <46a038f90605030456q679ceebcsa037b834bced9ca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 03 13:56:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFxu-00037s-Qa
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWECL4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWECL4R
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:56:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:54406 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965150AbWECL4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 07:56:17 -0400
Received: by wr-out-0506.google.com with SMTP id 67so115412wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 04:56:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mb/W+dF2nz7+uy0XdFsN6924jq/GGjryJgbGdFsqCJ5/OkBEFyrc+zzA4nGqvdIyEKwKc+jOUcsAM12asBLn63Dmx7GVc6RJGbnJwYa3sJbL3j+nKLWk0qKfpz1wpzQryHrb7pLcUZeWJKGf9DSfmD5nczDgS6vVn6NNssFF5lk=
Received: by 10.54.121.18 with SMTP id t18mr1802413wrc;
        Wed, 03 May 2006 04:56:16 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 04:56:16 -0700 (PDT)
To: git <git@vger.kernel.org>, "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19475>

Soon after v1.3.0 git-log --parents got broken. When using --parents,
the 'commit <sha1>' opening line would also list the SHA1 of the
parent commits. This seems to have broken git-cvsserver.

Just by testing git-cvsserver, git-bisect has said that

  9153983310a169a340bd1023dccafd80b70b05bc is first bad commit
  Author: Linus Torvalds <torvalds@osdl.org>
  Date:   Mon Apr 17 11:59:32 2006 -0700

    Log message printout cleanups

But I am not too confident that it's this particular commit -- but it
is definitely one in this series. I had suspected of changes in
git-diff-tree, but the output of git-diff-tree remains unchanged as
far as I could test it.

cheers,


martin
