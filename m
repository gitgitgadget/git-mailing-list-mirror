From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 09:33:23 -0700
Message-ID: <7vd2sq7ulo.fsf@alter.siamese.dyndns.org>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
	<5194921F.4080103@drmicha.warpmail.net>
	<CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
	<51949B85.40600@drmicha.warpmail.net>
	<CACsJy8D_5YE3w4WNvCA8-fA-y5DV2WqHULqcMYqd7X_SSh_aHw@mail.gmail.com>
	<7v1u9699x7.fsf@alter.siamese.dyndns.org>
	<CAMP44s3cjO4ETd+_oQB=afxDuWZb+HBDEOA2sdHfFQ10+y9foQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud17S-0005Tq-95
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab3EPQd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:33:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab3EPQdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:33:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DA201E316;
	Thu, 16 May 2013 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MpGVTp0uYPpL8U6xsxGc/kOm+NI=; b=r3mSeS
	qGHGgmckm4/Q/fMhVRkMZkiEOQW5LAz/LvQ0Sa/g9Wexms/3MGUdQ0KLTFw7prWO
	vREgWb6xBbgCuagqPPgdj0CmvhsmUEkVQvxRGEnMzCLnXOLaCmAX1j4EJXKLVN3K
	kOowcxIZRgkMW5AtHWGqY7YXEHisyaS4W8coU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jlbFmhymDueOWOMw7QFM01vogO4EK7Uu
	0xLlaFerZDjRZkSgY5U4oWnlJMIsoIOr6xhfR8V615u2GG4aRI+/dJHV8QChKYhF
	ar9UuQeH2CxC3tfYf5uITf0CiAZJuuYirVRuNdnrQfsrFdnNomOvYQBzV6xVBpvT
	eQPx8hRkT24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E3D1E314;
	Thu, 16 May 2013 16:33:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F0441E30F;
	Thu, 16 May 2013 16:33:24 +0000 (UTC)
In-Reply-To: <CAMP44s3cjO4ETd+_oQB=afxDuWZb+HBDEOA2sdHfFQ10+y9foQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 11:28:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5458363E-BE46-11E2-B7A1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224597>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 16, 2013 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> *1* indented because this is dependent of @{u}; showing ahead/behind
>>     without showing @{u} would not make any sense.
>
> That's what 'git branch -v' does.

OK, perhaps people know (or do not have to know) what @{u} is and
find ahead/behind still useful?  In any case, this need to be
separate and independent item, as we would want to be able to
express what we currently show in the updated system.

Thanks for a sanity check.
