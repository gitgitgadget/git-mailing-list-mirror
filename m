From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 12:37:36 -0700
Message-ID: <xmqqinzasqgv.fsf@gitster.mtv.corp.google.com>
References: <20160421161043.GK7907@onerussian.com>
	<xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
	<20160421185528.GJ23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:37:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKQ4-00050P-30
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbcDUThk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:37:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752379AbcDUThj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:37:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B544813483;
	Thu, 21 Apr 2016 15:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1r+14sTmkv3jnIf3zSfKpPb6V2M=; b=cZcLBq
	iD0tsYKg5G89faRzgDrTGWKKLuMSN3uavZTkvcuyyXMjYgxyxlzPtVntP6YQ2seo
	AhRcevaVpYUW4zka4U/BhanJB8K1a804QWk/sZ2+SyOEecu42STorpdQB/rT4pB/
	OE8SSc24k4KDbRy/yLNiGEkojl+mR54hMnJIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejp1z18e787RwOQRTEEBQyGUKSSqcNN4
	VrGDpnztYkHrRqOaR7W6KZvaCQ3qrANKkBI1Wtl+D+EwS8BvT/o8X+vcZlPUgl/r
	MXWw8iwxo7PbDluKI4hQqYhZLCWqMBm+6uaKvpj1nAayXUc3u5zcGAjzwbESqc/2
	kWI3LEzdFzo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA35213482;
	Thu, 21 Apr 2016 15:37:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CA1B13481;
	Thu, 21 Apr 2016 15:37:38 -0400 (EDT)
In-Reply-To: <20160421185528.GJ23764@onerussian.com> (Yaroslav Halchenko's
	message of "Thu, 21 Apr 2016 14:55:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81244A32-07F8-11E6-A733-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292150>

Yaroslav Halchenko <yoh@onerussian.com> writes:

>> It is not very productive to make such an emotional statement
>> without substantiating _why_ a merge that adds a new root, which was
>> declared in the thread above as "crap" (in the context of the kernel
>> project),
>
> Sorry if my statement sounded too emotional ;)  I will outline some of
> the use-cases below.

Thanks.  Emotional is fine, as long as you _also_ have useful
information.
