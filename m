From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1 0/6] Fix bug in large transactions
Date: Thu, 22 Jan 2015 09:58:58 -0800
Message-ID: <xmqqk30eu271.fsf@gitster.dls.corp.google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
	<20150121234659.GE11115@peff.net>
	<xmqqsif3tfcf.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ5fdDiT=zXhQkt17kxLBbkJnh1F06nyZJN7ta9WZ2dmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:59:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEM28-0005oq-71
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 18:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbbAVR7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 12:59:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752908AbbAVR7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 12:59:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CF9D302C6;
	Thu, 22 Jan 2015 12:59:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jrHEC+A4/InpLIXK6im4M365HuY=; b=AIktWN
	zy8TSW073EtViFSMVyhKeRd4ayN826sS9Wxx36v6tSf7VIb39BbKKwQ4hwswcH+6
	F3tD42HPO7NKCmzoub84jNh8+g9Hym8am1egDmfZpfvMf2hgneENNA6D+iUFqJsl
	wC0sy7ZacFfqg9bb1oypOSg/LCZP+VPREKYEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVVZiZHJFgJr5vyO34Q4Ih2el9mFUn+t
	DWt7dvxsguFBXmh02F1wnS1GAyFRBZ0dX3H1rffyhzBVcpARnXyT7puVfzvTuF2w
	OUqVe2rKY9or6b6wdAwgNaFra13AFdS5vo7oOREY5k1pbHcrr06At6xcrWQC8PTY
	96jJzl5xeQo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C27F6302C2;
	Thu, 22 Jan 2015 12:59:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CEA7302C0;
	Thu, 22 Jan 2015 12:58:59 -0500 (EST)
In-Reply-To: <CAGZ79kZ5fdDiT=zXhQkt17kxLBbkJnh1F06nyZJN7ta9WZ2dmQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 22 Jan 2015 09:52:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57BEBA0A-A260-11E4-86B2-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262852>

Stefan Beller <sbeller@google.com> writes:

> v2 applies to sb/atomic-push instead of next and will result in a one
> line merge conflict with next.

I acctually tried to apply on 'next' and also on 'sb/atomic-push'
and both failed.  I had to wiggle the patches to make them apply on
the latter, and that is what is queued on 'pu' now, but I would not
be surprised if I made silly mistakes while doing so, so please
double check the result and catch them if I did.

Thanks.
