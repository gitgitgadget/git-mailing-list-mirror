From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: Help debugging git-svn
Date: Fri, 18 Dec 2015 11:28:04 -0600
Message-ID: <CAOc6etaUUN_OdQqVJbHZ7XPq70hzEgO2HR1Uq0XxxEtK5CeDEQ@mail.gmail.com>
References: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
	<20151216074158.GB28518@dcvr.yhbt.net>
	<CAOc6eta=ZGyWFuBPAYe_4xWSH79RRmPcP5thCHYd8SsKScwW6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 18:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9yp9-0006jk-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 18:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbbLRR2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 12:28:07 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35163 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbbLRR2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 12:28:06 -0500
Received: by mail-pa0-f45.google.com with SMTP id jx14so34643943pad.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 09:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8ZR2pkS+kNAI4umNU9TYEMTucOs/MxhDDqGebUkVRbw=;
        b=sWeO915ZGNvjSVEIrlYTCaaER4e7gEI5Nf2dhpoccqnM2FLd7H0Ou1IGtk/xrQmc/J
         t8g9wE1rN4D8M2fNe62ZWRJt8RwysxiYY81i4qo4xI932rrBpiZywAC7rxWrJdw6igKJ
         +V/ECmwWapmLJuYYf7IEhPUbRzlSpVMQJY8tikq6mcMBXcJpzkeo2BMfcWMzuisXLJ/z
         vbBbgn5Qq4qPh2k6OJqR1Ifgs5fkQDImqNeljCptx3aRojr+9yWln3965P+O2D1DWfHy
         0V+siMcQCoakB5eTvVTgTDh+ODz5HS8CvGgQF3elKadiEoE4aTI37vQB6Ka0Dq/DzdPp
         rePg==
X-Received: by 10.66.190.66 with SMTP id go2mr7113407pac.114.1450459684553;
 Fri, 18 Dec 2015 09:28:04 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Fri, 18 Dec 2015 09:28:04 -0800 (PST)
In-Reply-To: <CAOc6eta=ZGyWFuBPAYe_4xWSH79RRmPcP5thCHYd8SsKScwW6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282708>

Ok.... I came up with another idea to avoid having to deal with the
old svn history (I'm having no problems fetching/dcommitting with my
current repo). I already have the branches I work with, the thing is
that the revisions I fetched before I started using the svn authors
file have nasty IDs instead of human names. I though that I could
create a script to rewrite the whole history of the project adjusting
the usernames to real names (I'll take care of the details, no problem
there... just found out about filter-branch, could work for what I'm
thinking of). My question would be in the direction of rebuilding
git-svn metainfo once I'm done so that I can continue fetching from
svn as if nothing had happened. I checked the documentation in
git-scm.com but didn't find the details about it. Is there a
straight-forward document that explains how the git-svn metadata files
are built?

Thanks in advance.

On Wed, Dec 16, 2015 at 6:36 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Wed, Dec 16, 2015 at 1:41 AM, Eric Wong <normalperson@yhbt.net> wrote:
>>
>> Any chance you can reproduce this on a Linux system?
>> I do not use non-Free systems and have no debugging experience
>> there at all.
>>
>
> My wish.... But it's a big resounding "no".
>
>>> With my very flawed knowledge of perl I have seen that the process is
>>> getting to Ra.pm around here:
>>
>> It could also be a bug in the SVN bindings or the port of
>> Perl.  Which versions are you running?
>
> I'm working on git for windows 2.6.3. I think I could use cygwin, just
> in case (I used it before).
>
>>
>>
>> I've also been wondering about the motivation of SVN developers to do a
>> good job on maintaining their Perl bindings (given git-svn is likely the
>> main user of them).
>> We've certainly had problems in the past with SVN breaking and
>> causing git-svn to segfault around 2011-2012; but it's been a while...
