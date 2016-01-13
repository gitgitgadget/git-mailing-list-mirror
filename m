From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t5304: Add test for .bitmap garbage files
Date: Wed, 13 Jan 2016 12:42:28 -0800
Message-ID: <xmqqr3hlmcsr.fsf@gitster.mtv.corp.google.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
	<cover.1452704305.git.dougk.ff7@gmail.com>
	<543776a2a3e5d9f920280d06363a85f30a279d94.1452704305.git.dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, sbeller@google.com
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:42:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJSFX-0005yy-3e
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686AbcAMUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:42:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754623AbcAMUma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:42:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02FCF3BD5E;
	Wed, 13 Jan 2016 15:42:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/55ccn1pGfv9L2Zu4llK20EcUM=; b=JitGwJ
	FKOm1i3ozCZJ0OdRFFB9Pv4Kv7GIIrsi2YeRbqjpE9r9ntsjhICdF5Nx4/kmpGIF
	KSkOIoHWQ6tRCi8JYWqyHLW5dZMpsFzjQUrPvqXbFicFYU8i7c0Rwp2vXujygESc
	NEnIevPZI+WfQab/u9BLTxDoj7h6Y7deCwCHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuVR4HnX2l0ZUfkutuhoByuY4INR7ss/
	tjpOevGxX7UuSLGe7gOmaHMktp2NVXUo3V+cDy1ml9YBVs/CtnODct9WsbW9xItA
	BYDG0b/klxCMdWrEgEFz9tOezFpCvRzV0noHhogtc5c/HlQ0AiaCgiHDrVeiKQqI
	JOGSGRkGTrg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF28D3BD5B;
	Wed, 13 Jan 2016 15:42:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71BBC3BD54;
	Wed, 13 Jan 2016 15:42:29 -0500 (EST)
In-Reply-To: <543776a2a3e5d9f920280d06363a85f30a279d94.1452704305.git.dougk.ff7@gmail.com>
	(Doug Kelly's message of "Wed, 13 Jan 2016 11:07:10 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29ABF364-BA36-11E5-8AAD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283984>

Doug Kelly <dougk.ff7@gmail.com> writes:

> When checking for pack garbage, .bitmap files are now detected as
> garbage when not associated with another .pack/.idx file.

Probably the above would read better with s/are now/should now be/,
as the _expect_failure this step introduces will be corrected with 
Patch 4/4.

Also I'd suggest s/another/any/.
