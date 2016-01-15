From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH 0/2] gitk: Two improvements to the branch context menu
Date: Fri, 15 Jan 2016 22:31:38 +0100
Message-ID: <51900395.pKIx87RN0F@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 22:49:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKCFa-0004vt-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbcAOVt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:49:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35727 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbcAOVt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:49:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so4930123wmf.2
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=/nAdS015Q2p8DSSvFhOG1A1ZPY+JqbvfvY7k1nML29U=;
        b=DQxo6sUF9g4Ehukt5QhWZlmQ0ckc/VbST0gbl7KLmsj8lVYrBKWHCWF8TEljwu0SKp
         FLv7gYpmpKw5Z2OKm8/kA3uOjVzOvwctxp9cY5N4Q6lwC/mUkBx6edwI7uzWLzjx5hxu
         41203aKah0+DNaFMfh7bPXHgcnPuFlzdpXBq/qhpsCmmNj7NwUiq6lTAXrRVgAVfcJv9
         F/JtmplgtWavoel9ct/03nl8iRP/jTW/xMHKLe0vma2YXY0i53zouXpzcLe6FSwC2FZ9
         XH7MP7USVShsUsa5bm1dPuBYQkNNQOU0QHBOtVK74YGtJwLe1/vGkBfEF9wnfyHsVDiv
         0eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding:content-type;
        bh=/nAdS015Q2p8DSSvFhOG1A1ZPY+JqbvfvY7k1nML29U=;
        b=En3OloGq5SrNkdWtahhtofjv0VWsMAQFBHPGl95cGtQV45Z8hjLzHMrvySDUV5cvKe
         8j91RMMPTBV6AVEyYSqFJG7ZPsX4yR6Rdy/ZKpQaG4m6uxEhgSBuA2vIhEvj5s3Ic+TX
         UtEf/PSHJxkxPKi1qRFNuxanD8pDYa8NHDS09Gk360N1J9FV7puUf9y6pMeu0faEOXhd
         dg/Jd0BiY1dw7wao+KZ88SfqLpVDiJzcRw46PMbHUrYtjbvD4bBFeXyyCEKXeeOLs0/M
         17tSyTKBR2VoDdJEneT37l141ON5I6QUugUsmhRyQyEYEq8jdk6jVWkBBU0XYokUdRfS
         raHg==
X-Gm-Message-State: ALoCoQnUrvNovYvYfHzjtALtEjMJ8nmnvwT/F4yt7wGcxQz/yoWCZfW2SXaHbPWG1xp2JxQPu2vBZ8REGgF/yW5qirkVs6rIhQ==
X-Received: by 10.194.86.166 with SMTP id q6mr13743116wjz.69.1452894565572;
        Fri, 15 Jan 2016 13:49:25 -0800 (PST)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id u69sm4249335wmu.20.2016.01.15.13.49.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jan 2016 13:49:25 -0800 (PST)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284223>

Hi,

I made two improvements to the gitk branch context menu:
1) gitk: Add a 'rename' option to the branch context menu
2) gitk: Allow checking out a remote branch
	(i.e. create and check out a local branch that tracks
	the specified remote branch)

They are related by the facts that they both affect the
branch context menu, and that the second depends on changes
introduced by the first.
