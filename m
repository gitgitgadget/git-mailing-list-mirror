From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: git commit broken ?
Date: Mon, 10 Apr 2006 10:02:44 +0200
Message-ID: <cda58cb80604100102p92e5258qf33a128f75f1b088@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 10 10:03:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSrMe-00041U-50
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 10:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWDJIDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 04:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWDJIDD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 04:03:03 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:47221 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750903AbWDJIDC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 04:03:02 -0400
Received: by zproxy.gmail.com with SMTP id o37so797229nzf
        for <git@vger.kernel.org>; Mon, 10 Apr 2006 01:02:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jsMWJ786eEbrRs1urg2A9MY+rr5Ps6J2PbmQSdxX7u62JO2iPg2cXVc7lAWiS3g3UcfWuFKw5UzWmfh0Y3Hxqvk5cbJb4G2qHmzayP6uXuLtoDmbvPYIS9uCg81y2st6qltmHwTBCyBw1aEXyxVppYfdgjLexbS+8XospDh9RCc=
Received: by 10.36.221.61 with SMTP id t61mr5180710nzg;
        Mon, 10 Apr 2006 01:02:59 -0700 (PDT)
Received: by 10.36.50.4 with HTTP; Mon, 10 Apr 2006 01:02:44 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18583>

It seems that "git commit -a -c ORIG_HEAD" command do not work as
expected.

Here is an example:

	$ ls
	a b c

	$ git status
	nothing to commit

	$ echo "good modif" > a
	$ echo "temp modif" > c
	$ git-update-index a
	$ git commit -m "work in prog"

	$ git reset --soft HEAD^
	$ git status
	#
	# Updated but not checked in:
	#   (will commit)
	#
	#       modified: a
	#
	#
	# Changed but not updated:
	#   (use git-update-index to mark for commit)
	#
	#       modified: c
	#
	
	$ git commit -a -c ORIG_HEAD
	$ git status
	nothing to commit

So it seems that c has been commmited this time...Is it the expected
behaviour ?

My git version:

	$ git --version
	git version 1.3.0.rc3.g0ed4

Thanks
--
               Franck
