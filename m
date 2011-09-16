From: Jay Soffian <jaysoffian@gmail.com>
Subject: git branch --set-upstream regression in master
Date: Fri, 16 Sep 2011 17:43:41 -0400
Message-ID: <CAG+J_DyxNpPevwfrJVkv3GBmv0tEXgW2LZtdHgarFoXb9Qqghw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	conrad.irwin@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 16 23:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4gCJ-0007iz-2z
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab1IPVnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 17:43:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35638 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab1IPVnl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 17:43:41 -0400
Received: by yxm8 with SMTP id 8so3218042yxm.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZhxkelBgX6U+oxnm4hvbIocwfOgvEVwbBfRIvD1P2os=;
        b=JZ70Ok8kKU+k+ZgJ5R/F2RiuwuPOZUK4gFczhFbgofI7r4F0b3GdQfd+6OusDVUzp7
         6ymCNtKcCRDg/GSqJZu/7pJ9Zre5+HuVpwC8h+cUAPB4NwHo0gX+XoYfvg/Cl7rHK2sf
         muOCxb0OoUo3bgFhQt4wrtbJ0I+8PeTX4mVjY=
Received: by 10.236.173.129 with SMTP id v1mr18303782yhl.25.1316209421187;
 Fri, 16 Sep 2011 14:43:41 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 16 Sep 2011 14:43:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181561>

This used to be possible on the checked out branch:

  $ git branch master --set-upstream origin/master

Now it gives "fatal: Cannot force update the current branch." which is
broken. You should be able to setup/change the tracking information on
the checked out branch.

It's apparently due to ci/forbid-unwanted-current-branch-update.

Sorry I don't have time to contribute a patch at the moment.

(BTW, --set-upstream still needs to be fixed so that these mean the same thing:

  $ git branch master --set-upstream origin/master
  $ git branch --set-upstream origin/master master

and to just allow:

  $ git branch --set-upstream origin/master

w/o having to specify the checked-out branch.)

j.
