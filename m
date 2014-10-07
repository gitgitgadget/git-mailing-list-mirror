From: Junio C Hamano <gitster@pobox.com>
Subject: Re: let git grep consider sub projects
Date: Tue, 07 Oct 2014 11:25:53 -0700
Message-ID: <xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com>
References: <20141007082914.GA2729@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:26:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZT2-0001cd-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbaJGS0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:26:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63950 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932110AbaJGS0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:26:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 502EE13D4B;
	Tue,  7 Oct 2014 14:26:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/6bM3uVlbDrninVtKalV0n/8BJU=; b=tghsa4
	FVLXoTQgX57/sndWpWzK9IIbHOvbEnKPOiffPJE039VOXTaifDXIbmfNyFFLl/o6
	D6zjWxxj2QDO9MaPxPGYELASJrYvKXou7hE2XX9D2csMDlp+4M65iledx8HzzX3/
	8lIVDGKkwPBGOh0nJaCrLsSrsrzM2bUiJmy5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eBCwLjFTe90reOwWCAWurd8dHv8nxmAS
	IFxzuuDihIoagC1Q48HmT/BItSrhnsflYvcVh7olcUKEm/DjYEFaJZeRuPtehOeF
	Zo/wR6n+f9TWPcUAXvHXuUVNCsglvroPEqmpXzAfocQX0reNPaAt1oSpfj+RW8yh
	W9bAl2G4scE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3484B13D48;
	Tue,  7 Oct 2014 14:26:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D02B13D47;
	Tue,  7 Oct 2014 14:26:00 -0400 (EDT)
In-Reply-To: <20141007082914.GA2729@aepfle.de> (Olaf Hering's message of "Tue,
	7 Oct 2014 10:29:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6360DD12-4E4F-11E4-BA2D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> How can I teach 'git grep $string' to also consider subprojects?
>
> The build system of xen.git clones 4 other trees into a directory in its
> source tree during build. It would be nice if my 'git grep' searches
> also in these cloned subdirs. Somehow there must be some knowledge
> because 'git clean -dfx' leaves them alone, while 'git clean -dffx'
> wipes everything.
>
> Olaf
>
> PS: Sometimes I miss a 'git clean -dfx --also-sub-repos' useful to
> really clean everything before starting over.

Is "submodule foreach" under-advertised or with less than adequate
features?
