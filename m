From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/10] Port tag.c to use ref-filter APIs
Date: Thu, 9 Jul 2015 15:57:13 +0530
Message-ID: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 12:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD93U-00037S-RD
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbGIK1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:27:44 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36488 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbGIK1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:27:43 -0400
Received: by obdbs4 with SMTP id bs4so168978801obd.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=GRrGBKjlPwSbFQeqTAPXyspfZgfUzKdq3eE94ikZGdU=;
        b=TZ25ph493zuNYMDwEiI/nu1BM+yeAwS03HgGfwVt1NCfh3pH0I8vOZthu3MqnVTz+B
         mmQoxk5WAh7g/Z4pbdrvl2Og4+V2jvLFqswG1eDRqKwmZyvvxVtKtPxsgGXbOiD8CCgJ
         lJxyRT9/f2OL5rBFGQkNSAQ2Wh2l8W2Esrn8VApypNvjMyudxngoSekcaGwllZhFVxQH
         ZRsNiEWhDWk/1sSYVKhK8I3hkkbAdLCnyXUZLWHsBAGkRyu5YTELeV6PSEGLJO5dNZl3
         j1+veyI79LxkuHOjZ6j1ol7hc/yq4BsZzI7/sbvMcJFXz9LP61ue3udEQYUdWMYVSDMj
         Xu7w==
X-Received: by 10.202.200.151 with SMTP id y145mr2549095oif.111.1436437663209;
 Thu, 09 Jul 2015 03:27:43 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 9 Jul 2015 03:27:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273731>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref
This patch series is continued from:
http://article.gmane.org/gmane.comp.version-control.git/273569

The previous RFC version is here:
http://thread.gmane.org/gmane.comp.version-control.git/272654

Changes in this version:
* Cleanup Documentation/tag
* Fixed grammatical errors
* Fixed a small merge conflict
* Other small changes

 Documentation/git-tag.txt |  39 ++++++++++---
 builtin/for-each-ref.c    |   3 +-
 builtin/tag.c             | 368
++++++++++++++++++++------------------------------------------------------------------------------------------------
 ref-filter.c              |  95 ++++++++++++++++++++++++++++--
 ref-filter.h              |   7 ++-
 t/t7004-tag.sh            |  51 +++++++++++++---
 6 files changed, 234 insertions(+), 329 deletions(-)

-- 
Regards,
Karthik Nayak
