From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 16:08:12 -0700
Message-ID: <7vd3ejq74z.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
 <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
 <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org>
 <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
 <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 01:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9PiG-0006RL-TA
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 01:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab1I2XIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 19:08:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab1I2XIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 19:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC2F4429;
	Thu, 29 Sep 2011 19:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ACGlvedo4ZNzwNAe9ax8YmUnbl4=; b=jmHPdbyEYLwTavr+T+cx
	La2450fcoCCrO4esseyP+6keHguqveaxuMc1LVneoHN4SYtXiZZb4H0Nd4bvBAbF
	mmpPXXREGmSnrDC8M5dFYh/Saz6vEMXqGbzPuzEaVkolg4xIhAWR3akPTgobvFVi
	nZVCpeppl7VhRGlq4KfTubI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WpaQIDnpJHDXTTdrSkjzaor1zCewd6ZRPiKjyfB11Xv1hE
	IdFIbZ8I9k4uBWwDFsHDgCQU8YFLeP7zPKyM6NIItv3LVCh8c/9q+1VSF7rHa0ZO
	ChcT922vBVdr7oJ9mptCjwslWhqq2SP1XTcDSmr56bFuSob3vtMPrq8awISsI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 144954428;
	Thu, 29 Sep 2011 19:08:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 720D84427; Thu, 29 Sep 2011
 19:08:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E837C116-EAEF-11E0-BDC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182455>

Phil Hord <phil.hord@gmail.com> writes:

>> I am saying that "separate history" has no place in git workflow, if these
>> multiple roots _originate_ in the same single repository with a working
>> tree.
>
> No place in *your* workflow.  Oh, wait.  Except it has, and you use it
> in the git tree.  So, um...  I'm confused.

No, no place in anybody's workflow.

I do carry non source html/man branches in the same distribution point
repository, but I did not create and I do not have these unrelated
branches in my development repository. Possibility to run "git checkout
html" in my development repository is just insane.

The branch switching semantics of Git is designed to work well when all
the branches you check out in the working tree are somewhat related
content-wise. You create a new file, or make modifications to an existing
file, realize that the change wants to go to a branch different from the
current one. You _can_ switch to the branch the change should belong to,
because the contents in the working tree is defined to be not tied to any
branch, but is floating on top of the current branch.

We often see new people who do not understand this (yet) wonder "I
modified a file, switched to another branch, but the modification is still
there. Why?" It is because the local changes in the working tree do not
belong to a specific branch, and local changes could be committed to any
branch.

What would happen if I were crazy enough to have the html branch in my
development repository and checked it out? In addition to the previous
build artifacts *.o files, new source files *.[ch] and documentation
sources Documentation/*.txt will stay and will be mixed in the checkout of
the html branch, where we all know there is no reason for them to be
committed on.

A sane way to use Git is to have a separate repository to keep track of
changes in the other unrelated material, and I have separate repositories
with checkouts for html and man. Of course I do not edit them manually;
these repositories are targets of "make install-doc" from the source
repository.

They happen to be pushed into the same distribution point repository, but
that is a mere historical artifact. It only started because at k.org I
only had a write access to /pub/scm/git/git.git but not to /pub/scm/git/
directory itself; I may have used /pub/scm/git/html and /pub/scm/git/man
repositories otherwise. 

And cloners are advised to "tar-tree" these out and extract them to
somewhere else, if they do not want to format the documentation themselves
but still want to look at them. Of course, they could "checkout", but you
would not edit these generated files in the working tree or commit to
these branches. So in that sense, yes they could "checkout", but that is
like saying they can run "rm -fr .git" too---they can do useful things and
not so useful things just alike.

I suspect that people often see those html/man branches in the
distribution point repository and get a wrong idea that having these
unrelated histories somehow add their coolness factor. It doesn't.

>> I have no trouble in a single repository with multiple roots if that is
>> done in a distribution point, which by definition does not need and
>> typically does not have any working tree. Options to "checkout/commit"
>> would not help as they need a working tree.
> ...
>> The way to do it is to work in multiple repositories, one for each of
>> these roots, and push into a single repository from them.
>
> That's one way to do it.

And I have been trying to teach why the other way is a wrong thing to do,
but there is no point in teaching a better practice if the listener is not
willing to learn. My time is better spent on other topics.
