From: "A.J. Rossini" <blindglobe@gmail.com>
Subject: problems with cloning; http vs git protocols?
Date: Sat, 9 Jun 2007 17:06:05 +0200
Message-ID: <1abe3fa90706090806m4014a680x89178bc5698fefda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 17:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx2W3-0008Jh-Vu
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 17:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbXFIPGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbXFIPGH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 11:06:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:14725 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbXFIPGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 11:06:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1452415wah
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 08:06:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kL8bCKQZE4L6qPsQJZ0aaNLBgCZijzGKHZND/VBoLk6G7B61GhzBI3qOIgKWcxgsQNeN8urQ8mrpnrvBdcgO3AgqOMKW4vAvz1sDfWVFVzhYi+4mC42Q81xVls1sWXQLrcgYUbcIJBwBjZkTVVWtG7CyDV7HCBQfvqYy4sPoiY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=if4nLEiEzanVnKIkaGRUf+sBzQ3uC+Z6y/q7A12LL3baKbofeCfbS6FijZMxFXpnd0sXnvseUB99e1/7RizGUT88YHFPHK1M6FGtbQxo+Hf4MNp4H0ToJYXOdRX8RD4jVVPzQlzoTxkkek2pODCaw4zT6fAm1+oOtLQscFsVfEc=
Received: by 10.115.77.1 with SMTP id e1mr3671437wal.1181401565063;
        Sat, 09 Jun 2007 08:06:05 -0700 (PDT)
Received: by 10.114.38.4 with HTTP; Sat, 9 Jun 2007 08:06:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49576>

Greetings -

I've been working on a project that I'm finally making available to
others, and have set it up on repo.or.cz.

It originated as an SVN project on a private repository, and I've been
using git-svn for communication with the original repo.

After having pushed it up

( git push -v git+ssh://repo.or.cz/srv/git/rclg.git master:master
tonylocal:tonylocal )

I've been working to verify it to write instructions for friends, and
here is the basic problem:

 git clone http://repo.or.cz/w/rclg.git

fails:
$ cd /tmp
$ git clone http://repo.or.cz/w/rclg.git/
Initialized empty Git repository in /tmp/rclg/.git/
/usr/bin/git-clone: line 381: cd: /tmp/rclg/.git/refs/remotes/origin:
No such file or directory
fatal: Not a valid object name HEAD

but

 git clone git://repo.or.cz/rclg.git

works:
$ rm -rf rclg
$ git clone git://repo.or.cz/rclg.git
Initialized empty Git repository in /tmp/rclg/.git/
remote: Generating pack...
remote: Done counting 446 objects.
remote: Deltifying 446 objects...
remote:  100% (446/446) done
Indexing 446 objects...
remote: Total 446 (delta 239), reused 446 (delta 239)
 100% (446/446) done
Resolving 239 deltas...
 100% (239/239) done



?? Is there something I'm doing wrong with the push statement, or with
my git-svn work, or is it a bug, or have I just forgotten/misread a
step??

(I'd like to get http working for a few corporate firewall-hindered friends).

best,
-tony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we
can easily roll-back your mistakes" (AJR, 4Jan05).
