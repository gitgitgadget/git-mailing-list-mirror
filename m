From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 14:57:43 -0700
Message-ID: <xmqq1t73lciw.fsf@gitster.mtv.corp.google.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	<20160321205043.GA436@sigill.intra.peff.net>
	<CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
	<CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Adam <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:58:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7pl-0001uS-Up
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbcCUV5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:57:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886AbcCUV5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:57:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22C294F22A;
	Mon, 21 Mar 2016 17:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SY+cKt5b8tvlDJFp2N417O3GCkM=; b=VWOOro
	/8u1TlEq0yq4sqnLre24LBdJoqAgkST7ZqJUPbgmZL3dPF7R3oSf+o79uChuiX9R
	sGITRNEfxoyaW7eZimGQuN/1NQUaqR5Py7Ncf1Z4lOUBZmgy4QIKnRdlnGUWtHNK
	kNigloBDrzRnQyREKRRkS4nAxxspO/bxJrC4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s9PvPZXUmZUpNT69r+aXKmw3khpKApvY
	u8ip6d2ENOluU7+K5CzZ/Mh1GuuGkBI9GFtR4LxN9RInW58Tjqggc1wRpJU6m+qK
	gyc7stiL+CTOpbMFooz22gtW/vlJo64OJI2GKAXJXwgbMQI5AOvwTNeQb/jzMm4g
	2kIw/lneC7U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A3354F229;
	Mon, 21 Mar 2016 17:57:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9309B4F228;
	Mon, 21 Mar 2016 17:57:44 -0400 (EDT)
In-Reply-To: <CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 21 Mar 2016 14:50:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0FE51BA-EFAF-11E5-A3E1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289468>

Stefan Beller <sbeller@google.com> writes:

>> "branch-X is uptodate with origin/branch-X (as of DD-MM-YY HH:MM:SS)"
>
> Actually I like that feature of recording the last known time we fetched,
> I would have found that information useful in the past a few times. (unrelated
> to this exact message, but if we were to make this change, we would
> need to record
> the time somewhere, and that's what I would have wanted)

Like in reflog for refs/remotes/origin/branch-X?
