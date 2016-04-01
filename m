From: Matthew Persico <matthew.persico@gmail.com>
Subject: Re: GIT_CONFIG - what's the point?
Date: Fri, 1 Apr 2016 10:31:12 -0400
Message-ID: <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
References: <CAL20dLDQsti1qW7CrrEifPAhPp1snq9r5MgJL+mDwhLqhe6fyQ@mail.gmail.com>
 <20160401123830.GB12019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:31:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am06q-000779-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 16:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbcDAObd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 10:31:33 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33564 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbcDAObc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 10:31:32 -0400
Received: by mail-yw0-f181.google.com with SMTP id h65so163801060ywe.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uxQeOR0ijylfmqZe0BkZmagDwtxTKhIVG//RIkCJJxM=;
        b=udkCQNSnrczUyg0e1irwrB4d9pcYRc2Ruks0QwEvY0HUCgdYaknn9SmHU4iPilZe+1
         bJrYe69Cj1WbZe94xfC7bbvP5pgoAdJ5xsgTco608+RaufFm7U5+6qWU47cFvVjjJ5DQ
         v1EEr9VBH2ocO5lA5lTWDiQbpUsp96w6OdCHnBP3Qkr5rtp6QJJvbsoxn1TP5AyykjbE
         1oxcLDbesfH4eQ53ULfs2dlNhXTFHSAZG1mvb+6AAXfzt9jcRf2GCVd7Zx9tOaF6ie+H
         dEVtMHvHIoapr+cDfHhJ0XrqUY8RB6xolI6bSSvEVPC3qizOrfR/UIMZqdrd182yI1ZA
         GQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uxQeOR0ijylfmqZe0BkZmagDwtxTKhIVG//RIkCJJxM=;
        b=JU5TyG12TTQ8PR3g/up6KYGO/V3hWuS7dSOZVnT96Cwe/trInWQ4nP7BZn64X6bKx+
         XGGYwLEsEAbZ34VSymA4HmuArZsOs07GWY0rpRTIQExkldPQha3UQa12SBbiP39H8F0j
         W1EkriI1274u1jN8C+Xt0q4vhZ11IEF9dd96g2Jv3pX6yc0YnH+eUI00LXiIM3hqKtjU
         QfemhLwJH2FvevOMIWResHxAk8G8kJwwjQEe7k2jyU/XOxFQEZBuAq1KsmrkT7SHap6r
         5qa69JBYeSMiEx2d4j92vmRd1lsNWYUusLyY1q807AL4W9//7tN6jkXy0edj0uA52hmR
         Nkyg==
X-Gm-Message-State: AD7BkJKTTcCtKqGI1bgBWillCoieUNW+p5vEkjzhWBykWpLc4j1+EJkMSoBH5Z6gpC2wNOI24yo3FfLAfEDYcw==
X-Received: by 10.31.12.3 with SMTP id 3mr2221626vkm.28.1459521092067; Fri, 01
 Apr 2016 07:31:32 -0700 (PDT)
Received: by 10.159.54.228 with HTTP; Fri, 1 Apr 2016 07:31:12 -0700 (PDT)
In-Reply-To: <20160401123830.GB12019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290539>

Let me explain my scenario. I have an nfs mounted home directory. It
is used across multiple machines. I use different colored xterms for
each machine. But that means that the one set of colors in my one
.gitconfig file don't work against all my screen backgrounds. I'm
trying to find a way to tune the git colors per login. The ability to
set colors in an environment variable (like most UNIX utils support)
would be the easiest way to do this. Failing that, I was hoping that
by setting GIT_CONFIG per login, I could tune the color schemes with
different config files.

Since that is not how GIT_CONFIG is used, I have simply decided to
squint where necessary, or open up a neutral colored xterm for the
diff, regardless of machine.

Yes, I could probably do diffs in many other ways, but git diff at the
command line is usually the most expedient.

Unless I wanted to define a GIT_CONFIG_OVER environment variable upon
login, place inside it the appropriate -c<name>=<value> overrides for
colors, and then define a bash function git as

git () {
   $(which git) $GIT_CONFIG_OVER "$@"
   return $?
}

which seems silly.

Thanks anyway.

On Fri, Apr 1, 2016 at 8:38 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 31, 2016 at 08:54:26PM -0400, Matthew Persico wrote:
>
>> So, what's the point of GIT_CONFIG if only git-config uses it? Or did
>> I miss a step?
>
> There isn't a point to it. It's historical cruft that has been left in
> to avoid breaking older scripts. The same thing is generally better
> accomplished by using git-config's "--file" parameter. We should
> probably do a better job of making that clear in the documentation.
>
> Or possibly deprecate it and eventually remove it entirely, as discussed
> in:
>
>   http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/1195694/focus=257770
>
> -Peff



-- 
Matthew O. Persico
