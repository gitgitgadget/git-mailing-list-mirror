From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t3404 incremental improvements
Date: Thu, 22 Aug 2013 12:02:24 -0700
Message-ID: <xmqqtxihr1kv.fsf@gitster.dls.corp.google.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk3jesk2a.fsf@gitster.dls.corp.google.com>
	<CAPig+cRM_j7KOKG+YS1aTqz7suDY5LC7kh5-oP5H-GAenUqq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 21:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCa9R-0007Cc-IV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 21:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab3HVTC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 15:02:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab3HVTC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 15:02:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D41F3A0AB;
	Thu, 22 Aug 2013 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/H3KvMJQEH79IyCQsmFKWT4np24=; b=iUb329
	2NbQZP1BAbynpLJ0JuNbp7DiOBgmA17GjuU1pYfac45ErGWbFxhVj9zsZuREXLcG
	uhLZm9udTlDBDKGkLK3dpzHatIBhxgg8qtkllYGAA7dvd7MJGihY8QOyw9gwvCjR
	kuy4GCntvPrkSQeHp8XG2WfE9PFB6dS9hObz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kEBy8WkPvvml8ruB2b+WmC8P7PEnZJcI
	nhl2h8QS46SekMcMu99hHgXwbQsE+TC9qdeFmU+dqZic87T2+P3Ej6scg6MiqetW
	P6MzOu0JdaildmQstgkapo4n/Gu+e6/kCktEK8WO2h3i4n63cuVlXGhovXSJ5293
	rU5aoTv0dzE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327A23A0AA;
	Thu, 22 Aug 2013 19:02:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8ADFC3A0A7;
	Thu, 22 Aug 2013 19:02:27 +0000 (UTC)
In-Reply-To: <CAPig+cRM_j7KOKG+YS1aTqz7suDY5LC7kh5-oP5H-GAenUqq-w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 Aug 2013 14:17:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6338F09E-0B5D-11E3-BEFB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232771>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Aug 21, 2013 at 7:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> This set of patches was meant to be a re-roll of [1] addressing Junio's
>>> comments, however [1] graduated to 'next' before I found time to work on
>>> it further, so these are instead incremental patches atop 'next'.
>>
>> Just FYI, 'next' will be rewound once the upcoming release is done,
>> so we have a chance to rewind and squash.
>
> How would we go about this? Is there something I can do to streamline
> the squashing?
>
> Unfortunately, the various fix-up patches do not have a one-to-one
> correspondence to the original three patches in 'next'.

The most stream-lined way would be to send a replacement series
early next week, by which time hopefully the 1.8.4 final is out; as
long as the end-results of applying the series are the same, we know
that the new code we will be using is the same as the code already
in 'next' that people have been testing.

That way, there is no risk of me screwing up while trying to wiggle
the existing patches and ending up with a split that do not match a
logical progression of the series you would expect to see.
