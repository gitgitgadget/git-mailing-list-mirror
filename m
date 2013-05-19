From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 23:10:30 -0700
Message-ID: <7vip2f1ovd.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
	<E74470E4201142788D36127322130401@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, "Jens Lehmann" <Jens.Lehmann@web.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun May 19 08:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdwpQ-0007Va-Gz
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 08:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3ESGKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 02:10:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab3ESGKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 02:10:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D2791C2E0;
	Sun, 19 May 2013 06:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSQHUuoZpmKK3nkKKUR3LnzSRjU=; b=tbKZgK
	DJXy2EJN9SUMSqE/YiNYl02SwLYy+4AoZeYN7q9sLqXeBQk83h/+/UEpK8/QrBoS
	O3c78xeuKPVs0UmDjaVzMcPLN8JRAgfWSvBd84W2fLjPlKRNhp3rv+66wwZZeg+M
	ooskeQJFr1kECdnsHd89+aRDdLrCbdG9hLwK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHnQ3SRaJL2AO9JQ/MwcQuZUhD18uSM4
	VqKGV/OE7Aa0Qb2WODo5dUwIb/gYVHyfpCwSJVLtH4SUiCoZvKZcroievw7GBQlQ
	Tme8yb6MvBThrNgt9OaI4EQIqALuhcSjYFmfrBhCo6+kZbWZoE8KFG8b8pjkdmw5
	24dV2UGK/CI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C4F1C2DD;
	Sun, 19 May 2013 06:10:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BCC1C2DC;
	Sun, 19 May 2013 06:10:32 +0000 (UTC)
In-Reply-To: <E74470E4201142788D36127322130401@PhilipOakley> (Philip Oakley's
	message of "Sat, 18 May 2013 14:12:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D00A4EE2-C04A-11E2-8E20-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224819>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Friday, May 17, 2013 7:30 PM
> Subject: Re: [PATCH 1/3] fetch: add --allow-local option
>
> [...]
>
>> So when "the user" is running "git fetch" on "mywork" branch that
>> happens to be forked from a local "master", i.e. her configuration
>> is set as
>>
>> [branch "mywork"]
>>        remote = .
>>                merge = refs/heads/master
>>
>
> Was the '.' example illustrative rather than exact. 

It is exactly spelled like so.  Just like '.' in the filesystem
refers to our current directory, a dot-repository used there refers
to our local repository.  "Git is distributed and no repository is
special" principle extends to our own local repository in that you
can use it just like you can use anybody else's repository as the
source of fetch or the destination of push.
