From: Stefan Beller <sbeller@google.com>
Subject: Re: "git submodule deinit -f ." no longer works when there are no submodules
Date: Tue, 22 Mar 2016 10:13:27 -0700
Message-ID: <CAGZ79kYVLaZg6APM0rfQkZjQRrh7bKBiZb39boucTAqH47eR1A@mail.gmail.com>
References: <CAP=KgsRjJ9JNKe07GRpcNP3eQK8+zYDvUpXkp-9WgiQUq0bgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:13:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPs5-0006v2-8U
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbcCVRNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:13:30 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36715 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcCVRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:13:29 -0400
Received: by mail-yw0-f172.google.com with SMTP id g3so262983313ywa.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GtO8hPIpmRwqRc1WlvRzYKtFxfbiRDVvD8+urClXbwg=;
        b=VrIaj61VlEz84W4xmCAIs+rD6F7C2Bv2rVBxTQ16bNeSqoILrJQkKoRVtQi02f+uMC
         jc/q60yL/YP1DHGh/DVIlhGJwRGZqDj6TQKAgdeAKLD9Bnn5TeXbwkd9qQOaYsq0SMHb
         uXlIszSdN/X0aEAQGolt5l8N/eRZbLtjtnC7cCm34cueUpVCLMSd6c2yrqhLjeTjAO1s
         pjLnERdHOX0MZU7Bz2uQ+bxnTW6o0U0HD3R8b2fIvi6MIEOI5KiKCEFWWMYJ8WE+2YnS
         wMCUi2w4xER+UBlAeEIJ1lvHVsx/xpcSibXSjtfktVx4uGm2+B0X7pmRNIylZNFOXL96
         KcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GtO8hPIpmRwqRc1WlvRzYKtFxfbiRDVvD8+urClXbwg=;
        b=hnHAv7rK8KoJR/eFpRxmAcOGDU8xVWF4KWjqnpwATxy0agh7BqDj1uQ2J8P1DMYzgW
         wT++oNKUlE6P0x6anm4IiQdGs2YdbqgGiUD2GhoBglYQsNLhfDkZZI9hFSDXojeb3W/R
         S9Gg+w7EhpiiQQdJE79usWU9CbcyjGHV+3QrnD7tHcG87i/gUoyNXhtoycio/SBWTUDZ
         AsLyJZq/8IwLKGwAbDKiUTzXxPAcc5pZsWlk+2w8IS/Gg8uAExMqgj6Bg2MYWwImUXOV
         y6Y6UA39y/9t0mohtYyNmVrYljN1oifYns+IghbC6FkPP2oKCg58DSXbKpS8xx33dzjd
         LqNA==
X-Gm-Message-State: AD7BkJLQJEcuGtXRT+gXeUmx/zQM6y2er4NeKgkf/5H7Q3JFxDHiWSOBgxP1v/7rqrvU4dTSuIIb+c/6FvtCSVry
X-Received: by 10.129.108.145 with SMTP id h139mr18476336ywc.320.1458666807828;
 Tue, 22 Mar 2016 10:13:27 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 10:13:27 -0700 (PDT)
In-Reply-To: <CAP=KgsRjJ9JNKe07GRpcNP3eQK8+zYDvUpXkp-9WgiQUq0bgcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289520>

On Tue, Mar 22, 2016 at 2:25 AM, Per Cederqvist <cederp@opera.com> wrote:
> It used to be possible to run
>
>     git submodule deinit -f .
>
> to remove any submodules, no matter how many submodules you had.  That
> is no longer possible in projects that don't have any submodules at
> all.  The command will fail with:
>
>     error: pathspec '.' did not match any file(s) known to git.
>
> But if I run "git submodule deinit" (without the ".") git tells me:
>
>     Use '.' if you really want to deinitialize all submodules
>
> This is a regression introduced in Git 2.7.0 (and v2.7.0-rv0).  "git
> bisect" points to this commit:
>
>     commit 74703a1e4dfc5affcb8944e78b53f0817b492246 (refs/bisect/bad)
>     Author: Stefan Beller <sbeller@google.com>
>     Date:   2015-09-02 14:42:24 -0700
>
>         submodule: rewrite `module_list` shell function in C
>
> One could argue that it makes no sense to run "git submodule deinit -f
> ." in a repository with no submodules.  I've written a continuous
> integration system for a project where some branches have submodules
> and other don't, and I found it convenient to don't have to treat
> those branches differently.
>
> The following shellscript demonstrates the issue.  It passes on git
> version before 2.7.0, and fails on later versions.

Thanks for the bug report, I'll fix it.
Stefan

>
> --- cut here ---
> #!/bin/sh
> #
> # This script demonstrates the "git submodule deinit ." bug.
> #
>
> if ! mkdir subdeinit
> then
>     echo 'Covardly refusing to alter the "subdeinit" directory.' >&2
>     echo 'Please remove it, or run this script inside an empty directory.' >&2
>     exit 1
> fi
>
> cd subdeinit
> mkdir repo
> cd repo
> git init
> echo test > test
> git add test
> git commit -m"Create an initial commit."
> if git submodule deinit -f .
> then
>     echo PASS: git submodule deinit -f . is allowed.
>     exit 0
> else
>     echo FAIL: git submodule deinit -f . is not allowed.
>     exit 1
> fi
> --- cut here ---
>
> Yours,
>     /ceder
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
