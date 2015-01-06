From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Additional plumbing commands
Date: Tue, 6 Jan 2015 18:37:34 +0100
Message-ID: <CAP8UFD1OZ1QjHRyNGVs0Vm52=Ue-ta1gBzNxLpX25NSCbtu9EQ@mail.gmail.com>
References: <CA+SVznFFPED+ms=4abNpvNQx-nt6imDMJtYKuNBTTLzCJ547Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Charles Rudolph <charles.w.rudolph@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 18:38:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Y4h-0006EB-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 18:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbbAFRhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 12:37:36 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56367 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbbAFRhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 12:37:34 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so3943812ier.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fxamxzuP8FOB5CPN7+l9WRR2375q0T7VuGdosEFGxCI=;
        b=QZN18tMHlCGZTam9BB5eMhETdtnDFHo/yPhxEjEmHNZTJB7a6MIYhe+wipcPhrTrlv
         mYTwPTo78bF5jFzryPQEO1jOYM3eub7j+9e2GlGquPK03aAt5GdhY7PDWMT5r+ECEEoS
         Gz4vV7sr0oiExssDNcPbD2iYLTiIO1LfKrLPnzL9qp3AHbCzn5y73J0SYq48IqHkHiRw
         YaUmOafPN8T6oLcPSiUF8/O00Z/6lbSX+H4Yal7cdkm53DHrnvK21PAYc1crWJySXC0B
         UHJPkFlXlmU6akZE/Hd6iLhoKcafSKRUmnQT1kfPlnqLfyzrbSzCdBGvoFQDpdBD5DSR
         3l5A==
X-Received: by 10.107.128.138 with SMTP id k10mr87041640ioi.69.1420565854188;
 Tue, 06 Jan 2015 09:37:34 -0800 (PST)
Received: by 10.50.252.7 with HTTP; Tue, 6 Jan 2015 09:37:34 -0800 (PST)
In-Reply-To: <CA+SVznFFPED+ms=4abNpvNQx-nt6imDMJtYKuNBTTLzCJ547Vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262077>

On Tue, Jan 6, 2015 at 5:05 PM, Charles Rudolph
<charles.w.rudolph@gmail.com> wrote:
> I am writing some higher level git commands for
> https://github.com/Originate/git-town and would like some additional
> plumbing commands that can tell me
>
> 1. is there a merge in progress?
> 2. is there a rebase in progress?
> 3. is there a cherry-pick in progress?
> 4. are there unmerged paths?
>
> Currently the only way I know how to do this is with "git status" and
> looking for specific text.

You may have a look at how "contrib/completion/git-prompt.sh" does it.
It has stuff like:

        if [ -d "$g/rebase-merge" ]; then
                __git_eread "$g/rebase-merge/head-name" b
                __git_eread "$g/rebase-merge/msgnum" step
                __git_eread "$g/rebase-merge/end" total
                if [ -f "$g/rebase-merge/interactive" ]; then
                        r="|REBASE-i"
                else
                        r="|REBASE-m"
                fi
...

Cheers,
Christian.
