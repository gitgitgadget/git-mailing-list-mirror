From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Thu, 19 Jun 2014 13:32:04 -0700
Message-ID: <xmqq1tuc8ypr.fsf@gitster.dls.corp.google.com>
References: <53A1EE0E.6040000@ramsay1.demon.co.uk>
	<20140618200854.GA23098@sigill.intra.peff.net>
	<53A2131A.30900@ramsay1.demon.co.uk>
	<20140619091924.GA29478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzulH-0004wo-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbaFYV3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:29:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56648 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823AbaFYV3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B2F121E00;
	Wed, 25 Jun 2014 17:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type; s=sasl; bh=ta4kbHoerSTsmD2vCXmDAAxK5r4=; b=sPSp6W
	GDPhMkE7p1Bc/QeQ8Et2ICsReyT0y2mE/7CMP8XIyFcrLWrhXKL4P815ACk/DvEd
	bdmr7ZebdC6wOn1JXZd295tT2u4hpSWhfTD2VnGZssvYEbmBw+O/LTQyZzpRO6M8
	HfDqqAV9OsJpab8ksVH50nqhbSgtL6o+OHHL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uoXWznMscfFQjbx4cEy8n+m4XsPsvSkW
	RQL0RPXAAkpD6169h1qdSZpgcvzmh/L4UcBA8hKprd1tIpohHGzC3UiCzjC+ydqs
	XEIpwBsNkkPFQk1S3vy3acTTCuu0uup1wlY+3UDrn3vhlEPxs8Ym5aWVlDb1wN+r
	D0itgjF8mfI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EE3A21DFF;
	Wed, 25 Jun 2014 17:29:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D706A21DF9;
	Wed, 25 Jun 2014 17:29:31 -0400 (EDT)
In-Reply-To: <20140619091924.GA29478@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Jun 2014 05:19:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBBDAADA-FCAF-11E3-B2B8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252462>

Jeff King <peff@peff.net> writes:

> For a while some people were compiling git with pretty antique
> compilers, but I do not know if that is the case any more (Junio noted
> recently that we have had trailing commas on arrays and enums in
> builtin/clean.c for the past year, and nobody has complained).

IIRC, the problematic is a trailing comma in enum definitions, not
array initialisations.
