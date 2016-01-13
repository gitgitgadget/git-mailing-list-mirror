From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 08:58:13 -0800
Message-ID: <xmqqy4btpgbe.fsf@gitster.mtv.corp.google.com>
References: <1452641726-25625-1-git-send-email-sbeller@google.com>
	<1452643808-29384-1-git-send-email-sbeller@google.com>
	<5695FFDA.9050409@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, jens.lehmann@web.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOkW-0007pE-M5
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbcAMQ6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:58:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754190AbcAMQ6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:58:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A3BD3A2DA;
	Wed, 13 Jan 2016 11:58:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SsM/DZp8hFDwhVO1voJGDVmNdgQ=; b=wXREUu
	EQicqCaPb1LWWjb5K1ottNaBfqrK4U+dbCV+3TyCSkUpYQw8zhbh+CfgVdx792Aj
	mHt/Yt3jvqB0OTPH0TKOqSccqv8CifijKJd1N/wOJZklLm2yPX2Us86FXjAY7Ymt
	y9MKVCXMIV5clcq9eI+wLfbD5/o7wYIFO0e8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EhrwC/DyLKR862HvSZgyFdCqh7B+JcWK
	DA9w+YRdszl4I57+udrA53/uN+ZX9bNVMFhy/dHEUzYvVRfFBCIHgai5sYEHF3jF
	0kocIpbNbTSk/zvJ0e7m8koV5Nic3YFZX2CiuP2lxrDbdfp2ihPq/pkf8URP20zk
	eiHWIKalL58=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70D633A2D3;
	Wed, 13 Jan 2016 11:58:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8FF43A2CE;
	Wed, 13 Jan 2016 11:58:14 -0500 (EST)
In-Reply-To: <5695FFDA.9050409@kdbg.org> (Johannes Sixt's message of "Wed, 13
	Jan 2016 08:42:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6282772-BA16-11E5-874C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283934>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 13.01.2016 um 01:10 schrieb Stefan Beller:
>> Later on we want to deprecate the `git submodule init` command and make
>> it implicit in other submodule commands. As these other commands are
>> written in C already, we'd need the init functionality in C, too.
>> The `resolve_relative_url` function is a major part of that init
>> functionality, so start by porting this function to C.
>
> Maybe tone down the word "major" to "a large and non-trivial function"?
> Otherwise, the lack of proof for the claim is irritating. (As we saw,
> the savings with the port to C are not breath-taking. But we have to
> start somewhere.)
> ...

All good suggestions.  Thanks for a low latency review.  Very much
appreciated.
