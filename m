From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 00/19] Sparse checkout
Date: Fri, 21 Aug 2009 00:50:04 -0700
Message-ID: <7vprapip1v.fsf@alter.siamese.dyndns.org>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 09:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeOtA-0005Yp-8a
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 09:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZHUHuL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 03:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755039AbZHUHuK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 03:50:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbZHUHuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 03:50:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A0812976;
	Fri, 21 Aug 2009 03:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ZOi+3RaACt0V4c0ndOYj8WVYX
	Ac=; b=VJ0ciZDEz7lCYA0OYGIkOaU1Xs6rHyh8v6Q89+3eoxnTw95swr6YVGa+p
	C4MLCkMidlhcutS+SpNOSVdUYDBjtNSCTtPoTqMBQ5pEJyyPvj/br/9k9TQcdBOv
	faOZUHCFd4COXQTdI9zldCd/CeDkzA0fpf5hqwbPIdSmuS916A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ZIp8GBd0B7oqqJsqu60
	NTh9GhMhtQr8BaeFpPSJIswY5Wv3kW5Q0HpY4oXil/6v8ceFmpOcpTOQJX5rf5rY
	ayAPa18mIZeUnvmNrk2CcVWcrniRV4yVWAaLiy8RPUmK4yW+w1ZH4EBEjSOOn0Yi
	JMSVNKdio80Io5G9A7BUzy8o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0C512974;
	Fri, 21 Aug 2009 03:50:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB2DE12973; Fri, 21 Aug
 2009 03:50:05 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F28A468-8E27-11DE-A850-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126692>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The recent assume-unchanged "breakage" that lets Git overwrite
> assume-unchanged files worried me. I sat back, checked and wrote test=
s

Yeah, it worries me, too.  Does the fix to make sure the sparse stuff
won't be broken apply equally to assume-unchanged?  Does the series hav=
e
such fixes to assume-unchanged bit as well?

By the way, I think the first patch in the earlier series, 540e694
(Prevent diff machinery from examining assume-unchanged entries on
worktree, 2009-08-11), is a good change regardless of the sparse
implementation, and I'm inclined to say that we should merge that part
(and I suspect there will be similar fixes to really ignore differences=
 to
CE_VALID entries) first and then queue this new series on top.
