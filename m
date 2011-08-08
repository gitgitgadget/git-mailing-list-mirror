From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Move git-dir for submodules
Date: Mon, 08 Aug 2011 14:34:35 -0700
Message-ID: <7v1uwvwpsk.fsf@alter.siamese.dyndns.org>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
 <1312831022-12868-3-git-send-email-iveqy@iveqy.com>
 <20110808204439.GA41500@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, gitster@pobox.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqXT9-0003dm-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab1HHVej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 17:34:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab1HHVei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 17:34:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C74E9549F;
	Mon,  8 Aug 2011 17:34:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xef3x8a0WIaUzd6MuZVm62IM91M=; b=roASVM
	Tnk5ez7iaYI8Pkpum8OonDdyZU5TGpfJZYa52nRUg8OAAKXalq5EGhGgiwd3VM81
	HeUl8UlY7QW+VrlR8STjMx2b59omu5Qh2r+utv7BHhoPSm9+hOosWR/3GPcc9HT3
	7Y6dLFxNeq0Jna4ig7Ma5+1ZR6guMeynb/GVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VN1sGoYZWZLsQIk4vtld+wSsBldx2LTM
	g/9CJGDmkfG2K7hcac0R1l/KPzSTkK0ANaTKWYYsHmoJAcSNET0124ccatFL9Gkf
	YWV2nwaC4MTc6Hh8HfHEcUsksbImhCOBUE/lkK0URFVtacSj+ok5xzbYLGm3yOnD
	yZGJPy85qQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF958549E;
	Mon,  8 Aug 2011 17:34:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FE7D549D; Mon,  8 Aug 2011
 17:34:37 -0400 (EDT)
In-Reply-To: <20110808204439.GA41500@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 8 Aug 2011 22:44:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 373FB25E-C206-11E0-A784-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178991>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Hi,
>
> On Mon, Aug 08, 2011 at 09:17:02PM +0200, Fredrik Gustafsson wrote:
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index c679f36..1ae6b4e 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -408,6 +408,7 @@ test_expect_success 'submodule update exit immediately in case of merge conflict
>>  	 test_cmp expect actual
>>  	)
>>  '
>> +
>
> There is a whitespace error here which we seem to have overlooked. Junio
> could you remove that?

Hmm, confused.

A blank between test would be the perfectly normal thing to see, no?

>>  test_expect_success 'submodule update exit immediately after recursive rebase error' '
>>  	(cd super &&
>>  	 git checkout master &&
>
> Cheers Heiko
