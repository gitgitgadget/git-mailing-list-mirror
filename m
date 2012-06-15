From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Fri, 15 Jun 2012 08:06:50 -0700
Message-ID: <7v62asd379.fsf@alter.siamese.dyndns.org>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
 <1339691389.4625.9.camel@beez.lab.cmartin.tk>
 <20120615091425.20e40af9@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfY6z-0000w1-Bu
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab2FOPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:06:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab2FOPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:06:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCB6866F;
	Fri, 15 Jun 2012 11:06:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+sjISEAyqnB8x2jLJap424QTjDA=; b=ICoU7b
	w4Ds1cOyzuXA64sPuBflQM/Ze+/44VZ0AW4Y9Nzwj5kjAWDNFHC5GQqDuIb2PZX3
	MFBs9LV8yathmOxMShXxAqIGrXnCD32rubGJ6azie9VW8bnh5aAJzQpkYiZ30i+L
	AQS2qR/2XIaW0AiLywisJ5lCOiXmQq1LDoYD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XdF7brDr/naSaRg6XRVrkI+JIGpumjf5
	GaN/SJ7jFrbctO92aImWxm+eUiATkFdhoVFdPDX8urWSDgtd5RIurJk7ZC/4FnEA
	d6x0Q2otIdAZPC2gKAMOuS0V6/7RmDqJUTChewD+GHQEvtgfwP8l1wjNEtSmks2w
	wQgtCzh0EsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2191D866E;
	Fri, 15 Jun 2012 11:06:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC839866D; Fri, 15 Jun 2012
 11:06:51 -0400 (EDT)
In-Reply-To: <20120615091425.20e40af9@chalon.bertin.fr> (Yann Dirson's
 message of "Fri, 15 Jun 2012 09:14:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCB9F2CE-B6FB-11E1-9A47-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200059>

Yann Dirson <dirson@bertin.fr> writes:

> Another orthogonal UI issue I see, is that rev-list could be more
> user-friendly to warn the user when one element of a rev list is
> ignored because of another one.

Sometimes my maint-1.7.8 branch may still have commits that are not
in maint branch, sometimes maint-1.7.9 branch is a true subset of
maint branch. "rev-list ^maint maint-1.7.8 maint-1.7.9" is a very
sensible thing to ask to find out what is still not in 'maint' out
of stuff that are _usually_ but not always part of 'maint'.

Complaining on such a query is not user-friendly at all.
