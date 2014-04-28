From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 14:32:57 -0700
Message-ID: <xmqqfvkxnnqu.fsf@gitster.dls.corp.google.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WetAh-0004pv-WA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbaD1VdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:33:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756456AbaD1VdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 17:33:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737F781943;
	Mon, 28 Apr 2014 17:33:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkPwKQ6fBKT8H23cF7NwHLkUkuo=; b=x+TOCu
	DKtwTx5fIkU6/EBhe+P9oZdUNLLf13yIufjIWRu0BA2brnnyrdCBMMoZRe92oNft
	HxxY86ZC5Jhqd5rG58vJSpC48wXYTcrvjcP3TOKuvym+x8ewwtI0Qn+htwqdSRAk
	jq6YAqYTZsDpNjuIKH/9og3ttKt7eAxd6TscM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NyNKpotjT1QI4PW388LbwjwoqmzqYcw+
	BkGe9A0h95rGwMK39m4gNWYNK806bkomZZPypyjt5Hxkh6SU2E3kBf81G5So1nWh
	SE1uGkAeuaBXcArh3Ea8mMZUxAkNRCEQJKj5Tbs7FRvro8pHLWqFq+pPHhBmWMeH
	KJSKSyCw0SQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 544CA81942;
	Mon, 28 Apr 2014 17:33:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3903A8193F;
	Mon, 28 Apr 2014 17:32:59 -0400 (EDT)
In-Reply-To: <1398718883-5630-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Mon, 28 Apr 2014 14:01:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB629F54-CF1C-11E3-9EF8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247457>

Dave Borowitz <dborowitz@google.com> writes:

> The original implementation of CURL_CONFIG support did not match the
> original behavior of using -lcurl when CURLDIR was not set. This broke
> implementations that were lacking curl-config but did have libcurl
> installed along system libraries, such as MSysGit. In other words, the
> assumption that curl-config is always installed was incorrect.
>
> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
> to curl-config being missing), use the old behavior of falling back to
> -lcurl.
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---

Thanks. Will pick this version up.
