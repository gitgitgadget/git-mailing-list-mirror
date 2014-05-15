From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 10:24:27 -0700
Message-ID: <xmqq38gbgdkk.fsf@gitster.dls.corp.google.com>
References: <20140514184145.GA25699@localhost.localdomain>
	<xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
	<CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
	<20140515050820.GA30785@localhost.localdomain>
	<alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Wagner <accounts@mwagner.org>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu May 15 19:29:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzSo-0002qP-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbaEOR26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:28:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58230 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbaEOR25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:28:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85269179CB;
	Thu, 15 May 2014 13:28:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MuoufKk9oDQOi5B07NX5DK4uqY4=; b=aeTT1E
	1xb1wHI7TJQa8PpqTpX3yCawIP1Urc67heO5A5mY/19m9XRRYweIBXy39XbGqzQW
	zHS/bZPzGjG7LAUvAG2QEIDMAS6qQ34quJrqYYsmzs1nSHCgoyw86UWeEyCfJlBB
	oQBUDrbSJJojfftpCMyuxtajcvz96UPRhz/F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kf5pqsMXQB9qkwU7RExwy1VmY9nxnM7E
	tSM/tHck702eqHg8r5vX6sf1vm7Ri8tAvxzCnxU/TyppU/gMk5gVI7ZbIAvvEeob
	8O82JybpQXuyd4/NGHJ2Oemu5qpe4u5jzguM9g4cQxc2O6oAD0ol2d/eXhI8QCcR
	g73idJ4uYKM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AB78179CA;
	Thu, 15 May 2014 13:28:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A21917622;
	Thu, 15 May 2014 13:24:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se> (Peter
	Krefting's message of "Thu, 15 May 2014 10:04:24 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5D38EB6-DC55-11E3-BE48-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249121>

Peter Krefting <peter@softwolves.pp.se> writes:

> What is happening is that whatever is generating the URI us
> UTF-8-encoding the string twice (i.e., it generates a string with the
> proper C3 BC in it, and then interprets it as iso-8859-1 data and runs
> that through a UTF-8 encoder again, yielding the C3 83 C2 BC sequence
> you see above).

Thanks for a quick response.  If the input was unnecessarily encoded
one extra time, it is no wonder it needed one unnecessary extra
decoding.
