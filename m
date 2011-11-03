From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 18:45:26 -0700
Message-ID: <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com> <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 02:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLmQF-0004Sa-RV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 02:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789Ab1KCBpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 21:45:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65435 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab1KCBps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 21:45:48 -0400
Received: by wwi36 with SMTP id 36so1104657wwi.1
        for <multiple recipients>; Wed, 02 Nov 2011 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=SLTD719DMGqU98Rss8Aq4sYWfd3lNsuMJ6OiAIolwD8=;
        b=L14f7OY4N052KbHcl0o3DXs0SfQqmY4YYvL25SyDRbJ3k7I44Q+uZJyv0q3i56DTF2
         R2WWKRu6gWw8R4dBBe5q3cJsvYgDmqU+P+SzjXXJ4UoaaV7Rp/vIi50BqCWoLdqaUhuJ
         iO+RL3Y5Yl7pTLciP9lOlSAEZh+K6LbGB4G5Y=
Received: by 10.216.24.39 with SMTP id w39mr6863433wew.67.1320284747097; Wed,
 02 Nov 2011 18:45:47 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Wed, 2 Nov 2011 18:45:26 -0700 (PDT)
In-Reply-To: <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
X-Google-Sender-Auth: NexF_CEO01POkkpg0icIMAkGwZI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184691>

On Wed, Nov 2, 2011 at 6:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm not saying that you shouldn't use them - go ahead and use the
> feature if you like it. But please spare me your excuses for stupid
> workarounds that come from the fact that they aren't a good match for
> sane workflows.

Btw, having now done odd things with signed tags (because we've used
them as a side-band verification mechanism), I can certainly also say
that the signed tags have their set of problems too.

So signed tags aren't perfect. They were designed for making releases,
and that shows very clearly in how git works with them. The default
choices that git makes are very awkward indeed when you use signed
tags as "security tokens".

But unlike the "sign the commit" approach, those are implementation
and UI issues, not "fundamentally broken design" issues.

For example, fetching a single signed tag with git is surprisingly
hard. It *shouldn't* be hard - and there's no underlying technical or
design reason why it would be hard, but it is. Why? Because all the
git actions when it comes to tags are all geared towards one
particular use, that is *not* about the signature checking aspect of
them.

Here's an example: Rusty Russell now makes nice signed tags for the
things he asks me to pull, and then states them in the pull message.
So he will mention that he has a tag named

   rusty@rustcorp.com.au-v3.1-8068-g5087a50

in his git repository at

   git://github.com/rustyrussell/linux.git

and while I don't think his tag names are all that wonderful, it makes
sense from an automated script kind of standpoint.

Now, let's try to get that tag:

  [torvalds@i5 linux]$ git fetch
git://github.com/rustyrussell/linux.git
rusty@rustcorp.com.au-v3.1-8068-g5087a50
  fatal: Couldn't find remote ref rusty@rustcorp.com.au-v3.1-8068-g5087a50

oops. Ok, so his tag naming is *really* akward. Whatever. Let's try again:

   [torvalds@i5 linux]$ git fetch
git://github.com/rustyrussell/linux.git
refs/tags/rusty@rustcorp.com.au-v3.1-8068-g5087a50
   From git://github.com/rustyrussell/linux
    * tag
rusty@rustcorp.com.au-v3.1-8068-g5087a50 -> FETCH_HEAD

Ahh, success!

Oops. Nope. It turns out that git will *peel* the tag when you fetch
it, so FETCH_HEAD actually doesn't contain the tag object at all, but
the commit object that the tag pointed to. MAJOR FAIL.

Quite frankly, I think that's a git bug, but it's a git bug because
"git fetch" was designed to get the commit to merge. Fair enough.
Let's work around it, and rename the tag at the same time:

   [torvalds@i5 linux]$ git fetch
git://github.com/rustyrussell/linux.git
refs/tags/rusty@rustcorp.com.au-v3.1-8068-g5087a50:refs/tags/rusty
   From git://github.com/rustyrussell/linux
    * [new tag]
rusty@rustcorp.com.au-v3.1-8068-g5087a50 -> rusty
    * [new tag]
rusty@rustcorp.com.au-v3.1-2-gb1e4d20 ->
rusty@rustcorp.com.au-v3.1-2-gb1e4d20
    * [new tag]
rusty@rustcorp.com.au-v3.1-4896-g0acf000 ->
rusty@rustcorp.com.au-v3.1-4896-g0acf000
    * [new tag]
rusty@rustcorp.com.au-v3.1-8068-g5087a50 ->
rusty@rustcorp.com.au-v3.1-8068-g5087a50

WTF? Now we finally *did* get the tag, and we can do

   git verify-tag rusty

and that will work. But what the hell happened? We got three other
tags too that we didn't even ask for!

So we have actual git bugs here, that relate to the fact that we've
treated signed tags specially, and have magic code to basically say
"if there's a signed tag that is reachable from the thing you pull,
and you're not just doing a temporary pull into FETCH_HEAD, we'll
fetch that signed tag too".

Again - not a fundamental design mistake in the data structures, and
it actually made sense from a "signed tags are important release
points" standpoint, but it makes it *really* inconvenient to use
signed tags for signature verification.

Also, the fact that the signed tag gets peeled when we do fetch into
FETCH_HEAD also means that we can't actually save the signature in
resulting the merge commit. The merge, instead of being able to
perhaps save the information that we merged a nice trusted signed
point, only has the commit.

But practically, all of these issues should be pretty easily solvable.
So it should be quite easy to make

    git pull <repo> <tag-name>

just do the right thing - including verifying the tag, and adding the
information in the tag into the merge commit message.

So signed tags are not mis-designed from a conceptual standpoint -
they just work really really awkwardly right now for what the kernel
would like to do with them.

With a few UI fixes, I think the signed tag thing would "just work".

That said, I do think that the "signature in the pull request" should
also "just work", and I'm not entirely sure which one is better. It
might be more convenient to get the signature data from the pull
request. So I'm not at all married the the notion of using signed tags
for this.

                       Linus
