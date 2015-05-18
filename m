From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/5] help: respect new common command grouping
Date: Mon, 18 May 2015 14:39:42 -0700
Message-ID: <xmqqr3qda7kx.fsf@gitster.dls.corp.google.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 23:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSlJ-0006Ty-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbERVjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 17:39:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34553 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbERVjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:39:44 -0400
Received: by ieczm2 with SMTP id zm2so110016730iec.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=loxOZu9n0g5PFHvKHdczAC3lwlSZRL6KHM3ZCM691ns=;
        b=AdkBZAc+Qg2oPAV+UVn4hNlZK2sDEq/jj+F5CcA29mkeHVRJjeZZwvv/RIN9+86nky
         48hLi29sdCZ/pEWtu7gtzYgz63ca9GZY76aUUzFPltZHuInEf3mKJ2T4nEP92PD/6/xh
         nbt/BbuEMcg7NF8pwbIpngFtpVv+4EySCnKit6rDqml5CDITOmFEy7KnYynkHOFqJGYS
         w9LwIQGzZg89lUf+jhKsaaAkILLR8oqTSdM06NNHaVUdFePM6eRexP2TEbpzlme5A1OE
         ILyfB/nz1TLP/7tVsNM5fJIjmBJLWBFWtpw0dxtOj1T2rAXUBbKPVx/fNRDSVFuJr1HE
         Y6mA==
X-Received: by 10.50.64.147 with SMTP id o19mr17011493igs.33.1431985183799;
        Mon, 18 May 2015 14:39:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id o2sm6407522igr.9.2015.05.18.14.39.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 14:39:43 -0700 (PDT)
In-Reply-To: <1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
	(=?utf-8?Q?=22S=C3=A9bastien?= Guimmara"'s message of "Mon, 18 May 2015
 21:18:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269324>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> 'git help' shows common commands in alphabetical order:
>
> The most commonly used git commands are:
>    add        Add file contents to the index
>    bisect     Find by binary search the change that introduced a bug
>    branch     List, create, or delete branches
>    checkout   Checkout a branch or paths to the working tree
>    clone      Clone a repository into a new directory
>    commit     Record changes to the repository
>    [...]
>
> without any indication of how commands relate to high-level
> concepts or each other. Revise the output to explain their relationsh=
ip
> with the typical Git workflow:
>
> The typical Git workflow includes:
>
> start a working area (see also: git help tutorial)
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize [...]
>
> work on the current change (see also: git help everyday)
>    add        Add file contents to the index
>    mv         Move or rename a file, a directory, or a symlink
>    reset      Reset current HEAD to the specified state
>    rm         Remove files from the working tree and from the index
>
> examine the history and state (see also: git help revisions)
>    log        Show commit logs
>    status     Show the working tree status
>
>    [...]
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---

I cannot exactly pinpoint what bothers me, but "The typical Git
workflow includes:" sounds a bit awkward.

What does a workflow "include"?  What are components included in a
workflow?  Are "starting a repository", "working on a single thing",
"collabolating", etc. components that are incuded in a workflow?

If so, the fact that "clone", "init", etc. are "commands that are
commonly used in each component of the workflow" is a more important
thing to say; in other words, the header does not explain what list
it is presenting the user.

Or does a workflow consists of "clone", "init", "add", "mv", etc.
that are included in it?  Then it is left unexplained what the
section headings stand for.

Perhaps something like

	These are common Git commands used in various situations:

may lessen the uneasiness I felt above.  I dunno.

Other than that, this round looks ready for 'next'.

I am not absolutely sure if new dependency on "awk" will not present
portability issues, though.  So far we only used it in scripts in
the fringes and only a few tests.

Thanks.
