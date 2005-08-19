From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Cannot use cg-clone over http after packing a public repo
Date: Fri, 19 Aug 2005 15:35:52 +1200
Message-ID: <46a038f905081820353988dfdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 05:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5xgb-0006xH-Af
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 05:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVHSDf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 23:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVHSDf4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 23:35:56 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:29929 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbVHSDfz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 23:35:55 -0400
Received: by rproxy.gmail.com with SMTP id i8so433151rne
        for <git@vger.kernel.org>; Thu, 18 Aug 2005 20:35:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YfN/d/lvCiPVPoQ/c2q9FuieT6ZKYcC5xZbihTcv8niYlNX9pHbpxosndGkpJ7T9+cifzgIvkvMyyAHWdCrw94FQGJnt3VfvnH9cL1GHO4SBUP8DdzSJ40++v5EYxaKSuW+4eeZkMPR/2KR5mF71+XDaLKnmU5MkvtTg+Ppe+s4=
Received: by 10.38.209.36 with SMTP id h36mr861274rng;
        Thu, 18 Aug 2005 20:35:52 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Thu, 18 Aug 2005 20:35:52 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With todays git and cogito:

  moodle-git-merge$ git-push-script --all ~/public_html/repos/moodle.git

This unpacked the repo completely, in spite if it being local. Anyway,
from a remote machine I could do cg-clone and it succeeded, though it
took ages:

    cg-clone http://mltest/~martin/repos/moodle.git moodle-foo

So I packed the repo

  GIT_DIR=~/public_html/repos/moodle.git/ git-repack-script
  GIT_DIR=~/public_html/repos/moodle.git/ git-prune-packed

And now cg-clone dies -- the objects/info/packs file is missing. It's
there for the repos in kernel.org, but it isn't there in mine. Hmmmm.
I don't see any option mentioned in the git-repack documentation to
create them. strange.

cheers,


martin
