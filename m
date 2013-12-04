From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
Date: Wed, 04 Dec 2013 14:02:38 -0800
Message-ID: <xmqqfvq8jmv5.fsf@gitster.dls.corp.google.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131201074919.3042.92026.chriscool@tuxfamily.org>
	<CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
	<20131203124645.GB26667@sigill.intra.peff.net>
	<CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
	<xmqqk3fkjq5c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:02:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKWu-0005S1-UH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab3LDWCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:02:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3LDWCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:02:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 204B1569E4;
	Wed,  4 Dec 2013 17:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QJWQdFjz3OppY4Tek+05kIQi2sU=; b=uPWFPe
	RFSdYcDf01LMn5iLwHg4VvdJHSmEQOe2Ffa0ihZ+6MCT6MtBCUsOSpZfVSQ+QWh4
	wLwe3P1L+t0oFUBxVS2JDwiBTuzMuhuLfGsVWOwoyjmepGeWkeV8xj+Wk9fBO5ap
	1d3tSZndzCVh/Zh91VXZfU5FEmCPu2ai2u228=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bB2xQp0szVHYDAltzImld48zfEZ6Oy2m
	fIBA5zOpKu/GSCjPLhLAjJyfuTmHcbl9Kv04yun0Pj7GdhkdBZTDu2rVWw8RUWd9
	8Q+BHWLZ7YNp8Gnc9R7z6OaQLvbjNt/+jDzjOyL/eO8neODI7BKHjdYk1ptIaAuO
	GM0MrUoWRSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E8F2569E3;
	Wed,  4 Dec 2013 17:02:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C56B569E1;
	Wed,  4 Dec 2013 17:02:40 -0500 (EST)
In-Reply-To: <xmqqk3fkjq5c.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Dec 2013 12:51:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CB00C822-5D2F-11E3-B0CC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238814>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> Ok, the commit is in the use_starts_ends_with branch on this github repo:
>>
>> https://github.com/chriscool/git.git
>
> I looked at the patches, and they looked alright.  The endgame needs
> to be on a separate topic to be held until a distant future, though.
>
> Will queue.  Thanks.

It turns out that, naturally, there are many new uses of prefixcmp
in the topics in flight.  I can manage, but adjusting all of them
would not look too pretty X-<.
