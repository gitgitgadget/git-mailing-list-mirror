From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Introduce an internal API to interact with the fsck machinery
Date: Wed, 10 Dec 2014 10:34:07 -0800
Message-ID: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xym6z-0006Kl-L0
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbaLJSfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:35:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932564AbaLJSfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:35:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 185F522FEC;
	Wed, 10 Dec 2014 13:35:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xjRJsPwqm174VLobTN7JK3cxBzM=; b=pUz97A
	F8f3ZYhHKwRtIxCVq2nT2pVPa9CsWcF7ZmP8NWcRnir4H/F4XDGrQKq2Puc/WSxW
	QaAiMSaRfHZ5CLTYBzRJlRdEXjQJXch08YEQ9S4awEiXEA7QVCuMHx9z0dXIcyFT
	KqpfMKkJjsDFa/yneI4ZlvWqzsTDBx4q4nQqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KazFYXaoD5JrR1p/wVaeGeK/nkAY2RVK
	vfeB6U4aZ0VrtTr3KGQBwFQoDO369OG3MxCmddw6SZSq+L5sH1Vy+sXGUVo1bS+w
	11SeDSzKPBrCE2yi0VQPTklwQ2t0hU5+44vvUqMjuUVgbL7RiT87pXFObtAUwUwJ
	FVHH7M/BoxU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DDE722FE9;
	Wed, 10 Dec 2014 13:35:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E09222FAA;
	Wed, 10 Dec 2014 13:34:09 -0500 (EST)
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Mon, 8 Dec 2014 17:13:55 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 211FC9A8-809B-11E4-AED2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261236>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> At the moment, the git-fsck's integrity checks are targeted toward the
> end user, i.e. the error messages are really just messages, intended for
> human consumption.
>
> Under certain circumstances, some of those errors should be allowed to
> be turned into mere warnings, though, because the cost of fixing the
> issues might well be larger than the cost of carrying those flawed
> objects.

Overall I very much like what this series aims to do.
Thanks for working on this.
