From: John Tapsell <johnflux@gmail.com>
Subject: Code changes in merge commits
Date: Mon, 29 Sep 2014 10:32:27 +0100
Message-ID: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 29 11:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYXK9-0002TK-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 11:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbaI2Jct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 05:32:49 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:34872 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaI2Jct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 05:32:49 -0400
Received: by mail-we0-f176.google.com with SMTP id p10so1079852wes.21
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=HBJFsdmXCZ3Zb2gz2/oFz8k+JCUmfj5OQpFAqI3bXFk=;
        b=CS7wVXd+UOsovsjmrodNlTt/qGRy09+RH69MI3CcGC0WhNBKYQ/8KLRPv6GsWxqcDA
         ZKBaLGiVd4DR2Nx7rBi6adzHtcHl60UFHgCPRZ5lGwTUrtJ1oFhrv1K8SwI7LqaTER1s
         AxTeErB7SfhydBaMb2hwyKB2pQqF5GQgW/AiP9LgSGMhWMJY1VbuFsfxLDWwC01ichF9
         hrjfmsRxeL3d7t4nlXTrEBhjQpt49qqVkCODlWoefwqxGN3Kcn2a+hMV0CGpQS+DdwPk
         kDs8AgB3w2krYu32PXAmI2Bv8lh8P4rhtPgMjISq9V2qy6ZwEZ2ARS88yW7+BvyoQSYN
         ZeBA==
X-Received: by 10.194.94.165 with SMTP id dd5mr41814290wjb.75.1411983167700;
 Mon, 29 Sep 2014 02:32:47 -0700 (PDT)
Received: by 10.27.130.193 with HTTP; Mon, 29 Sep 2014 02:32:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257617>

Hi,

  Our team just struggled with this problem, and I've created a
simple, 3 commit large, example git repository to demonstrate the
problem:

https://github.com/johnflux/ExampleEvilness2

The code:   Adds a file, adds a security fix commit, then removes the
fix during a merge.

This happened by accident in our code during a merge, but nobody
noticed, and it was not easy to track down.

In this example, you can see that the security fix was removed by doing:

$ git log -m -p

However the following do NOT show that the security fix was removed:

$ git log -m -p .
$ git log -m -p tmp.c
$ git log -c -p tmp.c

And so on. In a large code base, this a problem.

John
