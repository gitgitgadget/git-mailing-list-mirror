From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git push tags
Date: Thu, 25 Oct 2012 08:58:02 +0200
Message-ID: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRHOS-0004Mw-Ud
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 08:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157Ab2JYG6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 02:58:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57663 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab2JYG6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 02:58:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so936825pad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VANvnlBKdTaoNt4QYU3n0KVdp4joKfbBwYbKdPCEbAI=;
        b=sLY4JAwZJ59ZVrHnlHVbbQAGvgnWImwZcfm/2XroUJ0gs4kXrvIaT+72zGr1dxycIL
         zNkM6snImNT52J0bXhnGHgCH5yEovFLRXyaX/E1wixVpfm2hAHb8gzL09WbO58jw1DXd
         hHebQL5OQJBRmXvdVj0ggQTG3xg5B8nHh71h00w4s5kunOl0hexAcBK30CKIHelSJPsl
         KkWqJGm/ZYaxvXXpdOQwnX7AcXJerPVeTeUF0anH/8ukXAUW9idCyNSXKi2s5tK3saxQ
         cMtAjN9r43U4v7Ad3AMFp1AoFZJlrG1t3UmYN2S7LFTPKDZlJdh7cFXvj8x1GiR8fsEn
         OE0A==
Received: by 10.68.129.72 with SMTP id nu8mr57049703pbb.29.1351148282578; Wed,
 24 Oct 2012 23:58:02 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Wed, 24 Oct 2012 23:58:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208354>

Hello,

git push tag updates silently the specified tag. E.g.

git init --bare release.git
git clone release.git integrator
cd integrator
git branch -avv
touch f1; git add f1; git commit -m A
git tag v1
git push origin tag v1
touch f2; git add f2; git commit -m B
git tag -f v1
git push origin tag v1

the second git push updates the tag in the remote repository. This is
somehow counterintuitive because tags normally do not move (unless
forced to that), and is not documented.
This is also harmful because it allows to change silently something
(tags) that normally must not change.

-Angelo Borsotti
