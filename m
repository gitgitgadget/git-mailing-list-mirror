From: Baz <brian.ewins@gmail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Tue, 27 Oct 2009 15:17:08 +0000
Message-ID: <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 27 16:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2nnS-0007mD-NO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 16:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbZJ0PRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 11:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbZJ0PRG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 11:17:06 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:15875 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbZJ0PRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 11:17:04 -0400
Received: by gv-out-0910.google.com with SMTP id r4so59175gve.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1t6QuGHEITHOjpevxNCE722B4l8byw4MlOVaQ0o7MWw=;
        b=hgJkjQ0094i7IXyzrruUd9ToqQXTl3U79CtOoAC38cxSZnSey3Y8spUoZKMa6xfJR0
         jX8dBQESOfFnjYdHIL+OtCGPA2NCRuTHFlw/+SrSItEDFl0yKJVNkW9tmaFR6eN+hM77
         gkJFHEPxM6jxfHp6r1mVw1quIClFb0piBUC4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vi/d15ogHIV2NyDa/W/+zm/jy3d6HejX7u8qiDUDVh9pynp2mqFl/gsBnc1TniYcF6
         ixZO/SPhc7Tr1LT+OVqDKmvQJpyoN92wC6JFLUbKqgQbYy9QFtK04NV0BBBikOX0Ima6
         +EXEyD+u6la7Q2rtHF4wPOvIN8G/9qymWzDME=
Received: by 10.216.91.10 with SMTP id g10mr1726660wef.217.1256656628915; Tue, 
	27 Oct 2009 08:17:08 -0700 (PDT)
In-Reply-To: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131348>

2009/10/27 Erik Faye-Lund <kusmabite@googlemail.com>:
> I recently came over a not-overly-helpful error in git rebase -i, whe=
n
> a line got wrapped by the editor so that a part of the commit-message
> was interpreted as a command:
>
> ---
> $ git rebase -i HEAD~20
> <edit file>
> Unknown command: .
> fatal: ambiguous argument 'Please fix this in the file C:/msysgit/git=
/.git/rebas
> e-merge/git-rebase-todo.': unknown revision or path not in the workin=
g tree.
> Use '--' to separate paths from revisions
> fatal: Not a valid object name Please fix this in the file C:/msysgit=
/git/.git/r
> ebase-merge/git-rebase-todo.
> fatal: bad revision 'Please fix this in the file C:/msysgit/git/.git/=
rebase-merg
> e/git-rebase-todo.'
>
> $ git --version
> git version 1.6.5.1386.g43a7a.dirty
> ---
>
> In this particular case, the first character on the new line was '.',
> so the first line of the error message makes perfect sense, but the
> lines that followed the real error got me pretty confused. Perhaps
> this is something that could be cleaned away? I'd think that an
> unknown command always should be fatal, and not need to propagate
> further. But I might be wrong, as I'm not familiar with the inner
> workings of rebase -i.

I've got a somewhat related minor usability issue with rebase -i. I
accidentally typed something like 'git rebase -i -z' and got this
message:

error: unknown switch `z'
usage: git-rebase [-i] [options] [--] <upstream> [<branch>]
   or: git-rebase [-i] (--continue | --abort | --skip)

Available options are
    -v, --verbose         display a diffstat of what changed upstream
    --onto ...            rebase onto given branch instead of upstream
    -p, --preserve-merges
                          try to recreate merges instead of ignoring th=
em
    -s, --strategy ...    use the given merge strategy
    -m, --merge           always used (no-op)
    -i, --interactive     always used (no-op)

The last two lines were the surprise. It suggested to me that '-i' and
'-m' were now the defaults for git-rebase - which of course they're
not. A user would not know that this is actually reporting the flags
that work for git-rebase--interactive, especially since that's not
what the command calls itself. I wasn't sure about the best approach
to fixing this - the only comparable commands that pass arbitrary
flags down to an exec'd program make it clear what program is going to
be called (usually git merge) and so interpreting errors is easier.

It seems the intent here was to signal that the flags are different
once a rebase is in progress, but this usage message is shown when
rebase -i -z is called in any state.

Cheers,
Brian
>
> --
> Erik "kusma" Faye-Lund
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
