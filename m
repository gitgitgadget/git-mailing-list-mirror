From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Tue, 5 May 2015 23:08:28 -0400
Message-ID: <CAPig+cT9X-nXhQyjDtzLzm-A2LWLaCDThR9_xh=G049SqKHccw@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 05:08:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpphQ-0000b0-6s
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 05:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223AbbEFDIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 23:08:32 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37239 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965AbbEFDI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 23:08:29 -0400
Received: by igblo3 with SMTP id lo3so5483618igb.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=DHNxgtEq5iBXKqj7GcK0pKs0yErpwXRZIMloSjtRqso=;
        b=RtizcXQyrrhsZtYvdcQgnLSLpa0QgFwTAxunEwmhEqSOdrxZNRxGfdLQFUG9XiaKwc
         1zODfN2XC/g3xaLAGoosCr84V/CFQDQM/r01f+XycgW4TMtsxTdO6BkKniekzNJ96cZc
         99iG0wbtRkwhJjrXlrEghiir9HNoItC5FfcNCxgm0gxjFP5mI9SO/FqwIP+sPavJ6Rlq
         SxAxDT8phAieixS16sBOgpIuwMkyA3ffWCb9JcRKYDSGzq4B3fxP/3M8pam7rTI7y2F3
         z3XuLTzVwkFqyxICFapTQkxIB2Bw4QNoC7QP1teyjUzKyYQMdUR2/wtNU00n6XcAh0hM
         aI+A==
X-Received: by 10.42.250.70 with SMTP id mn6mr545958icb.78.1430881708343; Tue,
 05 May 2015 20:08:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 5 May 2015 20:08:28 -0700 (PDT)
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: 3mNjJB3QZPcOG8xjnL7HsLDzfXc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268441>

On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> This v4 includes the following suggestions:
>
> In command-list.txt:
> - Add a [groups] block containing names and description for groups:
>
>    [groups]
>    init                   starting a working area
>    worktree               working on the current change
>    remote                 working with others
>    info                   examining the history and state
>    history                growing, marking and tweaking your history
>
> - Add a [commands] header on top of the known command list, and
>   group names as a third column.
>
>    [commands]
>    git-add            mainporcelain                common-worktree
>    git-am             mainporcelain
>    git-annotate       ancillaryinterrogators
>    git-apply          plumbingmanipulators
>    git-archimport     foreignscminterface
>    git-archive        mainporcelain
>    git-bisect         mainporcelain
>    git-blame          ancillaryinterrogators
>    git-branch         mainporcelain                common-history

Thanks, this version is looking better. I, personally, still find the
redundant "command-" prefix ugly and would just as soon see it go
away. I'll make some suggestions about that when reviewing patch 2/3.

More below.

> This produces the following output of $ git help:
>
> [...]
> The most commonly used git commands are:
>
>    * starting a working area:
>       clone      Clone a repository into a new directory
>       init       Create an empty Git repository or reinitialize [...]
>
>    * working on the current change:
>       add        Add file contents to the index
>       reset      Reset current HEAD to the specified state
>
>    * working with others:
>       fetch      Download objects and refs from another repository
>       pull       Fetch from and integrate with another repository [..=
=2E]
>       push       Update remote refs along with associated objects
>
>    * examining the history and state:
>       log        Show commit logs
>       status     Show the working tree status
>
>    * growing, marking and tweaking your history:
>       branch     List, create, or delete branches
>       checkout   Checkout a branch or paths to the working tree
>       commit     Record changes to the repository
>       diff       Show changes between commits, commit and working [..=
=2E]
>       merge      Join two or more development histories together
> [...]
>
> I removed from the list of common commands: rebase, rm, mv, bisect
> because [1] they are not really common to an unfamiliar user, [2] to
> save vertical space occupied by group headers.

Please perform the removals in a separate (preparatory) patch. Not
only is it difficult to spot the removals mixed in with the primary
changes of 1/3, but they are not even mentioned in the commit message
of that patch. More generally, the removals are a logically distinct
change from assigning groupings to the common commands, thus deserve
their own patch.
