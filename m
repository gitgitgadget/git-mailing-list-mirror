From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Fri, 24 Oct 2014 09:48:50 -0700
Message-ID: <xmqqk33ph0r1.fsf@gitster.dls.corp.google.com>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
	<7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net>
	<xmqq7fzru5do.fsf@gitster.dls.corp.google.com>
	<xmqq38afu0of.fsf@gitster.dls.corp.google.com>
	<544A6D4E.7070408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 18:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhi2s-0000gD-TD
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 18:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbaJXQsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 12:48:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756015AbaJXQsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 12:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9852215FE8;
	Fri, 24 Oct 2014 12:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pDQ0XP7fz2zHMo4TaPoj5qG85Q=; b=sTqGsM
	Dt9iQX/bDYsCoS2ZuhH22YHl3LjsHlktky/LUF/l4/sn/vFxcNAaXbgZxrrxQ0iH
	fjg0Qkj4Rkxt4k1/Zm1cS25QYWTsKsUuGmEs6Oeg9NnNCnLkeC2wvdfYdnYDe4VI
	dYgZ+B1ena1P4wLbPjWugbhFdky4T6r3WQwiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fVqzDyz5gCARI70sfqr8eyCQrw1RG2Lm
	Onzvjq9rSfIaks973qW2JTNqfOy43/uWR8EG/HI2bkHytLhVKCPoSTbdw6Q8nf1J
	0gcwbNHsH0WkS0i4qEZAvxJncdepMIx8Utv7Na7ZIskgvB+cc27WTYfs75eLq2Pg
	RZnkLd7gcSY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ECE715FE7;
	Fri, 24 Oct 2014 12:48:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C16B15FE5;
	Fri, 24 Oct 2014 12:48:51 -0400 (EDT)
In-Reply-To: <544A6D4E.7070408@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 24 Oct 2014 17:16:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A268BFCE-5B9D-11E4-B3FA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> If I do that, I get:
>
> gpg: can't create `/home/mjg/src/git/t/trash
> directory.t5534-push-signed/gpghome/random_seed': Permission denied
>
> So I we do copy the env around. Problems arise only when the original
> copy ends up ro. We can guard against that by doing:

Ah, thanks for digging it further.
