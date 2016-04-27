From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/29] ref_transaction_commit(): remove local variable n
Date: Wed, 27 Apr 2016 13:45:53 -0700
Message-ID: <xmqqd1pa93we.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<9c31a016aa893e4a3748e31ee3fd48562f63a7a7.1461768689.git.mhagger@alum.mit.edu>
	<xmqqeg9qape3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWLQ-0007c8-TX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbcD0Up5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:45:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752280AbcD0Up4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:45:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BE671645C;
	Wed, 27 Apr 2016 16:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8dhwO6pR8OFvEiUrdlBQ+TkTXI=; b=CHF/vy
	cVHoHqvNFGYs3+XqFbFLsugqwq8y424DSFuvka/5RgTmGpK4U7g5ibmm4RDvyz1o
	PoifxhhmmUa+ZJM2gpDXJKCjZ6HUjnQ+F/NHUP8y0aup/dFDgT0WkQZLrxoEO9vE
	hBJ/WFG5aExKZxfsO/qjAsnK76AFS1BVZp94w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQ54O6JziEWwNWtRmS44gPcG+0K5uHfK
	YX26qzm3RWkqXCv+UJDnnzD+mO8f8i9gy08BhRTcIDpGnHQWk1U85eRN9IbI/xoa
	ojG8BY1QxcDuOs0eS3XAUT1GP7C1LbL3qyxsyEkYV/r1cJVAB6gTcc/wCsQtCCZt
	oP06PxzfCpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 325201645B;
	Wed, 27 Apr 2016 16:45:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90A4B1645A;
	Wed, 27 Apr 2016 16:45:54 -0400 (EDT)
In-Reply-To: <xmqqeg9qape3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Apr 2016 11:16:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 094F8F88-0CB9-11E6-8155-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292822>

Junio C Hamano <gitster@pobox.com> writes:

> I expect that somewhere in this series transaction->nr will not stay

s/series/& it is documented that/

> constant even if the client code of ref-transaction API makes no
> direct call that adds a new update[] element, though, even if it is
> not done in this patch.
>
> Thanks.
