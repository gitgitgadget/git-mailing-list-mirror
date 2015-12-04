From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 04 Dec 2015 08:15:34 -0800
Message-ID: <xmqq1tb2tck9.fsf@gitster.mtv.corp.google.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
	<CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
	<xmqqegf57sfe.fsf@gitster.mtv.corp.google.com>
	<xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbtOEMk2woY5rovvC4xduiQRsKp+BXVt=5h9d76tpLWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:16:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4t1N-0005Ky-RA
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 17:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbbLDQPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 11:15:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753719AbbLDQPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 11:15:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6218D2E338;
	Fri,  4 Dec 2015 11:15:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oo5+Vejt77bvjECsS/AaHdjAWMA=; b=lMDyDv
	YODPEYW1+eJQn+Ght0+1NWVuAZcaqU8G+8moooU6qM8JNNpS7lZ07thdVSLy0MrP
	Fbs0RtFfDj5mVQvXVFppY82SE4Kya2+6DPeFzQ5uJzgalKHP+1xXGVgGMVrDMYNp
	mO0Ix7NaXuBQSNTr9LNYH7K1IR7GKsrObVYjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=seM0HFl3cQ6sUf3BFakFKH+IiY8+Fp7z
	M8BDzBBt0xVRNEi/r7AIUExzbheHnE3D6ZTbid6QtOFUznybfybwPW9lIBoc7F8Q
	w9PVpv/i4iavAJnRaQ9yfvCMMB0A9q9x9uaodauXEviPWrTTBIgEbhsEtvt718h2
	ZwwSSMbSkk0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B9112E336;
	Fri,  4 Dec 2015 11:15:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC1642E334;
	Fri,  4 Dec 2015 11:15:35 -0500 (EST)
In-Reply-To: <CAGZ79kbtOEMk2woY5rovvC4xduiQRsKp+BXVt=5h9d76tpLWSA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 3 Dec 2015 12:03:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 403401AC-9AA2-11E5-B5DC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281987>

Stefan Beller <sbeller@google.com> writes:

> Did you have any reason to pick . specifically or are we welcome to bikeshed
> why a colon might be better? (or ":", "?", "[", "\", "^", "~", SP, or TAB)
>
> We could use [id]c78f7b5ed9dc1c6edc8db06ac65860151d54fd07
> or [const]c78f7b5ed9dc1c6edc8db06ac65860151d54fd07 ?

As to the bikeshedding, I kind of like the above.

    [object:c78f7b5ed9dc1c6edc8db06ac65860151d54fd07]

would be a more natural way to use the pairwise magic characters
like [], I suspect.

Thanks.
