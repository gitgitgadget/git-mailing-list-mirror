From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am and mangled subject lines
Date: Mon, 24 Feb 2014 12:19:18 -0800
Message-ID: <xmqqios48drt.fsf@gitster.dls.corp.google.com>
References: <530B9D50.6020705@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1zr-0005HS-V0
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbaBXUTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:19:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbaBXUTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:19:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0B606E1A2;
	Mon, 24 Feb 2014 15:19:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULIwULVEujouEEIEJf/xCK6l8Yo=; b=MhaDkT
	vo9HvHQXEVQcKNqRFAtQ6E50YMsyW6fPK70wvEsriVanDEgYbjf5Nkfr57AU29sL
	+Dtf1IEnYTQdoY3u7exiL60GJ61fUaS8mTdF+RzDVWTAzXhlU8F+J9c1fjRFSguB
	Z5SQ1pd+hmkwniRODSvluuGTzPZvlC9jNCf8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYadGx57wqbNbFeVkqlsLN2KXAJt7yIX
	fp+MvUut9O9lGGXV/UUq0P6CdhEqUJpUlw9wBEtuc1C1qvzHZgD9511PEraRZdWk
	tvpwxmy0WdmtGxGC3J0K9oyHBg1otpPEzk/itdru7ihf+TU9MXzUAsgQbS7xkPvt
	EtkaIqZlkeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB5376E1A1;
	Mon, 24 Feb 2014 15:19:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB7BF6E19E;
	Mon, 24 Feb 2014 15:19:21 -0500 (EST)
In-Reply-To: <530B9D50.6020705@ubuntu.com> (Phillip Susi's message of "Mon, 24
	Feb 2014 14:28:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F255089C-9D90-11E3-B0F7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242639>

Phillip Susi <psusi@ubuntu.com> writes:

> git am already ignores the "[PATCH X/Y]" prefix that format-patch
> adds.  Is it possible to get it to ignore any additional prefix that a
> bug tracker mangles into the subject line?  i.e. "bug #nnnn:"?

I think applypatch-msg hook is your friend in a case like this.
