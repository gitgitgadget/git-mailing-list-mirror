From: Johan Herland <johan@herland.net>
Subject: Re: Premerging topics
Date: Wed, 24 Apr 2013 08:22:18 +0200
Message-ID: <CALKQrgd8jZQ__rnAT3wbfx-Y6mg-vrTdam53nS2ya2c=yMcS6Q@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 08:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUt6D-0006Bo-SD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 08:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab3DXGW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 02:22:27 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:50886 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab3DXGWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 02:22:23 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUt5y-000MuL-5B
	for git@vger.kernel.org; Wed, 24 Apr 2013 08:22:22 +0200
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUt5x-0005Wr-Nm
	for git@vger.kernel.org; Wed, 24 Apr 2013 08:22:22 +0200
Received: by mail-ob0-f171.google.com with SMTP id er7so1189029obc.2
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 23:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RJy4PJBN5uI4DgPZ0Ck8uXnAjBu8gOXSjds3qUSdTso=;
        b=pyBmnOgM21dDvmo1PILlhcwtn2az0bgSozxqyfmBhDSt1CHRu22yhSJN+T50mckm8Z
         sEjvm2nRwzN58ai7/HVKQWEeZPcH4mtsDJ0WjK8N65OidoVGBRYMAFpp94VyUb0+OhO0
         CTYC3yuRhnO8C9ui9Go40+bckNB+CN0yKworWOpXBB7QGxjP2MHyqkqiffQzhCQlW5+Y
         xMAzZPKaD4PUpjBttpFM5VcZAE7e6wPh25gULI5pAGbLa3L4em/CxlqCqoh92U1QYtcq
         xVEcqIFeJc0+FmzV29mRSbcLHMLdVi85DShFY/Owc/PZHX2X+vPgJcgmSfsIwq7Gv2OD
         su9Q==
X-Received: by 10.60.162.102 with SMTP id xz6mr18233943oeb.69.1366784538335;
 Tue, 23 Apr 2013 23:22:18 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Tue, 23 Apr 2013 23:22:18 -0700 (PDT)
In-Reply-To: <7vzjwofpht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222225>

On Wed, Apr 24, 2013 at 7:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>>> But P is a commit(/merge with two parents), not a blob. Can we have trees
>>> pointing to commits instead of blobs ?
>>
>> Sort of. We do so when recording submodules in regular git trees.
>
> You are using notes to maintain reachability, aren't you?  Because
> commit objects that appears in trees are not treated as reachable
> from the trees, that won't fly.
>
> I think you guys are making it unnecessarily complex by using notes.
> To record a prepared evil merge for merging branch that contains A
> with another branch that contains B (assuming that the interation
> between A and B is what makes the evil merge necessary, e.g. A
> renames a function foo() to bar(), while B adds new callsite that
> calls foo()), we can store a single commit that records the prepared
> evil merge under "refs/merge-fix/$A-$B" where A and B are their
> object names.
>
> Then when merging a branch Y that contains B into our history X that
> already contains A (or vice versa),
>
>   ---o---o---A---o---X... ???
>       \                  .
>        \                .
>         \              .
>          o---B----o---Y
>
> we can enumerate the commits that appear in "log --left-right X...Y"
> on the left/right side and notice there is refs/merge-fix/$A-$B.
>
> So the simplest implementation of "an efficient data store to record
> a commit for <A,B> pair" turns out to be just a ref namespace ;-)
>
> There may be other <C,D> pairs in X...Y history, and it probably is
> the sane thing to do to replay prepackaged evil merges from older to
> newer in the topological sense, but that loop would be trivial, once
> we understand how to replay a single such evil merge.

This raises the same question I recently asked Antoine: For a given
prepackaged merge <X,Y>, do we assume that it only resolves conflicts
between the changes introduced in commit X vs. changes introduced in
commit Y, or do we assume that it resolves conflicts between the
histories leading up to X and Y, respectively? In other words, does
<X,Y> _supercede_ earlier pre-merges between the histories leading up
to X and Y?

I think the latter makes more sense, since we can then reduce the
number of pre-merges to consider in the final merge. There might still
be more than one pre-merge to consider, though, e.g. in criss-cross
cases like this:

  ---o---o---o---o---o---o---o---o
      \             /     \       \
       \           /       \       \
        \         /         \       \
         o---o---o           P2      \
          \       \         /         \
           \       \       /           M
            \       \     /           /
             o---o---+---o           /
              \       \   \         /
               \       P1  \       /
                \     /     \     /
                 o---o---o---o---o

(there is no commit at the "+")

> The actual merge-fix data should be just a commit with a single
> parent. The easiest way to prepare it would be like this:
>
>   ---o---o---A
>       \       \
>        \       M---F
>         \     /
>          o---B
>
> where M is the result of mechanical merge between A and B (there
> could be textual conflicts and you could choose to leave them in, or
> you could choose to have rerere resolve it.  As long as you do the
> same when replaying this prepackaged evil merge, this choice does
> not matter, but using rerere will make your life easier), and F is
> the final result you would want, with semantics conflicts resolved.
> In other words, in the ideal world, you would have resolved a merge
> between A and B to record the tree of F.
>
> Point "F" with refs/merge-fix/$A-$B and you are done.
>
> When you replay this prepackaged evil merge, first you mechanically
> merge X and Y without worrying about M or F to produce N.  If you
> allowed rerere to resolve textual conflicts between A and B when you
> recorded M, allow rerere to resolve this merge.  Otherwise leave the
> textual conflict in.
>
>   ---o---o---A---o---X
>       \               \
>        \               N
>         \             /
>          o---B---o---Y
>
> Then on top of N, you cherry-pick F, which will bring the semantic
> conflict resolution between M and F on top of N.
>
>   ---o---o---A---o---X
>       \               \
>        \               N---F'
>         \             /
>          o---B---o---Y
>
> Once you know the tree shape of F', then you no longer need N.  Just
> amend it away and make the tree recorded in F' the result of the
> merge between X and Y.
>
>   ---o---o---A---o---X---.
>       \                   \
>        \                  F''
>         \                /
>          o---B---o---Y--.

This is obviously a much better way to solve it. It might already be
obvious, but I would suggest when making "refs/merge-fix/$A-$B" that you
canonicalize the name by always choosing A and B such that A precedes B
alphabetically. That way you won't have problems with both recording
"refs/merge-fix/$A-$B" and "refs/merge-fix/$B-$A".


...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
