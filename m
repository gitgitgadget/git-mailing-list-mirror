From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 05 Dec 2013 10:01:28 -0800
Message-ID: <xmqqeh5ri3d3.fsf@gitster.dls.corp.google.com>
References: <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
	<CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
	<5297004F.4090003@gmail.com>
	<CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
	<211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
	<CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
	<20131128092935.GC11444@sigill.intra.peff.net>
	<CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
	<20131204200850.GB16603@sigill.intra.peff.net>
	<CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
	<20131205160418.GA27869@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Duy Nguyen <pclouds@gmail.com>,
	zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 19:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VodFK-00046w-OV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 19:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659Ab3LESBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 13:01:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757638Ab3LESBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 13:01:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B925717C;
	Thu,  5 Dec 2013 13:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5qBUHYAuZEj+WDQqEHZdRS9v7k=; b=lMLAR8
	S6rAehmUzCxrzLW7cb+oJC7J7pizvzB5FIhJhlQkirCR0W4bLEWZS2HGt+tidRnl
	V/F7CVxftB2EWX+GO//tKzLrVIbfFgWb3TnWvkeoATqJCUCEavN9iG3R+YjcJvhl
	9ZQNBgP+/0ojGISpTsvctLh/cEvnHu70JgstU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v178Z6L7GRxxc7iRLIS1x/lll0o7L+r5
	EIBzCCPBROG2Aln+H5XvNgnby6E+6Yu00PJRXK7BrW5mLkvgHziFbzeZHT3HUSni
	TG2FZijU7/e7rxopVoU2wYlpXEXSuaEsSE4LLEAOlBjJLAyF5sZMDjqeEEz11XHU
	CYdMj3A+L0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB335717A;
	Thu,  5 Dec 2013 13:01:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB62757172;
	Thu,  5 Dec 2013 13:01:41 -0500 (EST)
In-Reply-To: <20131205160418.GA27869@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2013 11:04:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4BA572F0-5DD7-11E3-AF82-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238891>

Jeff King <peff@peff.net> writes:

> Right, I think that's the most critical one (though you could also just
> use the convention of ".bundle" in the URL). I think we may want to
> leave room for more metadata, though.

Good. I like this line of thinking.

>> Heck, remote.origin.url might already
>> be a good mirror address to advertise, especially if the client isn't
>> on the same /24 as the server and the remote.origin.url is something
>> like "git.kernel.org". :-)
>
> You could have a "git-advertise-upstream" that generates a mirror blob
> from your remotes config and pushes it to your publishing point. That
> may be overkill, but I don't think it's possible with a
> .git/config-based solution.

I do not think I follow.  The upload-pack service could be taught to
pay attention to the uploadpack.advertiseUpstream config at runtime,
advertise 'mirror' capability, and then respond with the list of
remote.*.url it uses when asked (if we go with the pkt-line based
approach).  Alternatively, it could also be taught to pay attention
to the same config at runtime, create an blob to advertise the list
of remote.*.url it uses and store it in refs/mirror (or do this
purely in-core without actually writing to the refs/ namespace), and
emit an entry for refs/mirror using that blob object name in the
ls-remote part of the response (if we go with the magic blob based
approach).

>> Yes. And this is why the packfile name algorithm is horribly flawed. I
>> keep saying we should change it to name the pack using the last 20
>> bytes of the file but ... nobody has written the patch for that?  :-)
>
> Totally agree. I think we could also get rid of the horrible hacks in
> repack where we pack to a tempfile, then have to do another tempfile
> dance (which is not atomic!) to move the same-named packfile out of the
> way. If the name were based on the content, we could just throw away our
> new pack if one of the same name is already there (just like we do for
> loose objects).

Yay.
