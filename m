From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Thu, 09 Oct 2014 13:12:08 -0700
Message-ID: <xmqqsiix57fr.fsf@gitster.dls.corp.google.com>
References: <5430427A.5080800@web.de>
	<xmqqd2a3g2mf.fsf@gitster.dls.corp.google.com>
	<5436EAB5.2070809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcK4N-0001fZ-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 22:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbaJIUMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 16:12:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbaJIUML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 16:12:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B591F13CE0;
	Thu,  9 Oct 2014 16:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ae6lViECE+1F
	zmxpG+zXTt0b0CQ=; b=tN+T/DRZFychJ8twunF1upPXR2wfkbkBSxKPXkuShbAt
	yipOgDEM3A8+OyT5MkqtZyqQBgGSgjAohTIleBDP2MacUHVNawrbw41e8wmp5rcF
	nDfiWadorvjt2vQN2TmqF1Be3g+y3Kw+pckE5fXeJELQ2EgVu5NC3iJmOcWkQeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dX4D5H
	w3EdkAcMOtN+Zl/x9uh00D1MhKSHaCsR1aeRGhOwNSwfMyk6NomqyAdbGabFMPR4
	VlYOuTsAmpb2E9ITnlEOQHzrWh4hCn/cBunMMvLtO9fTi0YT0pJsBweOnHSJnR+5
	pjJWM5Sro+vfvByNauQw+xCvXw6+A7JQI9Y4g=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA32313CDF;
	Thu,  9 Oct 2014 16:12:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A26113CDE;
	Thu,  9 Oct 2014 16:12:09 -0400 (EDT)
In-Reply-To: <5436EAB5.2070809@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Thu, 09
	Oct 2014 22:06:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C422590-4FF0-11E4-AC5D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I didn't think much about the performance implications.  skip_prefix(=
)
> doesn't call strlen(3), though.

Ah, OK.

> The code handles millions of ref strings per second before and after
> the change, and with the change it's faster.  I hope the results are
> reproducible and make it easier to say goodbye to pfxlen. :)

;-)
