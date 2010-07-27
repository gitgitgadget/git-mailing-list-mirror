From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 15:15:08 -0400
Message-ID: <AANLkTi=6SDQ2A0Zxf8DiSSNzSfUS43M7wmCkKKraOd8w@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <4C49B31F.8000102@xiplink.com> 
	<AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<201007261051.41663.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:15:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odpcm-0004Pb-Ht
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab0G0TPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 15:15:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44069 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0G0TPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 15:15:30 -0400
Received: by wyf19 with SMTP id 19so3410910wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Myv/vN74ZRtS/t9YfHkjNtZbfm/PRfxyA9V719Sta+k=;
        b=J80CF+yEdbkeCWcK0CS6d06dkkZU939cbd1ljXOVrdI5GmgpahUMNQWoQGaBAxWKHo
         5tmOMla9HEwNs9hcVE5CgjsS+szxHhVKjzyRnAs3yfn/0rruKI6C5HJ2EITx+WDrVbxA
         mpDN8NXjZcW06Gn/877agASkDyFgpAyMjq7BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ls44IiCnmfj7IcZEX1TsCv+OTdSgutMQCJSUcftSlAAT9Bs4xg9tzFffGKyWM6EPuX
         NLPrTQwjynhdTeA1vrO+iE8/K1pv4vIcP6FWWQ3pR3/80tO/kQfHeJsmyWcLmPYpTI6z
         9MRIn1y2ixpCveta6a4Si33/gpjqrPpGOVuhg=
Received: by 10.216.165.201 with SMTP id e51mr9372958wel.89.1280258128208; 
	Tue, 27 Jul 2010 12:15:28 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 12:15:08 -0700 (PDT)
In-Reply-To: <201007261051.41663.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151975>

On Mon, Jul 26, 2010 at 4:51 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Sat, 24 Jul 2010 00:50, Avery Pennarun wrote:
>> My bup project (http://github.com/apenwarr/bup) is all about huge
>> repositories. =A0It handles repositories with hundreds of gigabytes,=
 and
>> trees containing millions of files (entire filesystems), quite nicel=
y.
>> =A0Of course, it's not a version control system, so it won't solve y=
our
>> problems. =A0It's just evidence that large repositories are actually
>> quite manageable without changing the fundamentals of git.
>
> There is also git-bigfiles project, although it is more about large
> [binary] files than large repositories per se (many files, long histo=
ry).

Right.  git-bigfiles is valuable, but it's valuable with or without
submodules.  (If you have large blobs, submodules won't save you.)

bup happens to have its own way of dealing with large files too, but
it may not be applicable to git.  It does result in lots and lots of
smaller objects, though, which is why I know git repositories are
fundamentally capable of handling lots and lots of smaller objects :)

> Note that with 'bup' you might not see problems with large repositori=
es
> because it does not examine code paths that are slow in large reposit=
ories
> (gc, log, path-delimited log).

gc is a huge problem.  bup avoids it entirely (it foregoes delta
compression); git gc fails completely on such large repositories (100+
GB).  There's no reason this has to be true forever, but yes, to
support really big repos, git gc would need to be improved somewhat.
=46or most reasonably sane repos (a few GB) you can get reasonable
performance by just making your biggest packfiles .keep so they don't
keep getting repacked all the time.

Compared to that, log feels like not a problem at all :)  At least
performance-wise.  The thing that sucks about log using git-subtree,
of course, is that you get all these log messages from multiple
projects jammed together into a single repo, which is rarely what you
want, even if it's fast.  I think the "best" solution is a single repo
with all your objects, but still keeping the histories of each
submodule separate.

>> IMHO, the correct answer here is to have an inotify-based daemon pro=
d
>> at the .git/index automatically when files get updated, so that git
>> itself doesn't have to stat/readdir through the entire tree in order
>> to do any of its operations. =A0(Windows also has something like ino=
tify
>> that would work.) =A0If you had this, then git
>> status/diff/checkout/commit would be just as fast with zillions of
>> files as with 10 files. =A0Sooner or later, if nobody implements thi=
s, I
>> promise I'll get around to it since inotify is actually easy to code
>> for :)
>
> IIUC the problem is that inotify is not automatically recursive, so
> daemon would have to take care of adding inotify trigger to each newl=
y
> created subdirectory.

Yeah, the inotify API is kind of gross that way.  But it can be done,
and people do.  (eg. the beagle project)

>> Also note that the only reason submodules are faster here is that
>> they're ignoring possibly important changes. =A0Notably, when you do
>> 'git status' from the top level, it won't warn you if you have any
>> not-yet-committed files in any of your submodules. =A0Personally, I
>> consider that to be really important information, but to obtain it
>> would make 'git status' take just as long as without submodules, so
>> you wouldn't get any benefit. =A0(I think nowadays there's a way to =
get
>> this recursive status information if you want it, but it'll be slow =
of
>> course.)
>
> Errr... didn't it got improved in recent git? =A0I think git-status n=
ow
> includes information about submodules if configured so / unless confi=
gured
> otherwise. =A0Isn't it?

Yes, but you're still left with the choice between slow (checks all
files in all submodules) and not slow (might miss stuff).  This isn't
a submodule question, really, it's an overall performance question
with huge checkouts with or without submodules.

>>> We chose git-submodule over git-subtree mainly because git-submodul=
e lets us
>>> selectively checkout different parts of our code. =A0(AFAIK sparse =
checkouts
>>> aren't yet an option.)
>
> Sparse checkouts are here, IIRC, but they do not solve problem of dis=
k
> space (they are still in repository, even if not checked out), and sp=
eed
> (they still need to be fetched, even if not checked out).

Hmm, don't mix bandwidth usage (and thus the slowness of fetch) with
slowness during everyday usage.  I don't mind a slow fetch now and
then, but 'git status' should be fast. AFAIK, sparse checkouts
*should* make git status faster.  If they don't, it's probably just a
bug.

Have fun,

Avery
