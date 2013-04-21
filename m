From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 01:48:08 -0700
Message-ID: <7vli8cuv5j.fsf@alter.siamese.dyndns.org>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	<m2fvyk8fb8.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpwV-0006js-RT
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab3DUIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:48:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab3DUIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDD013CB0;
	Sun, 21 Apr 2013 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=87PaA09Ho5jGFVH3pLN3HaMyW9E=; b=WvVM9T
	B3uXLaBE24zRls/ZoASfk6qRJ4rwPRwtB9Av/Bm50i0MLOVV7oBamokNIEvxVupe
	2VRh+8GjZoHp4gbPJDbDLDDBstTFDx8d2vrp43jFKxZCRHp/yBiQnJNHuEnloF+i
	4UhMbeOgVd0pTWVF6VTHtUPVDpW5f45xk8s2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2x54qbt3dS0kH/Ec7fMrwfVvAJiVGDI
	JlyOlydZJ2HM0zVPvE4HO+vlwuqVlSswoIY205uGsfHV8zTktJ+gvFYnpbGhoJol
	AJnAERjp7gLgZ3DkqwUdDm8krz9NGsajQkuI89MYUIR78nzJ6IPNVP4g+6gz/022
	qDrUwz64YV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C9D13CAF;
	Sun, 21 Apr 2013 08:48:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B520213CAD;
	Sun, 21 Apr 2013 08:48:09 +0000 (UTC)
In-Reply-To: <m2fvyk8fb8.fsf@igel.home> (Andreas Schwab's message of "Sun, 21
	Apr 2013 10:21:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 316F9828-AA60-11E2-88B4-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221926>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +				if [ -n "${ZSH_VERSION-}" ]; then
>> +					u="%%"
>> +				else
>> +					u="%"
>> +				fi
>
> aka u="%${ZSH_VERSION:+%}"

Do you need/want a colon there?  Even if it is empty, as long as it
is defined we would want this, no?

>
> Andreas.
