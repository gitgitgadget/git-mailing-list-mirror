From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 14:25:56 -0800
Message-ID: <xmqqy4biwowb.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
	<CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
	<xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:26:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNg8-0001Kw-M7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbcAUW0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:26:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751317AbcAUWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:25:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C3B23D40E;
	Thu, 21 Jan 2016 17:25:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yNHov/hQ6uj9ZWYZhiIpcxqxNoA=; b=oGop+j
	2gcoCVH4PMtKg4YIlgPwSOYOhV/c6u1rJFq/dF5/DXGeaJo41isihPyDyI8P9Zt5
	XuO4A9T0dmqgmfxyJcnrYSNWBQ93+lJjq3JpDBnKiWT+flqWG7hj/YNxU08Bholw
	oMh10mFsKe8GZkbexD348pvE5v6tPKVRCxyFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T54KQ0xzN6oAl63Lgof1zWtnIW2CjoE+
	HBo7M/h/yvqotkrxJr3IKdMaE9MkN/kJ7mr5z08tImY/Ip+AdqRL0K73AaKov0kR
	FUtr2dD9A4IbuvgdkJUp/L61tvopZmrIo/q9sW90WOflrRNrOJ+ScXB2OEVdEYGg
	UVmV9jGopSY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 031963D40D;
	Thu, 21 Jan 2016 17:25:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CF973D40C;
	Thu, 21 Jan 2016 17:25:57 -0500 (EST)
In-Reply-To: <xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 21 Jan 2016 14:18:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1422E2C-C08D-11E5-A3CA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284536>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that we will end up needing to support both styles.  The
> latter style is easier when you want to express a larger set as a
> collection of groups, e.g.
> ...
> might be a way to say "the default group includes everything in the
> 'development-tools' or 'editors' group, plus 'frotz' module, but do
> not include modules in the xyzzy group" or something like that.

I forgot to say that I personally do not think we need to support
such synthetic groups from day one.
