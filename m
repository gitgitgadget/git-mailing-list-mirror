From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] config: add '--sources' option to print the source of a config value
Date: Fri, 19 Feb 2016 10:26:19 -0800
Message-ID: <xmqqd1rsd0ac.fsf@gitster.mtv.corp.google.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com,
	Johannes.Schindelin@gmx.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpl5-0000ca-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946525AbcBSS0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:26:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946084AbcBSS0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:26:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D251B4474C;
	Fri, 19 Feb 2016 13:26:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=frkJ09Ya/hxtAO0YMg06/3JC6Kw=; b=ODPqe+
	tk+ykNIUwk69JPzskQRTfjVtfNOntZ1GDPQDUCAfSkNQMf4qobKo4z3xEjvKynDy
	yoZJo5ZEImrkfscC5HpeLiljexIqWOttANH6yBXpVerELYZ5WBuT96OmpwS+m0Ao
	Z6osLhWjDQ94sIL+t6aIFBmrnXv9BPQamqdYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BsjrXR/hrIO7AsQLIvoFpTosCgrI6nFR
	JiQoBakSkUhYpHsZH1eE9pSyGzOFUzZeafdGpOWhiRe7F6WXitCN160OXC1BfVE5
	5helukSCig+u+0N4HOH3U5fSfqrLrUNW6GFT0DGUqV6aC5tC8JgsYZgG0gtOyrZG
	zhvsuK01HyQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C91B54474A;
	Fri, 19 Feb 2016 13:26:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 30F6F44749;
	Fri, 19 Feb 2016 13:26:21 -0500 (EST)
In-Reply-To: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 19 Feb 2016 10:15:58
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 465524C8-D736-11E5-AF84-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286735>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v5:
> * rename 'type' to 'origin_type' as 'type' is too broad a word in the context
>   of configuration file (Thanks to the reviewers Junio and Dscho)
> * add dedicated patch to rename git_config_from_buf to git_config_from_mem
>   (this change was part of the series since v4 as suggested by Junio but
>   hidden in the "config: add 'origin_type'" patch)
>
> Thanks,
> Lars

Overall this round looks good.

I personally prefer 'stdin' to be spelled out as '(the) standard
input' in end-user facing messages, e.g. the expected message in
this piece

    test_expect_success 'invalid stdin config' '
            echo "fatal: bad config line 1 in stdin " >expect &&

to say "line 1 in the standard input", but that is a quite minor
point and just a preference.

Thanks.

Let's queue this version and move it forward to 'next' soonish.
