From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pushing/fetching from/into a shallow-cloned repository
Date: Thu, 18 Apr 2013 15:46:12 -0700
Message-ID: <7vbo9b4fuz.fsf@alter.siamese.dyndns.org>
References: <20130418135233.87aa23896fa48dc2d87d80fb@domain007.com>
	<8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Konstantin Khomoutov" <kostix+git@007spb.ru>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 00:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxau-0004A9-S1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 00:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967429Ab3DRWqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 18:46:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966948Ab3DRWqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 18:46:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF7B017243;
	Thu, 18 Apr 2013 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JOh/RxvIDNlUT6ZeqOfGxe0pEBI=; b=CRPIxt
	lfsp0WoCxC+aYEkKp0HMP+7yVMaLII+qtdowzkjRQRJ7p4A6LZAIWV96htWKIBWg
	MMpGF7DCX3eIqfb1fseZNnZwZolsCer+NrsbbuO2fYcymDT/w5/H9aE1tmoDkhhG
	aTeK8wJd38Sktiv18SlJboG2Hg2eoBIBRopTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/xPGWL/HdIQvQCU6y9eyV+phpEkX0E9
	OXjURVIjRI8Qc/tewGTQyKsdCmTmxbQq/YVVWjDmaeQZUFlu3BeTfmSbBc63WDyh
	sFBndE7x+z7LN5Et6bPmcFSEBH4f73hLXNksuWK8EAtAdJGHaxd00lnu5/Q6yTOZ
	aoLae+84bqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C767117242;
	Thu, 18 Apr 2013 22:46:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 476DA17240;
	Thu, 18 Apr 2013 22:46:14 +0000 (UTC)
In-Reply-To: <8BCCECD4CEEA4028AD97B851099F4C5E@PhilipOakley> (Philip Oakley's
	message of "Thu, 18 Apr 2013 21:27:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C61F997A-A879-11E2-B31B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221700>

"Philip Oakley" <philipoakley@iee.org> writes:

>> So I observe pushing/fetching works OK at least for a simple case like
>> this one.
>>
>> Hence I'd like to ask: if the manual page is wrong or I'm observing
>> some corner case?
>> --
> The manual is deliberately misleading.

Yes, it is erring on the safe side.

It was not coded with the case where the gap widens (e.g. either
side rewinds the history) in mind as you explained; for simple cases
the code just happens to work, but the users are encouraged not to
rely on it to be safe than sorry.
