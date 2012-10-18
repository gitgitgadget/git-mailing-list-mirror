From: Drew Crawford <drew@drewcrawfordapps.com>
Subject: git subtree error (just how do you expect me to merge 0 trees?)
Date: Thu, 18 Oct 2012 18:04:57 -0500
Message-ID: <FBE22FDC-5800-40C8-9778-82DFD27579F6@drewcrawfordapps.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 01:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOz9O-0003ty-TY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 01:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab2JRXFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 19:05:00 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40572 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab2JRXE7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 19:04:59 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so9178052oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 16:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer:x-gm-message-state;
        bh=XHJFWhtQOOOSO0OKc4rhNR21S6JW5ctWS3gd0wdHPXY=;
        b=FGtV+X8Z35+DZFgFueHsNEK9inuHfXg4oAXL8YaOuk5LBSPYuSh9supNJn6051mz5u
         a0C9RInvuNAVfqRil0nxWl4h8usvVXuaJZXJLc2Dh8cmH6Aj25CHWbaGitjTqAlFG7jt
         a0djGFv+AUDdkir49WkQ04u13Lt1/LY2919ECdc1HTH6ZsSwaNPr0BnT0EKwjL4YmZob
         CfjABo5WqMA/XxEgKa+aUKrqw4gQlkPXfJMux6tFClEiae/RuTgjgZo1UEzsyPEINtLe
         RpAWKTg1C5b6lEi2MGqeLA9Mk8kKjlz2NLYP6hqdqaBhCGtOAMXh9ycuJPUtksJ0ssUy
         1UTA==
Received: by 10.60.0.166 with SMTP id 6mr11536392oef.6.1350601499315;
        Thu, 18 Oct 2012 16:04:59 -0700 (PDT)
Received: from [10.0.1.105] (cpe-66-68-151-141.austin.res.rr.com. [66.68.151.141])
        by mx.google.com with ESMTPS id m6sm5030obk.3.2012.10.18.16.04.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2012 16:04:58 -0700 (PDT)
X-Mailer: Apple Mail (2.1499)
X-Gm-Message-State: ALoCoQnzuG6uVsDCz/0KMeCTp+T6Ug12E5EjEe7RPZ6m4br0NhyDDxX3JRPlti1FoGAmWH8FLs1s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208029>

I noticed today that if you leave off the branch name from git subtree like so:

$ git subtree add --prefix somewhere -m "adding CDH as subtree" path/to/repo
warning: read-tree: emptying the index with no arguments is deprecated; use --empty
fatal: just how do you expect me to merge 0 trees?

The error message is not particularly helpful (and seems to actually be in read-subtree?)  The solution in my case was to add the branch name on the end of the command.

Ideally it would be better to emit an error-message from a script higher up the calling chain that would be more descriptive about the problem (such as suggesting no branch is specified).