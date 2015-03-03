From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 03 Mar 2015 09:13:49 -0800
Message-ID: <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
	<CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<xmqqioekawmb.fsf@gitster.dls.corp.google.com>
	<20150302092136.GA30278@lanh> <20150303103351.GA4922@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:14:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSqOS-0002Ct-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 18:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbbCCRN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 12:13:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756507AbbCCRN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 12:13:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7315D3C9ED;
	Tue,  3 Mar 2015 12:13:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tc3TrIUvTB8QqgV9/Np2i/24sMo=; b=fUqOCi
	1MwWzB4BFNkRFtdYVM2//XaThoOircv/F8Lm0cc9mSED1WJtAow6p0+D/YbmBRy6
	b9RXuwGrTMjOQ0IceX08NLamG+kDmmkpkKmyJm51sPDVaGgbhZeKZEAp0cEiyKmR
	ROr1fUjArPoYvbNS2Wkvk0+qxU5k7KrqJ2lnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppX6MKWwxai3/W8w3ix+u2hPBBrm50bm
	xzBF7lklH5C2H+gMwcScYK2/gZ2QL9Uf4rmoDLOj75X9NBwgsNa7n8f3tABRt6wC
	csinVdc9zRPpFB6Ee5AjjfBI84rx1+eAYqmrxcWG/Cs65+GIJScpsPgunrYvlW4t
	NmgWpqxeDOc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ABE13C9EC;
	Tue,  3 Mar 2015 12:13:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE2433C9EB;
	Tue,  3 Mar 2015 12:13:50 -0500 (EST)
In-Reply-To: <20150303103351.GA4922@lanh> (Duy Nguyen's message of "Tue, 3 Mar
	2015 17:33:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A96A8B68-C1C8-11E4-87B3-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264671>

Duy Nguyen <pclouds@gmail.com> writes:

> Junio pointed out in private that I didn't address the packet length
> limit (64k). I thought I could get away with a new capability
> (i.e. not worry about it now) but I finally admit that was a bad
> hack. So perhaps this on top.

No, I didn't ;-) but I tend to agree that "perhaps 4GB huge packet?"
is a bad idea.

The problem I had with the version in your write-up was that it
still assumed that all capabilities must come on one packet-line.

The immediate issue that limitation in the current protocol we had
was that the usual "we can help newer programs to operate better
while getting ignored by existing programs by sending optional
information as part of the capability advert" would not work for
"upload-pack" to enumerate symrefs and their targets to help
"clone".

The lesson to draw from that experience is not "we should have an
option to use large packets".  64kB is plenty but the senders and
the receivers have a lot lower limit in practice to avoid harming
latency (I think it is like 1000 bytes before both ends agree to
switch talking over the sideband multiplexer).  It is not "we should
anticipate and design protocol better", either.  We are humans and
it is hard to predict things, especially things in the future.

The lesson we should learn is that it is important to leave us
enough wiggle room to allow us cope with such unanticipated
limitations ;-).

My recollection is that the consensus from the last time we
discussed protocol revamping was to list one capability per packet
so that packet length limit does not matter, but you may want to
check with the list archive yourself.
