From: Phil Hord <phil.hord@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 18:07:04 -0400
Message-ID: <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org> <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Witten <mfwitten@gmail.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OlN-0002iF-Uz
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1I2WHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:07:25 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:58815 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab1I2WHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 18:07:24 -0400
Received: by pzk1 with SMTP id 1so2747467pzk.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BSlOL7ALhn3Vw6fND8kMkPrXk4f8fNr7H0IDZmIU8VE=;
        b=NbAjiL8DzZw10NMNZ9WO3CWr9Ydxpqn45zanjgBT8w1AHBt2+w1BHVv69CsPjudlNe
         iFNq/vG5KHi+qCpWJtzKkQgDOmmNTEkgTBoAiz/TU+5WU7/iBrgYYNQAgvtkfSGD9K3t
         su1iO40ComGoaLDCd2BSj3f1l1wRbJ0/kqiGs=
Received: by 10.68.12.104 with SMTP id x8mr27044715pbb.79.1317334044056; Thu,
 29 Sep 2011 15:07:24 -0700 (PDT)
Received: by 10.68.52.105 with HTTP; Thu, 29 Sep 2011 15:07:04 -0700 (PDT)
In-Reply-To: <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182449>

Junio C Hamano <gitster@pobox.com> writes:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> I think a user looking for this functionality -- either a new git user
>> or a user who seldom uses the "create secondary root commit" command
>> -- would first try 'git help init'.  It seems logical to me that I
>> should be able to do this:
>>
>>   cd my-git-repo
>>   git init --root=<newbranch> .
>>
>> This feels natural to me for this operation.
>
> Hmm, this does not feel very natural to me; unless "git init --root=work"
> uses 'work' branch instead of 'master' when creating a new repository,
> that is. But it is attractive that init is much less often used than
> checkout/commit and everybody knows it is somewhat a _special_ operation.

That's what I meant.  Sorry my example wasn't more clear about that.
I also considered "--new-branch" and "--new-root".  I like the latter
more, but I didn't like the extra hyphen.  Considering the rarity and
the prior art, I guess either one is more clear here.

>>> That leaves "Hidden History" the only useful use case. IOW, the answer to
>>> the first question above is not "Separate or Hidden History", but is
>>> "Hidden History and nothing else".
>>
>> I think you're saying that the "hidden history" scenario is more
>> special than the "separate history" one because of these reasons:
>
> Not at all.
>
> I am saying that "separate history" has no place in git workflow, if these
> multiple roots _originate_ in the same single repository with a working
> tree.

No place in *your* workflow.  Oh, wait.  Except it has, and you use it
in the git tree.  So, um...  I'm confused.

> And all of "git checkout --orphan", "git commit --root" and your
> "git init --root" are solutions to make multiple roots _originate_ in the
> same single repository with a working tree.
>
> I have no trouble in a single repository with multiple roots if that is
> done in a distribution point, which by definition does not need and
> typically does not have any working tree. Options to "checkout/commit"
> would not help as they need a working tree.

I'm not sure where you're going with the "working tree" objection.
Are you saying that it's ok to _create_ "separate histories" in a bare
repository but wrong to do so in a non-bare one?  But surely this
means it is ok to _have_ "separate histories" in a non-bare
repository, since that is what I will get when I do a simple git-clone
of the bare one.

If I understand right, the mechanics of the initial creation is what
bothers you.  Is that right?  If so, we're on the same page here,
because it bothers me too.  The commit or checkout alternatives seem
like two halves of a turd sandwich.  Both ends are wrong somehow, and
it's because of the state of the working directory in the interim.

If I don't understand you right, ignore the sandwich metaphor and
please explain.

> The way to do it is to work in multiple repositories, one for each of
> these roots, and push into a single repository from them.

That's one way to do it.

>>> And a half of the the answer to the second question is "checkout --orphan"
>>> (and the other half would be "filter-branch"). "checkout --orphan" does
>>> have major safety advantage than introducing "commit --no-parent", as Peff
>>> pointed out earlier (to which I agreed).
>>
>> The thing I don't understand about "checkout --orphan" is exactly what
>> you're getting when you do this.  I assume you get a populated index
>> and a non-existent HEAD. This seems a lot like "git init" to me,
>> especially in the non-existent HEAD area.
>
> It is "HEAD pointing at a branch that does not yet exist", but I find it
> strangely attractive ;-)
>
>> I didn't think git init would be much use for this scenario before,
>> but now I've changed my mind.
>>
>>   git init --root=<newbranch> --keep-index
>>
>> Again, this avoids complicating the common commands.  But maybe it
>> does overload init with extra baggage.
>
> I do not think you would even need --keep-index there (running "git init"
> in an existing repository to see what it does. It does not touch the index
> nor HEAD).

In my imagined extension, the "separate history" action needs a clean
index.  I guess 'git rm -fr *' will suffice, but I think an in-line
switch would be more useful... for this "non-git workflow". :-)

> I am not sure if "--root" is the right name but if "git init --root=work"
> that is run to create (not re-init) a new repository points HEAD at a yet
> to be created 'work' branch instead of 'master', I think it would be a
> reasonable alternative.

That's what I meant.  How about this?

   git init --new-root-branch=<new-branch-name>

> By the way, why did you drop the mailing list?

Clicked the wrong button.  Not used to gmail yet for this.  Sorry about that.

Phil
