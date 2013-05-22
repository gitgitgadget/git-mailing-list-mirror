From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Wed, 22 May 2013 10:39:49 -0700
Message-ID: <7vd2sikj6i.fsf@alter.siamese.dyndns.org>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
	<7vvc6r4855.fsf@alter.siamese.dyndns.org>
	<7vfvxu3ivc.fsf@alter.siamese.dyndns.org>
	<CAJELnLEOg+D+baAddJvDiYM=ej8PKsgi2MWH25enOijXa+bO_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 19:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfD13-0003Mp-4K
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 19:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab3EVRjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 13:39:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3EVRjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 13:39:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C53217BE;
	Wed, 22 May 2013 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gxf0plXk358Pv8FjPOIYJMK+Vmc=; b=Vtt6wO
	p/AoOkC2jRqPwDIiZ7eWzZh/aQJ7EEl1gr1e+MsqExuVQgAfo19z8qjpIMyXqN+j
	2hK4F16b4o8jdX0xhSS8j0JbzH222eCrRm8h5DilghSE3Q62CmR4zt9ua06pbo6+
	uN6aO0CsbU+q7zMwkfBUBkesONqZBlZfLZmRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=focD35MvQhOrHVJnTJWLQcVXiMhRd/1o
	31yjoxTVWtZgPU4o3gwr8YviePrfeH8CDvhpcHY7k7zmpjY9+N2W3MM1wmmJvQlc
	TfxK9LHShF2y0Qfzpk2oS9zfhHaFjE0RhvP7lolFE78u02Y8FO66eLniijbZI9Ur
	Tk/4SbBI05E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFAA217BD;
	Wed, 22 May 2013 17:39:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45769217BB;
	Wed, 22 May 2013 17:39:51 +0000 (UTC)
In-Reply-To: <CAJELnLEOg+D+baAddJvDiYM=ej8PKsgi2MWH25enOijXa+bO_Q@mail.gmail.com>
	(Matt McClure's message of "Wed, 22 May 2013 09:25:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B0B0876-C306-11E2-A6F8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225179>

Matt McClure <matthewlmcclure@gmail.com> writes:

> On Fri, May 10, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think what I missed is that the same logic to ignore side branches
>> whose history gets cauterised with such an "ours" merge may apply to
>> an "ours" merge that people already make, but the latter may want to
>> take both histories into account.
>>
>> So I guess it is not such a great idea.
>
> The particular proposed implementation? Or the broader idea to save
> loose commits more permanently? I'm still interested in a solution for
> the latter.

Recording such an "otherwise should not be recorded as a merge" side
history as if it were "-s ours" merge is what I judged as "not a
great idea".

If you want to keep older commits, either you make sure you point at
them with some refs, or not prune the repository.  I do not think of
any other solution offhand.
