From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Thu, 21 Jul 2011 15:54:49 +0300
Message-ID: <CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
	<4E268D2F.50201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 14:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjsmJ-0004fS-IW
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1GUMyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 08:54:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60790 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab1GUMyv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 08:54:51 -0400
Received: by ewy4 with SMTP id 4so1136307ewy.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 05:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UNcyznnbTRdlLiNnh72NW2sKRP5DQ+YWsMxFZgm9ssM=;
        b=k4inG2itGEpTeB+UOUcw0uVEetxYMsFOCRflwCG+gDme9r7RExInZ7rb64qLSxonPn
         Nf2NgMI4RmonleBBv+bBSP0RwZK3owgPoRaI8heOiitNlawfvSY9twLgKwxy6TkhYwqT
         RYOWACl+aMLu8r6F7YLhmJnJeKVugsjMl+nBU=
Received: by 10.213.16.148 with SMTP id o20mr231797eba.143.1311252889839; Thu,
 21 Jul 2011 05:54:49 -0700 (PDT)
Received: by 10.213.17.15 with HTTP; Thu, 21 Jul 2011 05:54:49 -0700 (PDT)
In-Reply-To: <4E268D2F.50201@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael,

On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>> Add top level ignore rule for patches created by format-patch comman=
d.
>
> Please don't.
>
> The tracked ignore file is for ignoring products and artefacts of our
> build process. format-patch is not part of this process, and the
> existence of *.patch files depends on your workflow. But what is much
> worse: In
>
> git status
> git format-patch rev-spec
> git send-email *.patch
>
> it is very easy to send out the wrong patches (along with the right
> ones), because your patch hides them from status. Also, I can't clean
> them up with "git clean -f" any more. I would have to use "git clean =
-f
> -x" which would clean the build products also (and force a rebuild).
>
> So, your patch makes a format-patch based workflow much worse. What
> problem does it try to solve?

I will not insist. You may know it better but git as is a public
project where anyone can create and send patches. So it seems to me
basic workflow for sharing changes.

>
>> On the way, reorganize ignore rules and add comments.
>
> How and why do you reorganize?

Just to be able to find specific rule faster. Global rules are now all
together same is for top level root rules.

>
>>
>> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>> ---
>> =A0.gitignore | =A0 43 ++++++++++++++++++++++++++++++-------------
>> =A01 files changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 8572c8c..47afe77 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,3 +1,15 @@
>> +#
>> +# NOTE! Don't add files that are generated in specific
>> +# subdirectories here. Add them in the ".gitignore" file
>> +# in that subdirectory instead.
>> +#
>> +# NOTE! Please use 'git ls-files -i --exclude-standard'
>> +# command after changing this file, to see if there are
>> +# any tracked files which get ignored after the change.
>> +
>> +#
>> +# Top-level files
>> +#
>> =A0/GIT-BUILD-OPTIONS
>> =A0/GIT-CFLAGS
>> =A0/GIT-LDFLAGS
>> @@ -187,21 +199,10 @@
>> =A0/test-svn-fe
>> =A0/test-treap
>> =A0/common-cmds.h
>> -*.tar.gz
>> -*.dsc
>> -*.deb
>> =A0/git.spec
>> -*.exe
>> -*.[aos]
>> -*.py[co]
>> -.depend/
>> -*.gcda
>> -*.gcno
>> -*.gcov
>> =A0/coverage-untested-functions
>> =A0/cover_db/
>> =A0/cover_db_html/
>> -*+
>> =A0/config.mak
>> =A0/autom4te.cache
>> =A0/config.cache
>> @@ -213,6 +214,24 @@
>> =A0/tags
>> =A0/TAGS
>> =A0/cscope*
>> +/Debug/
>> +/Release/
>> +/*.patch
>> +
>> +#
>> +# Normal rules
>> +#
>> +*.tar.gz
>> +*.dsc
>> +*.deb
>> +*.exe
>> +*.[aos]
>> +*.py[co]
>> +.depend/
>> +*.gcda
>> +*.gcno
>> +*.gcov
>> +*+
>> =A0*.obj
>> =A0*.lib
>> =A0*.sln
>> @@ -222,5 +241,3 @@
>> =A0*.user
>> =A0*.idb
>> =A0*.pdb
>> -/Debug/
>> -/Release/
>
>
