From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix hg sharedpath when git clone is moved
Date: Sat, 23 Nov 2013 13:46:13 +0100
Message-ID: <CALWbr2zkiBS3zvcu8skrtn5tK8XMyQy8Nv1r1h+zowkgpWKYKw@mail.gmail.com>
References: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 23 13:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkCbW-000258-EP
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 13:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3KWMqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 07:46:15 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:37651 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3KWMqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 07:46:15 -0500
Received: by mail-la0-f51.google.com with SMTP id ec20so1674380lab.38
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r4hJrN0STKh1qLnXYPHmIDPtRM90WSKCzjHPZyVkrTw=;
        b=rEm93BizDhCIxjzeakeAIzbEyF7oYGAsQQIXxSqsQjRmO7WRP3pfgwVW/X6MczttxT
         0mJ3TZ5lkReJewhO6s0Za/xIiOayoM51grLzFZT1VhC7Y2T1tfZJ3PLTcQBZrc/iJtVt
         C8sCyTa7e/xUVgl90uhMWt5mf5jGMGEvkJIVvcqFBQtT0GhW0xuIiRKG/bq+U6Don75O
         WvgX5eMbQv912E+DaX+AoU0rQKGLRj6XJbnZeqFFB/r0R6x1i2+MQ0gXosUavwVOPR/I
         wOI2jTQ3SNiHwt9+XQlD+7tFhbgxO72qwiwKEWMEHuQQiqIv4vYfp8EuodyZz/jrq36p
         JGtQ==
X-Received: by 10.152.140.193 with SMTP id ri1mr14118503lab.18.1385210773518;
 Sat, 23 Nov 2013 04:46:13 -0800 (PST)
Received: by 10.112.202.102 with HTTP; Sat, 23 Nov 2013 04:46:13 -0800 (PST)
In-Reply-To: <1385210302-25518-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238232>

On Sat, Nov 23, 2013 at 1:38 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> remote-hg is using a mercurial shared clone to store all remotes objects
> in one place. Unfortunately, the sharedpath is stored as an absolute
> path by mercurial, creating a dependency on the location of the git
> repository. Whenever the git repository is moved, the sharedpath must
> be updated to reflect the new absolute path.
>
> Check mercurial sharedpath file when getting the local hg repository,
> and update it manually with the new path if necessary.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

By the way, this is the only link [1] I found about both relative path
and updating the file. So it looks like there is no other way to
update the path but to write the file manually.

[1]: http://bz.selenic.com/show_bug.cgi?id=2006
