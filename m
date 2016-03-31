From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply: free patch when parse_chunk() fails
Date: Thu, 31 Mar 2016 15:56:34 -0700
Message-ID: <xmqq37r6l0il.fsf@gitster.mtv.corp.google.com>
References: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
	<CAP8UFD2uT8dF+LMEGVdM6QZztqr_FbX=UQ01U0ttODFUk4AxbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:56:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allW6-00085r-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbcCaW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:56:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755163AbcCaW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:56:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 351B1528A8;
	Thu, 31 Mar 2016 18:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LfPacOrzYY+rE0kq+xUl5q7NsTg=; b=XhVfvz
	E2Jz1uPcwOmlnHX12dI1+2ioSn8AmXZ9qzlGzGUAXdmOc3Rn6EtPENN6qYny9uRD
	xb6qw/NTQKFRxStJbPOuoeM2B0zt8vI8+NZ62Nay3tChEx7OXEXnofqRhQFUnxVb
	h4VaCD2VR/aOLUYmHAABmlo6nYSjqKdlcOI5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jHjLhWPqGIg4KjyZEktACXfI12Imte/n
	m3ZyYQkqYzIBaPBMwqpcuf2K6EevccL/KkucP0eW4ZxCDO37rJ7Xxte7TY8i3fYz
	4aOYFqJO2ZQKlQGDzYNscjKljr5sfl8tud4eH7ugXNZwmsnnmevY45WQCrp32uB4
	eAMQjYzpHQg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2637B528A7;
	Thu, 31 Mar 2016 18:56:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97707528A4;
	Thu, 31 Mar 2016 18:56:35 -0400 (EDT)
In-Reply-To: <CAP8UFD2uT8dF+LMEGVdM6QZztqr_FbX=UQ01U0ttODFUk4AxbA@mail.gmail.com>
	(Christian Couder's message of "Thu, 31 Mar 2016 18:29:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1C5CAC6-F793-11E5-A0F6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290485>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Mar 16, 2016 at 3:35 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> When parse_chunk() fails it can return -1, for example
>> when find_header() doesn't find a patch header.
>>
>> In this case it's better in apply_patch() to free the
>> "struct patch" that we just allocated instead of
>> leaking it.
>
> Maybe this patch has fallen through the cracks too.

Anything worthy of discussion that you sent during the feature
freeze, please resend them to the list for discussion.
