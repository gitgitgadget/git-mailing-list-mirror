From: David <bouncingcats@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 1 Mar 2011 20:11:11 +1100
Message-ID: <AANLkTi=LPqu9zDiAJpxqC=ZCLig+aCv5ztXw668ERtH7@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
	<AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
	<20110227084317.GB3356@sigill.intra.peff.net>
	<1298820840.19827.69.camel@drew-northup.unet.maine.edu>
	<20110228230311.GA7533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLcC-0006U6-M8
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759Ab1CAJLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 04:11:14 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56011 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1CAJLL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 04:11:11 -0500
Received: by yxs7 with SMTP id 7so1881760yxs.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 01:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JizwWzQiGe7RhZlyvGzCizGgNvrON7kVlcahqw4lDlA=;
        b=IIAR0k7/VtRQpukXpoEkDSi5Sd6UQxkYZpL9Ge4PjXkwts9E8hjRpqJVOi8oLfpAFi
         XIHwXK/v1v4jLHXW6weM6nRkYFKR7Xne8RaoSf9LHzl1Ry5HqJLAYdpy0Zj1m/sQnva+
         n2vl4lLEivEZaPh3f5UhjKdz6vi0LhYifPEJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F6Q2MLqs7RZpzilvK4M2R8z/zrzibw0ExgkE4CyVPx8SHKqE4dzJpduoiQuhDPoa9T
         MPaVULfapx21NtIM7L9JO9JSYmWVvmjY+JyzTzPcj+RnNBKvNglHfv/B+qsmMicZdUMr
         KvCXtcvUM61Oee4q1Ce2dykrGD9mKIAMiqvSo=
Received: by 10.100.43.16 with SMTP id q16mr2774337anq.203.1298970671263; Tue,
 01 Mar 2011 01:11:11 -0800 (PST)
Received: by 10.101.58.13 with HTTP; Tue, 1 Mar 2011 01:11:11 -0800 (PST)
In-Reply-To: <20110228230311.GA7533@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168195>

On 1 March 2011 10:03, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 27, 2011 at 10:34:00AM -0500, Drew Northup wrote:
>
> I'm not sure what you mean by "distint unified staging area". It is a
> conceptual idea that you will put your changes somewhere, and when th=
ey
> look good to you, then you will finalize them in some way.
>
> But note that it is a mental model. The fact that it is implemented
> inside the index, along with the stat cache, doesn't need to be relev=
ant
> to the user. And the fact that the actual content is in the object
> store, with sha1-identifiers in the index, is not relevant either. At
> least I don't think so, and I am usually of the opinion that we shoul=
d
> expose the data structures to the user, so that their mental model ca=
n
> match what is actually happening. But in this case, I think they can
> still have a pretty useful but simpler mental model.
>
>> If we use "staging area made up of the object store and information =
kept
>> in the Index" then we tie a knot on everything, make it clear that i=
t
>> may be more complex than that--and you don't have to care, and we do=
 not
>> foreclose on the possibility of more complete explanation later. Tha=
t
>> does not bother me. We do however need to recognize that "staging ar=
ea"
>> is an idiom of limited portability and deal with that appropriately.
>
> Sure, I'm willing to accept that the specific words of the idiom aren=
't
> good for people with different backgrounds.
>
> One analogy I like for the index is that it's a bucket. It starts out
> full of files from the last commit. You can put new, changed files in
> the bucket. When it looks good, you dump the bucket into a commit. Yo=
u
> can have multiple buckets if you want. You can pull files from other
> commits and put them in the bucket. You can take files out of the buc=
ket
> and put them in your work tree.
>
> So maybe it should just be called "the bucket"?
>
> I'm not sure that's a good idea, because while the analogy makes sens=
e,
> it doesn't by itself convey any meaning. That is, knowing the concept=
, I
> can see that bucket is a fine term. But hearing about git's bucket, I
> have no clue what it means. Whereas "staging area" I think is a bit m=
ore
> specific, _if_ you know what a staging area is.
>
> So there are two questions:
>
> =A01. Is there a more universal term that means something like "stagi=
ng
> =A0 =A0 area"?
>
> =A02. Is the term "staging area", while meaningful to some, actually
> =A0 =A0 _worse_ to others than a term like "bucket"? That is, does it=
 sound
> =A0 =A0 complex and scary, when it is really a simple thing. And whil=
e
> =A0 =A0 people won't know what the "git bucket" is off the bat, it is
> =A0 =A0 relatively easy to learn.
>
> =A0 =A0 And obviously, replace "bucket" here with whatever term makes=
 more
> =A0 =A0 sense.

A suggestion: could your conceptual bucket be named as "the precommit".

Motives for this suggestion are:
1)  I imagine this word will be readily translatable;
2) Using an invented word like this neatly avoids the complication of
the various different connotations associated with existing words like
"index", "cache", and "stage" that others have raised.

The "precommit" would be a user concept that merely specifies the
content of the next commit. Its purpose is to simplify the user
interface and the documentation. For example, man git-status would
read like this:

"git status displays paths that have differences between the precommit
and the current HEAD commit, paths that have differences between the
working tree and the precommit, and paths in the working tree that are
not tracked by git."

The "precommit" is not to be associated to any specific data structure
in the implementation. For users who want more understanding, it can
be explained that the precommit is implemented by a combination of
data structures. Which are then free to be named anything appropriate
to their individual function (eg "the index file") without triggering
all the issues that give rise to this thread.
