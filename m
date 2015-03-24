From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Tue, 24 Mar 2015 11:00:30 -0700
Message-ID: <xmqq619q6zsx.fsf@gitster.dls.corp.google.com>
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
	<xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ22Fo5xGrk3x5+hV6WdbUg0A0h1fXgPBukenOxqyxVZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaT8G-0004Iu-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbbCXSAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 14:00:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932081AbbCXSAe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:00:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0823441DAA;
	Tue, 24 Mar 2015 14:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QPLeM86HO6R5K82x1iEiJD1YdLo=; b=mHekPh
	KowI3a0vDEWEUFX80R6h7inH8eMqtEbxMdPzcyKuwioxSjQd3GUaA9/tuFveIp6r
	kQ62oZ1cRbN2cbmI8DTQsXaodjj1ICUIkSB73ydCmNBnBZmWlMAs/HOV8fJbTzO9
	zZf/jUG2L05mETn5WeLlgcgLQ8bTKUYulOMIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQYIscFAPHD5rf/XDVQStpxyQYNMDEan
	73aFobmdX1cegJfZngOkwtH7MQ5YvJXT+GhEVNxR570Y46TcN7511T29S5fhLINx
	4eCU1i+lchvCUEArRJlmvADKMGfrUcnfjlCCx8fPmSLYCVw3umdaHkQseq2n/fLW
	KXJxKy7nt9E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3D0841DA9;
	Tue, 24 Mar 2015 14:00:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63DE241DA6;
	Tue, 24 Mar 2015 14:00:31 -0400 (EDT)
In-Reply-To: <CAGZ79kZ22Fo5xGrk3x5+hV6WdbUg0A0h1fXgPBukenOxqyxVZw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 24 Mar 2015 10:42:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A966275C-D24F-11E4-9FD7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266216>

Stefan Beller <sbeller@google.com> writes:

> So I started looking into extending the buffer size as another 'first step'
> towards the protocol version 2 again. But now I think the packed length
> limit of 64k is actually a good and useful thing to have and should be
> extended/fixed if and only if we run into serious trouble with too small
> packets later.

I tend to agree.  Too large a packet size would mean your latency
would also suck, as pkt-line interface will not give you anything
until you read the entire packet.  The new protocol should be
designed around a reasonably sized packets, using multiple packets
to carry larger payload as necessary.
