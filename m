From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 08:04:26 -0700
Message-ID: <7viph5gfet.fsf@alter.siamese.dyndns.org>
References: <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <4F7FFD7A.80104@pileofstuff.org>
 <20120412071150.GB31122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILZc-0008Er-SB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934342Ab2DLPEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:04:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757552Ab2DLPEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:04:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 343AB7F5D;
	Thu, 12 Apr 2012 11:04:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b8fg4O33BI+SrcKVf9W+Niu9asQ=; b=JZjf4w
	2NwTtyUgNbJNblrhoAgrRDLQMSGj/v4MKqofZKJLNzu4aawRh6ONs6pO1XKqck5Y
	VNzygCCk0/3RaYxpQPHAZaYqpcFXvghNvV0MgqkJywCfFebj9hW23MxR69GvPqbg
	SSqU7sQb7ReAUrW33OVrehYkhlHdBsgHxKWag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=chXRrHDNxan6ZnnWRsN3J+VGozXWqPrb
	aQa7ghkWTaytXAVOn61bJfTc+rVBG4MHWXOquzqvIkpK8hU8VLdIrWWPEwg78Ikp
	cBbt2659tgcGgqB3XDGU4rlacdHK9YBOkauVg22n7NDETBkNmLspGJGzjXYKsuq2
	i/th4e1aR14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AAC97F5C;
	Thu, 12 Apr 2012 11:04:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B5397F5B; Thu, 12 Apr 2012
 11:04:28 -0400 (EDT)
In-Reply-To: <20120412071150.GB31122@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 03:11:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCF952D8-84B0-11E1-B337-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195332>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 07, 2012 at 09:40:26AM +0100, Andrew Sayers wrote:
>
>> On a slight aside, should we add @{downstream} to describe the opposite
>> of @{upstream}?  Seeing that around the place would give intermediate
>> users a clue about why pull and push aren't as related as they think,
>> and would be useful here and there in code (e.g. __git_ps1 could show a
>> better bash prompt with GIT_PS1_SHOWUPSTREAM).
>
> Maybe. I don't really see how it is useful, but maybe you want to flesh
> our your proposal with some examples? I do not use __git_ps1, so I'm not
> sure what you want to improve there.

I took "downstream" as an opposite of "upstream".

The "upstream" of your branch is often (but not always) a remote tracking
branch, and because it makes sense to only have zero or one (but not more)
branch.$name.merge, "$name@{upstream}" would mean something.  There is an
N-to-1 mapping from branches to their upstreams.

Given a remote tracking branch $name, (or if you use "upstream" to fork
your branch off of another of your branches, it could be a local branch),
there can be many branches that call it an "upstream", which means that
the notation "$name@{downstream}" cannot even map to a single object name
or a refname; it is a 1-to-N mapping.

So I thought this was a joke and not a serious proposal.
