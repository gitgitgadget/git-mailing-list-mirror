From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 14 Nov 2009 06:06:00 +0900
Message-ID: <20091114060600.6117@nanako3.lavabit.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	<7vy6n065os.fsf@alter.siamese.dyndns.org>
	<7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	<94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	<7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	<94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	<20091025111438.GA11252@progeny.tock>
	<94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	<4AFBF18E.7070906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 22:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N93LW-0006cy-Vo
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 22:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbZKMVGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 16:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbZKMVGE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 16:06:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53169 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361AbZKMVGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 16:06:03 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 8A8FF11B866;
	Fri, 13 Nov 2009 15:06:06 -0600 (CST)
Received: from 6297.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id T19SP4BA5Y4M; Fri, 13 Nov 2009 15:06:06 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ZEbUjkddQFQjK0xvTZHj6PjhFxA2n6fV5/McV/Buo9rEVnV2sUXCXNRJu9N5FSj4xLiriMxbip5RaSQwgcS41r+IeK2nnE7doex9Oyn+9AAQSCv/EVhTjvCeoKgYuBxArGySMwTYi0dArJz/HOx5eGzLfQlPQ4dNAko3EBerX24=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4AFBF18E.7070906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132844>

Quoting Michael J Gruber <git@drmicha.warpmail.net>

> Regarding this specific patch series: I took part in the initial
> discussion, and got frustrated by the original poster's seemingly
> unwillingness to accept advice, so I left. I'm not drawing any general
> conclusions, and please don't take this as an ad hominem argument.
> Sometimes it's simply a matter of mismatching participants.

I didn't get myself involved in the follow-up discussion exactly 
for the same reason.

> If you care to go back to that discussion you see that there is good
> reason for having both --cached and --index. They are different. "git
> help cli" explains this nicely.

The need to support both options in the same command (eg. apply) means 
that anybody who says "I don't like 'index' nor 'cache'; why don't we 
change them all to 'stage'" doesn't understand the issue.

But that doesn't mean "apply --cached" vs "apply --index" is the best 
way to let the users specify which operation is requested. I don't 
think Felipe seriously wants to change them to --gogo vs --dance, but 
if he made a more constructive proposal, instead of making such a 
comment whose intended effect is only to annoy people, we may see 
an improved UI at the end.  Proposing "--index-only" vs "--index-too" 
or even "--stage-only" vs "--stage-too" would have helped him appear 
to be more serious and constructive and I think your expression 
"mismatching participants" was a great way to say this.

There was a similar discussion about "diff --cached". The command 
compares two things and the current syntax relies on counting the 
number of treeish on the command line to specify what these two things 
are, and sometimes people are confused which way the comparison occurs.

 * If you have two treeish, it compares the two treeish. Specifically, 
   it shows the change to make one treeish into the other treeish.

 * If you have one treeish, it compares the treeish with working tree 
   or the index (it shows the change to make the treeish into working 
   tree or the index). You need --cached to choose the "index", and
   this can safely be aliased to --staged.

 * If you have zero treeish, it compares the index with working tree 
   (it shows the change to make the index into working tree).

But it is also possible to have an alternate syntax to explicitly say
what you are comparing with what. Perhaps these may make it unnecessary
to remember which way the comparison occurs:

 git diff --tree-vs-staged HEAD
	same as "git diff --cached HEAD"
 git diff --staged-vs-tree HEAD
	same as "git diff -R --cached HEAD"

 git diff --staged-vs-working
	same as "git diff"
 git diff --working-vs-staged
	same as "git diff -R"

 git diff --tree-vs-working HEAD
	same as "git diff HEAD"
 git diff --working-vs-tree HEAD
	same as "git diff -R HEAD"

If people like this as a concept we can introduce shorter way to spell 
them, eg. "git diff --ts HEAD", etc.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
