From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] modernize t7300
Date: Mon, 07 Dec 2015 14:50:22 -0800
Message-ID: <xmqqr3ixlvpt.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
	<xmqq610alyy5.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQOW69-YNaVvqaVYyNt6cT-u92a=i0V6YufnVEmYHy3LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James <rouzier@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64c3-0000fk-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445AbbLGWu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:50:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756467AbbLGWuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:50:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D3EB32FB1;
	Mon,  7 Dec 2015 17:50:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e/6vyDu8I8V9GZ2kwvC5ZQO227Y=; b=IJTOlv
	pLhNKeVHW/oFF4UuT9uT2eeWL1KtNZEbVBC7POvLzFMMrdC4+hwyalQJF1dvnWeX
	7H1Lg+sAXzGuvODhygCTnZAQ7gk566hmpCHhu9vr1xrmbQmBRVd/uhAKgvIUGF8+
	inQ1HZUKvk6g5V+n6eHjiYlKwcj3YZoSC9Sx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvs5h64iNCuBkW3kowV40sGpfT72SOnr
	s8cj4ps9Gwv9E4NWiFQfkH1nh89agQ9IYTfRNmTRX1nE6p79LTzsFyWHozdUO5Bv
	Q9tRW9hZa1Oi6qhskHb6npJWk6Tre1wFbGiXXVsI5OxGywR7F8UP5VTjD/6KLIbc
	hyWJR8Nho1M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 037D532FB0;
	Mon,  7 Dec 2015 17:50:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F7CF32FA3;
	Mon,  7 Dec 2015 17:50:23 -0500 (EST)
In-Reply-To: <CAPig+cQOW69-YNaVvqaVYyNt6cT-u92a=i0V6YufnVEmYHy3LA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 7 Dec 2015 17:46:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E671B8EA-9D34-11E5-B365-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282136>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Alternately, update test_path_foo() functions to accept multiple
> pathnames, or is that too ugly?

That actually would have been my first choice, except (1) that
path_is_missing has a cruft whose usefulness is dubious, and (2)
that "path_exists A B C" and "path_is_missing D E F" would be
gramatically incorrect.

I think we should first see if we can remove that "customized
message" that appears only in path_is_missing and remove it if
we can.  Extending "path_is_missing A B C" and friends to work
would then become trivial.

Thanks.
