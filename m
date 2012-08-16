From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Thu, 16 Aug 2012 14:52:45 -0700
Message-ID: <7vr4r6zeqa.fsf@alter.siamese.dyndns.org>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
 <20120703063511.GA16679@sigill.intra.peff.net>
 <CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
 <20120704064450.GA24807@sigill.intra.peff.net>
 <7v394py7r2.fsf@alter.siamese.dyndns.org>
 <20120718072753.GC12942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Katsuyama Takeharu <gkatsu.ne@gmail.com>, git@vger.kernel.org,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T27zr-0002Xq-5r
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab2HPVwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 17:52:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2HPVws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 17:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3F499A2;
	Thu, 16 Aug 2012 17:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QME625MlSsWfaekGTXDbYV4uMpw=; b=wlSHqo
	zZ4l8PwuCXuar18V3OIcTsgYAKu1NMaKzd9imkEaq6n2mSZxSTFKA0+OjFSazh0y
	u1IACxUM1gKokuumEpT5WhtJCxFy/639xaIDg/ifOXnnETM5G3Wyj6WgamTjdAVL
	L/2wrvA5XFktaKNd4o/IYX5GnhwcgxwKppUTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fRUJfsQ+WcpU4JKNcJf5dBVqYRCEbki7
	Czpyo5teN7UAjWC/z7rWnO4RbsnbORRMMUwz+pSBdFLT/39ALisHnRKe7LifeUjH
	KhSnpN6RTv4kzTxNkXKliyc0NnPc8uLArhjHUEnOHiHMNWCjhul0vLism9Ay00Fi
	xNQafD0nWao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D985399A1;
	Thu, 16 Aug 2012 17:52:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56FDA99A0; Thu, 16 Aug 2012
 17:52:47 -0400 (EDT)
In-Reply-To: <20120718072753.GC12942@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 Jul 2012 03:27:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B76F3ABE-E7EC-11E1-B0DA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 17, 2012 at 10:10:25PM -0700, Junio C Hamano wrote:
>
>> Ping on a seemingly stalled thread.
>
> Hrm. I could swear that Takeharu sent a follow-up using
> pick_one_utf8_char directly that looked OK, but now I can't seem to find
> it in the list archives. I wonder if it was off-list and I didn't
> realize it.
>
> If I did not simply dream it, can you re-post the latest patch you
> sent?

Another ping on a seemingly stalled thread.
