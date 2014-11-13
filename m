From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] approxidate: allow ISO-like dates far in the future
Date: Thu, 13 Nov 2014 13:11:46 -0800
Message-ID: <xmqqr3x6ztyl.fsf@gitster.dls.corp.google.com>
References: <20141113110325.GD8329@peff.net> <20141113110722.GB4386@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Colin Smith <colin.webdev@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:11:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1gH-000245-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934152AbaKMVLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:11:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933636AbaKMVLt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:11:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC6221D504;
	Thu, 13 Nov 2014 16:11:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lyczUyPDLY90Ua84pWSVowyuaOs=; b=M/9SO9
	BpLgY6bp83dV7mdBYLzVUsDFfPNlDQGDbcJA0Z88BisYJpqxVDm/QE3x3nkDJtEd
	NbjS/NZsFVFe4eC/TNDWrPMMxO3Z4PGEStf0dPNrE6tsCtD3CAuE7KaRS3RQLphn
	+Ja9xbJsb0iAexsxee6W3kSkbDlaPSqmi3m/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HhDskxSagu3jogH+gicMbAPNcwbMK/oj
	NNwwg51ff743XM9keva4zfWQjAAdSjdkaSTGEofuD8V9tSMH5tQYXwj8N34K4SC4
	L75bMzM4ONlxHbeeyD1DwokPuni1nqnyqWhJN9bbPX0gHgKZqhkTv2yoYrn/oWhr
	enI99/aFdCs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B40BB1D503;
	Thu, 13 Nov 2014 16:11:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FAF51D502;
	Thu, 13 Nov 2014 16:11:47 -0500 (EST)
In-Reply-To: <20141113110722.GB4386@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 06:07:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD61C38A-6B79-11E4-99C7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  		if (c != '.' &&
> -		    is_date(num3, num, num2, refuse_future, now, tm))
> +		    is_date(num3, num, num2, refuse_future, now, tm, 0))
>  			break;

Doesn't the new argument '0', which is "allow-future", look somewhat
strange when we are already passing refuse_future?
