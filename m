From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Sun, 29 Jan 2012 20:34:17 -0800
Message-ID: <7v8vkperli.fsf@alter.siamese.dyndns.org>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 05:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrix5-0005XA-I0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 05:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2A3EeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 23:34:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab2A3EeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 23:34:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A64C70B1;
	Sun, 29 Jan 2012 23:34:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Q5TYNHlq27V2bOJplRRilLh9ns=; b=pzAWHu
	WtEpas6a7iZdYsoJ8UlIxM6EOuSDG+P0FJSm+LgBE1lcaaAG5EZKne14nZ21uxJn
	9UDdF3W0XipJISm/G+RhWsidaIv0odfPUOsth04reIelwtACGtyHPe1/yqlKCu05
	f2W2Q9+njaiAD77Mj2RU3A84tpBMlJAaZHQ0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BGppKcpni+bZQBZvyyKpeO72WDbjpMXU
	gs9dTup5pTahyI9KpV2dozTb4WheDnZMWC63Es9AZD+P13OIM04sY/hjpx1s5LZK
	AOBia4r2qLOqHt9y+mCgxTuZurNy7pRaHlYEe/wamnKCuMqZh5sV9XmkbLVAqi+3
	xJ4171mb4Hg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8287C70B0;
	Sun, 29 Jan 2012 23:34:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18FFE70AF; Sun, 29 Jan 2012
 23:34:19 -0500 (EST)
In-Reply-To: <1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 30 Jan 2012 01:41:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC9E4924-4AFB-11E1-8FE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189322>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Let's avoid it. This has the advantage that the code is now actually
> understandable (at least to me), while before it looked like voodoo.

I am somewhat hesitant to accept a patch to shell scripts on the basis
that the patch author does not understand the existing constructs that
are standard parts of shell idioms.

Avoiding zsh's bug that cannot use conditional assignment on the no-op
colon command (if the bug is really that; it is somewhat hard to imagine
if the bug exists only for colon command, though) *is* by itself a good
justification for this change, even though the resulting code is harder to
read for people who are used to read shell scripts.
