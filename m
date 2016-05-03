From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 03 May 2016 12:09:41 -0700
Message-ID: <xmqqvb2vm00a.fsf@gitster.mtv.corp.google.com>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
	<20160503190417.GD30530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	janx@linux.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 21:09:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfhi-0003uN-0G
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbcECTJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:09:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbcECTJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:09:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18255172C3;
	Tue,  3 May 2016 15:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dZn63B8jvXfKetnDT3tqMbqW46k=; b=K8HivZ
	GRtgsQymliPCRMQALx20zth1Yo8yruG5Kf4unHkb+pcwOk3QT2DV0gn77VCevObp
	lfsQYwCjGzaxCyDOlWN0MOzOsI6/Mv3c2y7gNwv9i6xrBFfiIiWvv3Lg+J9C/zC8
	oOn5ngFfhMawWK9g7vA1LO8LMbcA00uIjTcOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRD0IzybEdJTZ5doB+cv0uTWeBGlewQ8
	MaTOGhEs/NytIfen6430b3JqTiHPmijQykXjMdi225Hv7PTLxTso050HxkQ0xM64
	we7GeXcxtF+RHlJCrDQslOCCfTMh24c3Ln3mGAGdnPsILOiyu6ZkImye1R/W/Cb1
	mawB87sGwV0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10B88172C2;
	Tue,  3 May 2016 15:09:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71BC6172C1;
	Tue,  3 May 2016 15:09:43 -0400 (EDT)
In-Reply-To: <20160503190417.GD30530@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 May 2016 15:04:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97ED9EA8-1162-11E6-8AEC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293440>

Jeff King <peff@peff.net> writes:

> On Tue, May 03, 2016 at 11:54:32AM -0700, Stefan Beller wrote:
>
>> As the test runs `chmod 0` on a file, we don't want to run that test
>> as root.
>
> This somehow misses the root (no pun intended) of the issue, to me.
> Perhaps:
>
>   We `chmod 0` a file and test a case where git is unable to read it.
>   If the test is run as root, the permissions are ignored, and our
>   simulated read failure does not happen.
>
> The patch itself looks obviously correct. :)
>
> -Peff

Yup, I had exactly the same reaction.

Thanks.
