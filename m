From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 07 Oct 2014 14:41:06 -0700
Message-ID: <xmqqppe3d0ct.fsf@gitster.dls.corp.google.com>
References: <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
	<CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
	<xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
	<20141007212937.GA14632@redhat.com> <20141007213859.GB24508@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcVP-0008Al-BI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbaJGVlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:41:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55638 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754402AbaJGVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:41:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B9D14DE2;
	Tue,  7 Oct 2014 17:41:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GyVf4JqM/c4+XpHzddrBHcI83vM=; b=D6Hazw
	Rtrsb3dz53lpHn439rjoq5EMNvZLQrCYqW/1gbTE3yZI2GV1P5ddPrSqysosHGpR
	rRNza466r+4WeWXd2ZND5g+6fLTQufLFNEVKX3QCxAGZIJqFpZG9wjSBjzHykwSL
	NQRwxfmy2aI+T/T95g10NP6CRVuuGtVsW1Mrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EqaIH8V/VAQpCZLgldy0Mpet43JiAi4s
	sEnBw4kudxomxp6m2BhBQKkc5iVbMmTajhsOOk4OkGCbcMdMScLy58n+rJs7HkK+
	DEw/rImptjQ3JK5oHGW8bQQGCJTF7dJz84dvLYV8+2p5qSr03DHvsLYKS42SX3Kz
	kkEA+Fb9cdw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE77F14DE1;
	Tue,  7 Oct 2014 17:41:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72A2914DDF;
	Tue,  7 Oct 2014 17:41:08 -0400 (EDT)
In-Reply-To: <20141007213859.GB24508@peff.net> (Jeff King's message of "Tue, 7
	Oct 2014 17:39:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5E68E0A-4E6A-11E4-904B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Optional parameters for arguments make backwards-compatibility tricky.
> In this case, the command:
>
>   git am -s mbox1 mbox2
>
> means "apply the patches from mbox1 and mbox2, and signoff the patches".
> Under your scheme, it now means "apply from mbox2, and use the trailer
> mbox1".

Thanks for saving me from typing ;-)
