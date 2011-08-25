From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: Demonstrate breakage with --ancestry-path
 --all
Date: Thu, 25 Aug 2011 16:08:10 -0700
Message-ID: <7v4o15hyxx.fsf@alter.siamese.dyndns.org>
References: <20110824213205.GI45292@book.hvoigt.net>
 <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwj24-0005fN-2M
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab1HYXIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:08:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab1HYXIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 708675A94;
	Thu, 25 Aug 2011 19:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B03zVgCjuOp0XtqN7lcOkIjRdYw=; b=FWnRnh
	qcyGAYYDuGL37NLLVOTVPWy3N2L7179f0H3jTtpg2tGkNWPgXUCtycPAEshWE7eC
	z73hYYa99G06QRKO8/oB8RIEHpLNLYSn5Z0eqtH+H/6s06h+X3IJPzbFRl5FuWR0
	MqYSvZoOhXUir2ADhut0SC57VplYMAsYYJbAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lV+0xxy0nbZaO0ouV1I1e/7ncD4jQBUM
	8mUA1ttfZazVYSQxhaLH/YZATYfOcY/8IwUztKtf6einhc+wvXU69nvQNnv3bDGk
	aSuoPEVeisj2eoRF4hfwrAPOWPUFQqGKF2/49Ot77oBIkdO+HF4KoVI/eMO3Dcg6
	2COkRTZU02Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662445A93;
	Thu, 25 Aug 2011 19:08:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1818C5A92; Thu, 25 Aug 2011
 19:08:12 -0400 (EDT)
In-Reply-To: <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> (Brad King's message of "Thu, 25 Aug 2011 12:49:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AEBCEF0-CF6F-11E0-8377-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180135>

Brad King <brad.king@kitware.com> writes:

> The option added by commit ebdc94f3 (revision: --ancestry-path,
> 2010-04-20) does not work properly in combination with --all, at least
> in the case of a criss-cross merge:
>
>     b---bc
>    / \ /
>   a   X
>    \ / \
>     c---cb

Hmm, what should --ancestry-path do given more than one positive commit to
begin with, let alone --all? I do not think the request itself does not
make sense.
