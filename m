From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 20:46:43 +0200
Message-ID: <4C829413.1010302@gmail.com>
References: <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com> <AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com> <4C81A67B.2060400@gmail.com> <alpine.LFD.2.00.1009032304560.19366@xanadu.home> <4C81DC34.2090800@gmail.com> <alpine.LFD.2.00.1009040153280.19366@xanadu.home> <4C824CAD.9070509@gmail.com> <20100904155638.GA17606@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 20:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrxlT-0002iL-Q9
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 20:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0IDSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 14:46:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38286 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab0IDSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 14:46:49 -0400
Received: by eyb6 with SMTP id 6so1667225eyb.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=7ARC3IBuPTv/rimN5cKkM2JBpOT5N9SICjkehViqFSI=;
        b=S3Uo29vv26tQ2kwRusoXPmcUvoWqOX73Mb6hjYydZpY5Bw+loXCrA2RCEQeIgDR2kE
         w6Be1d4V5WzOmlohmGT7GR/XT29ih3KgQZuQLbsHfFpwsXMmt1e/5pPoHaBQ6zXeIV06
         g0aBtEfX+9hR2Z/gsGhiEHopyw03dE0fx6DbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=yIbJqzUi71LGKzJK4CGXr4p6togiEELDsjVEYpa43hu5h4qF5fTpLtTQym6NLAiejA
         r0KhZC2n0nUcguvwJ6D36Xl6f6ZIfWqMZ9TRdOL4plBJuasIJwPZ9Sa0Wu9dgN6/dYKU
         Ug6/bQP6c5q3INCe+Sr/YAsaJa6pO1GOUcs/c=
Received: by 10.213.19.202 with SMTP id c10mr96363ebb.24.1283626006218;
        Sat, 04 Sep 2010 11:46:46 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-125-157.multimo.pl [89.174.125.157])
        by mx.google.com with ESMTPS id z55sm5007912eeh.21.2010.09.04.11.46.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 11:46:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <20100904155638.GA17606@pcpool00.mathematik.uni-freiburg.de>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155346>

On 09/04/10 17:56, Bernhard R. Link wrote:
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

Actually, since the seeds of this quite obscure branch know that this branch
is rare and are most likely also sharing other, much more popular, refs, they
can just add another note to the initial reply, saying 
"this_ref_is_descendant_of($popular_branch, $common_base)". Then the client
can fetch old..$common_base and $common_base..$rare_head independently (even
in parallel).

artur
