From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg pull/rebase
Date: Wed, 11 Jun 2008 18:00:25 +0100
Message-ID: <b0943d9e0806111000s4faecfa8o4e4042245c6ff2ba@mail.gmail.com>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
	 <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com>
	 <20080610104244.GC30119@diana.vm.bytemark.co.uk>
	 <b0943d9e0806100843j28bb3353y5889a50712377959@mail.gmail.com>
	 <20080611061110.GA15034@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Ti2-0007n0-Ge
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbYFKRAa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 13:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbYFKRAa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:00:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:53942 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYFKRA3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 13:00:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1970087ywe.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WlVi8lNOGc8YJzVSppZvUrYofGKxsEp4cnHn54OPMS8=;
        b=VmnzSh5+4bOkngVPysG4Twx7Ym31MiDwZdPvjJHKbCScsrStjZgFBoaeXfAELP0+mk
         EodpY9kD4YtlJvCAxPmvSTHk/NOslBue6rMkqIxIlSZNZYvImJRVb69/SQ4DjSvZXTzm
         nXThcqGYkwe2w/Znub6un1MuLSUgvcM/nmRiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d32s5R8U1WjmFhYlSBd4YWY8NlVnZGrrV3waAlsNyvzTJfeNpGtvDb6YhwkEok9sZi
         2mezkToVIIqZn/Um265WVfuAARPIn4cgVPdQ2ONzLVgA5EBeQZKkqi7pVgCUZ0766YOw
         5VsgX4DKyZIzUKRC3iaj6srYuXZHEv0EH1KYg=
Received: by 10.114.56.1 with SMTP id e1mr94881waa.69.1213203625555;
        Wed, 11 Jun 2008 10:00:25 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Wed, 11 Jun 2008 10:00:25 -0700 (PDT)
In-Reply-To: <20080611061110.GA15034@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84623>

2008/6/11 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-10 16:43:27 +0100, Catalin Marinas wrote:
>
>> 2008/6/10 Karl Hasselstr=F6m <kha@treskal.com>:
>> > But what exactly is "rebasecmd" useful for, when you already have
>> > "fetchcmd" and a built-in rebase?
>>
>> In case the built-in rebase is not enough. Can you use "git svn
>> fetch" followed by plain "git rebase"? There are some comments in
>> git-svn.txt that recommend to use "git svn rebase" to preserve
>> linear history.
>
> You most definitely can. I've been doing so daily for more than a
> year:
>
>  $ git svn fetch -q
>  $ stg rebase -m svn/branch

Maybe, I haven't tried (I just followed the git-svn documentation). Is
the imported svn history linear? If it works, I no longer have a need
for a rebasecmd option.

> The _advantage_ of having fetch be the only external command (besides
> reducing complexity) is that we can make it all one single StGit
> transaction (since the fetch runs to completion before the transactio=
n
> starts). This means that we don't have to touch files unnecessarily,
> which means less recompilation.

That's a good reason.

>> I think it's more of an language interpretation issue (I'm not a
>> native English speaker). I see the "pull" action as pulling (can't
>> find meaningful synonyms) remote changes into the current branch
>> (i.e. fetch + merge). I think you see it as pulling the current
>> stack onto a new base (i.e. rebase).
>
> Well, the reason I proposed to keep "stg pull" rather than "stg
> rebase" is that I agree with you that "pull" means "fetch _and_
> integrate". (Let's try a new term; "integrate" means either "merge",
> "fast-forward", or "rebase" (none of which implies any fetching, of
> course).) This is how I imagine it working:
[...]
> Any of --no-fetch/--fetch-only can be combined with any of
> --fast-forward/--rebase/--merge.
>
> If stg pull is given a committish argument, this automatically means
> --no-fetch, and causes it to integrate with that committish rather
> than the branch specified in the config. We might want to allow other
> kinds of arguments as well, I don't know.
>
> And of course,
>
>  stg rebase [committish]
>
>    The same as "stg pull --no-fetch --rebase [committish]"; that is,
>    no fetch, just rebase.

I'm OK, as long as we keep a "rebase" alias :-)

>> See my interpretation of the word "pull". I can change my mind, no
>> problem, but it would be interesting to see what a native English
>> speaker says (though you are probably closer to English than me
>> :-)).
>
> Mph, I don't know about me being "closer". I thought you were the one
> living in the UK? ;-)

I was more thinking about the native language roots (Germanic vs Latin
in my case, I've only lived in the UK for 7 years) :-)

> Regardless, I don't think we're actually in disagreement -- as I
> understand it, we both think that pull =3D fetch + integrate. And
> "rebase" is one possible value of "integrate".

I think the disagreement is that I consider "fetch" in the above
equality to be mandatory. But I think your proposal is OK.

--=20
Catalin
