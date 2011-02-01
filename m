From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 17:13:59 -0800
Message-ID: <7v8vy04kvc.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
 <AANLkTin2kTW85UC1r_1LUDVLiexcVDvt--9ndnXZ2ARS@mail.gmail.com>
 <7vd3nc4qr6.fsf@alter.siamese.dyndns.org>
 <AANLkTinRo5KxC9OQWyZMnqQP4WHi0sR5qqw6byr4V+3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk4oz-0006xx-Ds
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab1BABOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:14:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693Ab1BABOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:14:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BCB04EDC;
	Mon, 31 Jan 2011 20:15:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nIyTQolwUtCwD6vPJzeEwnTzmQ=; b=i3nktY
	o2GeAd7IVAs0f0MRYNeQ8zfMioyF4jsO1E2JgQHUFGrcMS6uFSmllCa2Ur90u6jj
	CU2N+DJLgmBU8FAt0mAFXpG548CYgML30E936Uy8y6WJiTYaVEPhGR4yWC54FaGC
	UoF2Wd9CMz5OnahVGKABook5WDfEU8u/Vi1Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rVed0bO7zzHmDxMCoz+swLpfzcG65wuB
	CfUvt/TUQqCKbuoHGA2Qz4LsrQD9exvD40P/vp3023/0ToRHo07z4Z+WGe3jK2Xq
	1g9QQ2QQQOQhEC79p9ZW2awJReHkKyqWt44vjMwRoK7OBTsXZleTMUUAuP5utOCZ
	fdSp0uU9gl8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAF8F4EDB;
	Mon, 31 Jan 2011 20:14:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B29B14ED7; Mon, 31 Jan 2011
 20:14:53 -0500 (EST)
In-Reply-To: <AANLkTinRo5KxC9OQWyZMnqQP4WHi0sR5qqw6byr4V+3a@mail.gmail.com>
 (Eugene Sajine's message of "Mon\, 31 Jan 2011 18\:39\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF2A6B74-2DA0-11E0-AB9B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165785>

Eugene Sajine <euguess@gmail.com> writes:

> I did understand what Thomas illustrated. I'm just thinking that the
> range origin/master...FETCH_HEAD seems to be useful but in fact is
> pretty useless, because you cannot guarantee the state of the
> origin/master _before_ the fetch and therefore you cannot rely on the
> results of range selections involving it.

With the current system, origin/master is what I _used to_ have before
running this fetch, iow, what I have been looking at as a reference
material while I did my own work so far.  The current "when fetching refs
explicitly, do not touch tracking branches" behaviour guarantees that.

The range above shows what I already knew about the work the other people
did, and what is new on both sides, to help me decide what I want to do
next with the fetched result.  At least that is the workflow the "when
fetching refs explicitly, do not touch tracking branches" behaviour allows
us to support (I am not recommending that the workflow in particular, by
the way).  The next action after seeing what they added is sane may be to
run "git pull" (no arguments), which would fast-forward my view of the
other side to whatever I reviewed this round.
