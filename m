From: Alex Riesen <raa.lkml@gmail.com>
Subject: git-clone ignores umask for working tree
Date: Fri, 6 Jul 2012 21:27:29 +0200
Message-ID: <CALxABCZn5W-cEQ9PS+4XoqhH7L+5P3KN==_RrcruK+oKdijmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEC6-0008Ny-MA
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab2GFT1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:27:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41339 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2GFT1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:27:51 -0400
Received: by yhmm54 with SMTP id m54so9755486yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=IzkibzJxdj7FxkxGocygvIBKDwzdNBMwu/OK/XAAOc4=;
        b=CTAXBPcavEJ6MqfAC8TopagCBjuaKETw2+r/APP7rVFzzabS1mVVxeBXXBL/j0gKj3
         tTzEw3Q+MEOq1tOxunSLm7z0cn+A6FzF0EG9w0LhiRCPj6MB3wjLQhZddwG5fLY0WVny
         FhYvCAJvr7Jn8RCkKCONjSmpe/58TnXAyvFnssvxGia38CaiGeaK/MhHEY6UHnjvBGxy
         I9LNrEKTIBXvspcoP6Gy0ki3FcHWArZB4fm3TELYkdx+D0XZm7kg7Lep83lBwKk7BYHO
         tJhc3/GcS3xftEeMtn/VRDTuimS2UqtTKsF1tbtMHvishraPJC2/WgwNp1kJrXMnsRZq
         HJ5g==
Received: by 10.101.3.34 with SMTP id f34mr10891186ani.3.1341602870861; Fri,
 06 Jul 2012 12:27:50 -0700 (PDT)
Received: by 10.146.162.9 with HTTP; Fri, 6 Jul 2012 12:27:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201140>

Hi list,

when git-clone was built in, its treatment of umask has changed: the shell
version respected umask for newly created directories by using plain mkdir(1),
and the builtin version just uses mkdir(work_tree, 0755).

Is it intentional?

This Stackoverflow question is what got me interested:

http://stackoverflow.com/questions/10637416/git-clone-respects-umask-except-for-top-level-project-directory

and might provide a credible use case.

Regards,
Alex
