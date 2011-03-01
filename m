From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 01 Mar 2011 09:43:31 +0100
Organization: terreActive AG
Message-ID: <4D6CB1B3.1010005@terreactive.ch>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com> <20110214231920.GA24814@elie> <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com> <20110227084317.GB3356@sigill.intra.peff.net> <1298820840.19827.69.camel@drew-northup.unet.maine.edu> <878466.93199.1298934204331.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:44:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLBY-0001eE-5H
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab1CAInz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 03:43:55 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:59374 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab1CAIny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 03:43:54 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <878466.93199.1298934204331.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168192>

On 03/01/2011 12:03 AM, Jeff King wrote:
> On Sun, Feb 27, 2011 at 10:34:00AM -0500, Drew Northup wrote:

> One analogy I like for the index is that it's a bucket. It starts out
> full of files from the last commit. You can put new, changed files in
> the bucket. When it looks good, you dump the bucket into a commit. You
> can have multiple buckets if you want. You can pull files from other
> commits and put them in the bucket. You can take files out of the bucket
> and put them in your work tree.
> 
> So maybe it should just be called "the bucket"?
> 
> I'm not sure that's a good idea, because while the analogy makes sense,
> it doesn't by itself convey any meaning. That is, knowing the concept, I
> can see that bucket is a fine term. But hearing about git's bucket, I
> have no clue what it means. Whereas "staging area" I think is a bit more
> specific, _if_ you know what a staging area is.
> 
> So there are two questions:
> 
>   1. Is there a more universal term that means something like "staging
>      area"?
> 
>   2. Is the term "staging area", while meaningful to some, actually
>      _worse_ to others than a term like "bucket"? That is, does it sound
>      complex and scary, when it is really a simple thing. And while
>      people won't know what the "git bucket" is off the bat, it is
>      relatively easy to learn.

I like the name "git bucket", as in "a git bit bucket", but semantically
the connection is just "a container". Especially for beginners this can
result in the wrong connotations:
* Limited size. A modern harddisk is vastly larger than most Git
repositories, likening it more to a container ship than a bucket.
* Definite size. Harddisk space availability varies with time, unlike
most containers.
* Non-linear use. A full physical bucket could be used for many
different things, but a full git bucket can either be forgotten (with
checkout), remembered temporarily (with stash), or remembered
permanently (with commit).
* Container-specific features irrelevant for git: Handles, translucency
(or not), depth, material, dimensions of the opening...

How about a metaphor like "plan"? You either cancel/undo it (git
checkout), postpone / shelf it (git stash), resume/continue it (git
stash apply) or commit to it. Coming from the desktop metaphor, I
personally like `git undo`, `git postpone/resume` and `git commit` -
They give a clear sense of direction towards the commit, and much
clearer verbs for those new to VC in general.

-- 
Victor Engmark
