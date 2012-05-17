From: =?UTF-8?Q?Bartosz_G=C4=99za?= <bartoszgeza@gmail.com>
Subject: Local cache for git objects
Date: Thu, 17 May 2012 22:06:51 +0200
Message-ID: <CALnNMuHdNFktUkp+Vdc=ooTJ9ay_BJftAJ_toVaBDA5EOzt9ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 22:07:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV6yu-0000Zl-Ko
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 22:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387Ab2EQUHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 16:07:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62529 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347Ab2EQUHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 16:07:22 -0400
Received: by obbtb18 with SMTP id tb18so2927485obb.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3SgkMjpfB8JZ79TWbA58KqvBwyz1utjWj2Ua78ijwbc=;
        b=lduyzlL8iQoyY5Fe4Kmq30+/dy3e9oUI3lQ/hI4Cq+kCiBXD7p29PNGky3i9zUyRgy
         6QT0iJwwK0cicJPB6LR6YFY54fa9Ezv1S5w8LJK/Zix6mEzyRck1V4W3d9Vo6QSVFtxy
         W8Ij/xko/qeghQK8Ve8v039Q3BLZ4rjBb1qET/JxxJAX2V5/rCw0PJ6OsMnF6Ai8N7vp
         DvdUNeCqXotx+FqXWL2bc9x4FtYGUCSK8eLuw+iU3o/cKCG0Iu6zmw84OMqrXHg7nKhd
         ehy0jj9eKpYZh9OCOPlfupEe45R9Qu84t7GTDln0Zfebu8Yoneh7glSjVK7J+83LF3jv
         FZyg==
Received: by 10.182.172.100 with SMTP id bb4mr7698454obc.22.1337285241393;
 Thu, 17 May 2012 13:07:21 -0700 (PDT)
Received: by 10.76.74.35 with HTTP; Thu, 17 May 2012 13:06:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197927>

I'd like to speed up fetching objects from remote repositiories when creating
multiple clones on one or more machines in LAN.

I know it can be done by hand: git-fetch once and git-clone from local copy.
I think about adding new capability to upload-pack which would allow making
relay and object store. Client would supply url where "want"-ed objects should
be available.

Next I'd add config option for git-fetch with url of this cache.
fetch-pack would get refs from remote and request objects from cache.

I'm not sure if this hasn't been done.
Would such feature be included in git?
