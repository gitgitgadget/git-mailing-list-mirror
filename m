From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch --in-reply-to allows header injection. Intended?
Date: Thu, 04 Sep 2014 14:36:09 -0700
Message-ID: <xmqqppfbqd9x.fsf@gitster.dls.corp.google.com>
References: <5408D7ED.9010203@nh2.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, petr.mvd@gmail.com
To: Niklas =?utf-8?Q?Hamb=C3=BCchen?= <mail@nh2.me>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:36:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPehV-0002HM-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbaIDVgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 17:36:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62459 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbaIDVgN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 17:36:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C59C538FB2;
	Thu,  4 Sep 2014 17:36:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NzXvblqcKaCD
	fPp2Aaok5KFjdyQ=; b=jOcjcOhf+5KGKKZPPfhPxyKqCwdZ4k+eOPPb4KO0l6NF
	akDNGmpKKk9rJseuL2uvXzeDN4pNw39XE7Hl+pJRLUFUgLEooL3qG7jQwtuLv90A
	mB5ZBOBiCMQjpnJMDTz6Wk3OSeZQfZMY7TW0W8xYHGO/x36zjq8PFFLUzq+WanY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LgmKMM
	X/p3e0QK2Ens1mAyhmA/KnlGUT+Tc62EpxOcneysV/fm+IyfXiysn9tC2nVZl5D1
	+AwzV1ZetB120bY+l7d+silp4yqn7QIQYCF91ciiHs5YFks12cjoRSmdat+KQGXX
	ZWLg3kHasxuOY3exxaWuAZOlGS4ZWanN3Sui0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8680238FB1;
	Thu,  4 Sep 2014 17:36:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D54C538FAF;
	Thu,  4 Sep 2014 17:36:11 -0400 (EDT)
In-Reply-To: <5408D7ED.9010203@nh2.me> ("Niklas =?utf-8?Q?Hamb=C3=BCchen?=
 =?utf-8?Q?=22's?= message of "Thu,
	04 Sep 2014 23:21:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D7BF7A6-347B-11E4-B6CF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256485>

Niklas Hamb=C3=BCchen <mail@nh2.me> writes:

> For example, if you pass "--in-reply-to=3D<msgid>\nTo: <other@example=
=2Ecom"
> (notice lack of trailing `>`), then the generated email will actually
> contain a
>   To: <other@example.com>
> header.

While I do not think of a reason to specify such a string to the
in-reply-to option (I'd rather edit the output in the editor if I
wanted to do anything fancy [*1*]), I do not think there is a reason
why you want to add a code to forbid such use, either.


[Footnote]

*1* For that matter, --in-reply-to option itself is superfluous.
