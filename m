From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] precompose-utf8: do not call checks for non-ascii "utf8"
Date: Mon, 20 Aug 2012 15:02:43 -0700
Message-ID: <7v4nnxjk70.fsf@alter.siamese.dyndns.org>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
 <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
 <7vobm9v32e.fsf@alter.siamese.dyndns.org> <50311DEB.4050700@web.de>
 <7vobm5jusz.fsf_-_@alter.siamese.dyndns.org> <5032940A.4040005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 21 00:02:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3a3k-0006R5-LR
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 00:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab2HTWCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 18:02:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab2HTWCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 18:02:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 002028A0D;
	Mon, 20 Aug 2012 18:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wxnpAkxhBd+x
	BUQafbJtT0un3f8=; b=Q7nCqDoNywxb0X2qDGm6nuF7J23KjND642zLIwesSMuc
	KhgCy4qrMaXFNCI3UicW1dtONlqGVBRAfIvhkpJaUbjRX5af1YtiDNxPfKFtspcY
	M/sVc9kBjRgj+3skbxUGLWuJ6AzjW4ajDCawNUoGmT9xKwmk+VEfBYi28TZVYt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IAPyfu
	ME/MkTjbmHykls5VU1yYHUi/IWuzZCvZIAOsBNEhxtFeeyGMdm6RVZjGmuzJhEK7
	GUzC8PZbAGl0FBZsC5cS5+HKEDgkfIvzOjOxBQjuudG9bEBtBx789lSwhIN/37e3
	N+/goDlf4TNGQdi1QCxnDaSQm9b+u0vhNigNI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1C278A0B;
	Mon, 20 Aug 2012 18:02:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61CB88A0A; Mon, 20 Aug 2012
 18:02:45 -0400 (EDT)
In-Reply-To: <5032940A.4040005@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Mon, 20 Aug 2012 21:46:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C58C7606-EB12-11E1-8E6C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203898>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> a) in readdir we die() when iconv_open() fails, and we could/should d=
o
> that in void precompose_argv() as well?

Probably.

> b) Should die("txt") be converted into die(_("txt")) to be able to
> translate the message?

I do not even know what die("txt") is trying to tell to
English-speaking users, so I dunno ;-).  The message needs to be
updated to human readable form and then annotated with _(), I guess.
