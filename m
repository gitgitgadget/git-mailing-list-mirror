From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 08:41:20 -0400
Message-ID: <CABURp0rPF3WSm9dQe70DBOKtJDtUTL_BdpQOv1h-nwwcCZpD9g@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-2-git-send-email-artagnon@gmail.com> <CABURp0pVzQ2rVB-B2L+uCMtPV7QFPSgkZnHitCsrPCrR9LJOVA@mail.gmail.com>
 <20130614122950.GE23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:41:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTK6-0003GP-19
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab3FNMlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:41:42 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:45022 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3FNMll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:41:41 -0400
Received: by mail-vc0-f179.google.com with SMTP id hz11so400081vcb.10
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r7tRoK+4fluHnkneoXzR8RK19DsA1XMfEQABVS3yCEM=;
        b=0N/H6pyZJ3Ha95j82uoLSIMmr5VXsC2tBvsuI0TNz/0bIK7uQyUmGyUsHb17JzPUgL
         XwlQY0WlBTmhPiUANtJwrZmYo8IRB4lkar0kLdXBVbkKHEQSYDEYUiUsVuo55w3dPMdr
         0VQ5iNPSsgRsGGUzab1qFZuRX+7+J8tbrRsKElsX5sYUEtKT6InmQhfL+SnhdHcEV9Kb
         CI5bpFofp0D6KU48cGM7C3WmqkN5Qzo3wB7TJoYT+XH1lQfkrPlpCmIR7vpygqIOOhvF
         TzJbiD1ZnMhHTT9yUSk7hIEN6r8MzizQOW2nQ2rZMT5l+KjuZxgauJrMxN1ClpDTtosK
         /8Cg==
X-Received: by 10.220.48.73 with SMTP id q9mr865109vcf.36.1371213701074; Fri,
 14 Jun 2013 05:41:41 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 05:41:20 -0700 (PDT)
In-Reply-To: <20130614122950.GE23890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227818>

On Fri, Jun 14, 2013 at 8:29 AM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Jun 14, 2013 at 08:12:56AM -0400, Phil Hord wrote:
>> On Fri, Jun 14, 2013 at 4:56 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>> > If a rebasing pull is requested, pull unconditionally runs
>> > require_clean_worktree() resulting in:
>> >
>> >   # dirty worktree or index
>> >   $ git pull
>> >   Cannot pull with rebase: Your index contains uncommitted changes.
>> >   Please commit or stash them.
>> >
>> > It does this to inform the user early on that a rebase cannot be run on
>> > a dirty worktree, and that a stash is required.  However,
>> > rr/rebase-autostash lifts this limitation on rebase by providing a way
>> > to automatically stash using the rebase.autostash configuration
>> > variable.  Read this variable in pull, and take advantage of this
>> > feature.
>>
>> This commit message does not tell me what this commit does.  It mostly
>> describes the current situation.  Then it refers to something called
>> "rr/rebase-autostash" which will lose meaning in the future when this
>> commit is no longer current on the list.  A better way to refer to
>> this commit is to say "this commit".  However, even this is not the
>> norm for this project.  The norm here is to avoid such noise by
>> speaking in the imperative mood.  That is, do not tell me what this
>> commit does; instead, tell the code what to do.  See
>> Documentation/SubmittingPatches:
>
> It seems to me that Ram's message is already in the imperative.  The
> only (slight) issue is that rr/rebase-autostash will become hard to find
> once Junio cleans up feature branches that have graduated.  Since that
> branch has graduated to master, it would be clearer to refer to commit
> 5879477 (rebase: implement --[no-]autostash and rebase.autostash,
> 2013-05-12).  Is something like this clearer?
>
>     "git pull" currently cannot be used with the "autostash" feature
>     added to "git rebase" by commit 5879477 (rebase: implement
>     --[no-]autostash and rebase.autostash, 2013-05-12) because it
>     unconditionally calls requre_clean_worktree early on, which results
>     in:
>
>         # dirty worktree or index
>         $ git pull
>         Cannot pull with rebase: Your index contains uncommitted changes.
>         Please commit or stash them.
>
>     Remove this restriction by skipping the call to
>     require_clean_worktree if the "rebase.autostash" configuration
>     variable is set.


Yes, thanks.   I was mislead by my poor understanding all the players
involved.  This disambiguates things nicely.

Phil
