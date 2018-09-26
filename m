Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD261F453
	for <e@80x24.org>; Wed, 26 Sep 2018 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIZSX4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 14:23:56 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55593 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZSX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 14:23:56 -0400
Received: by mail-wm1-f43.google.com with SMTP id 206-v6so2010174wmb.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h1X5zXeY2Yih1vxzAMSCpMoZZlNyO3nvMtfOcHZBvBI=;
        b=CSEZgsLwFMr8q3q1DdInzSeWDhVZejmbosNk40nUptu7rIyiYp0tUkJuYQ1UHyrA3B
         tSznBp3CvuPbUSXT6/3423U4rZAHYHwxE4IUr8oK6RwURViIO94sAx0VHM5AoIXIQMdH
         T0TLeGSY4xO555WgVkIzcky0JdT1/CX4OAdl2yzLx/2I5GLhsEutKvLDKOVYEzIBxgHo
         tyPUCa4wcVMfAHhWD/oO9iinS2u4GPRq3kDCn2sQK+HA+7cBWz6S3/7hS+AGbmQHvNJw
         5yrb0FeHDDVAdkyLbyaH5u+5kUzYJ3QgI6S3/pV39jyA0hco5hVsqAe55OU5ypqpURVW
         ElVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h1X5zXeY2Yih1vxzAMSCpMoZZlNyO3nvMtfOcHZBvBI=;
        b=E1woyouudlH9DnKydKODAq4WLGOYmiJ7PLjiYQyAMS57EhL8s/mx7T6bsepo2TxOcI
         SOZCVOUlnUJkUHer0Ot5gmASYBWHWnk0FyPf24OkF6/IyhMUY91hVEm2PxZP1ueOTF1r
         ecKqs0cX067/aEjNUZ9KVOmEBqJXmFG1QxCnq3OpJ/LYay5z8+A3EiK3zSCvzaXqVSri
         Iw7YhbfUIO6E/KzJuBC/5slzS+MVQFJ0Z+qXtjJMv2NwnOTmFE4Se9h4r6vKD9kKVWkg
         tEzuwNBCbI3sJVHkIcLK/XiXC4P0TGIUkWL0mKgwVubtoLnSi/v4w5P4tAx2s+mB1pGN
         gFqA==
X-Gm-Message-State: ABuFfogADWSG2lPdcx02dojMW4FcWoukmuq6Ols47vTWhUQQgIFMIPCU
        15ZIpV19BtSKHoThQp3wB9O7OrOm
X-Google-Smtp-Source: ACcGV60Kg8O7fL8Chbr8aEN6ZQvxirUGRxiHtQEVMoSZna2oG8yMqlc+Vvm+L8s7y0cLckWIwAY0cA==
X-Received: by 2002:a1c:570a:: with SMTP id l10-v6mr4112622wmb.56.1537963871286;
        Wed, 26 Sep 2018 05:11:11 -0700 (PDT)
Received: from localhost (x4db9854a.dyn.telefonica.de. [77.185.133.74])
        by smtp.gmail.com with ESMTPSA id w192-v6sm3067181wmf.33.2018.09.26.05.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 05:11:10 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:11:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t7005-editor.sh failure
Message-ID: <20180926121107.GH27036@localhost>
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
 <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 11:52:42AM +0200, Martin Ågren wrote:
> On Wed, 26 Sep 2018 at 11:00, Alexander Pyhalov <apyhalov@gmail.com> wrote:
> > As for sign-off, do I understand correctly that you just want to know
> > that I'm the original author of the code? Yes, it's so.
> 
> Right. Plus that you agree that the code (the commit) may be
> redistributed basically forever.
> 
> > I see this on OpenIndiana in
> > https://github.com/OpenIndiana/oi-userland/pull/4456 , when running
> > test suite.
> > Not sure why it wasn't noticed earlier, as 'trash directory' is used in path.
> 
> My first theory was that my shell and that of other developers was
> "modern" or "clever" enough to realize that the space belongs to the
> filename, so it just takes everything to the end of line.

(Note that redirections can occur anywhere in the command, i.e. these
are all equivalent: 'echo foo >out', 'echo >out foo' '>out echo foo')

> Whereas your
> shell would be "dumber". I see now that you have a newer bash than I
> do... Maybe this cleverness can be configured (at compile-time?), or
> maybe something else is happening.

Let me put on my POSIX-lawyer hat for a moment to explain this :)

Long story short: Bash doesn't conform to POSIX in this respect.

So, the Shell Command Language specification section 2.6 Word
Expansions [1] says among many other things the following:

  Tilde expansions, parameter expansions, command substitutions,
  arithmetic expansions, and quote removals that occur within a single
  word expand to a single field. It is only field splitting or
  pathname expansion that can create multiple fields from a single
  word.

Later, in section 2.7 Redirection [2]:

  [...] the word that follows the redirection operator shall be
  subjected to tilde expansion, parameter expansion, command
  substitution, arithmetic expansion, and quote removal. Pathname
  expansion shall not be performed on the word by a non-interactive
  shell; an interactive shell may perform it, but shall do so only
  when the expansion would result in one word.

Note that this "word" is _not_ subject of field splitting, i.e. in a
redirection like

  echo foo >$file

it's not necessary to quote $file, because it will remain a single
field even if it contains spaces.

Most shells I have at hand follow the specs:

  $ for shell in dash mksh ksh ksh93 zsh ; do $shell ./e\ space.sh "output from $shell" ; done
  $ ls -1 output\ from*
  output from dash
  output from ksh
  output from ksh93
  output from mksh
  output from zsh

Bash doesn't:

  $ bash ./e\ space.sh "output from bash"
  ./e space.sh: line 1: $1: ambiguous redirect

And this behaviour is documented in its man page (though the text
calls "word splitting" what the specs call "field splitting"):

  The word following the redirection operator in the following descrip
  tions, unless otherwise noted, is subjected to brace expansion,
  tilde expansion, parameter and variable expansion, command
  substitution, arithmetic expansion, quote removal, pathname
  expansion, and word splitting.

When run in posix mode, however, even Bash follows the specs:

  $ ls -l /bin/sh
  lrwxrwxrwx 1 root root 4 Sep 26 12:04 /bin/sh -> bash
  $ sh ./e\ space.sh "output from bash as sh"
  $ bash --posix ./e\ space.sh "output from bash --posix"
  $ ls -1 output\ from\ bash*
  output from bash as sh
  output from bash --posix

That's why we didn't noticed it yet, not even on macOS, which uses
Bash as /bin/sh.  You have to build Git with 'SHELL_PATH=/bin/bash' to
make t7005 fail because of this issue, and based on the trace that
Alexander showed us it seems that OpenIndiana folks do build Git that
way.

Good.  *throws the POSIX-lawyer hat into the farthest corner*

Having said all that, I didn't omit the quotes in 4362da078e with the
above in mind; in fact I tend to use quotes even when they are
unnecessary (e.g. in variable assignments: var="$1"), because unquoted
variables and command substitutions freak me out before I can think
through whether its safe to omit the quotes or not :)


Sidenote: this test should use the write_script helper to create this
editor script.



[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06
[2] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07


> > execve("/bin/bash", 0x007EA898, 0x007EA960)  argc = 5
> > 2655:    argv: /bin/bash -c ./e\ space.sh "$@" ./e\ space.sh
> > 2655:     /export/home/alp/srcs/oi-userland/components/developer/git/build/amd64/t/trash
> > directory.t7005-editor/.git/COMMIT_EDITMSG
> > 2655:   execve("./e space.sh", 0x005655C8, 0x00564008)  Err#8 ENOEXEC
> > ./e space.sh: line 1: $1: ambiguous redirect
> 
> > Shell is bash, as you can see (GNU bash, version 4.4.23(1)-release
> > (i386-pc-solaris2.11))
> 
> I came up with the following commit message. What do you think about it?
> 
>     t7005-editor: quote filename to fix whitespace-issue
> 
>     Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
>     prereq, 2018-05-14) removed code for detecting whether spaces in
>     filenames work. Since we rely on spaces throughout the test suite
>     ("trash directory.t1234-foo"), testing whether we can use the filename
>     "e space.sh" was redundant and unnecessary.
> 
>     In simplifying the code, though, the commit introduced a regression around
>     how spaces are handled, not in the /name/ of the script, but /in/ the
>     script itself. The editor-script created looks like this:
> 
>       echo space >$1
> 
>     We will try to execute something like
> 
>       echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG
> 
>     Most shells seem to be able to figure out that the filename doesn't end
>     with "trash" but continues all the way to "COMMIT_EDITMSG", but at least
>     one shell chokes on this.
> 
>     Make sure that the editor-script quotes "$1".
> 
> Martin
