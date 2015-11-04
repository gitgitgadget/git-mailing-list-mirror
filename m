From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 00/11] Expose the submodule parallelism to the user
Date: Wed, 04 Nov 2015 10:17:50 -0800
Message-ID: <xmqq8u6dbpdd.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<xmqqk2pxbqft.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZhgVThVrR-gOZj3zaicG43JNgv1FTxk2S5mr__7YB5Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu2dD-0005Xx-Sd
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 19:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229AbbKDSRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 13:17:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756008AbbKDSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 13:17:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4C40274D7;
	Wed,  4 Nov 2015 13:17:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ePxQOzj4AgHhI+MOH2glX5YVkzs=; b=cd9qNq
	QXluWNu44V9BUQlv7OWr73EnxM5IVd5buxojQQqNkln80omeWi91N61miieBhvI9
	Hy4VsW7fncOOwjhs5Tc6VhoKHwfAxgwqtxFuZBjOy9SoV6jHNvE/+NstcPKV8zbd
	O3L5MYj+dTqDdaC0oy8aSUyGkL8LFgAOTllPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o/NXSdrUvO4r78sPz469hMY3g/v7jZQO
	o2loFZRQUxnox/Jj5nzd4WkaWnfg0SDT7jdEMP2w6XKi7vgTVVtkEHzN58zRHITv
	v4gQTQpvFwcGHEGf5J+rhOeN6i8fBI2lMLSt8UHX3odrcBCeYimuwJRl1eSQ/DRo
	V3DXzeJvRqs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB2B6274D6;
	Wed,  4 Nov 2015 13:17:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FC35274D3;
	Wed,  4 Nov 2015 13:17:51 -0500 (EST)
In-Reply-To: <CAGZ79kZhgVThVrR-gOZj3zaicG43JNgv1FTxk2S5mr__7YB5Yg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 Nov 2015 10:08:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C250062-8320-11E5-AEE4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280864>

Stefan Beller <sbeller@google.com> writes:

> So you are saying that reading the Windows cleanup patch
> before the s/deinit/clear/ Patch by Rene makes it way easier to understand?

No.

The run-parallel API added in parallel-fetch that needs to be fixed
up (because the topic is in 'next', my bad merging prematurely) with
a separate "oops that was not friendly to Windows" is the primary
concern I have for those who later want to learn how it was designed
by going through "log --reverse -p".
