From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 00:55:51 -0800
Message-ID: <7vfx8mg3mw.fsf@alter.siamese.dyndns.org>
References: <4AF92133.6070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 09:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7mWI-0005xD-Tb
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbZKJIz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 03:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbZKJIz4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:55:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZKJIz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 03:55:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB8F7B340;
	Tue, 10 Nov 2009 03:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VCys/5wRG1Sg
	bCsxWuit3ux4gFg=; b=VgQDu1E5TNljqQgmW/YPLGySlnsZi9OunGn7SIOJTFVz
	g9CHgTXUh+jLTqGCoBceAY41BerERSisRidshvz6dBDdXNk5I1QOS3vagFQFWOA8
	aKGhcCCDz/BxdlaU0Uwwn57KVdDDANLknlqeIyxRc+++3jQI77kOonnGXG7+I+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a8W51X
	0t522ZKShROGWfXlDvUMtLt2/uEG0cAmlbx7yLsMr1pjhGkAocATXngG2yCJr3cT
	ZbCrAkU1gEPrh7hvldD+CvufIpZhCgw2LIS1wsr1BAUT7lCkQNyo9hh2j0BOi7Ks
	03Q0kpkgWnBUCpPW9R3EemxmMEj71W9FlwXTc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDDE7B33F;
	Tue, 10 Nov 2009 03:55:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2582C7B33E; Tue, 10 Nov
 2009 03:55:53 -0500 (EST)
In-Reply-To: <4AF92133.6070005@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Tue\, 10 Nov 2009 09\:15\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DCCE1696-CDD6-11DE-B20A-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132552>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> From: Jay Soffian <jaysoffian@gmail.com>

Thanks for being careful; it would be even better if you preserve the
author date by copying Date: from the original.

> Teach fetch to cull stale remote tracking branches after fetching via=
 --prune.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>

Yuck...

builtin-fetch.c: In function 'prune_refs':
builtin-fetch.c:500: error: implicit declaration of function 'get_stale=
_heads'
builtin-fetch.c:500: error: initialization makes pointer from integer w=
ithout a cast
builtin-fetch.c:501: error: 'dry_run' undeclared (first use in this fun=
ction)
builtin-fetch.c:501: error: (Each undeclared identifier is reported onl=
y once
builtin-fetch.c:501: error: for each function it appears in.)
make: *** [builtin-fetch.o] Error 1
