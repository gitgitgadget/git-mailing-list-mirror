From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 16 Aug 2012 16:29:29 -0700
Message-ID: <7vr4r6xvom.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7vy5mftm3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:29:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29VS-0004Av-2A
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab2HPX3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:29:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527Ab2HPX3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:29:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 072569057;
	Thu, 16 Aug 2012 19:29:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X7gP2mrn0tBeNrE89OVBU9GVu6w=; b=tkfmNk
	dILPJR7QDePeM08wsGg2R+gEbTXz5jn56+PiXxOMMU9ND11BW6keUi+IRFSo6OaP
	7TYr84ggo3nuVaAqtE3Bj4NMTTnBMZNq5VIkK2hrbJAf8IcV7cgieMvSSIBor2rT
	vrGbCAgEwNA3+wCJEGgZifQNcab4j+90RVX8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjt/jH76Gouq5XfTMSXo1fpbzkFwu1yU
	+bPaRc0vQJRTIZv4y3o6aqlqzyzS2YrlyRW0k5Ch55s0xrigz/R95pMfjdXfBmd9
	30isT8ZQAsv5A7o7+Jg0J1PwFXj6piPWInVo2NyKDYplN77clH9RN6hcOHKiV2Wm
	OGJvN452RA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E238D9056;
	Thu, 16 Aug 2012 19:29:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 612AD9053; Thu, 16 Aug 2012
 19:29:31 -0400 (EDT)
In-Reply-To: <7vy5mftm3q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 19 Jul 2012 15:36:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AE98A72-E7FA-11E1-9DCF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I like the general direction.  Perhaps a long distant future
> direction could be to also use the same trick in the ref namespace
> so that we can have 'next' branch itself, and 'next/foo', 'next/bar'
> forks that are based on the 'next' branch at the same time (it
> obviously is a totally unrelated topic)?

I notice that I was responsible for making this topic veer in the
wrong direction by bringing up a new feature "having 'next' and
'next/bar' at the same time" which nobody asked.  Perhaps we can
drop that for now to simplify the scope of the topic, to bring the
log graveyard back on track?
