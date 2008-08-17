From: "Sean Brandt" <sean@fuzzymagic.com>
Subject: Install on opensolaris 2008.05
Date: Sun, 17 Aug 2008 08:55:57 -0400
Message-ID: <7a675f570808170555ie640c86jb5561cc6f7b68c73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 14:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhoe-0003vM-6q
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbYHQM4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYHQM4A
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:56:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:15125 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYHQMz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:55:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1411132fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 05:55:58 -0700 (PDT)
Received: by 10.102.253.13 with SMTP id a13mr3239286mui.74.1218977757997;
        Sun, 17 Aug 2008 05:55:57 -0700 (PDT)
Received: by 10.103.247.8 with HTTP; Sun, 17 Aug 2008 05:55:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92610>

I'm building an opensolaris box, and am running into test failures
when compiling git.

 I'm installing on opensolaris 2008.05 and the tests fail in
t0002-gitfile.sh  ( test numbers 2 and 3 ) is this expected/ok?

*** t0002-gitfile.sh ***
*   ok 1: initial setup
* FAIL 2: bad setup: invalid .git file format

                echo "gitdir $REAL" >.git &&
                if git rev-parse 2>.err
                then
                        echo "git rev-parse accepted an invalid .git file"
                        false
                fi &&
                if ! grep -qe "Invalid gitfile format" .err
                then
                        echo "git rev-parse returned wrong error"
                        false
                fi

* FAIL 3: bad setup: invalid .git file path

                echo "gitdir: $REAL.not" >.git &&
                if git rev-parse 2>.err
                then
                        echo "git rev-parse accepted an invalid .git file path"
                        false
                fi &&
                if ! grep -qe "Not a git repository" .err
                then
                        echo "git rev-parse returned wrong error"
                        false
                fi

*   ok 4: final setup + check rev-parse --git-dir
*   ok 5: check hash-object
*   ok 6: check cat-file
*   ok 7: check update-index
*   ok 8: check write-tree
*   ok 9: check commit-tree
*   ok 10: check rev-list
* failed 2 among 10 test(s)
gmake[1]: *** [t0002-gitfile.sh] Error 1
gmake[1]: Leaving directory `/root/git-1.5.6.5/t'



Thanks

- Sean
