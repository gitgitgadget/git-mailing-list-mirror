From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Wed, 05 Jun 2013 10:41:43 -0700
Message-ID: <7v1u8g3160.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<51AEBAEF.6090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 05 19:41:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkHib-0003qy-9G
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 19:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab3FERlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 13:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab3FERls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 13:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E31251E7;
	Wed,  5 Jun 2013 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cjy2zgFi13dGjkk6cuj8208ZxAY=; b=mTwCXO
	SBM3Ca8v7JMMAJlLGwD9oNVFP23WXak1CEIBlXI66YGHnsyIAcaq0GtDOKIyfOfX
	K41TaDfoVX60Ee80eUYWLh/elHUu7wu63928d7sKN6Oy9UPS9Zraw4t40mevnW3c
	9ksCsIGwkUqVWXDaYeKKoycbqrqGG8G7+gON4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nd3oGkMChSNjnlkyfpdrrrzQI/nN4CSP
	Kl4cvSa1SYkl1I/cTrCLZZVVXMKDSvJbvEPgcy9wcqTN7jA7X8QIyaU0UJCllEDR
	rQTS50Vf2TJGDHgam//+hqq1ZkXi094Qh1BSZZwv2qXO8UjRBoDA4EbN/bTfDiU+
	GqprEXjoa4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B6E0251E5;
	Wed,  5 Jun 2013 17:41:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3784251E2;
	Wed,  5 Jun 2013 17:41:44 +0000 (UTC)
In-Reply-To: <51AEBAEF.6090402@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 05 Jun 2013 06:13:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30787C62-CE07-11E2-A058-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226461>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For completeness, let me point out two other small advantages of contrib:
>
> * a tool in contrib can assume that it is being bundled with the
> corresponding version of Git, and therefore doesn't necessarily have to
> go to the effort of supporting older versions of Git.

It is true that in-tree stuff can go in-sync with the rest, but I
think that is irrelevant, as we are discussing a tool in contrib/;
if it is part of the core, it deserves that benefit over tools
developed out-of-tree (that need to worry about utilizing new
features after a version check).  After moving tools that we want to
keep as a part of core out of contrib/, they will still be in-sync.

For those that alternative third-party designs and implementations
for solving the non-core problems they try to solve (e.g. ciabot,
continuous, blameview) can exist, it would be better for the
ecosystem of they compete with their alternatives on the same
ground.

> But my main point is that I think it would be easier to phase out
> contrib/ if there were a good alternate way of providing visibility to
> "satellite" projects.  The relevant Git wiki page [1] is the most likely
> candidate, but it is a bit overwhelming due to its size, it has fallen
> into disuse because it was broken for such a long time, and it is not
> prominently linked to from git-scm.com.  If it were curated a bit, it
> would help users find the best ancillary tools quickly.  Perhaps ranking
> the tools based on the results of the Git user surveys would help bring
> the most popular to the top of each category.

That is a very good point.

>
> Michael
>
> [1] https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools
