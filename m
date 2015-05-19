From: Stefan Beller <sbeller@google.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Tue, 19 May 2015 13:34:58 -0700
Message-ID: <CAGZ79kZf_C=QkfQ+LV9G9fLsfqE9USrwkMiNdLmz0-BtPuAmRw@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
	<CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
	<20150519104413.GA17458@book.hvoigt.net>
	<CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 22:35:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuoEE-0001y2-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 22:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbbESUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 16:35:00 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36293 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbESUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 16:34:59 -0400
Received: by qcir1 with SMTP id r1so13686569qci.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 13:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zyYOd9STs0HVjD69UphHWgK0CBKU4iGQHR17LytLtK0=;
        b=meGZNKhN3tL0ryGMIeXAA9P3ugYKDl5XFXFLMp69preLfix3Rzt0hvdeH8sixjRj1V
         aHqBLHDDjGxNgS+1yHdoHQzS9BBQmcJ05rLzhkaxqrdcPo9ggE0MNBI3lhGSrcgsQkDm
         CYo4Y3yuLyoBaf7iWTtGXXjCxoySGv10xTRGwN9ZwV5NN1tk0mEVumXIkkqCK8qiVJCT
         I4UwV751Qm7l8jFbrBNtMZINs+3yILKYE51I0kbdbKOa/QUzl63Ss+K+zT/MX70TNoML
         1kDT5i42Cly0Temx6I16bxhvXk1WtmB6Eu1BUnvgyIwBG3xEX1GQ6QM/yzK+B4kdP48D
         klqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zyYOd9STs0HVjD69UphHWgK0CBKU4iGQHR17LytLtK0=;
        b=Dv8xA43vEmAl4ZXEB4GKjbJGtrzTi5+UZlF2sU5TrDJe7ZPab6NOjY/kXNNr8t8isb
         LozcPWPsJwbhuGyg79Rbfnfzu+bj4CaXraX+DMIktJOcw8XVUaFlo7dKAoK0ZYUrkYhx
         Apu65X+nE6UpaxrlpYa9HUyAlwEe3oVcTAaAf7RHwX3h7ttvQLjJHMVIUR0j36x9an9z
         nkEwvC+yzNGnm+6XWXKwh2+SYXLYj2KYZN2XEbAatXi9+upGZpitswyYWzJedAXFuymJ
         FFCww5HKIcNR1NmMIjUNuG6Zyix+c/a+TUMrSSYw4IV5qnPtOkJKbv/KZYoQpWPSBLaC
         MPAg==
X-Gm-Message-State: ALoCoQk6dPo/oTJTW88OsE8coIJgVFnWsdFaxPIPxcFZxwvbKAKzeKAFYYCjzTjAc6jqQxZ7gsym
X-Received: by 10.140.196.140 with SMTP id r134mr13052005qha.60.1432067698779;
 Tue, 19 May 2015 13:34:58 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 19 May 2015 13:34:58 -0700 (PDT)
In-Reply-To: <CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269398>

On Tue, May 19, 2015 at 12:29 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> How do you send your patches inline?

There are various ways to do so.
If you look at https://github.com/git/git/blob/master/Documentation/SubmittingPatches
and search for Thunderbird (I used to use Thunderbird for a long time
before switching to
git send-email, so I'll take that as an example) at the bottom:

    Thunderbird, KMail, GMail
    -------------------------

    See the MUA-SPECIFIC HINTS section of git-format-patch(1).

Ok, indirection is the fun part of computers. ;)
So you'd look at the man page of git format patch,
such as here http://git-scm.com/docs/git-format-patch
and scroll the way down to MUA-SPECIFIC HINTS, which offers
3 different ways of doing it. (decisions!)

> Do you use git send-email?

I do, but I remember my initial struggle with it (I will contribute only
one patch anyway, so why care?)

> I have
> tried that and it is horrible to setup. Do you just copy/paste the
> patch inline in your compose window?

Once setup correctly git formatpatch / send-email are actually very
convenient (e.g. git send-email HEAD^ --to=git@vger.kernel.org will
just work. And I have strong confidence in it continuing to work,
even when Git decides to revamp the preferred patch format,
line wrapping or other exotic stuff)

>
> It would be much simpler to fork Git, create a branch, make my change,
> and initiate a pull request. I can get email notifications on comments
> to my PR diff and address them with subsequent pushes to my branch
> (which would also automatically update the code review). Turn around
> times for collaborating on a change are much quicker via Github pull
> requests.

Github has indeed an excellent product, even free for open source.

This workflow discussion was a topic at the GitMerge2015 conference,
and there are essentially 2 groups, those who know how to send email
and those who complain about it. A solution was agreed on by nearly all
of the contributors. It would be awesome to have a git-to-email proxy,
such that you could do a git push <proxy> master:refs/for/mailinglist
and this proxy would convert the push into sending patch series to the
mailing list. It could even convert the following discussion back into
comments (on Github?) but as a first step we'd want to try out a one
way proxy.

Unfortunately nobody stepped up to actually do the work, yet :(

>
> I am willing to review the typical workflow for contributing via git
> on mailing lists but I haven't seen any informative reading material
> on this. I just find using command line to email patches and dealing
> with other issues not worth the trouble. Lack of syntax highlighting,
> lack of monospace font, the fact that I'm basically forced to install
> mail client software just to contribute a single git patch.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
