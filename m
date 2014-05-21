From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 15:15:55 -0700
Message-ID: <xmqqfvk2ok10.fsf@gitster.dls.corp.google.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
	<1400634170-18266-2-git-send-email-jmmahler@gmail.com>
	<xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
	<20140521215059.GB13956@hudson.localdomain>
	<xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
	<20140521220250.GA11970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 00:16:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEnw-0002xd-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbaEUWQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:16:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52569 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbaEUWQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:16:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E8F61930C;
	Wed, 21 May 2014 18:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86uOYGje8oIQ4NDESNvR7loh+AY=; b=JaQycF
	6mgQRb2OUGxrlf65N1HmFJ8KXV0GZHBbwqaRD/cQzAu+utI75ugkq5tkD4JZMCNG
	DgQ6k4hU/zrwXBg+cM4gTJ7ieYspkVL/fBAP9JXYE6HLNqMuU3w7WVCgb0uiKkoU
	y5YcpUa+79FaN4M1Yelu7kAC6eaH/6KAx0rXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkgXF/V8yF5wQH8pmRvGzZPRXfDPIQeb
	WYn18NpDt4uD0Y5CII8LMtWRp1F0uh0p8rRRsn4iPGoZLo5iV5T/cEmU72zxYG9E
	u4LYmBcXQwchHF3EQ6WDgeD0yF/DKW6aMh3UISYbnu5px3qiW0zkf8duRtw8L4sq
	8Khm6GMIx8k=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAB4419309;
	Wed, 21 May 2014 18:16:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39BFD19300;
	Wed, 21 May 2014 18:15:57 -0400 (EDT)
In-Reply-To: <20140521220250.GA11970@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 May 2014 18:02:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B7BA3DC-E135-11E3-8A0C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249851>

Jeff King <peff@peff.net> writes:

> I think he is responding to my earlier request to use test_must_fail
> instead of "!".  But there is a subtlety there he does not know, which
> is that we typically only use the former for git programs, and rely on
> "!" for normal Unix commands.

Ok, that explains it.  Thanks.

> Yeah, I noticed and gave a pass on this in earlier review, because the
> file is used across many tests. So burying it in the first test that
> uses it is probably a bad thing. However, it could go in its own setup
> test.

Yeah, placing it in its own setup may be the best.  There are quite
a many set-ups outside the tests in this script from the olden days,
so I am OK if left it as-is and have a separate clean-up patch after
this topic settles.  I am also OK to add a new one "the new right way"
so that a later clean-up patch does not have to change what is added
in this step.
