From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 8/8] update-ref: add test cases covering --stdin signature
Date: Tue, 10 Sep 2013 15:54:59 -0700
Message-ID: <xmqqppsguw1o.fsf@gitster.dls.corp.google.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
	<9083b451c8bdb7c7e04541deee1b96ae81f910b4.1378773895.git.brad.king@kitware.com>
	<CAPig+cQNrtznw1jc+dVOZhqBV7me0gC6Vx-k5siMPeyCzxmBSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWpz-00059U-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab3IJWzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:55:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab3IJWzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:55:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2019841CE6;
	Tue, 10 Sep 2013 22:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nxog5t5sszDK5vxq572ouhJB3Q8=; b=cDHSxd
	aiQbdQq6VG4j6atrpUkLL69P8nogHjrbDT1k0g5qVwW5eaoWiZDhlFyUqk5aIcaf
	RWc+XdBlJ7cmB2OG/GW2EWCtKPz4v5S+iz6JoTSyAEXivyF/5xhNYmikb2oGDgpv
	lWeAKt29H42Yw9VwUNmELOBb8PReAikbFaeVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xdu84I67DppkyUk7Ca2Gu6R5NRlQkUd0
	FRijKDgTxn3fZNLhLBSpD9bSnlvRXfSowkXIhMIKvJTa3tp7K5edIdxUtBPcDrmN
	mHoPkX0bMREoLzQCXBPoteB1+TxRHNwwwnuUvL6adv9c7d9PefkuOlr94+soD/jN
	0CSYMRsxn9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5F841CE4;
	Tue, 10 Sep 2013 22:55:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E321541CE1;
	Tue, 10 Sep 2013 22:55:01 +0000 (UTC)
In-Reply-To: <CAPig+cQNrtznw1jc+dVOZhqBV7me0gC6Vx-k5siMPeyCzxmBSQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 Sep 2013 18:46:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0684C120-1A6C-11E3-9A76-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234501>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thus printf provides all the functionality you require, and
> print_nul() function can be dropped. So:
>
>     printf '%s\0' foo bar baz
>
> is equivalent to:
>
>     print_null foo bar baz

Good eyes.  Thanks, I missed them when I looked at the patches.
