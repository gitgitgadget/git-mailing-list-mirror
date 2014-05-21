From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] rebase: test ack
Date: Wed, 21 May 2014 09:54:47 -0700
Message-ID: <xmqqioozqdgo.fsf@gitster.dls.corp.google.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
	<1400447743-18513-4-git-send-email-mst@redhat.com>
	<xmqq4n0lwizh.fsf@gitster.dls.corp.google.com>
	<20140520143850.GA13099@redhat.com>
	<xmqqvbt01o14.fsf@gitster.dls.corp.google.com>
	<20140521125246.GA21476@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed May 21 18:54:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9n7-0001Ke-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 18:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbaEUQyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 12:54:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64714 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbaEUQyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 12:54:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 086E51879D;
	Wed, 21 May 2014 12:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JVs73jyyl0Jqgr9q/mW/VuRDzI=; b=fNPnAp
	Zxf4WEn4BLf1KEMI/vFdxFQpdpIXQZKwkoIgQdDf+jyQ/aGBGhCP+BFqRX8TfSiv
	pfC5o1bH5j9f5+iqXJG4mDmIGbNwVMLxLr/mBpjlexRZ8QDarAZdwUks5HWimvCg
	/l3vwZVQZENl/FJCrGV115p6ZTk/ncq0zdQAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=piXQg7+jtURVq4P9HGjZCgEPM+zTi7vp
	YPA7DRYev+MV0UtYROplEs7/NG8us9SkGtB1eQzyT7oBw0xeVP2xAPdSZndCyE5h
	bC8fl07NuKkZsnmpyyXDTZF9umrjz0rEbYUIK5is3OdRd10Fvez3fHyctOKGUMtJ
	6+Y0sttHbVw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFE4C1879C;
	Wed, 21 May 2014 12:54:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD4C71879A;
	Wed, 21 May 2014 12:54:48 -0400 (EDT)
In-Reply-To: <20140521125246.GA21476@redhat.com> (Michael S. Tsirkin's message
	of "Wed, 21 May 2014 15:52:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E95F598-E108-11E3-AA56-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249806>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, May 20, 2014 at 08:13:27AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Just to clarify I can post v2 of 4/4 without reposting 1-3 since they
>> > are queued?
>> 
>> If you need to update anything queued only on 'pu' but not yet in
>> 'next', it is customary to resend the whole for everybody to see
>> (what is already in 'next' should only be built upon incrementally
>> and not updated with replacement patches), while noting which ones
>> are the same as before.  Christian Couder has been doing it nicely
>> in his recent rerolls (if the series were not in 'next', that is).
>> 
>> Thanks.
>
> Actually I don't see anything like it in pu.

The way I usually work is to apply a non-fix (i.e. enhancement)
series on a topic branch forked from 'master' (or the last tagged
version contained in its tip) and see if it makes sense, and then
try-merge the result to 'next' to see if it is free of potential
funny interactions with other topics that are already in flight.
After that happens, the topic branch is merged to somewhere in 'pu'.

It is possible that I did not have time to go through all the steps
above (after all, I had to make another -rc release and there was an
unexpected last-minute change of plans in the morning that blew a
few hours of work).  Or there may have been some merge conflicts
that I didn't feel like resolving for various reasons (e.g. if I
knew the series would be rerolled anyway, it can wait; if the other
topic that interacts with your series has been cooking sufficiently
long in 'next' and if it is very close to the final release of this
cycle, it may be easier to wait for the other topic to graduate to
'master', which would happen soon after this cycle finishes, and ask
you to rebase your series).

I don't remember which ;-)
