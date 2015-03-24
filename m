From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Tue, 24 Mar 2015 08:58:38 -0700
Message-ID: <xmqq619q8k0h.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq7fudld61.fsf@gitster.dls.corp.google.com>
	<551185D9.6050200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaRE8-0004Wl-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 16:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbbCXP6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 11:58:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752139AbbCXP6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 11:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7796D406BA;
	Tue, 24 Mar 2015 11:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39LywMwJ6nIgfvoNbXRmGHaBokk=; b=UIvVfK
	upMjztdZWOMNFTFXKGzq/tgHxOV5WpBzsFcITXecq/3wO52lih+0mTbh/PwgGOjW
	q36R20G4O06+/GdjI7UWjM8FupCgLo22n3w+u+Uy1YX9hKFARUVGf1Poh9Y3KJJj
	NHJ1X3WOyXKNI7wdsnnuj25Wg/x300j5+1zW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O+Y413DkSNUV3JNDshTslSgifd425nWd
	NXWGKH9s+V6KsjX242DoAbgluQp2Ry45E6lYEs+TbVebVR8SDKNYW11YwqCB+DId
	lNYyX4EG3CiDbA6wC2loZIDaL1av5PSJPKu45dEA362sKyfAyqPEQiRzKEXyMIWr
	BgPL1gMracE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70846406B9;
	Tue, 24 Mar 2015 11:58:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECD71406B7;
	Tue, 24 Mar 2015 11:58:39 -0400 (EDT)
In-Reply-To: <551185D9.6050200@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 24 Mar 2015 16:42:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3713DB6-D23E-11E4-855C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266193>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is easy to allow "--abbrev=+7"; I would just need to add NUM_PLUS to
> those call sites. Should I do so?

The more relevant question to ask from my point of view is why you
need to "add" NUM_PLUS to "enable" it.  What valid reason do you
have to forbid it anywhere?  Only because you do not accept it by
default, you need to "add" to "enable".

>> Why is it a problem to allow "git cmd --hexval=0x1234", even if "git
>> cmd --hexval=1234" would suffice?
>
> In some cases we would like to allow that flexibility; in some cases
> not. But the strtol()/strtoul() functions *always* allow it.

The same issue.  Whare are these "some cases"?
