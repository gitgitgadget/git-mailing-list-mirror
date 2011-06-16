From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Wed, 15 Jun 2011 23:27:26 -0700
Message-ID: <7v39jai94h.fsf@alter.siamese.dyndns.org>
References: <20110616003800.GC20355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 08:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX63I-0003ug-To
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 08:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1FPG1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 02:27:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1FPG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 02:27:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D96E3A93;
	Thu, 16 Jun 2011 02:29:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i3fvpkgCkmUW9vC4BpTSe3xdZH8=; b=sbVQsh
	RdoZNyzywqBhwTiIxlC0RoH5/+vvnKwnbTTGb43k1PHSlrzobRzegMSPynoGyCEa
	K51QyRbd36fTS5iwOd4+DVMcOiDZh/a4dVZnYdNe/TcGH/NZ+NsupmlDvqz7/zO+
	PeIagWoTZL+gjG1HRPn1l+jG6KRHUgn0KjxUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ItTTBdF80KiUeXYnw2fbPzFP/dMzzjjX
	I8Dhizl88m8yvNkswxZMsZR7e+Yz21sytjYQJtm/HOmLw/FVgyVcu3YbYUC6JghB
	doaz6elmQ0dqRen9ktppP/B8J3qO9IDsvmTaYPTv24FUIgZQ0ZcTY4jkmjeqx1fl
	EimlNxQFXlE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 267643A92;
	Thu, 16 Jun 2011 02:29:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86B043A91; Thu, 16 Jun 2011
 02:29:39 -0400 (EDT)
In-Reply-To: <20110616003800.GC20355@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 15 Jun 2011 20:38:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0357DD34-97E2-11E0-862C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175881>

Jeff King <peff@github.com> writes:

> This feels a little wrong, as we are changing what the tool outputs all
> the time just to appease a poorly-written test.

Now you confused me.  Isn't '-n' to tell the tool *not* to write timestamp
out, so that we can avoid changing what the tool outputs all the time?
