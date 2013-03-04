From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Sun, 03 Mar 2013 16:05:14 -0800
Message-ID: <7v4ngsyqpx.fsf@alter.siamese.dyndns.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
 <1362342072-1412-3-git-send-email-philipoakley@iee.org>
 <7vwqtoyryp.fsf@alter.siamese.dyndns.org>
 <EE36F065A5DA4769989FC7345DF7BCE6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIuX-0006jh-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3CDAFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:05:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3CDAFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 19:05:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6125FA523;
	Sun,  3 Mar 2013 19:05:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qEAWiGiH7rLve6RF3LzN0VXTV1Y=; b=YJR9bo
	ucykizOHq0JIdvzP13lXwTifCsNUwhZhPhQWFf6JZd34ATBBXbexi6Ha1CkSJsKT
	WklTxgDOAoqmlEuDiiJUPvffX0UI/vuu+4aSu8epG9l2WM8hr3idCLUmKASTezOH
	8MZiAjh34a3sCwbn0siyihgNsqCjpbxN36RWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ec/ubKQ+oYkaCwVsW9Zb3s5EH62lvbzK
	Zn/H+9WZlVDihCNQPx3JYD0pZY8XkL5HIJB8tT1q99VYibEyWsHi39zIryL1OEd3
	/gKZkvcS4X8zMoOFXFNN7NR3y0Ae59ip9MRsutIsOwDE3Uy2519qVU3ceiWki6pb
	JaVDaFNccH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56F2AA522;
	Sun,  3 Mar 2013 19:05:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF428A521; Sun,  3 Mar 2013
 19:05:16 -0500 (EST)
In-Reply-To: <EE36F065A5DA4769989FC7345DF7BCE6@PhilipOakley> (Philip Oakley's
 message of "Sun, 3 Mar 2013 23:54:11 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31DD9B92-845F-11E2-899B-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217382>

"Philip Oakley" <philipoakley@iee.org> writes:

>> Hrm, I do not recall anybody ever declared that "--all" is deprecated.
>
> No, it was the use OPT_COUNTUP rather than OPT_BOOLEAN that the
> deprecated' was refering to.

Oh, no OPT_BOOLEAN was deprecated because too many people rightfully
thought it was about 0/1 choice and got burned by its count-up
behaviour.  When you want to count-up, OPT_COUNTUP is the right
thing to do and replacing deprecated BOOLEAN with it is a correct
thing to do.  But for this optoin, I do not think you want to count
up in the first place.  You want a 0/1 choice, which is written as
OPT_BOOL these days.
