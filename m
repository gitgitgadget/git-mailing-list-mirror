From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 19:23:38 +0200
Message-ID: <4C82809A.3020101@gmail.com>
References: <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com> <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com> <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home> <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home> <4C824CAD.9070509@gmail.com> <20100904155638.GA17606@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 19:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrwT0-0003Cc-4i
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 19:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab0IDRXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 13:23:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42742 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab0IDRXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 13:23:42 -0400
Received: by fxm13 with SMTP id 13so1859248fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=QfJJe4ojj+/WYp/sbFuFefW7Uts9KEtu0iH1rtdXmkQ=;
        b=GLcvcLsFISpUEdnZ+/BNivUj0ys9f02WvPsMgwy9yuTw+JlMTossmNCuoKlRfi2Agq
         Fgb/HTiJuc5RU0xZ7PjbQcvVWm02kwbj+O6D/cjAO1jlPeObMZlPD2KGjr2dfI3ga8Ja
         Thpa16wKFjD54Skxqi5OEY7BNQcIQ5zgzDpnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=XL/LjqXyuo7E8HGOgdp0KgNjj7ICAC8MFuzOHn+8thiI/7j6NtgFaTWu/ZKix9xqdd
         NNHzPdkhcqTyJy1PCDUucBn9wP73VP30tdPCtG4E/3ZbnyJzD42Wjh4V3PtJx1fJxXdX
         /8JCLnKnNlqq9KlNuBIVOckS/9aNnFUpuoTp8=
Received: by 10.223.124.13 with SMTP id s13mr74438far.19.1283621021431;
        Sat, 04 Sep 2010 10:23:41 -0700 (PDT)
Received: from [172.19.43.221] (ip-94-42-5-222.multimo.pl [94.42.5.222])
        by mx.google.com with ESMTPS id c20sm1508700fak.9.2010.09.04.10.23.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 10:23:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <20100904155638.GA17606@pcpool00.mathematik.uni-freiburg.de>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155343>

On 09/04/10 17:56, Bernhard R. Link wrote:
> While your approach looks like it could work with one commonly looked
> for branch/tag, it might be worthwhile to look at some more complicated
> cases and see if the protocol can be extended to also support those.
> 
> Assume you are looking to update abranch B built on top of some
> say arm-specific branch A based on top of the main-line kernel L.
> 
> There you have 6 types of peers:
> 
> 1) those that have the current branch B
> 2) those that have an older state of B
> 3) those that have the current branch A
> 4) those that have an older state of A
> 5) those that have the current branch L
> 6) those that have an older state of L.
> 
> Assuming you want a quite obscure branch, type 1 and 2 peers will not
> be that many, so would be nice if there was some way to also get stuff
> from the others.
> 
> Peers of type 6 do not interest you, as there will be enough of type 5.
> 
> But already peers of type 3 might not be much and even less of type 1
> so types 2 and 4 get interesting.
> 
> If you get first a tree of all commit-ids you still miss (you only
> need that information once and every peer of type 1 can give it to you)
> and have somehow a way to look at the heads of each peer, it should be
> streight forward to split the needed objects using your way (not specifying
> the head you have but the one you hope to get from others), they should be
> able to send you a partial pack in the way you describe.

I doubt git-p2p would work well w/ any "quite obscure branch";
obviously, the p2p approach works best for popular content...

But there's the case of _new_ content, that has not already propagated
thrugh the swarm. And this was the very reason I chose to have 'ref' in
the protocol.

Let's say Linus releases a new kernel, I want to fetch it, and find 200
peers of which only three have already updated.
Here another field in the initial UDP protocol comes in, that i omitted
in the original description in order to keep things simple (it's just
an optimization).
The UDP response from the peer, in addition to the latest commit_id that
it has, also contains an integer "commits_ahead" that says how many
commits ahead of the _my_ id (that I've sent in the request) this peer is.
So in the above situation I immediately find out that eg I'm missing 2000
commits. It would be extremely stupid to try to update using just the
three seeds, of course. 
But by looking at all the commit_aheads of all peers I can see
(make an educated guess, really) that 150 of them already have 1500 of
the new commits. So what i do is pick one of the IDs given by one of the
peers, such that a sufficient number of other sources are likely to
already have it (ie they all have a lower 'commit_ahead'). And start
fetching that commit from the 150 sources, instead of my real target commit.
Once I'm done with this, I'll repeat the process again; by now hopefully
more peers have already updated. If the target commit is still rare I can
again look for an intermediate commit, that has a sufficient numbers of
seeds. 
No extra traffic, and it also discourages abuse, as leeching from just the
few seeds will likely result in overall slower download.

This works best if the ref isn't rewound, obviously, but i think that would
be the common case.

Does this address at least part of your concerns above? The 'obscure branch'
case I'm not sure is easily solvable; I don't know if having a lot of rarely
used content widely distributed in the swarm would be a great idea...

One other interesting case is reusing objects needed by (large) merges, that
could already be available in the cloud. I'm not sure it happens often enough
to care though...

artur
