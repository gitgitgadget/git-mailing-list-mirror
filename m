From: Cole <cole@opteqint.net>
Subject: Git submodule add with branch and depth option
Date: Thu, 4 Sep 2014 17:21:29 +0200
Message-ID: <CACsf_wy51oUaFOKHbg9QUQibkM045FYXY9HpYM84H5tvJcbPYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 17:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPYqt-0005KO-FU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 17:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbaIDPVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 11:21:31 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60326 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaIDPVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 11:21:30 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so7530424obc.9
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=SzIwFKYg89DmZhrKBxQPSdn6NtzZB8BrIGUKIyoea0c=;
        b=cKjGtSOSj4GOp1Y6BE1JMq9rbxX2l2xIokCrWGDVi+rEYUMUqjcL/yZf0WwpARNQAW
         YAo5ZIc4Ixibf3CUVl4bCljqtW9/EWeaGeBkgU8u8ccd5Yaz3enFCAYHIRaLfEDHDjSD
         WfuYZmOM17flQPt9ny1Oo4FcvgwlEch8bh1iOdQN0GbtWMxVNacWW8Lh9yM7KXZct62Y
         59xn2NbZw/97AlzepsfN1ZLmgyjtopL6Qj90QR01wiqSayzHkOJoqO24tYu4M6o9ofb/
         ZVldziYt1pBoH51aMD9xnr44XqnSEYbOMwyVPyw8cQC0EPo6DgLTjrBvgIIaPPlkWGfY
         tgxQ==
X-Gm-Message-State: ALoCoQmJnGssmZZ1id/iyZxs14fpuxUJ1uQWIJJ0IXD71gnflPIy1caorohsRORAHKgWjlNOTrIN
X-Received: by 10.60.52.144 with SMTP id t16mr5874523oeo.81.1409844089927;
 Thu, 04 Sep 2014 08:21:29 -0700 (PDT)
Received: by 10.202.23.132 with HTTP; Thu, 4 Sep 2014 08:21:29 -0700 (PDT)
X-Originating-IP: [196.215.199.87]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256449>

Hi,

I am trying to add a submodule using the following command:

$ git submodule add -b gcc-4_9-branch --depth 1
https://github.com/gcc-mirror/gcc.git src

As you can see, I am trying to clone a single commit from the
'gcc-4_9-branch' branch, and avoid downloading the entire history of
that branch.

However, after downloading all the necessary files, it then errors out
with the following output:

colem@xvm14:~/repos/gcc-4.9 [0]
$ git submodule add -b gcc-4_9-branch --depth 1
https://github.com/gcc-mirror/gcc.git src
Cloning into 'src'...
remote: Counting objects: 90203, done.
remote: Compressing objects: 100% (71667/71667), done.
remote: Total 90203 (delta 27425), reused 62802 (delta 17053)
Receiving objects: 100% (90203/90203), 111.82 MiB | 467.00 KiB/s, done.
Resolving deltas: 100% (27425/27425), done.
Checking connectivity... done.
fatal: Cannot update paths and switch to branch 'gcc-4_9-branch' at
the same time.
Did you intend to checkout 'origin/gcc-4_9-branch' which can not be
resolved as commit?
Unable to checkout submodule 'src'
colem@xvm14:~/repos/gcc-4.9 [0]
$ git --version
git version 2.1.0
colem@xvm14:~/repos/gcc-4.9 [0]


Does anyone have any suggestions to try resolve the problem?
Any help would be appreciated.

Regards
/Cole
