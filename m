From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Thu, 12 May 2016 12:04:10 -0700
Message-ID: <xmqqr3d7f68l.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<5734B805.8020504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu May 12 21:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vuE-0004bN-LG
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbcELTEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:04:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752441AbcELTEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:04:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5644B1A47A;
	Thu, 12 May 2016 15:04:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLFVOqNtYOBrR6LG7z9khNM8gus=; b=INUZA0
	w+CRq8did41XamgmEX0TW4DxTxLzNjpIiMQx99qk+7FzUiY8qD306+/eOUN/uUGS
	C2EmbvK46sv0VkY5CiF4SGXgEuLetrv/LRoY7vOXKyKg28XfeBYVO9lkCF0ZxFtd
	eNiCveVa0B0Mx+ygU3WX/QsZElyX5ZurRb91k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9E/tbZ+B8pEtaMRCGSJ7DaXlDLqaI3h
	sw7no3gVP4UY0hpSH5Xy82moMxUl8hBWOtudmcwPxXdXE0OF+kzt9ku+SY+QQR5K
	NSCaCfQvbvWbS6zO6C85rMIelfmQMweHDNu0YkBQHP7KWsjfoZW3aYgu7Y1ET0X2
	ANARM/EzcCo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DA2C1A479;
	Thu, 12 May 2016 15:04:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C64491A478;
	Thu, 12 May 2016 15:04:11 -0400 (EDT)
In-Reply-To: <5734B805.8020504@kdbg.org> (Johannes Sixt's message of "Thu, 12
	May 2016 19:06:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5001EDB0-1874-11E6-B591-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294427>

Johannes Sixt <j6t@kdbg.org> writes:

> I'll also use it in production for a while, although I am not a git-am
> consumer nor do I use git-rebase without -i, hence, my tests will
> probably only show that there is no bad fall-out.

It will probably only show that you do not use the part that was
touched by the series ;-)

As Christian said in 00/94, this probably needs to go in steps, as I
do not think anybody wants to review fouteen rounds of 90+ patch
series.  I thought the early 40+ patches in the series were at least
cursory reviewed already?
