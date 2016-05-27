From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Fri, 27 May 2016 11:30:40 -0700
Message-ID: <xmqqmvnbqrov.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
	<xmqqh9dm37xk.fsf@gitster.mtv.corp.google.com>
	<20160527044112.GA31742@zoidberg>
	<xmqqoa7sroru.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri May 27 20:30:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6MX3-0002We-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbcE0Sap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 14:30:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756163AbcE0Sao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 14:30:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6611E771;
	Fri, 27 May 2016 14:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l0k646f1ZcgZ1oonTboEBQTDuQ8=; b=EPo1JY
	88+nxWQoGsRbeudj91nBRX4D41PMvkPr8LRu+YREYKeDB8Lg7ayrx+vzDQ/6NAi8
	bHfa0f0mXskD/r4YrH/BJQSoLhv6OAXwYPcJ5O3pBXnxRDVl/JiXwFi+WnZY/g0S
	2jTdxxeFHR+BpQ7T+1UMzGfPqM5zZkT1w3m3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZlzD5NnlBaTS/WW0YchGeCaK3QhZF+2Q
	+3N3NWcKVBs5XXm/497KWpoQnA/U7ei3QCvqXJP1E3AlI0YkftOVcZt4hAbv4Yij
	3vbTLzqUYd48F/e5h0Ast2GPQSOrxLeby+332sM0CvGaX3i+vyJjyubGodIu3c2Y
	4wQYouwatRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 912121E770;
	Fri, 27 May 2016 14:30:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18AC61E76E;
	Fri, 27 May 2016 14:30:43 -0400 (EDT)
In-Reply-To: <xmqqoa7sroru.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 May 2016 23:36:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EE081DA-2439-11E6-A345-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295782>

Junio C Hamano <gitster@pobox.com> writes:

> Edward Thomson <ethomson@edwardthomson.com> writes:
>
>> However I do not think that this is a common enough action that it needs
>> to be made automatic such that when I `git add foo.rb` it is
>> automatically made executable.  I think that the reduced complexity of
>> having a single mechanism to control executability (that being the
>> execute mode in the index or a tree) is preferable to a gitattributes
>> based mechanism, at least until somebody else makes a cogent argument
>> that the gitattributes approach would be helpful for them.  :)
>
> It wasn't a "having to specify it every time sucks; you must do this
> way instead" at all.  I was just gauging if it would be a viable idea
> for a follow-up series to complement your patch.
>
> Thanks.

Oh, having said all of that, the comments on the implementation
still stand.
