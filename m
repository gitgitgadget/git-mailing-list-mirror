From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Tue, 07 Jan 2014 09:51:07 -0800
Message-ID: <xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
	<CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
	<20140107171307.GA19482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:51:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aoB-0004L0-HY
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbaAGRvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:51:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbaAGRvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:51:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E14F60F12;
	Tue,  7 Jan 2014 12:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=met4xQiAJXiXoUVyV6qV485r3lg=; b=cy8XHD
	LKTrvTg7KiRojmCWV28zzmVPQWlwJFzvcg7RjHjYMxGhijCRHrf/mFExJ1s9OmLB
	o8NecQF/lzkWweMRkjzSApBXKoHdBQi4Y0lHJyk9qzWs8rIUv288QJEqAt4Z8hu6
	DCCJpEnhoX49Z+XGJa/88rH5To6otQlD6g4Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DPGfwAT1VdhmmTDwEsCLZAT6GsERXpvH
	xoPSfvRnRh8debsTJOJpF2zH7WBNHcgh/qftgkzOa0ebVnocUUtWnJN5k5/YZhiJ
	6ya57tBugBRlAsgs8OfCyfhnZ3ZlVbhcj8XX2qBB1DOAK2NqeJ0g1gCYDtjwkq40
	tl+UrUkpj0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22FC60F10;
	Tue,  7 Jan 2014 12:51:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A736860F0D;
	Tue,  7 Jan 2014 12:51:09 -0500 (EST)
In-Reply-To: <20140107171307.GA19482@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 12:13:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A692B64-77C4-11E3-BDDE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240119>

Jeff King <peff@peff.net> writes:

> Alternatively, I guess "cat-file
> --batch" could just turn off warn_ambiguous_refs itself.

Sounds like a sensible way to go, perhaps on top of this change?
