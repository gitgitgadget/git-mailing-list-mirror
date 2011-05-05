From: Jerome Martin <tramjoe.merin@gmail.com>
Subject: Re: Private/public branches/repos workflow
Date: Fri, 6 May 2011 00:05:56 +0200
Message-ID: <BANLkTinwuGTbX0qeOZHAhGKgZzPBTTaHCw@mail.gmail.com>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
	<201105051535.p45FZQDY019419@no.baka.org>
	<BANLkTikFdV=nGW-L+3NVzP58uPiS5ui-9A@mail.gmail.com>
	<201105052110.p45LAViP010495@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Fri May 06 00:06:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI6gL-0004Gr-Ub
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 00:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab1EEWF5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 18:05:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41016 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1EEWF5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 18:05:57 -0400
Received: by gxk21 with SMTP id 21so975869gxk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LpvZAiO6dusfRLltQO4rX33hImrtHgPYQGVswwti738=;
        b=AT5Rw24mweQV0cTz+t+yy2AnZxRPmI6E4WsdIfZmW0fM4PrZK2p19MK+HYZ/IL7/JJ
         kPqlfs4UIoEp/e8Qo+PL5dcpt8AkEZtU/xQCGoSu24w25eRUWIWSZwRPh5qfbKXaE+9V
         9eAew+DzOei9wC0HlR8ASs5QFwGKGI/gRcUpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cEUQwDu1ryvJFpMW0hU4SD+9gQsA8duDihOKmFJ8cd/QLt7HJwocPy1oIXqHmJ9STo
         06zl3H2EIuLgwGmDXl5jP3FGZF+kMJkB+Ikq6nFgp5ABGcpCV7w7WVcq6ZdVTb5w4V+G
         CXKc7xTsAQ8jkmP4MS45OP4GMp0AaGjFpthgY=
Received: by 10.151.5.14 with SMTP id h14mr2707324ybi.182.1304633156216; Thu,
 05 May 2011 15:05:56 -0700 (PDT)
Received: by 10.147.167.8 with HTTP; Thu, 5 May 2011 15:05:56 -0700 (PDT)
In-Reply-To: <201105052110.p45LAViP010495@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172921>

Thanks for the additional clarification on detached vs orphan.

I want to thank you guys again for being so patient and helpful. It
helps a lot, as for some reason, only reading the docs doesn't seem to
sink in as fast as I would like ;-)

Regarding the usage of an orphan branch, a coworker of mine suggested
an alternate way, which seems similar to me regarding the result, but
if you could take a look at it and tell me what you think, that would
be very helpful:

1) On the public server, init a blank repo, and commit there an export
of the public tree as initial import.
2) On the devel machines, use git-remote to track that repo's master
as a local 'public' branch. That public branch now has no history
other than the initial import, and is in the same repo as both my
private branch and my public-branch-with-full-history (not to be used
for future work).
3) From there, use this 'public' branch as if it was created using
--orphan from my local public-branch-with-full-history.

Are there any essential properties that set apart a 'public' branch
created this way from one creating using your suggested --orphan
method ?

On Thu, May 5, 2011 at 11:10 PM, Seth Robertson <in-gitvger@baka.org> w=
rote:
>
> In message <BANLkTikFdV=3DnGW-L+3NVzP58uPiS5ui-9A@mail.gmail.com>, Je=
rome Martin
> writes:
>
> =A0 =A0One thing I do not understand clearly is why with a detached (=
I guess this
> =A0 =A0is synonym to orphan ? At least when creating it ?) branch can=
not be then
> =A0 =A0merged with the branch that was initially copied to create it =
and just get
> =A0 =A0the additional commits. Instead, it gets the whole history. Be=
ing used to
> =A0 =A0using merge between my public/private branches, I am afraid th=
at using that
> =A0 =A0orphan branch might lead to disaster eventually.
>
> Junio appears to have answered much of these followup questions so I
> will focus on a slight misunderstand you exhibit here.
>
> An orphan branch is very different from a detached head. =A0A detache=
d
> head is not on any branch. =A0Commits on detached heads cannot typica=
lly
> be referenced by any symbolic name and will eventually go away throug=
h
> garbage collection. =A0In general you want to avoid detached heads fo=
r
> any read/write activity.
>
> An orphan branch, on the other hand, is one which simply doesn't have
> a parent. =A0The first commit you make in a new repository is also
> orphan, though it is not talked about as such. =A0The point of this
> orphan branch is that since it does not have a parental link from you=
r
> private branch, if you publish the orphan it will not bring along any
> of the private commits.
>
> As Junio stated/suggested, as long as you are careful to never merge
> from private into public, and instead either cherry-pick or do
> development from public and merge that into private, you should be
> safe. =A0However, a good safety test might be to have an intermediate
> repository be part of your public push process, and have a
> post-receive (or other process) script run which looks for magic
> cookies in that intermediate repo showing that private data has leake=
d
> before proceeding to push that validated repo to a publicly accessibl=
e
> repo.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Seth Robertson
>



--=20
J=E9r=F4me Martin
