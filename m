From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Fri, 12 Sep 2014 09:36:56 -0700
Message-ID: <xmqqtx4cbxsn.fsf@gitster.dls.corp.google.com>
References: <540F426E.6080908@exec64.co.uk>
	<xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
	<540F554C.5010301@exec64.co.uk>
	<xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
	<20140909214520.GA13603@peff.net>
	<xmqqtx4fgzqe.fsf@gitster.dls.corp.google.com>
	<20140912044901.GC15519@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:37:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSTqM-0004Gi-4y
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 18:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaILQhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 12:37:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52718 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbaILQg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 12:36:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9122E38C43;
	Fri, 12 Sep 2014 12:36:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MgOiPeidKKHM6+yI+ttBkyR4ZjI=; b=cYYqn+
	FPWuJlpCpUI0ys212hGau/GnxKaH1bh4SxCwpGGHfvcg1uhGQ8XbkflNfpJCigzK
	M+SAAIgM6uAuDAdBlH2siVl21YRTqd2RvYuJI546TBCCs+dPzKukz2WnkZBByah9
	TS4M1z1HPiqxk6sLrkh0Xcp7MpaHHidgfcrfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ivhw1RJdpbVt+a537pmXUXHtdwTFtLwt
	u2hlVxH2u2Y0QrEA/krBj+ApbyxUXn3b/avuUSjGnCEHdV6oFHSX52lmOTJrKg+R
	AylCQ1AEqEW3EMD71RFgvDcdlNbgLrxSwxmVdrrfrWelVPUFr5+QDCy/mM+MVcs5
	q32/RtiJ3PQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 855ED38C42;
	Fri, 12 Sep 2014 12:36:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F150238C41;
	Fri, 12 Sep 2014 12:36:57 -0400 (EDT)
In-Reply-To: <20140912044901.GC15519@peff.net> (Jeff King's message of "Fri,
	12 Sep 2014 00:49:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0370B82C-3A9B-11E4-8916-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256926>

Jeff King <peff@peff.net> writes:

> I dunno. I wrote that original set of lua pretty-format patches to try
> to stop the insanity once and for all. But I realized that I do not
> actually want to do anything complicated with the output formats, and
> "--oneline" and a few simple "--format" calls usually are enough.

Yeah, I share that exactly, and %+ and friends are meant to be on
this side of the line between "a few simple" and "complicated".  I
was not sure which side %if() falls myself, and while I still am not
sure, if I were asked to decide which today, I would probably say it
is on the "simple" side.
