From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #04; Wed, 13)
Date: Mon, 18 Nov 2013 08:11:55 -0800
Message-ID: <xmqqfvqtd704.fsf@gitster.dls.corp.google.com>
References: <xmqqob5ndho5.fsf@gitster.dls.corp.google.com>
	<20131115064830.GA30234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViRQv-0000wv-BL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3KRQMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 11:12:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3KRQL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 11:11:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C92F528AD;
	Mon, 18 Nov 2013 11:11:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PoZ/kjpgg0pflbkSS9zU5R3JkTE=; b=W7S1y4
	Mu7Fsil2BtZ6pnDzcF5h8VPiFY2IzLNK+vQkM7teZTLJhwOKoIHqGCki58EO4YT1
	gD1I14mSUiznN4qoY5ZQ0v6OQWqnTI8mvfGSQ/9Kq9H5A8FhA7Et4gqdYh3UpWzS
	L769NOw3w9+Ix3fWG+Kx5HBpGH/883qmVA5ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zhj2SFxaZlwOtN9ZhwsE9i+Ma3KzKkSi
	cRCpJ154ZXxnHws9aZG3j65819s2x7QlJIDsM0sTgla5QwpSwfzDImTc7e4TUgdt
	2B6cDK3+BnLwsKU1Yxoh3INO41o61XtttyOYeuMNj0rrgC0EMzhZv/8tWW0MZJMm
	rNNpc+6bZYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B846528AB;
	Mon, 18 Nov 2013 11:11:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C2A2528AA;
	Mon, 18 Nov 2013 11:11:57 -0500 (EST)
In-Reply-To: <20131115064830.GA30234@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Nov 2013 01:48:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 260F5E2A-506C-11E3-B50C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237986>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 13, 2013 at 03:07:54PM -0800, Junio C Hamano wrote:
>
>> * nd/liteal-pathspecs (2013-10-28) 1 commit
>>   (merged to 'next' on 2013-11-01 at 1a91775)
>>  + pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses
>> 
>>  Will cook in 'next'.
>
> I think we want this to be part of v1.8.5. It is a fix for a regression
> that appeared in master post-1.8.4:
>
>   $ git.v1.8.4 --literal-pathspecs blame Makefile | wc -l
>   2596
>
>   $ git.v1.8.5-rc2 --literal-pathspecs blame Makefile | wc -l
>   fatal: Makefile: pathspec magic not supported by this command: 'literal'
>   0
>
> Sorry to mention it so late into the -rc cycle, but I just noticed that
> the patch hadn't graduated.

Thanks for being careful. Will merge it down to 'master' before
another round of rc, which hopefully be the last.
