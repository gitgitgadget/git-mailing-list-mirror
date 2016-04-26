From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: "gitk --author=foo" shows also parent
Date: Tue, 26 Apr 2016 10:06:02 -0400
Message-ID: <CANoM8SXn0CgUqQU3vmH-kwuxiDfC1=4FCh1SUsYuOOv4fQtWpw@mail.gmail.com>
References: <571F6852.1070405@qt.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, paulus@samba.org
To: Nikolai Kosjar <nikolai.kosjar@qt.io>
X-From: git-owner@vger.kernel.org Tue Apr 26 16:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av3dG-0005lp-W7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 16:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbcDZOGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 10:06:24 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36096 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcDZOGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 10:06:23 -0400
Received: by mail-ig0-f171.google.com with SMTP id u10so42579304igr.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yOvYOhcjrTzXNRpaH2Mv9hce74l+YYveppGRvjn/7AM=;
        b=eQHp6Sy1JwMDHYh2Bh+Bc66AH+zSmNgXIwFdjnobB5a/MP8JEGz59NidqMsqkCEH03
         qn+ycoAJL6fNj6Tom7PWBkzU51Y1SuNw5SkDRBiapljZaVu9U/WgYZOxhAyYvrRy1nEw
         fq0Gzsq0A2Y1CMiqFxxVG7IG0t0mkI3YXSIBocTTPdnlf1u7ZcWkjA8BP6NU9Gtztdgk
         KKh5rtKAIkPXHxGElklPe2VEwm94OcBM6S6WfGxoIdHndNyOAB/fCn8lifZSIpHjTCEh
         siEemhWsXIvITZduXbU+d0t0E85dvgDha0vYELyKvIdFUBnnwTda86eHO0sKCGdxN6C1
         UYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yOvYOhcjrTzXNRpaH2Mv9hce74l+YYveppGRvjn/7AM=;
        b=M7cuSrxhnO5ZJ5l4yawdYjLqbA69FusOwSYhtmiCMiB6bmB3KD8+CdOpEajx8vacx9
         bpfxAED1Lu5RpjtO9gb7TR1DVdGgsvok7bEYfpRgNm6zJ2UABqmeT1MOUTLgD+eL+Kjv
         L1c6wv2Rvj1WvEuStygmOZCHevogrm+o9yPJvqXRw05JIt9Nm1+K1tuy1gLx7rR+kZHj
         0gJTKC+eiaQigDAAGZE9WK6/b0fuXqVKpTVoiiMRa4v0LRNHLL6VviJdH097ycZzl7Q7
         IG6/NhmKGR8eXyVUfjvvG8ANMINMlztunVpKlffSdGPwyAY0el7sxQUUsCXfdbHVhfhT
         189g==
X-Gm-Message-State: AOPr4FW0B3YQYZhhxz6JqCsoCfrgtQjLWGdG+0Qy+x/T3NWnIFpPqKXqgEH7B87rhBuyuxmntzWaarI7Llb6lw==
X-Received: by 10.50.30.41 with SMTP id p9mr3608204igh.86.1461679582197; Tue,
 26 Apr 2016 07:06:22 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Tue, 26 Apr 2016 07:06:02 -0700 (PDT)
In-Reply-To: <571F6852.1070405@qt.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292601>

On Tue, Apr 26, 2016 at 9:08 AM, Nikolai Kosjar <nikolai.kosjar@qt.io> wrote:
> Hi!
>
>         $ gitk --author=foo
>
> ...seems to show also the parent of each author-matched commit, whereas
>
>         $ git log --author=foo
>
> does not. Is this intended or a bug? I've stumbled over this while
> configuring a gitk view with the author field.

I believe that this is intentional.  Notice that the parent commit's
circle is just outlined
compared to the selected authored commits are filled.  I consider this
the context
of the commits you are looking at.

>
> Nikolai
>
>
>
>
>
> # Setup
> ~/work/gitkBug % git init .
> ~/work/gitkBug % touch file1 file2
> ~/work/gitkBug % git add file1
> ~/work/gitkBug % git commit "--author=MrFoo <foo@world>" file1 -m "add
> file1"
> ~/work/gitkBug % git add file2
> ~/work/gitkBug % git commit "--author=MrBar <bar@world>" file2 -m "add
> file2"
>
> # TEST: git log --author - OK
> ~/work/gitkBug % git log --author=MrBar # OK, as expected
> commit 8aa4a4f651162bcb2275a1e9ee23fc1bb7226097
> Author: MrBar <bar@world>
> Date:   Tue Apr 26 14:22:58 2016 +0200
>
>     add file2
>
> # TEST: gitk --author - OPS
> ~/work/gitkBug % gitk --author=MrBar  # Ops, gitk shows also the parent
> commit
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
