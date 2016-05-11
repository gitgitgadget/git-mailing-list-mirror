From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] perf: make the tests work in worktrees
Date: Wed, 11 May 2016 13:40:44 -0400
Message-ID: <CAPig+cR=MeXZXA-Xdr-7A4nxfNvBrOy2ZtmzJOLHq5YGFiuNyA@mail.gmail.com>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
	<cover.1462955446.git.johannes.schindelin@gmx.de>
	<d783290cabe601ee8623044482b2992fb7936534.1462955446.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 11 19:40:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Y7t-0004Qy-I1
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcEKRkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 13:40:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36816 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEKRkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 13:40:45 -0400
Received: by mail-io0-f193.google.com with SMTP id k129so7015015iof.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0cn5zngTFmzkqwz3P65OhyDJHQrFvfeob//J410v7DQ=;
        b=lgY4xXWpmmQOhr8YV6oR9h71pDgxTAssL6W71+XHVF+mLhs2LpJeGwOuKn3XsYR1Fi
         puEza44Gax1Fh0fKafXggj3SNShQ0j4kITI2wgKmVWyG1YRGrfsYhTYP35yX3MJmXMFw
         LQYekNIpbR2EKiD/vv2Ev43W/r9NcKxlqArE/QBS00FnCG93GkESo5OYZeXrJInTiqlM
         ZF2zDEBnMQaGj2lh5GhDIo36zTqbtrI84/AIBhjLiazYLM0L8hKIOwRhBZUCvrcdw8Zc
         lJKTkeiIIVC5lEtRJ+d0nkSVF/YeulYTRPFusXHO4F7b3AeoUjSzQi0ZhKwToh9UtBy9
         1V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0cn5zngTFmzkqwz3P65OhyDJHQrFvfeob//J410v7DQ=;
        b=X6d0mTYXhYwOklt2sTyk6b1R4PBRMayq/BNNc+8AraFv26WPL4DKKsANGbJh7Bsnid
         5WmrJSBkUTVSggxDaoY/EFA7EGZ4LLvEo5Ed8+fEifHLDDaDxmwqQxU9ory/0qey1UOi
         AVuwVGv0wJFDOdyHvtqxKsoqdSLmUsB4rJWzwIkp26KBmnE+NjiND3kwhSpQGpb+UtK6
         qLW3tPLyMOlAxqxHy4iAmIaZ8xYw4FOK3aD+DcD/jWxRw6JUWAQiGhvgbgiQFy6SlGSd
         fzztUW920L597rziV1tf1bEObNe5BtBGiMBPoIk/F7v6Y7pJzwQEqlGxPkTINjTGEHTE
         hzrQ==
X-Gm-Message-State: AOPr4FXAH9OKVNfadNJWHzynsFB36p7I/gyI8S6EK+DB3ZUv7s4bYL40MQtjTgAVe0iGYsVg8BCI8jII6sACvQ==
X-Received: by 10.107.132.66 with SMTP id g63mr4729288iod.34.1462988444605;
 Wed, 11 May 2016 10:40:44 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 11 May 2016 10:40:44 -0700 (PDT)
In-Reply-To: <d783290cabe601ee8623044482b2992fb7936534.1462955446.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: N2zidKkGHlPxCM1TbU7k8k4jkN0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294357>

On Wed, May 11, 2016 at 4:42 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This patch makes perf-lib.sh more robust so that it can run correctly
> even inside a worktree. For example, it assumed that $GIT_DIR/objects is
> the objects directory (which is not the case for worktrees) and it used
> the commondir file verbatim, even if it contained a relative path.
>
> Furthermore, the setup code expected `git rev-parse --git-dir` to spit
> out a relative path, which is also not true for worktrees. Let's just
> change the code to accept both relative and absolute paths, by avoiding
> the `cd` into the copied working directory.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
> -       source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> +       source_git="$(cd "$source" && git rev-parse --git-dir)"
> +       objects_dir="$(cd "$source" && git rev-parse --git-path objects)"

Would it be out of the scope of this patch to simplify these by using -C?

    source_git=$(git -C "$source" rev-parse --git-dir)
