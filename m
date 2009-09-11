From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 14:57:28 -0700
Message-ID: <7vr5uduotz.fsf@alter.siamese.dyndns.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
 <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
 <20090911212938.GA26589@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmE84-0002cZ-S6
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbZIKV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 17:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbZIKV5q
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 17:57:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbZIKV5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 17:57:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CFB2FA92;
	Fri, 11 Sep 2009 17:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/0I+149yh3f3Q2BHqLhfk1vsaug=; b=uvu6Xt
	344L8lIpG5K6v+gQfLWqUCpzDMJNX2GkE7NyoNiePtxSdFSEHZYXb9m85AJ/ebcA
	6WZnb+cKjpQQiQXhs5gYB+S3Q4hFyqFaiPkO58cFHq3Yzy+mqcWYyqAX2beMuyL5
	xu1U4pD+YH8NkikMUH8u6sBDBl1tHOQ2D/30U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ufsVgD1xcX6RdAEE/+5/OlAJfpsWokDG
	rGCl9cd2lSqinl/ZunhxqpOKjrXErHIQbYm5W0AELHDWR6GPc23b3AT6IyS9FNNq
	DhXHJoj94HPBVckF790xaJK0628bqJ1kB2xGfCH64cRc9/owtYP3jQ12rMq/YnzA
	N7bxPv2JmA0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ECD62FA8F;
	Fri, 11 Sep 2009 17:57:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C19A2FA8D; Fri, 11 Sep
 2009 17:57:29 -0400 (EDT)
In-Reply-To: <20090911212938.GA26589@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 11 Sep 2009 17\:29\:38 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20835046-9F1E-11DE-BC6E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128223>

Jeff King <peff@peff.net> writes:

> I think something like that needs to "belong" to the diff code itself. I
> guess in the case of "diff", we could check all diff-related config at
> diff setup time.

Not necessarily.  You do not want to care about color configuration if you are
doing diff --raw for example.  The one that first uses the color variable
should be able to notice the breakage, no?

> But what about something used in several places, like
> core.quotepath?

Exactly the same way I checked what codepaths needed to fix for the
autosetupmerge stuff.  core.quotepath internally sets quote_path_fully,
and the sole user of quote_path_fully is sq_must_quote() which is only
used by next_quote_pos().  So you can have your check very isolated.
