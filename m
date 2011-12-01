From: bradford <fingermark@gmail.com>
Subject: Re: Workflow Recommendation - Probably your 1000th
Date: Thu, 1 Dec 2011 15:46:52 -0500
Message-ID: <CAEbKVFQLvyTq+VL9DJZtp4YZLUgeR56N9u5RrsGqEB=e81O3zQ@mail.gmail.com>
References: <CAEbKVFSXn3we7Btb3fN5DUW7BMub_ZrBeUwLUZrRFTmESoW97A@mail.gmail.com>
	<363b3901-eee6-4265-adae-267f4662a1f7@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 21:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWDX3-0003ad-9F
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 21:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab1LAUq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 15:46:56 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50595 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab1LAUqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 15:46:55 -0500
Received: by eeaq14 with SMTP id q14so802785eea.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=c4NSQA3TSnXmGpS/t/Mkqw+VVy7/lbROsfj/08caKGE=;
        b=cv3BfEHp1KsXYPW6Zr7d7P2v4SYC6sJpZw+yvBwj1il2Deu//OVguzD1Is3jlb3e0n
         upI0Tumet8dVPnCZ/Erg3pjP/oP9q9FNof/lb4Xu0atClc4Hlku2cTgubpNXy+mzGKRZ
         1A7N/LZ82f/FxxTjvuKx32U1l6igjVpLclwE4=
Received: by 10.227.207.205 with SMTP id fz13mr3604519wbb.0.1322772412775;
 Thu, 01 Dec 2011 12:46:52 -0800 (PST)
Received: by 10.227.130.150 with HTTP; Thu, 1 Dec 2011 12:46:52 -0800 (PST)
In-Reply-To: <363b3901-eee6-4265-adae-267f4662a1f7@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186192>

Thanks, Stephen.   I guess I'm looking for more input on the
advantages and disadvantages of using a QA and production branch vs
just doing everything out of master.

Trying to go through the following:
http://news.ycombinator.com/item?id=3D1617425
scottchacon.com/2011/08/31/github-flow.html

We have some weeks where we release very frequently and some weeks
where we release only once a week and have to do production fixes in
the meantime.  Sure other people have similar experiences.

On Thu, Dec 1, 2011 at 1:55 PM, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "bradford" <fingermark@gmail.com>
>> To: git@vger.kernel.org
>> Sent: Thursday, December 1, 2011 1:26:10 PM
>> Subject: Workflow Recommendation - Probably your 1000th
>>
>> You guys probably receive a ton of workflow related questions. =A0I'=
m
>> trying to convert from svn to git. =A0In order to complete, I would
>> like to be able to provide a workflow to our team. =A0We typically g=
o
>> from dev -> qa -> production (Java and Rails projects). =A0The probl=
em
>> is that sometimes QA can get backed up and we'll need to release
>> something to production while QA is doing their thing. =A0What is a
>> good workflow? =A0I would like to not use git-flow, because it's ano=
ther
>> tool.
>
> Hey wow... =A0I read that Driessen's workflow post [1] a long time ag=
o, but hadn't run into the git-flow tools until a few days ago. =A0Gues=
s I was just oblivious... =A0Anyway, if it's any consolation, my compan=
y runs a model very much inspired by Driessen's post without using git-=
flow itself.
>
> [1] http://nvie.com/posts/a-successful-git-branching-model/
>
>> I've read suggestions to use environment branches (master,
>> staging, production). =A0I've also read not to do this and just use
>> master, tagging your production releases. =A0How well would our setu=
p,
>> where things can get backed up, work with the latter? =A0Are there a=
ny
>> alternative suggestions?
>
> In our workflow we flip Driessen's model on its head. =A0master is th=
e newest code, while we branch off maintenance branches just before eac=
h release. =A0We tag each release so it's easy to identify which versio=
ns in the field contain a given bug or fix (multiple minor versions com=
e off a single maintenance branch). =A0Our QA guys follow the maintenan=
ce branches (they're relatively stable). =A0We recently had to do a hot=
-fix release which I think would be similar to your "release to product=
ion". =A0Basically we found the last commit on the maintenance branch t=
hat was well tested, created a new branch from there, did the hot fix, =
QA did some real fast testing (sounds like you'd skip this step), and w=
e shipped that. =A0As always that hot-fix release gets tagged, so in th=
e future we can still reference that particular build (and in this case=
 the branch merged back into the maintenance branch -- we've had other =
situations where the branch was simply deleted after tagging).
>
> In the grand scheme of things our model isn't that different than Dri=
essen's; we just name the branches differently. =A0Commits go on the ol=
dest branch that's safe for them, and then everything merges to the new=
er branches. =A0Tags provide easy reference for where on a given branch=
 a release came from.
>
> Hope that helps.
>
> Stephen
