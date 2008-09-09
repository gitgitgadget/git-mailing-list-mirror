From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 00:35:21 +0200
Message-ID: <200809100035.23166.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <7vljy159v7.fsf@gitster.siamese.dyndns.org> <20080909205003.GA3397@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdBpA-0007bm-B3
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYIIWfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbYIIWfc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:35:32 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53217 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbYIIWfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:35:31 -0400
Received: by gxk9 with SMTP id 9so12075249gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fl/+ov5DoYXgLJQT4uPAoBJ564Z1Z1yUjtKL8TCn25A=;
        b=B8XO4k3srSH1l7Y7J9b14FPtQlzPF9ck4BvGQDm+hiDE0DPXWcfiJh2sMQKvPT9vgx
         6mDp+ElkDyiNZIx1rjgYptEPgt35P1zc48k0q1w6PU7UW+HRG4b6c28RLQjLPLBHQQJs
         HS1ixyGe4A72nmFt3/gBgND7QqRjwW3GoUNaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gz1fDhAHLuP1uXs8p89veWKGwVjJ6nF6yUcOmcIOmqIoriUfaKkeMX2lrhF9NfmfBv
         Z640N+nEU3WmzcTs1U4FCaiZtVRMWHH7JuSvKTJKKt/fqfdptJZln6UY84cunnq8QHxZ
         5ZTFFStXcnVaKQJKfFFPQsDAItnhiIHB8v2/0=
Received: by 10.86.95.20 with SMTP id s20mr331179fgb.65.1220999729160;
        Tue, 09 Sep 2008 15:35:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.71])
        by mx.google.com with ESMTPS id 12sm6549840fgg.0.2008.09.09.15.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 15:35:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080909205003.GA3397@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95451>

On Tue, 9 Sep 2008, Jeff King wrote:
> On Tue, Sep 09, 2008 at 01:42:52PM -0700, Junio C Hamano wrote:
> 
> > As for "by the way ... was used to make this commit": this is git.  So how
> > you arrived at the tree state you record in a commit *does not matter*.
> 
> But it _does_ matter, which is why we have commit messages to explain
> how you arrived at this tree state.

Well, that is why I was carefull to say that "origin <rev1> <rev2>"
(or 'changeset', or 'cset') means that tree state for given commit
is created out of parent commit (or parent commits in the case of merge)
and of (<rev2> - <rev1>) patch.  This is a bit of enhancement to
"parent <rev>" meaning that tree state for current commit is derived
from tree state of <rev>.

This is nice generalization...

> Now, that being said:
> 
> > After reading the discussion so far, I am still not convinced if this is a
> > good idea, nor this time around it is that much different from what the
> > previous "prior" link discussion tried to do.
> 
> For the record, I am not convinced it is a good idea either; I was
> hoping to steer it in a direction where somebody could say "and now this
> is the useful thing we can do now that we could not do before." If the
> ultimate goal is to put links to other commits into history viewers,
> then the commit message is a reasonable place to do so. The only thing I
> see improving with a header is that it makes more sense for pruning and
> object transfer.

I'm also not all convinced that 'cousin'/'origin'/'changeset'/'cset'
header is a good idea.  I only tried to steer discussion in good
direction if it is somewhat a good idea.

First, if the only goal would be to add extra links (extra edges) to
[graphical] history viewer, then full sha-1 of a commit which can be
recorded in commit message for cherry-picks and reverts should be
enough.  It does mean parsing commit message, and all possibilities
for mistake which are connected to using conventions in free-form part
of commit object; on the other hand it is not _that_ critical.

If however 'origin' links are more (perhaps only a tiny bit more),
for example discussed "weak" links... then I'm not sure if
the tradeoffs are worth it. First, if it is full connectivity like
in 'parent' header case, then a) why not use 'parent' anyway,
b) it pins the history indefinitely long. Second, if it is "weak"
link, i.e. local protect it on prune, then a) there are problems
with transferring the data, and protecting links on transfer,
as somewhere in the middle or at the end there might be repository
which uses older git (backwards compatibility strikes again),
b) git in many, many places assumes that object is valid if it passes,
and all objects linked to from object are valid; we would have either
use some kind of separate 'not strictly checked' packfile/storage,
or have grafts-like thingy.

So I'm not sure if 'origin' links are worth the trouble.


About much, much earlier "prior" link discussion: I think the discussion
about "prior" header link was done before reflogs, or at least before
reflogs got turned on by default.

-- 
Jakub Narebski
Poland
