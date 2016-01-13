From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] trailer: use fprintf instead of printf
Date: Wed, 13 Jan 2016 11:20:04 -0800
Message-ID: <xmqqd1t5nv6j.fsf@gitster.mtv.corp.google.com>
References: <1452688989-13746-1-git-send-email-tklauser@distanz.ch>
	<1452688989-13746-2-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:20:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQxs-0000qR-4s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbcAMTUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:20:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779AbcAMTUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:20:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CED533A720;
	Wed, 13 Jan 2016 14:20:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=INymfEAzZqCLv4lNRzog0sJI5hA=; b=ZRBJkB
	/4jN8P9sHOmLsTLHM2Algs39bXTa9bJpoqqJDQZqg25wefqEZbUVSW4s0rvLPM95
	RpPUVqGJuENTYSNY6gjzkATwRsPtCRtw6ds9y4dvcjWArh7FwGUZpt1wQwSqKxDy
	SD47IrXKP19mKnIEGOok9PK2h3PTREVdWFFS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZY8uNJwlSNgWIfITL5pBrEFsE/xufGJH
	2cNbZYGlH8BwEqdgZbBEc3c6HPhgKgQibPvGm43rQMnwqLV+F2eZr1c7LQkhM8ya
	ar1U7VymWYtgBhNs8RUJ/rwYWzjYeeH7s1Ft6Hvo3A6U6atwhopw0ebbu2Jb8wd1
	CyKzylEuyTA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8A7A3A71F;
	Wed, 13 Jan 2016 14:20:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFCD73A71A;
	Wed, 13 Jan 2016 14:20:05 -0500 (EST)
In-Reply-To: <1452688989-13746-2-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Wed, 13 Jan 2016 13:43:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A70CCC18-BA2A-11E5-81FA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283972>

Tobias Klauser <tklauser@distanz.ch> writes:

> Use fprintf instead of printf in trailer.c in order to allow printing
> to a file other than stdout. This will be needed to support in-place
> editing in git interpret-trailers.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks.  I won't bother to amend it myself or request you to reroll
only for this, but that is a rather suboptimal title.

The distinction between fprintf/printf is an implementation detail;
what you want to do in this change is to allow writing to a file
other than the standard output, and that should be in the title.
