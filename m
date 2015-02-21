From: David Aguilar <davvid@gmail.com>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Sat, 21 Feb 2015 15:31:55 -0800
Message-ID: <20150221233154.GA90150@gmail.com>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
 <20150218170007.784be6aa@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun Feb 22 00:32:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPJWl-0003za-0E
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 00:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbbBUXb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 18:31:57 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40047 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbBUXb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 18:31:56 -0500
Received: by pdev10 with SMTP id v10so16266344pde.7
        for <git@vger.kernel.org>; Sat, 21 Feb 2015 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8NN2KsqdrWyuXE2MrbhVj3TOsUIikMOAlXvLi+lRIz4=;
        b=WXFUXs/Hghlv6MmChMEymJwD6xLyR3dLFo0x5cY1MnrBzBuOcH2pLFjPQxdj5tav7E
         D7S+kIrdJ6X2ZnCIe94R1vq6QxOGhM38aCY30G5nVS7r/DQZohvvkOSEdBlIjFzd5RWW
         QKjHT+M9BAWu0X/AYm1l5BCuGwbbY4kvpo3vvd53Mq0IxVxfoq3ZhlZKSz8BhMDAzEcc
         YUBaOB7+IFjj4VwOJHy8Fc++Lz3DNx3bk9sA6m5cn5KFaRkhZKCKOLA9Ek+5j8c5W+pu
         aZP/FkietfPH8Kmn3KkuFBgkz2/CQdDnfuTU/aHaaDmZ5HxBMrJ0gN8zrwJho9YMjakp
         fxww==
X-Received: by 10.68.69.109 with SMTP id d13mr7453293pbu.152.1424561516369;
        Sat, 21 Feb 2015 15:31:56 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id z2sm22114458pde.94.2015.02.21.15.31.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 21 Feb 2015 15:31:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150218170007.784be6aa@pc09.procura.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264229>

On Wed, Feb 18, 2015 at 05:00:07PM +0100, H.Merijn Brand wrote:
> On Wed, 10 Dec 2014 23:46:25 -0800, Junio C Hamano <gitster@pobox.com>
> wrote:
> 
> > Hello, all.
> > 
> > H. Merijn Brand runs a few HP-UX boxes to help perl5 and other open
> > source communities, wants help porting more recent Git on these
> > boxes, running HP-UX 10.20, 11.00, and 11.23, and looking for a
> > volunteer.  Please contact him directly if you are interested.
> 
> No-one. Disappointing :(
> 
> I started to work on 2.3.0 on HP-UX 11.23/63 ia64
> 
> 
> Did *anyone* ever test with NO_ICONV?
> Too many tests fail without iconv
> 
> It is *very* hard to decide from the current status if all
> remaining failures are related to (Asian) locale failures and (thus)
> can be safely ignored (in my environment).
> 
> 
> Specifics at the end
> 
> 
> FAILures from scratch with no iconv:
> --------------------------------------------------------------------------------
> [...snip...]
> t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
> t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
> [...snip...]
> 
> FAILures from scratch with iconv:
> --------------------------------------------------------------------------------
> [...snip...]
> t7610-mergetool.sh              Tests: 18 Failed:  1 Failed tests: 18
> t7800-difftool.sh               Tests: 56 Failed:  1 Failed tests: 49
> [...snip...]


I think it's safe to say that these mergetool and difftool
failures are not iconv-related.


> t/t7610-mergetool.sh
> --------------------
> HP-UX' mktemp obviously is not compatible with GNU mktemp (which I have
> not installed/available on HP-UX)
> 
>  SYNOPSIS
>       mktemp [-c] [-d directory_name] [-p prefix]
> 
> Resolved 'subdir/file3' using previous resolution.
> Automatic merge failed; fix conflicts and then commit the result.
> + git mergetool --no-prompt --tool myecho -- both
> + 1> actual
> error: mktemp is needed when 'mergetool.writeToTemp' is true
> error: last command exited with $?=1
> not ok 18 - temporary filenames are used with mergetool.writeToTemp


We have prerequisites that can be used by tests to mark specific
tests as skippable.  It looks like inventing a prereq for mktemp
would be helpful here.

Maybe we don't need a global prereq, but certainly checking
whether mktemp is compliant for our use case could be used as a
criterion for skipping this test.

A further improvement would be to have have test coverage over
the failure scenario to ensure that the expected error message
is reported and that the correct exit code is returned when we
attempt to use a non-compliant mktemp.

I'd be happy to help review changes to this test.

I'm busy this week(end), but I might be able to poke around next
week if you wanted to give me a shell account.

That said, this error is non-fatal for most use cases ~ as long
as you don't set mergetool.writeToTemp then mergetool will work
fine as it will not attempt to use mktemp.


> t/t7800-difftool.sh
> -------------------
> HP-UX doesn't have readlink
> 
> + git difftool --dir-diff --symlink --extcmd ./.git/CHECK_SYMLINKS branch HEAD
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> ./.git/CHECK_SYMLINKS: line 5: readlink: command not found
> /pro/3gl/LINUX/git-2.3.0p/git-difftool line 472: No such file or directory
> fatal: 'difftool' appears to be a git command, but we were not
> able to execute it. Maybe git-difftool is broken?
> error: last command exited with $?=128
> not ok 49 - difftool --dir-diff --symlink without unstaged changes


This sounds like another case where a prereq would be helpful.
In this instance it'd be a "readlink" pre-req.

The --dir-diff code should probably be a little more careful
here, nonetheless.

The error about, "fatal: 'difftool' appears to be a git command"
seems like it might be something that can be improved.

It seems like difftool is returning an error code that the
caling code is misinterpreting as meaning, "not able to execute"
vs.  the real situation where difftool simply exited with an
(unexpected) error code.

It seems like we'd want to catch the error within difftool and
exit with a known error code.
-- 
David
