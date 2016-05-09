From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 09 May 2016 09:23:51 -0700
Message-ID: <xmqqeg9bxkrs.fsf@gitster.mtv.corp.google.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
	<cover.1462774709.git.johannes.schindelin@gmx.de>
	<4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 18:25:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznye-00082T-T9
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbcEIQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:23:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbcEIQXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:23:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 896EC1A759;
	Mon,  9 May 2016 12:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/KUafcap+0A6P05p2vjLConNzpY=; b=CzpyDV
	N+sK4iTLMyGM1Ckb1nAWo+jgAUzi+1rLI6OvaRYHKLDvY+o0ANyPm5W+q0fqQNan
	Ix8z+PklrGQKNjOU+4CE0xcEy72lo+Q4Oq1cIcJ+Z1GehP8ptRo5aZ7wKPGoZa6K
	uVv+t37Sip9mmyw71swvuD3X/KcSmd1XFusEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVD5ZjhcCpr7yNeXxl8L08beNKYnKFog
	Rpfw/qeyNRs7ThtsfTQxL/uWqvkUth+Po9GQMYyDWIBq9G6K5MJt6JI20vD+OekG
	ZJ8FJycleePIAY7AVZO41Ohbi/LqpOT+EIyO7CKD5rWjKkBtBVpmcmAFOAHuNub0
	CrCUmeM7QV0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F51F1A758;
	Mon,  9 May 2016 12:23:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECAA01A757;
	Mon,  9 May 2016 12:23:52 -0400 (EDT)
In-Reply-To: <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 9 May 2016 08:18:52 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B7CE2EE-1602-11E6-93D4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294010>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
> +# And as RewriteCond unfortunately lacks "not equal" matching, we use this
> +# ugly trick to fail *unless* the two headers are present.
> +RewriteCond %{HTTP:x-magic-one} =abra
> +RewriteCond %{HTTP:x-magic-two} =cadabra
> +RewriteRule ^/smart_headers/.* - [L]
> +RewriteRule ^/smart_headers/.* - [F]

Clever.  Thanks.  Will queue.
