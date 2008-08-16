From: Sean Brandt <sean@fuzzymagic.com>
Subject: Install on Solaris 2008.05
Date: Sat, 16 Aug 2008 16:51:07 -0400
Message-ID: <3785F93B-FDC4-46DC-B21D-A7000FAB221E@fuzzymagic.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 22:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUSlG-0006dv-Hf
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 22:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYHPUva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 16:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYHPUva
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 16:51:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:51046 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbYHPUv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 16:51:29 -0400
Received: by wa-out-1112.google.com with SMTP id j37so896582waf.23
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 13:51:28 -0700 (PDT)
Received: by 10.114.180.18 with SMTP id c18mr3838165waf.128.1218919888795;
        Sat, 16 Aug 2008 13:51:28 -0700 (PDT)
Received: from ?192.168.1.15? ( [68.48.33.158])
        by mx.google.com with ESMTPS id m31sm6776225wag.21.2008.08.16.13.51.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 13:51:26 -0700 (PDT)
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92555>

I'm building an opensolaris box, and am running into test failures  
when compiling git.

  I'm installing on opensolaris 2008.05 and the tests fail in t0002- 
gitfile.sh  ( test numbers 2 and 3 ) is this expected/ok?

*** t0002-gitfile.sh ***
*   ok 1: initial setup
* FAIL 2: bad setup: invalid .git file format

                 echo "gitdir $REAL" >.git &&
                 if git rev-parse 2>.err
                 then
                         echo "git rev-parse accepted an invalid .git  
file"
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
                         echo "git rev-parse accepted an invalid .git  
file path"
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
