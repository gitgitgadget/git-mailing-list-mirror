From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] mingw: let's use gettext with MSYS2
Date: Mon, 25 Jan 2016 10:53:24 -0800
Message-ID: <xmqq8u3dh4nv.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<7162dcb55e6a317cba840ef1176d09d99fc37f6b.1453650173.git.johannes.schindelin@gmx.de>
	<xmqqio2ibfkn.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601251714380.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:53:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmGe-0006GU-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 19:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbcAYSxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 13:53:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757587AbcAYSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 13:53:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADF043E66A;
	Mon, 25 Jan 2016 13:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IN/a6g09gA1qsGC+cXaJOcIEKok=; b=Mr6b17
	8jm1gQsXnBXjA0+H/aESIZPYEkdpaBR50Ih/A4vhI9n2Oneq8vxrHV+f9gpcIJBM
	8NzhlGcQx7Vt6XIoisrOww58/unDQ9iZkyX5WbA1uPIKPrtIPAP+rItKOLPUOUGZ
	MKX2VXcv73mtTQXkjUrTt60lZcTJBsAIc0ilQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bBibu0PFOMrMwJ4ywvjp5kcysRxypuMj
	2WyzhP4HevgDsCuc+vmq1Mv12JhgWoaa+B+cjLLSdOppuiv/6kwlvJdwlzvbad9y
	wVj/wl/xN4UKRNQvB8ju5kyOpbQ0UmP+gPfB2LO9h6KGm4K/MKU9gWGrJyOjGau5
	RYv07xyN7oU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A44463E669;
	Mon, 25 Jan 2016 13:53:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B4AE3E667;
	Mon, 25 Jan 2016 13:53:26 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601251714380.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 25 Jan 2016 17:16:48 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA7C1F12-C394-11E5-8356-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284745>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > - we sidestep the infamous "BUG: your vsnprintf is broken (returned -1)"
>> >   message when running "git init" (which otherwise prevents the entire
>> >   test suite from running)
>> 
>> It is unclear to me how gettext is related to use of vsnprintf().
>
> Including libintl.h overrides vsnprintf() with the libintl_vsnprintf()
> drop-in replacement that does return the expected value.

Ah, that makes sense.

>
> I updated the commit message (will be part of v2):
>
> 	https://github.com/dscho/git/commit/4473801e

Thanks.
