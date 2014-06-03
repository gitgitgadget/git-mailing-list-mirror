From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Paper cut bug: Why isn't "git clone xxxx" recursive by default?
Date: Tue, 03 Jun 2014 12:52:25 -0700
Message-ID: <xmqqvbshwz2e.fsf@gitster.dls.corp.google.com>
References: <CAJdEhSa20ODuN4LkdvaWi0cSztgbJ+p50AYbtZs2oYWLitnjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Mara Kim <mara.kim@vanderbilt.edu>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrulB-0003Zp-57
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 21:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956AbaFCTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 15:52:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58405 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbaFCTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 15:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1204A1B3D4;
	Tue,  3 Jun 2014 15:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3leZAbEIP4VJipUsV8wyv6Wg7H4=; b=WEXO2X
	hBgW1OuK8p3GiMvxPoYMS2QDwqSYbz/yzPHhE0rRxFdz59dMdI0kocW2/1/z035X
	JuonMD1XH+2JI8RlJq6zzPgokqtbz0zZ925cwV0ixCUlrrBsFPsYS0HwOiUIMbjQ
	tXQ9xeyz2gdW8+cJV2u30jcylM8BPyg8zNsYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tpL6ykllNNeQvpvGMowaZmBr1ODi4gGp
	ZvQHpxJVj2K3DNjryLkjbHvT6RwkkV67wsZbNl0nuKdZ8NgtQ4Oro2s9q0O7Ko/+
	v1mj94pxthaF8Bcnxtqjc/WE2AKjsN3RsQHSVKH2Uubi5E2TyZoxp2zfJCTunUiv
	VJ0e48jBu8E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 076CD1B3D3;
	Tue,  3 Jun 2014 15:52:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6EFE61B3CD;
	Tue,  3 Jun 2014 15:52:27 -0400 (EDT)
In-Reply-To: <CAJdEhSa20ODuN4LkdvaWi0cSztgbJ+p50AYbtZs2oYWLitnjbA@mail.gmail.com>
	(Mara Kim's message of "Tue, 3 Jun 2014 13:11:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97062104-EB58-11E3-8CBC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250641>

Mara Kim <mara.kim@vanderbilt.edu> writes:

> Apologies if this question has been asked already, but what is the
> reasoning behind making git clone not recursive (--recursive) by
> default?

The primary reason why submodules are separate repositories is not
to require people to have everything.  Some people want recursive,
some others don't, and the world is not always "majority wins" (not
that I am saying that majority will want recursive).

Inertia, aka backward compatibility and not surprising existing
users, plays some role when deciding the default.

Also, going --recursive when the user did not want is a lot more
expensive mistake to fix than not being --recursive when the user
wanted to.
