From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-parallel: rename set_nonblocking to set_nonblocking_or_die
Date: Wed, 04 Nov 2015 22:14:04 -0800
Message-ID: <xmqqfv0l7z2r.fsf@gitster.mtv.corp.google.com>
References: <563A63BA.9020407@web.de>
	<1446677029-10745-1-git-send-email-sbeller@google.com>
	<1446677029-10745-2-git-send-email-sbeller@google.com>
	<563AF229.1060302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	git@vger.kernel.org, johannes.schindelin@gmx.de,
	Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDoL-00084p-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030659AbbKEGOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2015 01:14:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030377AbbKEGOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2015 01:14:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D3C41C6FE;
	Thu,  5 Nov 2015 01:14:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZEyfhoIN6v4X
	CemJKszWlhyOpbo=; b=B+HlnO8nBoDcH2SHshdtSh1EsGH8JONh50sNPVL9B9aF
	Qjp45u4JZUsyKDTTFa/j+b1vbB0Z96i0DkPRxMWYCq6mNi3ZKU2NLM9SnRzQ2foO
	eyoFGRXe46334HX3kCWPSa3MapcF/PqXX7VjC6cJwXmsv4HTvF/wSxjZ+cziJSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CQOFLP
	2RiU6aAlfHaA3o+uLa2yqEGDZ0uupfr+1U6r5rylDLi1ihw5tX77snHooQ5sh9cz
	4ShpSqH0zT5DtLD8GPc+7GeoEP9+gCqz/moFkGeJl4F3VLYuwCK4OG2SiaxyxrSS
	zOHPO0GI9eUNZb8mRixZai1t8IdAjG2jU+bZY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 648B81C6FD;
	Thu,  5 Nov 2015 01:14:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DFF2D1C6FC;
	Thu,  5 Nov 2015 01:14:05 -0500 (EST)
In-Reply-To: <563AF229.1060302@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 5 Nov 2015 07:07:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B124B52-8384-11E5-996E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280905>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> (Jumping into an old discussion, I may be off topic)

I think this is exactly the latest "I wonder" from Peff, to which I
said "well, perhaps we didn't need nonblock after all from the
beginning".

> And this work regardless if the fd blocking or not, so from that poin=
t of view,
> the set_nonblocking() is not needed at all.
>
> The major question is, if the poll() works under Windows, (and I
> haven't found time to dig further)

;-)
