From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 21:56:08 -0400
Message-ID: <BANLkTikamzsiSJqkRjA7nDjRoyEbd32rvw@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<7vd3ir9btd.fsf@alter.siamese.dyndns.org>
	<4DEDC124.3060302@drmicha.warpmail.net>
	<201106081312.46377.jnareb@gmail.com>
	<BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
	<20110608150537.GC7805@sigill.intra.peff.net>
	<BANLkTinibF0xmibeuJ6f9FUjaMmxavMJig@mail.gmail.com>
	<20110609004347.GC19715@sigill.intra.peff.net>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 03:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUUTo-0008Hh-QJ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 03:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab1FIB4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 21:56:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57152 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1FIB4K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 21:56:10 -0400
Received: by bwz15 with SMTP id 15so922623bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 18:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h+xQN/jFp1qsixUx55jihdQKsoVn9qi1sx+952ude+o=;
        b=OAjUxxSKN8sKmIl4kzFiW2HHM01s9MxDRXMFeJ20NdhgrgCuNJ17nZEbIHYpPz9Xwq
         s3RdsOqFZoXDQTYzs1+/mblBym9lm6uYGjYUTg03yPRQ5oL04xplR0PfYy416iHX3GnC
         uWuJ+sQ6pXS4c/lPFXU01aod58F5hacjq4FU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=gZs1R7HH0s0WaozHUg4xg6dL+JLSMsL7qnhOd9rOZx8cq7teJeEUjbAEQ2p92ygrxM
         PTBtnhUridxFYtG3DMty19K2qllbz0ojVtMQiO9DGCUe237QPv7vOJr17fZmjYtMz9nK
         ai1dG8VYvVR8o0PhYEikv/nQdZ2OQmX2VMwa8=
Received: by 10.204.14.144 with SMTP id g16mr159723bka.34.1307584568749; Wed,
 08 Jun 2011 18:56:08 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Wed, 8 Jun 2011 18:56:08 -0700 (PDT)
In-Reply-To: <20110609004347.GC19715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175484>

Hi Peff,

=46irst, thanks for correcting my diff-without-NEXT-and-WTREE to
diff-with-NEXT-and-WTREE pairing.

Second, I agree that the index is more than just NEXT.  There were
good reasons behind calling it "NEXT" and not "INDEX".

Third, I didn't know for sure that "git diff" during a merge conflict
would produce a three-way-diff result, but I suspected it would.  (You
really didn't have to produce all that code - I would have accepted
your word as an expert.  But thanks!)  So, yes, the two-way merge
result of "git diff NEXT WTREE" would be different.

I could argue that git should allow a 4-way diff where "git diff NEXT
WTREE OURS THEIR" prints all the unresolved changes as coming from
OURS or THEIR or neither.  But I think that's silly.

I will say that "git diff NEXT WTREE" will tell you what's left
unresolved and most of it is in <<<<=3D=3D=3D=3D>>>>> blocks that tell =
you
whether it came from OURS or THEIRS.  If the user has any discipline,
they won't introduce unnecessary changes that were not necessary for
the merge.  If they don't have discipline, we really can't help them.

I'm not saying there is no use for a 3-way merge.  In fact, I'd guess
it's a requirement so that Alice can check Bob's merge before Bob
commits.  But I'm fine with making it "git diff --3-way" or the silly
"git diff NEXT WTREE OURS THEIRS" because I think its "git diff NEXT
WTREE" will be good enough 99% of the time.



On Wed, Jun 8, 2011 at 8:43 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 08, 2011 at 02:57:09PM -0400, Michael Nahas wrote:
>
>> > Isn't this going to be behavior change, since your NEXT is not qui=
te the
>> > same as the index? How do I now get an n-way combined diff of the
>> > unmerged files in the index?
>>
>> The index is a file in .git/ that serves many purposes. =A0NEXT is a=
n
>> image of the whole project. =A0NEXT can be computed from the index a=
nd
>> HEAD.
>>
>> During a conflicted merge, stage 0 of the index holds the resolved
>> files. =A0WTREE holds all merge files: the resolved and the unresolv=
ed
>> (which have <<<< =3D=3D=3D=3D >>>> blocks in them). =A0I propose tha=
t during a
>> conflicted merge, that NEXT be computed as HEAD plus the resolved
>> files, that is, the files in stage 0 of the index.
>
> OK. So NEXT actually has less information than the whole index, becau=
se
> it doesn't contain information on what was on either side of the merg=
e
> originally (or in the merge base).
>
>> "git diff HEAD NEXT" would print the resolved changes.
>> "git diff NEXT WTREE" would print the unresolved changes
>> "git diff HEAD WTREE" would print all changes.
>>
>> I believe that is the same behaviour as "git diff", "git diff
>> --cached" and "git diff HEAD" during a conflicted merge.
>
> I assume you don't mean respectively here, but rather:
>
> =A0git diff =A0 =A0 =A0 =A0 =A0=3D> git diff NEXT WTREE
> =A0git diff --cached =3D> git diff HEAD NEXT
> =A0git diff HEAD =A0 =A0 =3D> git diff HEAD WTREE
>
> But even still, I don't think "git diff" is the same. Try this:
>
> =A0git init repo && cd repo
> =A0echo one >file && git add file && git commit -m one &&
> =A0echo two >file && git add file && git commit -m two &&
> =A0git checkout -b other HEAD^ &&
> =A0echo three >file && git add file && git commit -m three &&
> =A0! git merge master &&
> =A0git diff
>
> I get:
>
> =A0diff --cc file
> =A0index 2bdf67a,f719efd..0000000
> =A0--- a/file
> =A0+++ b/file
> =A0@@@ -1,1 -1,1 +1,5 @@@
> =A0++<<<<<<< HEAD
> =A0 +three
> =A0++=3D=3D=3D=3D=3D=3D=3D
> =A0+ two
> =A0++>>>>>>> master
>
> Note that this is _not_ a diff between NEXT and the working tree. =A0=
It is a
> 3-way "combined" diff of what's in the working tree compared to each =
side of
> the merge.
>
> If NEXT is a tree that contains HEAD plus stage 0 files, then we woul=
d
> see a 2-way diff of the HEAD version of "file" and the working tree
> version. I.e., the same as "git diff HEAD -- file":
>
> =A0diff --git a/file b/file
> =A0index 2bdf67a..087e97e 100644
> =A0--- a/file
> =A0+++ b/file
> =A0@@ -1 +1,5 @@
> =A0+<<<<<<< HEAD
> =A0 three
> =A0+=3D=3D=3D=3D=3D=3D=3D
> =A0+two
> =A0+>>>>>>> master
>
> which looks similar, because we haven't started resolving anything ye=
t.
> But try resolving it like this:
>
> =A0cat >file <<'EOF'
> =A0three
> =A0and
> =A0two
> =A0EOF
>
> Now try "git diff" again. You should get:
>
> =A0diff --cc file
> =A0index 2bdf67a,f719efd..0000000
> =A0--- a/file
> =A0+++ b/file
> =A0@@@ -1,1 -1,1 +1,3 @@@
> =A0 +three
> =A0++and
> =A0+ two
>
> This shows us that "three" came from one side of the merge, "two" fro=
m
> the other, and that "and" was found in neither side.
>
> Compare to the 2-way that shows:
>
> =A0diff --git a/file b/file
> =A0index 2bdf67a..1ecff7e 100644
> =A0--- a/file
> =A0+++ b/file
> =A0@@ -1 +1,3 @@
> =A0 three
> =A0+and
> =A0+two
>
> There's nothing to distinguish added code pulled from the other side =
of
> the merge versus changes that were made as part of the resolution.
>
> I think this is what Junio was talking about when he said that the in=
dex
> is more than a tree. There may be times when you want to treat the it=
ems
> in stage 0 as a tree, but diffing against the index is more than just
> diffing against that tree.
>
>> I do not know how "n-way" merge works. =A0I saw somewhere that indic=
ated
>> that it was a series of N-1 two-way merges.
>
> Git history can represent a merge of any number of branches (an "octo=
pus
> merge"), because the commits store only the final state and a list of
> parent commits. The combined diff format is capable of handling an
> arbitrary number of parents.
>
> I should have just said "3-way", though, because it's not relevant he=
re.
> The index only has 2 stage bits, so we can only represent four stages
> ("resolved", "base", "ours", and "theirs"). So you can't represent an
> n-way merge in the index.
>
> So "git merge" just punts on an octopus merge if there are actual mer=
ge
> conflicts that would need to go in the index. So in practice, people
> just tend to do N-1 pair-wise merges.
>
> You can see some example octopus merges (and their combined diff) if =
you
> have a recent git (that supports --min-parents) with:
>
> =A0git log --min-parents=3D3 -p --cc
>
> in both git.git and linux-2.6.git.
>
> -Peff
>
