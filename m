From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 14:13:38 -0700
Message-ID: <xmqqppk1non1.fsf@gitster.dls.corp.google.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com>
	<xmqqtx9dp6rd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:13:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wesrz-0005v2-9c
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbaD1VNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757237AbaD1VNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 17:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D1F813B5;
	Mon, 28 Apr 2014 17:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R26uPiYRelimxHJRh+Md44vK+0g=; b=jA/wqG
	Els5ZOxEzqoSgElX+X4xwbBbOReiMH0XKUlnnrsCHwkHnW7soWys2S5SiP9IZJhw
	/XnoiLuUsMH7bxrYTGSW1RWcnihHcIlnVYyTgR7/Gzrvy/ze9P113SBjkwF7Wt/L
	2CDJIuezrCMBhxyYERgj5ss0sBW8rCht6UXmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRkPjwF53GVwVXjwW1++ksszc/S8oyEe
	fxtk3a9ugH4P7Tzt+B6pDxcRNT4k3a/eTod4gIR3A4o+4Jv8MAW4NsbRo4WO7fzI
	tZnLP0WyvVy0G2mMlMiLM5vv5cqDPNnb7zWx/nNUZT2zj2opv3ISj0esHtRFAQdv
	ZdLgt2MkQqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C21C1813B4;
	Mon, 28 Apr 2014 17:13:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9AB6813B2;
	Mon, 28 Apr 2014 17:13:39 -0400 (EDT)
In-Reply-To: <xmqqtx9dp6rd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Apr 2014 12:56:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F83F4B0E-CF19-11E3-90AA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247453>

Junio C Hamano <gitster@pobox.com> writes:

> This "ifeq" is redundant and will never set CURL_LIBCURL to empty
> without running the "else" part, I think.  In a Makefile, a variable
> explicitly set to empty and a variable that is unset are treated the
> same....
> 	$ make -f Makefile CURL_CONFIG=""
> 	Empty Undefined

Oh, I was blind.  Please ignore this noise.

Thanks.
