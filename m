From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 08:29:18 -0700
Message-ID: <xmqq37qgxprl.fsf@gitster.mtv.corp.google.com>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
	<a7b889d525f99fecfb9d4a890fd2a5d4bf3001e0.1461134258.git.johannes.schindelin@gmx.de>
	<20160420065349.GA14490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asu4Q-0002w9-TS
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbcDTP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:29:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbcDTP3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:29:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED6E810D21;
	Wed, 20 Apr 2016 11:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8r5Xn4ZOTq6QZhjeuzbEEOcdq2A=; b=bsKnwi
	ZPOLY4CdLHOoM6/mQAULXwMo9ULfSNPLqhuV1T9WDc+FJNo6kiG01q5GM2I4MlMQ
	o8jbu1mBq6LCpgZNKeFudpbTABLs8dhzWrzTO0AmzdXYz/TiGJfc1bDbyVDefjjY
	IHmchetr2zyjUKMs0fMgzQypxfhH2JzR7+m24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VBdwyhiiK83VPBRYn2xvokUnhA6jy384
	r2bycbQ5rSXy4qnaGAIMt2sJDhIuUyiJEF8erdCNp8FO18eXvdRmtqyB/FgRAige
	tpDIJm7ui4NOKOkS3yD92rVE8oH6ndjO3E/2L9OybM3on7NQkDfjxL/gad/P8g6/
	GSSuJMm5KKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E584710D20;
	Wed, 20 Apr 2016 11:29:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5442410D1F;
	Wed, 20 Apr 2016 11:29:19 -0400 (EDT)
In-Reply-To: <20160420065349.GA14490@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Apr 2016 02:53:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A65E64F0-070C-11E6-9DF5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292027>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 20, 2016 at 08:38:03AM +0200, Johannes Schindelin wrote:
>
>> We simply need to read the config, is all.
>> 
>> This fixes https://github.com/git-for-windows/git/issues/733
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Looks good to me. Thanks.

Yup, I think the new placement is at the most logical place, just
before parse options.  I looked at other codepaths and I do not see
a reason why they shouldn't read the configuration variables.

Thanks, both.
