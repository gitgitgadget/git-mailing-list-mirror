From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 11:12:23 -0700
Message-ID: <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 20:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6KW-0001Av-Ay
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbaEGSM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:12:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53723 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbaEGSM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:12:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02C9D1615F;
	Wed,  7 May 2014 14:12:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6O9W0Fgz6cVpEo/1msoTphyCk7o=; b=sF86rM
	vnWUkACgGveYyLae6P0mHAhXitV66l8w82H9RjOgcB5c+cKWRs90CtKgkd0t+qER
	pDUUMOtCJ3XNjh86uOHfGsCZXiud7LANugpdho9FYghqKICCVaisCavo+NsyRuhJ
	1tE8Ca+4NfUGcUm96BG1D+l7cFeZsW8p18bYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wx6bVM9rV8GxcOPA4S0BeIJkuJ8LKbPT
	IPdtXBW58zi3sLjQV5Oej11dUv5gV3pSof+aN5GvFUi1INmyHxp0DLQ5YRlzsQ5A
	KJzBPBxLLMXuTo8ExnKCuLhqOIG61itaZaYsinzJ19BGmBtPFAa03alXe6w5S3G3
	vD2pZX/crNg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9ABB1615E;
	Wed,  7 May 2014 14:12:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 852D81615C;
	Wed,  7 May 2014 14:12:24 -0400 (EDT)
In-Reply-To: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 3 May 2014 21:16:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23DBFFC8-D613-11E3-B1C0-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248341>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Here's a bunch of tests more, and a fixes for Mercurial v3.0.

I think the discussion with John Keeping hints that we shouldn't be
rushing fc/remote-helpers-hg-bzr-graduation and this does not appear
to assume the presense of that series, which is good in order to
make these fixes jump over them.

I'll queue this separately on a topic based on the tip of
yesterday's master for now.

One thing I couldn't read from the proposed log messages was if this
is meant to work with and tested with both v3.0 and pre-v3.0 Hg, or
this is to request others who run pre-v3.0 Hg to test these changes.

For example, I see

	from mercurial import changegroup
        if check_version(3, 0):
        	cg = changegroup.getbundle(...)
	else:
        	cg = repo.getbundle(...)

and offhand it was unclear if the unconditional import was a
mistake.

Thanks.

>
>
> Felipe Contreras (4):
>   remote-hg: add more tests
>   t: remote-hg: add file operation tests
>   t: remote-hg: trivial cleanups and fixes
>   remote-hg: add support for hg v3.0
>
>  contrib/remote-helpers/git-remote-hg |   6 +-
>  contrib/remote-helpers/test-hg.sh    | 240 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 238 insertions(+), 8 deletions(-)
