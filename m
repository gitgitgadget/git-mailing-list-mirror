From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Wed, 30 Nov 2011 13:47:24 +0200
Message-ID: <CAMP44s2WxveGAmzaz8kwKRxia1TBWYwxwPBdb14K93TKr1sfsA@mail.gmail.com>
References: <20111107210134.GA7380@sigill.intra.peff.net>
	<CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
	<20111108181442.GA17317@sigill.intra.peff.net>
	<CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
	<20111111181352.GA16055@sigill.intra.peff.net>
	<CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
	<20111114122556.GB19746@sigill.intra.peff.net>
	<CAMP44s1G9jJyiis7z7XbPvW925E-u=0_-h9jJKkj2wyPS9o5ig@mail.gmail.com>
	<20111121214450.GA20338@sigill.intra.peff.net>
	<CAMP44s3StLjb9KgBkRrG4nPqJD_ZjeSyFUwuP4A3b+mJKBgHWQ@mail.gmail.com>
	<20111130070111.GE5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 12:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVidP-0004Et-JM
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 12:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1K3Lr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 06:47:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45473 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1K3LrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 06:47:25 -0500
Received: by faaq16 with SMTP id q16so318086faa.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qtDJXy+HZheRmn6gGITgu1+1JqKzULhAZ6klOz36mfs=;
        b=ux2cs0qkwPAOsoMRrU3gGtXzuFcAmXTgiFhPYTVOH0tQcG3QtwnjVjEQhfyLZCT2vL
         UjmMBFzg47X6JLTXCFTD6tQdMoKJ4xHGlhX78ZSWX7Tmzyj9BQ0H5yARau6f04rr9+eQ
         4LUFz/aPdCgqMXceFe5KJzqNUfuTu1FrvuAp8=
Received: by 10.204.149.144 with SMTP id t16mr1817043bkv.134.1322653644178;
 Wed, 30 Nov 2011 03:47:24 -0800 (PST)
Received: by 10.204.197.201 with HTTP; Wed, 30 Nov 2011 03:47:24 -0800 (PST)
In-Reply-To: <20111130070111.GE5317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186122>

On Wed, Nov 30, 2011 at 9:01 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 22, 2011 at 01:47:36AM +0200, Felipe Contreras wrote:
>
>> > I didn't mean "you didn't define a mirror in your config". I meant "your
>> > question is not well-defined, because you haven't defined the term
>> > 'mirror'". IOW, I can't answer your question without knowing exactly
>> > what you meant.
>>
>> I wasn't the one that brought the mirror up, you did:
>
> Yes, because that is the most related concept in current git. But I
> thought you were asking from the perspective of a clueless user, and I
> don't know what that clueless user meant by "mirror".

I don't think common users know, or should care about, what a "mirror" is.

> Anyway, I don't think it's important.

Me neither.

> I read over your whole message, and I feel like our discussion isn't
> really moving towards an actual goal. Junio and I both mentioned that in
> the long-term, features like this should be part of "push", not
> "remote". Do you want to try revising your patch in that direction?

Yes, I can try that for 'git push', but my worry is about 'git fetch'.
To me it's really clear that what I am trying to achieve is more
complicated than a simple push/fetch.

You still haven't replied to my solution to synchronize the local
branches, which to first do a 'git fetch' so we have the remote
branches tracked locally, and go through each one of them and do
something to the local ones. This solution works, is simple, and
allows all kinds of options, but IMO it's not part of 'git fetch'.

> That will give us something concrete to talk about (and hopefully
> apply).

Yes, but that's basically 'git push --prune', which I think is the
only thing we have agreed. But what about the rest?

I feel you are trying to ignore the fact that 'refs/heads/*' is not
user-friendly, neither is BRANCHES, or :, and 'git fetch' would be
even more cumbersome.

The user-friendliness of git is one of the biggest complains people
have, and while it makes sense to keep certain operations under
push/fetch, there's only so much pureness we can have before things
become too complicated for the users. The fact of the matter is that
these particular remote synchronization operations are much easier to
picture mentally in a group like 'git remote sync'. That not only
works for all the cases, including 'git fetch', but it's
non-intrusive, and most importantly: user-friendly.

Cheers.

-- 
Felipe Contreras
