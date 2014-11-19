From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Wed, 19 Nov 2014 13:41:18 -0800
Message-ID: <xmqqfvderhq9.fsf@gitster.dls.corp.google.com>
References: <20141119013532.GA861@peff.net> <20141119013739.GC2135@peff.net>
	<20141119020009.GR6527@google.com> <20141119020451.GA2734@peff.net>
	<20141119020713.GT6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	sahlberg@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrD0F-0000iS-JD
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbaKSVlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:41:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757301AbaKSVlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:41:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0677D1EDA7;
	Wed, 19 Nov 2014 16:41:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+WPiA1RY0Y6F7sEz89HvD6g6MyE=; b=axAmmx
	WSo8G5X1Zo7QM8+ZElqoxLQku6HZATYPSkNH1R4hAnUA8DtYjcOP40svJTZQNn7b
	UpZeI25dJS6Kl66mErkZ+kGQU106i4N+DeBFjWVqDcmjTlPnUtrZE+gzQJ1YPl7I
	0oPyANh1lqP1MknHp0Txh/XcOoK8SOBs5oszw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXXN4Iu5bP6MFqhalu0j+nNNVlxPKX29
	Y+aav5XNNkgvYeKvw/3ir9Ep+s8tRYFQnC+Zdr+PocuSwSPRUgcrYGr3pRMTss7V
	fYg707sUZB+BTMptiXCsxuNWDnQ6T4xIP2YWzAWE65SSPn4xmIumFQgSUxF3M0SJ
	6u0KCVEg4zs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF2AA1EDA3;
	Wed, 19 Nov 2014 16:41:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EAE71EDA2;
	Wed, 19 Nov 2014 16:41:19 -0500 (EST)
In-Reply-To: <20141119020713.GT6527@google.com> (Jonathan Nieder's message of
	"Tue, 18 Nov 2014 18:07:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC35EFD8-7034-11E4-AE9D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Hmph. Should we just abandon my series in favor of taking Ronnie's
>> original patch, then? We can apply the "save/restore errno in error()"
>> patch independently if we like.
>
> I liked patches 1 and 2 and the explanation from patch 4.  Perhaps
> patch 3 should be replaced with a patch renaming unlock_ref to
> free_ref_lock or something.

Concurred.
