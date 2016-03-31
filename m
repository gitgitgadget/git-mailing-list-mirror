From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 08:49:09 -0700
Message-ID: <xmqq60w2r6kq.fsf@gitster.mtv.corp.google.com>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
	<20160331142200.GB31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:49:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aleqT-0000AG-3y
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbcCaPtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:49:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756572AbcCaPtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:49:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A22094FF60;
	Thu, 31 Mar 2016 11:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a9flHfYodlPyt4yzg6wwrIihEkU=; b=qkMTPd
	UPqV54pWCLlsnitLqYVShZmUC2pkTcXZOiHv55E+NUZMpmB+ev+c4riMZC8/XlCo
	ipMaueJrPZKM9s41Qx4Mpnali+q8Rdt+zQ/zcHU9QkwahvwmIehn6+rMjSFPRTFJ
	3o3krLZsT0+rjp9ZjZzQKpD4c+3JPabi0AwCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C6LcrdxIXZtL6lndrqNO2Az8sztIcFVR
	LmMWTETaZl07xzmZjqSHxFpH12ldcZnEle0iGGr07UuUwtWDiWuXDY2LiY1HI4gQ
	GPHkixHvLr+R0Z98BmGOAL8USe0/Pv8ZP0kP7FYUpgGprS3oFdAi7hY3hqo0ENOa
	8fTE8D6LueU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96D3B4FF5E;
	Thu, 31 Mar 2016 11:49:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0D21E4FF5A;
	Thu, 31 Mar 2016 11:49:10 -0400 (EDT)
In-Reply-To: <20160331142200.GB31116@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Mar 2016 10:22:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C6C5D74-F758-11E5-A91D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290405>

Jeff King <peff@peff.net> writes:

> But maybe we could pull this out to a separate config option, like
> "commit.defaultSignatureType", which could be either "gpg", "gpgsm", or
> "auto" to enable the behavior you have here.  Then savvy users can pick
> the type they plan to use.

Yes, I think the topic should start without "auto" guessing mode
to get the basics right; guessing mode can come after we are
comfortable with the solidness of the resulting codebase.

> And regardless of the default type for creating signatures, we'd still
> automatically verify signatures from either type.

Again, true, as long as we can tell which program to use to verify,
there is no guesswork involved, and this can and should be in the
early part of the topic.

Thanks.
