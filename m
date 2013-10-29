From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] use @@PERL@@ in built scripts
Date: Tue, 29 Oct 2013 12:41:58 -0700
Message-ID: <xmqqeh73euex.fsf@gitster.dls.corp.google.com>
References: <20131029011859.GA22140@sigill.intra.peff.net>
	<20131029011959.GA27738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbFB9-000343-2O
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab3J2TmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 15:42:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab3J2TmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 15:42:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1D084DA6F;
	Tue, 29 Oct 2013 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyXCHB63QjMFQd+yCYq2ygoYQcc=; b=JnUidp
	wz3YkyylIxS3u6ufQX9MYS7G5Hk9ppQdO0T38Rwa7B6o+zWL03l2B0ueobSI7R3f
	RFDKNOxWe4PyZ9oFcVgnDgMZwCgSNMKj9VxUT8rbHPHa+W6HJsUGjesbie2sqtLG
	4TOw90eJad/ZWxqzk8/c2nTS+a7Vx2UJb8iI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0Nh44ngnUKK6tcLAY4o3MWgPJXBs5+F
	kaBBJTVaHnQtnWXkoNPjKHa1nXS5DbQeISkPn5tZLgNrMvweK+wg+LT/xVpuemts
	mlH8obHACpparjrn3aOZ0OMpDK0iq+ZLEO7ENJYrv3fK2cP+8kNAUq7MVVZhYRAG
	FQ9Xuyli8AM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEECD4DA6E;
	Tue, 29 Oct 2013 19:42:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F8044DA67;
	Tue, 29 Oct 2013 19:42:07 +0000 (UTC)
In-Reply-To: <20131029011959.GA27738@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Oct 2013 21:19:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31A3D378-40D2-11E3-AC66-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236944>

Jeff King <peff@peff.net> writes:

> Several of the built shell commands invoke a bare "perl" to
> perform some one-liners. This will use the first perl in the
> PATH rather than the one specified by the user's SHELL_PATH.
> We are not asking these perl invocations to do anything
> exotic, so typically any old system perl will do; however,
> in some cases the system perl may have unexpected behavior
> (e.g., by handling line endings differently). We should err
> on the side of using the perl the user pointed us to.

Thanks; this makes sense.
