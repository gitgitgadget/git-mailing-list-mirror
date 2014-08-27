From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a buffer
Date: Wed, 27 Aug 2014 12:41:51 -0700
Message-ID: <xmqqioldd8jk.fsf@gitster.dls.corp.google.com>
References: <20140827075503.GA19521@peff.net>
	<20140827075600.GA26384@peff.net>
	<xmqqioldet75.fsf@gitster.dls.corp.google.com>
	<20140827180016.GA6269@peff.net>
	<xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
	<20140827191414.GA7561@peff.net>
	<xmqqsikhd98f.fsf@gitster.dls.corp.google.com>
	<20140827193857.GD7561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:42:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMj7C-000352-1h
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbaH0TmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:42:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55142 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806AbaH0TmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:42:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A324E35AF3;
	Wed, 27 Aug 2014 15:42:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qifyeTGnKvm2DVjwoN9JFfmxGgk=; b=o9ynZO
	26fZTE8te/cT3XdI0++EGm0wQ8alpV+NAk3rHUp82ANIxnL6OwSszlhlu9U+E2zH
	FSQVdcDjfhWThljQhO2Si757J6OeMWytrw3mOyltQ5D5F/SHBnvAxuiPRjpCSQV8
	o03StIYMGy/JMD1GKVi5ZHlveRA3uas4+eBUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YFuD8xFB6Qr3ck4y3y7FHAibxc7lrmid
	0vKQwZN13f8aaVAGRnuy3BdwjUhNaCGQzht9tNuaDznfAbMEJAUTGkW0WSyPQ2zC
	+pZMAYrKoGOmoPdb7owUEIxaHIdSFQP0a4CaTV6RIiPdO9l/1cwmq19VNIOrrC0K
	XKsBvWhh0M8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9977735AF2;
	Wed, 27 Aug 2014 15:42:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 252A035AE8;
	Wed, 27 Aug 2014 15:41:53 -0400 (EDT)
In-Reply-To: <20140827193857.GD7561@peff.net> (Jeff King's message of "Wed, 27
	Aug 2014 15:38:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32107D64-2E22-11E4-AA9C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256031>

Jeff King <peff@peff.net> writes:

> What I didn't want to do is deal with it in each callsite, like:

OK.
