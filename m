From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] t3400 (rebase): don't set GIT_AUTHOR_{NAME,EMAIL}
Date: Fri, 10 May 2013 10:53:16 -0400
Message-ID: <CAPig+cSW39bnmKOeNDz0H5ZyNzPt3oCLnCUttaMJU9fGuKvJeQ@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:53:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaohO-0004Bc-1k
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab3EJOxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:53:20 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:61004 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924Ab3EJOxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:53:18 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so4083282lab.27
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mILTZsMaItlntn5AUqOBodUxNkCmz4zmt6QB14BfcNU=;
        b=QltISIyGhQjjRSG8zarUVmBs443+o/w6mQrjIzKofGBFo8odkycZgIr4aps5q8Aa2z
         O5gdA9M5o0GPRe5o2V/TWmgZB1ib2vE+duQTqBd/GulVkxxPWhpMTagvPL0dApZMU0wV
         AvSOuwWmXBXd/YoLShmrlY/mMrPfivSnEXP4Nq4cY0GAWrt5UePc79t3FhjlV4vIVCD6
         JE0hQShnGLy0EIkISJuHHWbxvdVdk+pJbwiidquAZCTnkzJFDQa6GrQKkU6sbba8CuLo
         A3Y7T7sLTn+SeD3pi2mVOtgNM9IYPOLifuJMlfE1Onn33RL6soUVC0216WfIMBIi6MU9
         ZkdA==
X-Received: by 10.112.166.101 with SMTP id zf5mr7666698lbb.59.1368197596401;
 Fri, 10 May 2013 07:53:16 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 10 May 2013 07:53:16 -0700 (PDT)
In-Reply-To: <1368196178-5807-2-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: Q3h_7rI3GEYB7RtU28pxFkjiQBI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223859>

On Fri, May 10, 2013 at 10:29 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> test-lib.sh already sets a sane GIT_AUTHOR_{NAME,EMAIL} for all test
> scripts to use.  Don't unnecessarily duplicate the work.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t3400-rebase.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index b58fa1a..a7ca2f1 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -10,10 +10,6 @@ among other things.
>  '
>  . ./test-lib.sh
>
> -GIT_AUTHOR_NAME=author@name
> -GIT_AUTHOR_EMAIL=bogus@email@address

These values are intentionally bogus. Doesn't this change defeat the
purpose of 43c2325 (am: use get_author_ident_from_commit instead of
mailinfo when rebasing; 2010-06-16)?

> -export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
> -
>  test_expect_success 'prepare repository with topic branches' '
>         git config core.logAllRefUpdates true &&
>         echo First >A &&
