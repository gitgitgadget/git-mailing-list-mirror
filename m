From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Tue, 15 May 2012 11:10:36 -0700
Message-ID: <7vsjf1e2n7.fsf@alter.siamese.dyndns.org>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
 <20120515015437.GA13833@sigill.intra.peff.net>
 <7vtxzhfpv9.fsf@alter.siamese.dyndns.org>
 <20120515174724.GA329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 20:10:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUMCy-00089R-RS
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 20:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119Ab2EOSKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 14:10:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932628Ab2EOSKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 14:10:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26538385;
	Tue, 15 May 2012 14:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6uoVhmVUBQQvtGKOE5JngT50wXU=; b=Ka3/K4
	5bdyioREMIUbZmEJgyaKPTSVP2DpwC+KUaG2D0yEKNAWHsd2Kjmcg8JK5/00mOff
	pe+lx4481GGMKW8cbAqxg+sGAxsDsd7pIVEuuWj3V/76LJPVeHSW5AZMwr2Erdo2
	GC1SEms9q5UGBxUvsbzsfvRvMu+8S+uoDm1ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q0BJdc5cLE+7sxEshDYc8fpvlumG0uWU
	yUeAn87hwoef8n8u/2bNkbV1O90heSAs13Fry4Kqn4Y6WF/A0UgGGh6WlTrRjHPq
	Akn/DaVZBS3NAVOZNiF8I1Y91LBR9Dl4XoIOFqCZw7D9Fm9nSVtnUqB5zcGPRbBd
	aqapjgkp5aU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91238384;
	Tue, 15 May 2012 14:10:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD508382; Tue, 15 May 2012
 14:10:42 -0400 (EDT)
In-Reply-To: <20120515174724.GA329@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 May 2012 13:47:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48A38134-9EB9-11E1-9CFF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197847>

Jeff King <peff@peff.net> writes:

> So it seems to me like a much simpler set of rules would be:
>
>   1. When reading gecos, always fall back to the username if the gecos
>      field is unavailable or blank.
>
>   2. Always die when the name field is blank. That means we will die
>      when you pass in a bogus empty GIT_COMMITTER_NAME (or an empty
>      config name), which makes a lot more sense to me than falling back;
>      those are bogus requests, not system config problems.  And we won't
>      ever have a blank gecos name, because we'll always fall back on the
>      username.

That certainly sounds very simple to explain and understand, and I do not
offhand think of anything *sane* that would break ;-)

Thanks.
