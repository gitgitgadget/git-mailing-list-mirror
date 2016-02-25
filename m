From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv17 01/11] submodule-config: keep update strategy around
Date: Thu, 25 Feb 2016 10:06:36 -0800
Message-ID: <xmqqwppsoeab.fsf@gitster.mtv.corp.google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
	<1456369618-18127-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:06:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ0JN-0006Yy-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 19:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbcBYSGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 13:06:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932381AbcBYSGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 13:06:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B20C2462B9;
	Thu, 25 Feb 2016 13:06:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4yCmAyPi4rNlL/Lu/GWC5ob2ryo=; b=XVdnSy
	BwYK69m54+hJlLhl6dj61eMOj8v8JGCYoq8GDFTxNveHyeg9wL2cowuY1UnxPYIu
	Uh15is7+fcBLlnvUhwrJR8er5CpmDp2iQSRt5I3hVWb06EFHQqmvT6N3nLW8sJ5I
	bdxj8UMzT4nJtHgymfPpUVsD/37ktg5FPSSOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pg31mkCGmkf2Ws30byeqqjUzMYeWeHEo
	M3pq2p9GPnFHov1ANXyy8uUuGN4wwliro9cNr7FONOv19SJC3oB0AaCHNJw072Gx
	3slONJn8I+qm+s8EMTeCcq3eQkmB8HHPDV16WYGtlwcBKdoKiVAFIPagGEjwNJoi
	KU9o+REFlzs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9AAA462B8;
	Thu, 25 Feb 2016 13:06:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0FFAC462B6;
	Thu, 25 Feb 2016 13:06:38 -0500 (EST)
In-Reply-To: <1456369618-18127-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 24 Feb 2016 19:06:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 839BB0E6-DBEA-11E5-B221-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287409>

Stefan Beller <sbeller@google.com> writes:

> +int parse_submodule_update_strategy(const char *value,
> +		struct submodule_update_strategy *dst)
> +{
> +	free((void*)dst->command);

	free((void *)dst->command);

"git tbdiff" is quite handy; it didn't spot any other lossage of
local tweak that was in 'pu', which is good.

Thanks, will replace.
